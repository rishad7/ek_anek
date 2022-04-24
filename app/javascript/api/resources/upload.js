import ApiConnection from "../api_connection";
const resource_api_path = "/upload";

export default {
  //   create(payload) {
  //     return ApiConnection.post(`${resource_api_path}`, payload);
  //   },
  //   update(id, payload) {
  //     return ApiConnection.patch(`${resource_api_path}/${id}`, payload);
  //   },
  delete(id) {
    return ApiConnection.delete(`${resource_api_path}/${id}`);
  },
  //   add_project_class_attachments(payload) {
  //     return ApiConnection.post(
  //       `${resource_api_path}/add_project_class_attachments`,
  //       payload
  //     );
  //   },
  //   reanme_project_class(payload) {
  //     return ApiConnection.patch(
  //       `${resource_api_path}/reanme_project_class`,
  //       payload
  //     );
  //   },
  //   delete_project_class(project_id, class_id) {
  //     return ApiConnection.delete(
  //       `${resource_api_path}/${project_id}/delete_project_class/${class_id}`
  //     );
  //   },
  //   train_model(payload) {
  //     return ApiConnection.post(`${resource_api_path}/train_model`, payload);
  //   },
  //   save_as_draft(payload) {
  //     return ApiConnection.post(`${resource_api_path}/save_as_draft`, payload);
  //   },
};
