<template>
  <b-row cols="12" class="my-2 justify-content-between">
    <div>
      <slot></slot>
    </div>
    <div>
      <b-button :to="to">EDIT</b-button>

      <b-button @click="deleteFunction(data.id)">DEL</b-button>
    </div>
  </b-row>
</template>

<script>
export default {
  name: "DataCard",
  props: ['to', 'data', 'deleteFunction']
}
</script>

<style scoped>

</style>
