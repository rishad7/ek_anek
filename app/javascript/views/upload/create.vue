<template>
  <div id="projects-create">
    <div class="mt-16 flex justify-center">
      <form class="" autocomplete="off" @submit.prevent="submitForm">
        <div class="create-new-upload-div p-8 flex flex-col">
          <div class="flex justify-between items-center">
            <div class="text-color-1 text-2xl font-semibold">
              Upload a new file
            </div>
            <div @click="close" class="text-color-2 cursor-pointer">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </div>
          </div>
          <input
            v-model="form.title"
            class="input h-10 w-full px-4 mt-4"
            type="text"
            placeholder="Title"
          />
          <textarea
            class="input h-24 w-full px-4 py-2 mt-4 resize-none"
            placeholder="Add a description"
            v-model="form.description"
          ></textarea>
          <input
            type="file"
            ref="fileInput"
            class="hidden"
            @change="onFilePicked"
          />
          <div class="mt-4 cursor-pointer" @click.stop="openAttachment">
            + Add File
          </div>
          <div class="flex-auto flex items-end justify-end">
            <button
              :disabled="!isValidForm"
              :class="{ disabled: !isValidForm, active: isValidForm }"
              class="btn text-white"
            >
              Upload
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import UploadFactory from "../../api/resources/upload";
export default {
  name: "upload-create",
  props: {
    current_user_id: String,
    project: String,
    type: String,
  },
  data() {
    return {
      form: {
        title: "",
        description: "",
        file: null,
      },
    };
  },
  beforeMount() {
    if (typeof this.project !== "undefined") {
      this.model = JSON.parse(this.project).data;
    }
  },
  computed: {
    isValidForm() {
      if (this.form.title === "" || this.form.description === "") {
        return false;
      } else {
        return true;
      }
    },
  },
  methods: {
    close() {
      window.location = "../dashboard";
    },
    openAttachment() {
      this.$refs.fileInput.click();
    },
    onFilePicked() {
      this.form.file = this.$refs.fileInput.files[0];
    },
    submitForm() {
      if (this.isValidForm) {
        // const formData = new FormData();
        // formData.append("title", this.form.title);
        // formData.append("description", this.form.description);
        // formData.append("file", this.form.file);
        // const headers = { "Content-Type": "multipart/form-data" };
        // axios.post('https://httpbin.org/post', formData, { headers }).then((res) => {
        //   res.data.files; // binary representation of the file
        //   res.status; // HTTP status
        // });

        const params = {
          title: this.form.title,
          description: this.form.description,
          file: this.form.file,
        };

        let formData = new FormData();

        Object.entries(params).forEach(([key, value]) =>
          formData.append(key, value)
        );

        UploadFactory.create(formData).then((response) => {
          if (response.status === 201) {
            this.$swal({
              title: "",
              text: `${this.form.title} has been uploaded`,
              type: "success",
              toast: true,
              position: "bottom-end",
              showConfirmButton: false,
              timer: 1000,
            });
            this.clearForm();
          }
        });
      }
    },
    clearForm() {
      this.form.title = "";
      this.form.description = "";
      this.form.file = null;
    },
  },
};
</script>

<style scoped>
.create-new-upload-div {
  width: 420px;
  height: 480px;
  border: 1px solid #e8e8e8;
  border-radius: 47px;
}
.text-color-1 {
  color: #6f6f73;
}
.text-color-2 {
  color: #a1a1ac;
}
.input {
  outline: 0;
  border: 1px solid #e8e8e8;
  border-radius: 12px;
}
.input-no-of-classes {
  width: 92px;
  height: 37px;
}
::-webkit-input-placeholder {
  /* Chrome/Opera/Safari */
  font-size: 12px;
}
::-moz-placeholder {
  /* Firefox 19+ */
  font-size: 12px;
}
:-ms-input-placeholder {
  /* IE 10+ */
  font-size: 12px;
}
:-moz-placeholder {
  /* Firefox 18- */
  font-size: 12px;
}
.btn {
  width: 73px;
  height: 36px;
  border-radius: 6px;
}
.disabled {
  background-color: #a1a1ac;
}
.active {
  background-color: #456fff;
}
</style>
