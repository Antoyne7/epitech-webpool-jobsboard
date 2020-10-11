<template>
  <div class="lightbox">
    <div @click="close()" :close="close" class="lightbox-background">
    </div>
    <div class="img">
      <img :src="cv" alt="">
    </div>
  </div>
</template>

<script>
export default {
  name: "Lightbox",

  props: {
    cv: null,
  },
  methods: {
    close() {
      this.$emit('hide');
      document.body.style.overflow = 'unset'
    }
  }
}
</script>

<style lang="scss">

.lightbox {
  width: 100vw;
  height: 100vh;
  position: fixed;
  left: 0;
  top: 0;
  z-index: 999;

  .lightbox-background {
    width: 100vw;
    height: 100vh;
    position: absolute;
    top: 0;
    left: 0;
    background: rgba(0, 0, 0, 0.75);
    -webkit-backdrop-filter: blur(20px);
    backdrop-filter: blur(20px);
    z-index: 1000;
  }

  .img {
    height: auto;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1001;
  }

}
</style>
