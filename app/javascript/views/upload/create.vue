<template>
  <div id="projects-create">
    <div class="mt-16 flex justify-center">
      fghjk
    </div>
  </div>
</template>

<script>
export default {
  name: "upload-create",
  props: {
    current_user_id: String,
    project: String,
    type: String,
  },
  data() {
    return {
      transitionName: "slide-left",
      selectedComponent: "model",
      data: {},
      model: null,
      emptyClass: false,
      decrementClassCount: 0,
    };
  },
  beforeMount() {
    if (typeof this.project !== "undefined") {
      this.model = JSON.parse(this.project).data;
    }
  },
  methods: {
    setSelectedComponent(cmp, nav, data = {}, isEmptyClass = false) {
      if (nav === "next") {
        this.transitionName = "slide-left";
      } else {
        this.transitionName = "slide-right";
      }
      if (isEmptyClass) {
        this.emptyClass = isEmptyClass;
      }
      this.selectedComponent = cmp;
      this.data = data;
    },
    classRemoved() {
      this.decrementClassCount = this.decrementClassCount + 1;
    },
    setdecrementClassCount() {
      this.decrementClassCount = 0;
    },
  },
};
</script>

<style scoped>
.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active {
  transition-duration: 0.3s;
  transition-property: height, opacity, transform;
  transition-timing-function: cubic-bezier(0.55, 0, 0.1, 1);
  overflow: hidden;
}
.slide-left-enter,
.slide-right-leave-active {
  opacity: 0;
  transform: translate(2em, 0);
}
.slide-left-leave-active,
.slide-right-enter {
  opacity: 0;
  transform: translate(-2em, 0);
}
</style>
