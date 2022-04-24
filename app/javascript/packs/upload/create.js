import Vue from "vue/dist/vue.esm";
import UploadCreate from "../../views/upload/create.vue";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#vue",
    components: { UploadCreate },
  });
});
