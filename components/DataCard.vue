<template>
  <b-row
    cols="12"
    class="my-2 mx-0 justify-content-between rounded-lg data-container flex-nowrap"
  >
    <div id="slot">
      <slot></slot>
    </div>
    <div class="d-flex">
      <b-button variant="light" @click="$emit('edit')">
        <svg
          width="32"
          height="32"
          viewBox="0 0 32 32"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M27.5 26.125H4.5C3.94687 26.125 3.5 26.5719 3.5 27.125V28.25C3.5 28.3875 3.6125 28.5 3.75 28.5H28.25C28.3875 28.5 28.5 28.3875 28.5 28.25V27.125C28.5 26.5719 28.0531 26.125 27.5 26.125ZM8.05313 23.5C8.11563 23.5 8.17813 23.4938 8.24063 23.4844L13.4969 22.5625C13.5594 22.55 13.6188 22.5219 13.6625 22.475L26.9094 9.22812C26.9383 9.19921 26.9613 9.16487 26.977 9.12707C26.9927 9.08927 27.0008 9.04874 27.0008 9.00781C27.0008 8.96688 26.9927 8.92636 26.977 8.88855C26.9613 8.85075 26.9383 8.81641 26.9094 8.7875L21.7156 3.59063C21.6563 3.53125 21.5781 3.5 21.4937 3.5C21.4094 3.5 21.3313 3.53125 21.2719 3.59063L8.025 16.8375C7.97812 16.8844 7.95 16.9406 7.9375 17.0031L7.01562 22.2594C6.98522 22.4268 6.99609 22.5991 7.04727 22.7613C7.09846 22.9236 7.18842 23.071 7.30937 23.1906C7.51562 23.3906 7.775 23.5 8.05313 23.5V23.5Z"
            fill="black"
          />
        </svg>
      </b-button>
      <b-button variant="light" @click="deleteFunction(data.id)">
        <b-icon-trash-fill></b-icon-trash-fill>
      </b-button>
    </div>
  </b-row>
</template>

<script>
export default {
  name: "DataCard",
  props: ["to", "data", "deleteFunction"]
};
</script>

<style scoped lang="scss">
div,
a,
button {
  font-size: 1.6rem;
}

#slot {
  text-transform: capitalize;
}

button,
a {
  width: 50px;
  height: 34px;
  justify-content: center;
  align-items: center;
  display: flex;
  background: transparent;
  border: none;
}

.data-container {
  padding: 4px 12px;
  display: flex;
  align-items: center;
  box-sizing: content-box;
  border: 1px solid transparent;
  height: 34px;
  &:hover {
    border: 1px solid black;
    // button, a {
    //   display: flex;
    // }
  }
}

.data-container:nth-child(odd) {
  background: rgba(0, 0, 0, 0.05);
}

</style>
