// Serveur fournisseur des données
const host = 'http://localhost:8888/T-WEB-501-STG-5-1-jobboard-lucas.michalet/back/public/api/';

export default {

  //Paramétrage du local storage
  // localStore: "NumericaUser",
  // titre: "Vehicule",
  // util: null,

  // Les différentes adresses des flux de données
  listeCandidatures: host + 'candidatures',
  listeOffres: host + 'offres',
  ajoutUtilisateur: host + 'utilisateurs',
  register: host + 'register',

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
    errEmail: "Veuillez entrer un email valide",
    errMdp: "Veuillez entrer un mot de passe de plus de 5 caractères",
    errNoInfo: "Veuillez remplir les informations",

    sucProfil: 'Vos informations ont bien été mises à jour !',
    sucPasswords: "Les mots de passe correspondent"
  }
}
