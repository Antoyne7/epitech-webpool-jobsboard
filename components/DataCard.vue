<template>
  <b-row cols="12" class="my-2 justify-content-between">
    <div>
      <slot></slot>
    </div>
    <div>
      <button>EDIT</button>
      <button>DEL</button>
    </div>
  </b-row>
</template>

<script>
export default {
  name: "DataCard"
}
</script>

<style scoped>

</style>
