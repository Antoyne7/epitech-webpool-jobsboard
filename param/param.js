// Serveur fournisseur des données
const host = '';

export default {

  //Paramétrage du local storage
  // localStore: "NumericaUser",
  // titre: "Vehicule",
  // util: null,

  // Les différentes adresses des flux de données
  // listeVehicule: host + 'listeVehicules.php',

  //Messages d'erreur
  message: {
    //"errDefault" permet de changer le message d'erreur d'un composant simplement, sans passer par des props.
    errDefault: "Une erreur s'est produite",
    errDroits: "Vous ne pouvez pas accéder à cette page",
    errPasswords: "Les mots de passe ne correspondent pas",
    errCnx: "les informations saisies sont incorrectes",
    errSignIn: "Un compte existant utilise déjà cette adresse mail",
    errInfo: "Veuillez remplir les informations",
    errDeco: "Veuillez vous connecter pour accéder à cette page",

    sucProfil: 'Vos informations ont bien été mises à jour !',
    sucPasswords: "Les mots de passe sont les mêmes !"
  }
}
