-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: localhost    Database: jobsboard
-- ------------------------------------------------------
-- Server version	5.7.31-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `candidatures`
--

DROP TABLE IF EXISTS `candidatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candidatures` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `useprofilecv` tinyint(1) NOT NULL,
  `cv` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `utilisateur_id` bigint(20) unsigned NOT NULL,
  `offre_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `candidatures_utilisateur_id_foreign` (`utilisateur_id`),
  KEY `candidatures_offre_id_foreign` (`offre_id`),
  CONSTRAINT `candidatures_offre_id_foreign` FOREIGN KEY (`offre_id`) REFERENCES `offres` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `candidatures_utilisateur_id_foreign` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidatures`
--

LOCK TABLES `candidatures` WRITE;
/*!40000 ALTER TABLE `candidatures` DISABLE KEYS */;
INSERT INTO `candidatures` VALUES (1,1,'fileUser/jV2N3DRkemiHuB9RE9milu5aZAQ8a76IvwoYLSdn.pdf','Salut à tous c\'est Diablox9 on se retrouve pour une vidéo à l\'intervention sur terminal, j\'adore le gaming haha.',1,'2020-10-16 11:32:37','2020-10-16 12:18:38',4,9),(2,1,'fileUser/d33aQl7w4CqdeFnKWSp9jlt5pYTCbtygKjM2lREe.png','Salut à tous c\'est Diablox9 on se retrouve pour une vidéo à l\'intervention sur terminal, j\'adore le gaming haha.',0,'2020-10-16 11:33:04','2020-10-16 11:33:04',4,10),(3,1,'fileUser/CMQOKdKHnVxT17z9zoGz5FzTspSTwD23UOVz1CsG.pdf','Hou oui de la bonne caillasse',0,'2020-10-16 11:33:45','2020-10-16 11:33:45',4,11),(4,1,'fileUser/I84UHikvietBP9C43J1avuYJHph41QT8h2cPjSAo.pdf','Salut moi c\'est Antoine Braillard je veux ce poste',0,'2020-10-16 11:37:14','2020-10-16 11:37:14',5,10),(5,1,'fileUser/I84UHikvietBP9C43J1avuYJHph41QT8h2cPjSAo.pdf','Salut c\'est encore moi, je suis super fort à minecraft donc je pense que j\'ai ma place dans ce job.',0,'2020-10-16 11:37:42','2020-10-16 11:37:42',5,11),(6,1,'fileUser/I84UHikvietBP9C43J1avuYJHph41QT8h2cPjSAo.pdf','Ooooh stp sardoche jsuis ton plus grand fan wtf embauche moi !!!!! Le roi du seeeeeeel !',1,'2020-10-16 11:38:14','2020-10-16 12:17:56',5,9),(7,1,'fileUser/QLmdCNw1NF7CzO0xZjsBIobriH7EY96DvPOX2Lqf.jpeg','Oui monsieur OUI',0,'2020-10-16 11:50:12','2020-10-16 11:50:12',6,11),(8,1,'fileUser/GSVg3PVChYMXOCWcVwhHBrTFLO6Z201GyXn2SNOh.pdf','Je suis parfaitement qualifié pour ce job',0,'2020-10-16 11:50:35','2020-10-16 11:50:35',6,10),(9,1,'fileUser/aArqKKpdjd0ifJwNkgpiInExiyC4vBI8e087Bcqm.png','Oua mais le streaming c\'est grave mon délire',1,'2020-10-16 11:51:18','2020-10-16 12:18:09',6,9),(10,1,'fileUser/1biJYEIGcx6yqp2sjkckB1ngoSiUjDR4uTBXAOrY.pdf','Vraiment pas mal cette offre',0,'2020-10-16 12:01:23','2020-10-16 12:01:23',3,11),(11,1,'fileUser/1biJYEIGcx6yqp2sjkckB1ngoSiUjDR4uTBXAOrY.pdf','Oui je veux être espion pitié',0,'2020-10-16 12:01:36','2020-10-16 12:01:36',3,10),(12,1,'fileUser/1biJYEIGcx6yqp2sjkckB1ngoSiUjDR4uTBXAOrY.pdf','Franchement go',0,'2020-10-16 12:01:45','2020-10-16 12:01:45',3,9),(13,1,'fileUser/1biJYEIGcx6yqp2sjkckB1ngoSiUjDR4uTBXAOrY.pdf','Je suis chaud',0,'2020-10-16 12:01:56','2020-10-16 12:01:56',3,8);
/*!40000 ALTER TABLE `candidatures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entreprises`
--

DROP TABLE IF EXISTS `entreprises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entreprises` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entreprises`
--

LOCK TABLES `entreprises` WRITE;
/*!40000 ALTER TABLE `entreprises` DISABLE KEYS */;
INSERT INTO `entreprises` VALUES (1,'Antoine CORPORATION','2020-10-16 06:43:49','2020-10-16 06:43:49'),(3,'Gpadidé .Inc','2020-10-16 10:58:11','2020-10-16 10:59:14'),(4,'KCORP','2020-10-16 11:04:29','2020-10-16 11:04:29'),(5,'STONKS Industries','2020-10-16 11:05:03','2020-10-16 11:05:03'),(6,'Bruh','2020-10-16 11:06:30','2020-10-16 11:06:30'),(7,'Apple','2020-10-16 11:15:00','2020-10-16 11:15:00'),(8,'René Coty','2020-10-16 11:24:35','2020-10-16 11:24:35');
/*!40000 ALTER TABLE `entreprises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1),(5,'2020_09_29_135857_create_offres_table',1),(6,'2020_09_29_140922_create_type_offres_table',1),(7,'2020_09_29_140935_create_tags_table',1),(8,'2020_09_29_140950_create_entreprises_table',1),(9,'2020_09_29_141200_create_offre_tag_table',1),(10,'2020_09_29_141608_create_offre_type_offre_table',1),(11,'2020_09_29_142014_create_candidatures_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offre_tag`
--

DROP TABLE IF EXISTS `offre_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offre_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `offre_id` bigint(20) unsigned NOT NULL,
  `tag_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `offre_tag_offre_id_foreign` (`offre_id`),
  KEY `offre_tag_tag_id_foreign` (`tag_id`),
  CONSTRAINT `offre_tag_offre_id_foreign` FOREIGN KEY (`offre_id`) REFERENCES `offres` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `offre_tag_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offre_tag`
--

LOCK TABLES `offre_tag` WRITE;
/*!40000 ALTER TABLE `offre_tag` DISABLE KEYS */;
INSERT INTO `offre_tag` VALUES (1,NULL,NULL,1,1),(2,NULL,NULL,1,2),(3,NULL,NULL,1,3),(4,NULL,NULL,2,4),(5,NULL,NULL,2,5),(6,NULL,NULL,2,6),(7,NULL,NULL,2,7),(8,NULL,NULL,2,8),(9,NULL,NULL,1,9),(10,NULL,NULL,1,10),(11,NULL,NULL,1,11),(12,NULL,NULL,1,12),(13,NULL,NULL,3,13),(14,NULL,NULL,3,14),(15,NULL,NULL,3,15),(16,NULL,NULL,4,16),(17,NULL,NULL,5,17),(18,NULL,NULL,5,18),(19,NULL,NULL,5,19),(20,NULL,NULL,6,20),(21,NULL,NULL,6,21),(22,NULL,NULL,6,22),(23,NULL,NULL,6,23),(24,NULL,NULL,7,24),(25,NULL,NULL,7,25),(26,NULL,NULL,8,26),(27,NULL,NULL,9,27),(28,NULL,NULL,9,28),(29,NULL,NULL,9,29),(30,NULL,NULL,10,30),(31,NULL,NULL,10,31),(32,NULL,NULL,10,32),(33,NULL,NULL,11,33),(34,NULL,NULL,11,34),(35,NULL,NULL,11,35);
/*!40000 ALTER TABLE `offre_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offre_type_offre`
--

DROP TABLE IF EXISTS `offre_type_offre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offre_type_offre` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `offre_id` bigint(20) unsigned NOT NULL,
  `type_offre_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `offre_type_offre_offre_id_foreign` (`offre_id`),
  KEY `offre_type_offre_type_offre_id_foreign` (`type_offre_id`),
  CONSTRAINT `offre_type_offre_offre_id_foreign` FOREIGN KEY (`offre_id`) REFERENCES `offres` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `offre_type_offre_type_offre_id_foreign` FOREIGN KEY (`type_offre_id`) REFERENCES `type_offres` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offre_type_offre`
--

LOCK TABLES `offre_type_offre` WRITE;
/*!40000 ALTER TABLE `offre_type_offre` DISABLE KEYS */;
INSERT INTO `offre_type_offre` VALUES (1,NULL,NULL,2,1),(2,NULL,NULL,2,2),(3,NULL,NULL,1,1),(4,NULL,NULL,1,2),(5,NULL,NULL,1,6),(6,NULL,NULL,1,8),(7,NULL,NULL,3,1),(8,NULL,NULL,3,2),(9,NULL,NULL,3,3),(10,NULL,NULL,4,8),(11,NULL,NULL,4,9),(12,NULL,NULL,4,6),(13,NULL,NULL,4,10),(14,NULL,NULL,5,1),(15,NULL,NULL,5,2),(16,NULL,NULL,5,8),(17,NULL,NULL,6,1),(18,NULL,NULL,6,2),(19,NULL,NULL,6,3),(20,NULL,NULL,6,6),(21,NULL,NULL,7,3),(22,NULL,NULL,8,1),(23,NULL,NULL,8,2),(24,NULL,NULL,9,7),(25,NULL,NULL,9,3),(26,NULL,NULL,10,6),(27,NULL,NULL,10,2),(28,NULL,NULL,11,8),(29,NULL,NULL,11,10),(30,NULL,NULL,11,9),(31,NULL,NULL,11,6);
/*!40000 ALTER TABLE `offre_type_offre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offres`
--

DROP TABLE IF EXISTS `offres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offres` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code_ville` int(11) DEFAULT NULL,
  `ville` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_departement` int(11) DEFAULT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pourvu` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `entreprise_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `offres_entreprise_id_foreign` (`entreprise_id`),
  CONSTRAINT `offres_entreprise_id_foreign` FOREIGN KEY (`entreprise_id`) REFERENCES `entreprises` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offres`
--

LOCK TABLES `offres` WRITE;
/*!40000 ALTER TABLE `offres` DISABLE KEYS */;
INSERT INTO `offres` VALUES (1,'Cherche développeur web back-end H/F',67482,'Strasbourg',67,'Depuis 9 ans, notre agence à taille humaine voit chaque année ses activités de développement d’applications web avec Ruby on Rails accroitre.','# Détail de l\'offre\n---\nÉcrivez les détails de votre offre ici\n\n## Missions\nVous pouvez faire différentes parties\n- Avec des listes\n- non ordonnées\n1. mais aussi\n2. ordonnées','offreimgs/k0I0eaARxpiwvQAmX1Vay9QVONMxX9q1eS1mu7bg.jpeg',0,'2020-10-16 06:44:42','2020-10-16 11:05:56',3),(2,'Développeur web Front-end H/F',67482,'Strasbourg',67,'Memo ball est une application web permettant à des élèves en difficulté d\'apprendre leurs leçon en s\'amusant. Nous sommes à la recherche d\'un développeur Front.','# Développeur web front\n---\nÉcrivez les détails de votre offre ici\n\n## Missions\nVous pouvez faire différentes parties\n- Avec des listes\n- non ordonnées\n1. mais aussi\n2. ordonnées','offreimgs/OnP2KbG4UW4B1K79Az8g7A8oTdbmyfhJAb8CwtsK.jpeg',0,'2020-10-16 06:57:48','2020-10-16 07:12:39',1),(3,'Nous recherchons quelqu\'un H/F',25388,'Montbéliard',25,'Groupe familial de dimension mondiale, Würth est présent dans plus de 80 pays avec plus de 400 sociétés. Il emploie plus de 77 000 collaborateurs.','# Détail de l\'offre\n---\nÉcrivez les détails de votre offre ici\n\n## Missions\nVous pouvez faire différentes parties\n- Avec des listes\n- non ordonnées\n1. mais aussi\n2. ordonnées','offreimgs/PdAmyGqjenMjpHpATte5QnjP4ayvdr2TPRrQzG9o.jpeg',0,'2020-10-16 11:08:48','2020-10-16 11:10:08',5),(4,'Technicien réseau',34172,'Montpellier',34,'KCORP recrute pour l’un de ces partenaires, un technicien réseaux en ALTERNANCE .\nRattaché(e) à un chef d’équipe vous allez vous amusez!','An h1 header\n============\n\nParagraphs are separated by a blank line.\n\n2nd paragraph. *Italic*, **bold**, and `monospace`. Itemized lists\nlook like:\n\n  * this one\n  * that one\n  * the other one\n\nNote that --- not considering the asterisk --- the actual text\ncontent starts at 4-columns in.\n\n> Block quotes are\n> written like so.\n>\n> They can span multiple paragraphs,\n> if you like.\n\nUse 3 dashes for an em-dash. Use 2 dashes for ranges (ex., \"it\'s all\nin chapters 12--14\"). Three dots ... will be converted to an ellipsis.\nUnicode is supported. ☺\n\n\n\nAn h2 header\n------------\n\nHere\'s a numbered list:\n\n 1. first item\n 2. second item\n 3. third item\n\nNote again how the actual text starts at 4 columns in (4 characters\nfrom the left side). Here\'s a code sample:\n\n    # Let me re-iterate ...\n    for i in 1 .. 10 { do-something(i) }\n\nAs you probably guessed, indented 4 spaces. By the way, instead of\nindenting the block, you can use delimited blocks, if you like:\n\n~~~\ndefine foobar() {\n    print \"Welcome to flavor country!\";\n}\n~~~\n\n(which makes copying & pasting easier). You can optionally mark the\ndelimited block for Pandoc to syntax highlight it:\n\n~~~python\nimport time\n# Quick, count to ten!\nfor i in range(10):\n    # (but not *too* quick)\n    time.sleep(0.5)\n    print(i)\n~~~','offreimgs/YvBc1YY1k2IMgtHVzFzWkQRQB0BWacUdNhjM68R6.jpeg',0,'2020-10-16 11:11:44','2020-10-16 11:11:44',4),(5,'Développeur Intégrateur Web H/F',90010,'Belfort',90,'Nous recrutons un(e) webmaster / intégrateur en alternance pour intégrer notre équipe digitale. Vous participerez activement à l’élaboration.','# Détail de l\'offre\n---\nÉcrivez les détails de votre offre ici\nNous recrutons un(e) webmaster / intégrateur en alternance pour intégrer notre équipe digitale. Vous participerez activement à l’élaboration, au suivi de la réalisation et à la maintenance de nombreux projets Web.\n## Missions\nVous pouvez faire différentes parties\n- Avec des listes\n- non ordonnées\n1. mais aussi\n2. ordonnées','offreimgs/dkjdx3W5vLhWY4p9OmwHu3YspDsOXIKVWPKmK7DB.jpeg',0,'2020-10-16 11:13:40','2020-10-16 11:13:40',4),(6,'Pas un robot svp',54395,'Nancy',54,'Ah bah la c\'est une description courte de l\'offre comme il en existe pleins d\'autre mais la notre est plus original c\'est tout','# Détail de l\'offre\nÉcrivez les détails de votre offre ici\n\n## Missions\nVous pouvez faire différentes parties\n- Avec des listes\n- non ordonnées\n1. mais aussi\n2. ordonnées','offreimgs/xNjCLLvIc7cIbRM35vf6RddNrUJeSjqSTN8YNAMd.jpeg',0,'2020-10-16 11:15:39','2020-10-16 11:15:39',5),(7,'Developpeur windows XP H/F',34172,'Montpellier',34,'Réseau Alliance, acteur majeur dans le recrutement depuis plus de 30 ans pour un CA de plus de 250 millions d\'euros, implanté dans 6 pays différents et présent.','# Détail de l\'offre\n---\nÉcrivez les détails de votre offre ici\n\n## Missions\nVous pouvez faire différentes parties\n- Avec des listes\n- non ordonnées\n1. mais aussi\n2. ordonnées','offreimgs/DugJyeVxbRADNv0sAJF3chZ3CfBPqCJnEtZ6eSmr.jpeg',1,'2020-10-16 11:16:43','2020-10-16 12:18:50',5),(8,'Aled',67483,'Struth',67,'Créé en 2005, le Groupe A2micile est aujourd’hui présent en France, en Belgique et en Allemagne, avec deux marques phares : Azaé et DomAliance.','# Détail de l\'offre\n---\nÉcrivez les détails de votre offre ici\n\n## Missions\nVous pouvez faire différentes parties\n- Avec des listes\n- non ordonnées\n1. mais aussi\n2. ordonnées','offreimgs/1Np7I1eoRIYmKg1UmSJZszmy9k4g2ednFMisws7T.jpeg',0,'2020-10-16 11:21:40','2020-10-16 11:21:40',7),(9,'Streamer H/F',13055,'Marseille',13,'KCORP recherche un streamer pour remplir des créneaux dans sa futur webtv. Possibilité de stream sur sa chaine perso hors créneaux','# Détail de l\'offre\n---\nÉcrivez les détails de votre offre ici\n\n## Missions\nVous pouvez faire différentes parties\n- Avec des listes\n- non ordonnées\n1. mais aussi\n2. ordonnées','offreimgs/pbKREOLtGIctdkxADqBjCgStMgxWnuUENopz4uOc.jpeg',0,'2020-10-16 11:23:09','2020-10-16 11:23:09',4),(10,'Cherche espion pour sécuriser le proche orient',75056,'Paris',75,'Vous voyez la voiture derrière moi ? Elle est absolument nickel ! C\'est quand même mieux une voiture propre. À l\'occasion je vous passerai un coup de polish.','# Détail de l\'offre\n---\nÉcrivez les détails de votre offre ici\n\n## Missions\nVous pouvez faire différentes parties\n- Avec des listes\n- non ordonnées\n1. mais aussi\n2. ordonnées','offreimgs/oEmt7vHK96FJM4gWQVOymImsKfSg1qFiBwNvRWgn.jpeg',0,'2020-10-16 11:27:27','2020-10-16 11:27:40',8),(11,'Mineur alternance',67447,'Schiltigheim',67,'Stonks industries recherche un mineur pour extraire les minerais présent en très grand nombre dans les mines. Poste a pourvoir dans de nombreuses villes.','# Détail de l\'offre\n---\nÉcrivez les détails de votre offre ici\n\n## Missions\nVous pouvez faire différentes parties\n- Avec des listes\n- non ordonnées\n1. mais aussi\n2. ordonnées','offreimgs/bjwPwZtNv9V6vXSmOhjvmkwFdLhBersUTGrqgBoJ.jpeg',0,'2020-10-16 11:27:40','2020-10-16 11:27:40',5);
/*!40000 ALTER TABLE `offres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (15,'App\\Models\\Utilisateur',4,'authToken','72d642d6d206a6bd8af26e93427a6626b426e9dc3850ffbc6931b40daf46c922','[\"*\"]',NULL,'2020-10-16 11:29:46','2020-10-16 11:29:46'),(16,'App\\Models\\Utilisateur',5,'authToken','1cba1890b25591549c0478c6d08ac1241690da58a80793e06afa25fdcdf3ac6b','[\"*\"]',NULL,'2020-10-16 11:34:41','2020-10-16 11:34:41'),(27,'App\\Models\\Utilisateur',3,'authToken','7e73aa08a752de05322e912932e8013591bf968ca30bc438c7c494c8ff9988cd','[\"*\"]',NULL,'2020-10-16 12:19:23','2020-10-16 12:19:23');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'tag1','2020-10-16 06:44:42','2020-10-16 06:44:42'),(2,'tag2','2020-10-16 06:44:42','2020-10-16 06:44:42'),(3,'tag3','2020-10-16 06:44:42','2020-10-16 06:44:42'),(4,'tagggz','2020-10-16 06:57:48','2020-10-16 06:57:48'),(5,'développeur web','2020-10-16 07:12:39','2020-10-16 07:12:39'),(6,'front-end','2020-10-16 07:12:39','2020-10-16 07:12:39'),(7,'full-stack','2020-10-16 07:12:39','2020-10-16 07:12:39'),(8,'tmtc','2020-10-16 07:12:39','2020-10-16 07:12:39'),(9,'strasbourg','2020-10-16 11:02:17','2020-10-16 11:02:17'),(10,'développeur','2020-10-16 11:02:17','2020-10-16 11:02:17'),(11,'webmestre','2020-10-16 11:02:17','2020-10-16 11:02:17'),(12,'street','2020-10-16 11:02:17','2020-10-16 11:02:17'),(13,'tema','2020-10-16 11:08:48','2020-10-16 11:08:48'),(14,'la','2020-10-16 11:08:48','2020-10-16 11:08:48'),(15,'kichta','2020-10-16 11:08:49','2020-10-16 11:08:49'),(16,'reseau','2020-10-16 11:11:44','2020-10-16 11:11:44'),(17,'diablox9','2020-10-16 11:13:40','2020-10-16 11:13:40'),(18,'zumba','2020-10-16 11:13:40','2020-10-16 11:13:40'),(19,'cafew','2020-10-16 11:13:40','2020-10-16 11:13:40'),(20,'stonk','2020-10-16 11:15:39','2020-10-16 11:15:39'),(21,'pas robot','2020-10-16 11:15:39','2020-10-16 11:15:39'),(22,'homme','2020-10-16 11:15:39','2020-10-16 11:15:39'),(23,'femme','2020-10-16 11:15:39','2020-10-16 11:15:39'),(24,'windows xp','2020-10-16 11:16:43','2020-10-16 11:16:43'),(25,'tiekar','2020-10-16 11:16:43','2020-10-16 11:16:43'),(26,'bruh','2020-10-16 11:21:40','2020-10-16 11:21:40'),(27,'dofus','2020-10-16 11:23:09','2020-10-16 11:23:09'),(28,'pvp','2020-10-16 11:23:09','2020-10-16 11:23:09'),(29,'twitch','2020-10-16 11:23:09','2020-10-16 11:23:09'),(30,'espion','2020-10-16 11:27:27','2020-10-16 11:27:27'),(31,'porter des choses lourdes','2020-10-16 11:27:27','2020-10-16 11:27:27'),(32,'sécuriser le proche orient','2020-10-16 11:27:27','2020-10-16 11:27:27'),(33,'mineur','2020-10-16 11:27:40','2020-10-16 11:27:40'),(34,'fort','2020-10-16 11:27:40','2020-10-16 11:27:40'),(35,'musclé','2020-10-16 11:27:40','2020-10-16 11:27:40');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_offres`
--

DROP TABLE IF EXISTS `type_offres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_offres` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_offres`
--

LOCK TABLES `type_offres` WRITE;
/*!40000 ALTER TABLE `type_offres` DISABLE KEYS */;
INSERT INTO `type_offres` VALUES (1,'Freelance','2020-10-16 07:13:25','2020-10-16 07:13:25'),(2,'CDI','2020-10-16 07:13:56','2020-10-16 07:13:56'),(3,'CDD','2020-10-16 10:49:56','2020-10-16 10:49:56'),(6,'Temps plein','2020-10-16 10:56:50','2020-10-16 10:56:50'),(7,'Temps partiel','2020-10-16 10:56:56','2020-10-16 10:56:56'),(8,'Apprentissage','2020-10-16 10:57:10','2020-10-16 10:57:10'),(9,'Contrat de proffesionalisation','2020-10-16 10:57:43','2020-10-16 10:57:43'),(10,'Alternance','2020-10-16 10:57:51','2020-10-16 10:57:51');
/*!40000 ALTER TABLE `type_offres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utilisateurs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cv` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  `api_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `utilisateurs_email_unique` (`email`),
  UNIQUE KEY `utilisateurs_api_token_unique` (`api_token`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateurs`
--

LOCK TABLES `utilisateurs` WRITE;
/*!40000 ALTER TABLE `utilisateurs` DISABLE KEYS */;
INSERT INTO `utilisateurs` VALUES (1,'BRAILLARD','Antoine','Antoine.brld@gmail.com',NULL,'$2y$10$PtyByPPugt7XbbHOhsGVPeLVidK1AkX5Emgn9/ygxQ7MBvASG9xPe',NULL,NULL,NULL,NULL,NULL,'2020-10-16 05:37:09','2020-10-16 05:37:09'),(2,'ADMIN','admin','admin@gmail.com',NULL,'$2y$10$c5bYNRgZRK744aJS6ft/MeZhYb2VR.ts9rWkJNk6ZfKbPvmN8uEI.',NULL,NULL,NULL,2,NULL,'2020-10-16 06:18:58','2020-10-16 06:18:58'),(3,'Michalet','Lucas','lucasmichalet81@gmail.com',NULL,'$2y$10$y1rcEZ8NNNxY.UbFxd9.K.YEUP8fCVTc4xmbZQi.EEk/iQ7cBo4ja',NULL,NULL,'fileUser/1biJYEIGcx6yqp2sjkckB1ngoSiUjDR4uTBXAOrY.pdf',NULL,NULL,'2020-10-16 06:30:18','2020-10-16 12:01:05'),(4,'Diablox9','Benoit','gaming@dx9.fr',NULL,'$2y$10$rVqzJVaYNzmXgNojnzHz/OuQZQtpqRFk45MDxkvnHJkNKzc8fneJC',NULL,'imgUser/uP8llzl1cPO7SqJPsSYZODbTI2e6AN6Gucfi7ghI.png',NULL,NULL,NULL,'2020-10-16 11:29:17','2020-10-16 11:30:24'),(5,'Braillard','Antoine','antoine@braillard.fr',NULL,'$2y$10$lO23TOXCwLqx3Bi.kMKfW.Fa/eqUCN63O/QfLxiRDAHM9R6idpi/O',NULL,'imgUser/8RFECD3RDiukVatOiPBserJPtE2LqZs2yIQMGGoZ.png','fileUser/I84UHikvietBP9C43J1avuYJHph41QT8h2cPjSAo.pdf',NULL,NULL,'2020-10-16 11:34:29','2020-10-16 11:36:50'),(6,'Gaming','Alderiate','alderiate@gaming.fr',NULL,'$2y$10$iLtIa3YurE9ZHa9n07mjQuvT77VXxM2LxUXccGdmptDsjpghltdPq',NULL,'imgUser/9phZOqz4mAtsNErXzdGP7EMCByghEZqE14ixbanC.jpeg',NULL,NULL,NULL,'2020-10-16 11:39:27','2020-10-16 11:49:52');
/*!40000 ALTER TABLE `utilisateurs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-17  0:08:53
