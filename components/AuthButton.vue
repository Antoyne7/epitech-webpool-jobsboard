<template>
  <button>{{ text }}</button>
</template>

<script>
export default {
  name: "AuthButton",
  props: ['text']
}
</script>

<style scoped>
button {
  background: var(--primary-jobs);
  border: none;
  border-radius: 5px;
  color: white;
  text-transform: uppercase;
  font-size: 25px;
  font-weight: 500;
  width: 320px;
  height: 65px;
  margin: 40px auto 30px;
  display: block;
}
</style>
