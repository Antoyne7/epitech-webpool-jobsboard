<template>
  <div>
    <span :class="type">{{ msg }}</span>
  </div>
</template>

<script>
export default {
  name: "Alert",
  props: ['msg', 'type'],
}
</script>

<style lang="scss" scoped>
span {
  font-size: 1.6rem;
  margin-left: 10px;

}
</style>
