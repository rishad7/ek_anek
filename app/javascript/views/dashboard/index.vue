<template>
  <div id="dashboard-index">
    <div class="mt-8 flex justify-between items-center">
      <div class="text-color-1 text-sm">
        RECENTLY UPLOADED FILES
      </div>
      <div
        @click="uploadANewFile"
        class="create-a-new-model-btn flex items-center justify-center cursor-pointer"
      >
        <div class="mr-4">+</div>
        <div class="text-sm">Upload a new file</div>
      </div>
    </div>
    <div v-if="hasUploads" class="ai-table mt-8">
      <div class="th pb-4 flex w-full text-color-1 b-b-2">
        <div class="w-220">Title</div>
        <div class="w-228">Description</div>
        <div>File</div>
      </div>
      <div class="tbody flex flex-col b-b">
        <div
          v-for="(upload, index) in uploadList"
          :key="index"
          class="py-4 flex items-center b-b"
        >
          <div class="w-220 flex items-center">
            <div class="ml-4 text-color-1 text-sm">
              {{ upload.attributes.title }}
            </div>
          </div>
          <div class="w-228 text-color-1 f-13">
            {{ upload.attributes.description }}
          </div>
          <div class="text-color-1 f-13">file upload</div>
          <div class="flex-grow">
            <div class="flex justify-end items-center">
              <!-- <div>
                <img
                  @click="editModel(upload.attributes.hashid)"
                  class="ml-8 cursor-pointer"
                  src="/assets/icons/edit_icon.svg"
                />
              </div> -->
              <div class="ml-8">
                <img
                  @click="deleteFile(upload.id, upload.attributes.title)"
                  class="cursor-pointer"
                  src="/assets/icons/delete_icon.svg"
                />
              </div>
              <!-- <div class="ml-8">
                <img class="cursor-pointer" src="/assets/icons/menu_icon.svg" />
              </div> -->
            </div>
          </div>
        </div>
      </div>
    </div>
    <div v-else class="text-center text-color-1 mt-16">
      No files uploaded yet!
    </div>
    <!-- <modal name="training-modal" width="420px" height="320px">
      <div class="flex flex-col items-center">
        <h1 class="text-color-1 text-2xl font-semibold mt-12">
          Training in progress
        </h1>
        <p class="w-257 text-color-2 text-sm mt-8 text-center">
          We will notify you once the training of the models are completed
        </p>
        <p class="w-267 text-color-2 text-sm mt-12 text-center">
          This process will take about 60 - 90 mins depending on the size & no.
          of the images uploaded to train the model
        </p>
      </div>
    </modal> -->
  </div>
</template>

<script>
import UploadFactory from "../../api/resources/upload";
export default {
  name: "dashboard-index",
  props: {
    uploads: String,
    current_user_id: String,
  },
  data() {
    return {
      uploadList: [],
    };
  },
  computed: {
    hasUploads() {
      if (this.uploadList.length > 0) {
        return true;
      } else {
        return false;
      }
    },
  },
  beforeMount() {
    this.uploadList = JSON.parse(this.uploads).data;
  },
  methods: {
    uploadANewFile() {
      window.location = "../upload";
    },
    predict(hashid) {
      window.location = "../dashboard/" + hashid;
    },
    deleteFile(id, fileName) {
      this.$swal({
        title: "Are you sure?",
        text: `Are sure that you want to delete ${fileName} file?`,
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "Delete",
      }).then((result) => {
        if (result.value) {
          UploadFactory.delete(id).then((response) => {
            if (response.status === 204) {
              const index = this.uploadList.findIndex((res) => res.id === id);
              if (index != -1) {
                this.uploadList.splice(index, 1);
              }
              this.$swal({
                title: "",
                text: `${fileName} has been removed`,
                type: "success",
                toast: true,
                position: "bottom-end",
                showConfirmButton: false,
                timer: 1000,
              });
            }
          });
        }
      });
    },
    editModel(hashid) {
      window.location = "upload/" + hashid;
    },
    trainModel(index, model) {
      let transferData = {
        user_id: this.current_user_id,
        data: [],
      };

      model.attributes.project_classes.data.forEach((item, index) => {
        transferData.data.push({
          class_name: item.attributes.name,
          images: [],
        });
        item.attributes.project_class_images_processed.data.forEach((img) => {
          const imgUrl =
            img.attributes.payload.endpoint +
            "/" +
            img.attributes.payload.assets[0].derivatives.medium.id;
          transferData.data[index].images.push(imgUrl);
        });
      });

      console.log(transferData);
      this.$modal.show("training-modal");
      UploadFactory.train_model({ id: model.id }).then((response) => {
        if (response.status === 201) {
          this.uploadList[index].attributes.is_trained = true;
          this.$modal.hide("training-modal");
        }
      });
    },
  },
};
</script>

<style lang="scss" scoped>
.text-color-1 {
  color: #707070;
}
.create-a-new-model-btn {
  border: 1px solid #456fff;
  width: 183px;
  height: 38px;
  color: #456fff;
  border-radius: 8px;
}
.th {
  font-size: 13px;
}
.b-b {
  border-bottom: 1px solid #e8e8e8;
}
.b-b-2 {
  border-bottom: 2px solid #e8e8e8;
}
@responsive {
  .w-220 {
    width: 220px;
  }
  .w-228 {
    width: 228px;
  }
  .f-13 {
    font-size: 13px;
  }
}
.h-15 {
  height: 15px;
}
.train-model-btn {
  background-color: #456fff;
  border-radius: 8px;
}
.trained-model-btn {
  border: 1px solid #456fff;
  border-radius: 8px;
  color: #456fff;
}
.predict-btn {
  background-color: #456fff;
  border-radius: 8px;
}
.w-257 {
  width: 257px;
}
.w-267 {
  width: 267px;
}
</style>
<style>
.vm--modal {
  border-radius: 47px !important;
}
</style>
