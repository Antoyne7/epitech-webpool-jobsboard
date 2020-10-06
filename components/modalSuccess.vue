<template>
  <b-modal @hidden="goTo" :centered="isCentered" hide-footer hide-header :id="id">
    <b-btn-close @click="modalHide" class="btn"/>
    <Sucess :msg-validation="message"/>
  </b-modal>
</template>

<script>
import Sucess from "./Sucess";
import param from "../param/param";

export default {
  name: "modalSuccess",
  components: {Sucess},
  props: {
    //ici on stock l'idée de la modal (pour le cas ou on est dans un liste et qu'il y a plusieurs modals)
    id: "",
    //on stock ici le message à afficher
    message: "",
    //On stock ici si la modal est centrée ou non
    isCentered: Boolean,
    //On stock ici le fait que l'utilisateur est besoin d'être déco ou pas
    needDcnx: Boolean,
    //enfin on stock ici la route à laquelle se rendre à la fermeture de la modal
    route: ""
  },
  methods: {
    goTo: function () {
      this.$router.push(this.$props.route);
    },
    modalHide: function () {
      this.$bvModal.hide(this.id);
    }
  }
}
</script>

<style scoped>
.btn {
  float: right;
}
</style>
