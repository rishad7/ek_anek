class Api::V1::UploadController < Api::ApiController
    before_action :set_upload, only: [:destroy]

    # def index
    # end

    def create
        @upload = Upload.new(item_params.merge(user_id: current_user.id))
        if @upload.save

            attach_main_pic if upload_params[:file].present?

            render json: UploadSerializer.new(@upload).serialized_json, status: :created
        else
            render json: @upload.errors, status: :unprocessable_entity 
        end
    end

    # def update
    #     @previous_no_of_classes = @project.no_of_classes
    #     if @project.update(upload_params)
	# 		store_model_image if params[:image]
    #         update_classes
    #         render json: ProjectSerializer.new(@project).serialized_json, status: :ok
	# 	end
    # end

    def destroy
        if @upload
            @upload.destroy!
            head :no_content
        end
    end

    # def add_project_class_attachments
    #     project_id = params[:project_id].to_i
    #     ProjectClassAttachment.where(project_id: project_id).destroy_all
    #     params[:attachments].each do |attachment|
    #         project_class_id = attachment['id'].to_i
    #         attachment['attributes']['project_class_images_processed']['data'].each do |payload|
    #             ProjectClassAttachment.create(payload: payload, project_id: project_id, project_class_id: project_class_id)
    #         end
    #     end
    #     render json: {message: "images added"}, status: :ok
    # end

    # def reanme_project_class
    #     project_class_id = params[:id].to_i
    #     @project_class = ProjectClass.find(project_class_id)
    #     if @project_class.update(name: params[:name])
    #         render json: {message: "class renamed"}, status: :ok
    #     end
    # end

    # def delete_project_class
    #     project_class_id = params[:class_id].to_i
    #     project_class_deleted = ProjectClass.where(id: project_class_id).destroy_all
    #     @project.take! if project_class_deleted.present?
    #     head :no_content
    # end

    # def train_model
    #     @project.update(is_trained: true)
    #     render json: {message: "trained"}, status: :created
    # end

    # def save_as_draft
    #     @project.update(is_saved_to_draft: true)
    #     render json: {message: "saved to draft"}, status: :created
    # end

    private

    def item_params
      {
        title: upload_params[:title],
        description: upload_params[:description],
      }
    end

    def upload_params
      params.permit(
        :title,
        :description,
        :file
      )
    end

    def attach_main_pic
        @upload.file.attach(upload_params[:file])
    end

    def set_upload
        @upload = Upload.where(user_id: current_user.id).find(params[:id])
    end

    # def store_model_image
    #     @project.attach_base64(:image, params[:image])
    # end

    # def create_classes
    #     params[:no_of_classes].times do |i|
    #         project_name = "Class #{i+1}"
    #         @project_class = ProjectClass.create(name: project_name, project_id: @project.id)
    #     end
    # end

    # def update_classes
    #     if @previous_no_of_classes != params[:no_of_classes]
    #         ProjectClass.where(project_id: @project.id).destroy_all
    #         create_classes
    #     end
    # end

end  