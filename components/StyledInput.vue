<template>
  <div class="input-container">
    <input @keyup="valueChange($event.target.value)" :type="type" :placeholder="placeholder" :id="identifier">
    <label :for="identifier">{{ placeholder }}</label>
  </div>
</template>

<script>

export default {
  name: "StyledInput",
  data() {
    return {
      inputVal: null,
    }
  },
  props: ['placeholder', 'type', 'identifier','varToUpdate'],
  methods: {
    valueChange(value) {
      let input = document.querySelector('#' + this.$props.identifier);
      this.inputVal = value
      this.$emit('update:' + this.$props.varToUpdate, value)

      if (value === null || value.length === 0) {
        input.classList.remove('focused');
      } else {
        input.classList.add('focused');
      }
    }
  }

}

</script>

<style lang="scss" scoped>
.input-container {
  position: relative;

  input {
    padding: 27px 30px;
    width: 100%;
    border: solid 1px;
    font-size: 18px;
    font-weight: 300;

    &:focus {
      outline-color: var(--primary-jobs);
    }

    &::placeholder {
      color: white
    }


    &:focus + label {
      transform: translate(-20px, -52px);
      background: white;
      padding: 0 10px;
    }
  }

  .focused + label {
    transform: translate(-20px, -52px);
    background: white;
    padding: 0 10px;
  }

  label {
    position: absolute;
    top: 50%;
    left: 30px;
    transform: translateY(-50%);
    font-size: 18px;
    font-weight: 300;
    transition: all ease-in-out .15s;
  }
}


</style>
