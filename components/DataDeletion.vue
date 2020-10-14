<template>
  <span>
    <svg v-if="withPoubelle" @click="deleteModal(id)" id="line_Icons" height="512" viewBox="0 0 74 74" width="512"
         xmlns="http://www.w3.org/2000/svg"
         data-name="line Icons">
      <path
        d="m52.8 72h-31.6a5.11 5.11 0 0 1 -5.094-4.8l-2.841-47.132a1 1 0 0 1 1-1.06h45.472a1 1 0 0 1 1 1.06l-2.847 47.132a5.11 5.11 0 0 1 -5.09 4.8zm-37.475-50.992 2.781 46.076a3.108 3.108 0 0 0 3.094 2.916h31.6a3.108 3.108 0 0 0 3.1-2.917l2.781-46.076z"/>
      <path
        d="m62.646 21.008h-51.292a1 1 0 0 1 -1-1v-4.237a7.163 7.163 0 0 1 7.155-7.155h38.983a7.163 7.163 0 0 1 7.155 7.155v4.237a1 1 0 0 1 -1.001 1zm-50.293-2h49.293v-3.237a5.161 5.161 0 0 0 -5.155-5.155h-38.983a5.161 5.161 0 0 0 -5.155 5.155z"/>
      <path
        d="m46.232 10.616h-18.464a1 1 0 0 1 -1-1v-3.539a4.082 4.082 0 0 1 4.077-4.077h12.31a4.082 4.082 0 0 1 4.077 4.077v3.539a1 1 0 0 1 -1 1zm-17.464-2h16.464v-2.539a2.079 2.079 0 0 0 -2.077-2.077h-12.31a2.079 2.079 0 0 0 -2.077 2.077z"/>
      <path d="m47.065 61.739a1 1 0 0 1 -1-1v-29.577a1 1 0 1 1 2 0v29.577a1 1 0 0 1 -1 1z"/>
      <path d="m37 61.739a1 1 0 0 1 -1-1v-29.577a1 1 0 1 1 2 0v29.577a1 1 0 0 1 -1 1z"/>
      <path d="m26.935 61.739a1 1 0 0 1 -1-1v-29.577a1 1 0 0 1 2 0v29.577a1 1 0 0 1 -1 1z"/>
    </svg>
    <b-modal id="delete-modal" title="Modal de suppression" hide-footer hide-header>
      <h2>{{ title }}</h2>
      <p class="my-4">
        <slot></slot>
      </p>
      <div class="btn-containers">
        <button class="bg-blue-jobs" @click="cancel">Annuler</button>
        <button class="mr-2 attention" @click="deleteData">Supprimer</button>
      </div>
    </b-modal>
    <modal-success v-if="withSuccess" :route="route"
                   :need-dcnx="withDcnx" :is-centered="true"
                   :message="messageSuccess"
                   id="success-deletion"/>
  </span>
</template>

<script>

import ModalSuccess from "@/components/modalSuccess";

export default {
  name: "BasicDataDeletion",
  components: {ModalSuccess},
  props: [
    'title',
    'type',
    'withPoubelle',
    'withDcnx',
    'withSuccess',
    'route',
    'messageSuccess',
    'id'
  ],
  data() {
    return {
      toDelete: null,
      showSuccess: false
    }
  },
  created() {
    console.log(this.withSuccess)
  },
  methods: {
    deleteModal(id) {
      this.toDelete = id
      this.$bvModal.show('delete-modal')
    },
    deleteData() {
      this.$axios.$delete('/back/api/' + this.type + '/' + this.toDelete)
        .then(() => {
          this.$bvModal.hide('delete-modal')
          this.$emit('deletion')
          if (this.withSuccess) {
            this.$bvModal.show('success-deletion')
          }
        })
        .catch(e => console.log(e))
    },
    cancel() {
      this.$bvModal.hide('delete-modal')
      this.toDelete = null
    }
  }
}
</script>

<style lang="scss" scoped>
svg {
  height: auto;
  width: 30px;
  cursor: pointer;

  path {
    fill: red;
  }
}

p, button {
  font-size: 1.6rem;
}

.btn-containers {
  display: flex;
  justify-content: center;
}

.bg-blue-jobs {
  border: solid 1px var(--primary-jobs);
  background: none;
  color: var(--primary-jobs);
}

.attention {
  margin-left: 10px;
  background: #ed4337;
  border: solid 1px #ed4337;
}

button {
  border-radius: 6px;
  padding: 6px 18px;
  border: none;
  color: white;
  text-transform: uppercase;
  font-weight: 500;
}

</style>
