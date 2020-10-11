<template>
  <div>
    <input @change="toggleCheck" :checked="checked" type="checkbox" name="checkbox" :id="'checkbox' + checkboxId" :value="value">
    <label :for="'checkbox' + checkboxId">{{ label }}</label>
  </div>
</template>

<script>
export default {
  name: "CheckboxButton",
  props: {
    label: {
      type: String,
      required: false,
      default: 'Label'
    },
    value: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      checkboxId: 0,
      checked: false
    }
  },
  methods: {
    toggleCheck() {
      this.$store.commit('offretype/toggleType', this.value)
    }
  },
  mounted() {
    // This generate "unique" ID for checkboxs
    this.checkboxId = this._uid
    if (this.$store.state.offretype.types.includes(this.value)) {
      this.checked = true
    }
  }
}
</script>

<style scoped>

input {
  position: absolute;
  left: -9999px;
}

label {
  font-size: 1.6rem;
  display: inline-block;
  position: relative;
  margin: 8px;
  padding: 8px 16px;
  font-weight: 700;
  border: 2px solid black;
  border-radius: 8px;
  color: black;
  background-color: white;
  white-space: nowrap;
  cursor: pointer;
  user-select: none;
  transition: background-color .2s, box-shadow .2s;
}

/*label::before {
  content: '';
  display: block;
  position: absolute;
  top: 10px;
  bottom: 10px;
  left: 10px;
  width: 32px;
  border: 3px solid red;
  border-radius: 100px;
  transition: background-color .2s;
}*/


input:checked + label {
  background-color: var(--primary-jobs);
  color: white;
}

/*input:checked + label::before {*/
/*  border-color: black;*/
/*  background-color: green;*/
/*}*/

</style>
