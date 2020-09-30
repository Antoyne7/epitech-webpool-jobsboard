<template>
  <button>{{ text }} <img src="~/assets/icons/ic_chevron_right_48px.svg" alt="Icone chevron"></button>
</template>

<script>
export default {
  name: "AuthRedirection",
  props: ['text'],

}
</script>

<style lang="scss" scoped>
button {
  width: 100%;
  border: solid 1px var(--primary-jobs);
  font-weight: 500;
  font-size: 2rem;
  background: none;
  padding: 15px 0;
  position: relative;

  img {
    position: absolute;
    right: 30px;
    top: 50%;
    transform: translateY(-50%);
    width: 35px;
  }
}

</style>
