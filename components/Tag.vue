<template>
  <div :class="{'type' : isType}">
    {{ text }}
  </div>
</template>

<script>
export default {
  name: "Tag",
  props: ['text', 'isType'],
}
</script>

<style lang="scss" scoped>
div {
  color: var(--primary-jobs);
  font-size: 1.6rem;
  font-weight: 500;
  border: solid 1px var(--primary-jobs);
  border-radius: 5px;
  padding: 5px 12px;
  text-transform: capitalize;

  &.type {
    background: var(--primary-jobs);
    color: white;
  }
}
</style>
