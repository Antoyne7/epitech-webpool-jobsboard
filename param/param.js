// Serveur fournisseur des données
// const host = 'https://backend.antoinebraillard.tech/jobboard/public/index.php/api/';
const host = 'http://jobs.epitech.fr/back/public/api/';
// const host = "http://localhost/EPITECH/PROJETS/JOBBOARD/T-WEB-501-STG-5-1-jobboard-lucas.michalet/back/public/api/";

export default {
  // cheminPhoto:
    // "http://localhost/EPITECH/PROJETS/JOBBOARD/T-WEB-501-STG-5-1-jobboard-lucas.michalet/back/storage/app/",
  cheminPhoto: "http://jobs.epitech.fr/back/storage/app/",

  // Les différentes adresses des flux de données
  listeCandidatures: host + "candidatures",
  listeOffres: host + "offres",
  ajoutUtilisateur: host + "utilisateurs",

  register: host + "register",
  login: host + "login",
  logout: host + "logout",

  typeOffres: host + "typeoffres",
  tags: host + "tags",
  entreprises: host + "entreprises",

  getUser: host + "utilisateurs",
  updateUser: host + "utilisateurs",

  //Messages d'erreur
  message: {
    //"errDefault" permet de changer le message d'erreur d'un composant simplement, sans passer par des props.
    errDefault: "Une erreur s'est produite",
    errDroits: "Vous ne pouvez pas accéder à cette page",
    errPasswords: "Les mots de passe ne correspondent pas",
    errPasswordLength: "Le mot de passe rentré est trop court (< 6 caractères)",
    errCnx: "les informations saisies sont incorrectes",
    errSignIn: "Un compte existant utilise déjà cette adresse mail",
    errInfo: "Veuillez remplir les informations",
    errDeco: "Veuillez vous connecter pour accéder à cette page",
    errEmail: "Veuillez entrer un email valide",
    errMdp: "Veuillez entrer un mot de passe de plus de 5 caractères",
    errNoInfo: "Veuillez remplir les informations",
    errMail: "Un compte est déjà lié à cette adresse mail.",
    errMailused: "Cette addresse mail est déjà utilisée.",
    errCv: "Veuillez envoyer un cv avec votre candidature",
    errText:
      "Veuillez renseigner un message de plus de 6 caractères pour la candidature",

    sucProfil: "Vos informations ont bien été mises à jour !",
    sucPasswords: "Les mots de passe correspondent"
  }
};
