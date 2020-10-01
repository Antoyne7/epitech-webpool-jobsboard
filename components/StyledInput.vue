<template>
  <div class="input-container">
    <input @keyup="valueChange($event.target.value)" :type="type" :placeholder="placeholder" :id="identifier">
    <label :for="identifier">{{ placeholder }}</label>
    <img @click="changeType()" v-if="icone" :src="'icone/'+icone" alt="Icône">
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
  props: ['placeholder', 'type', 'identifier', 'varToUpdate', 'icone'],
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
    },
    changeType() {
      if (this.$props.type === "password") {
        this.$props.type = "text"
      } else {
        this.$props.type = "password"
      }
    }
  }

}

</script>

<style lang="scss" scoped>
.input-container {
  position: relative;

  input {
    padding: 20px 25px;
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
      transform: translate(-20px, -48px);
      background: white;
      padding: 0 10px;
    }
  }

  img {
    position: absolute;
    right: 30px;
    top: 50%;
    transform: translateY(-50%);
    width: 28px;
    cursor: pointer;
  }

  .focused + label {
    transform: translate(-20px, -48px);
    background: white;
    padding: 0 10px;
  }

  label {
    position: absolute;
    top: 50%;
    left: 30px;
    transform: translateY(-50%);
    font-size: 16px;
    font-weight: 300;
    transition: all ease-in-out .15s;
  }
}


</style>
