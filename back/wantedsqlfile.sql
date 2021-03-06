-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: laravelTest
-- ------------------------------------------------------
-- Server version	5.7.24

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidatures` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `useprofilecv` tinyint(1) NOT NULL,
  `cv` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `utilisateur_id` bigint(20) unsigned NOT NULL,
  `offre_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `candidatures_utilisateur_id_foreign` (`utilisateur_id`),
  KEY `candidatures_offre_id_foreign` (`offre_id`),
  CONSTRAINT `candidatures_offre_id_foreign` FOREIGN KEY (`offre_id`) REFERENCES `offres` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `candidatures_utilisateur_id_foreign` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidatures`
--

LOCK TABLES `candidatures` WRITE;
/*!40000 ALTER TABLE `candidatures` DISABLE KEYS */;
INSERT INTO `candidatures` VALUES (1,1,'http://www.leannon.org/voluptatem-aspernatur-voluptate-ut-ut-ad-est','Qui aut ut praesentium. Corrupti impedit tempora vitae. Nemo nihil modi est aperiam sit quia.','2020-10-02 06:42:23','2020-10-02 06:42:23',9,8),(2,1,'http://www.frami.com/nulla-neque-et-qui-provident-magni-velit-quis','Quasi quis rerum ratione eos eligendi. Vel incidunt enim blanditiis illo sapiente eum. Et harum amet placeat molestias rem deserunt.','2020-10-02 06:42:23','2020-10-02 06:42:23',6,9),(3,1,'http://www.lang.info/aliquam-architecto-sed-aliquid-et-beatae-consectetur','Delectus doloremque consequatur aut consequatur nulla. Iste omnis et id occaecati ab accusamus. Placeat hic aliquam sunt vel ratione non. Et atque culpa omnis impedit sint fugiat accusantium.','2020-10-02 06:42:23','2020-10-02 06:42:23',1,5),(4,1,'https://www.herzog.com/eaque-asperiores-qui-voluptatum-repudiandae-officia-quaerat','Porro et quas assumenda ipsum reiciendis vel. Aliquam mollitia beatae a. Ducimus deleniti voluptatibus dolorem ipsum quaerat non voluptatem. Nihil nisi aut consequatur libero et enim natus.','2020-10-02 06:42:23','2020-10-02 06:42:23',11,4),(5,1,'http://stracke.com/velit-quidem-deleniti-sapiente-laboriosam','Esse voluptatem laudantium qui amet. Voluptatum eius est aut. Dolores accusamus sint repellat aut. Et aut deleniti ad ullam.','2020-10-02 06:42:23','2020-10-02 06:42:23',5,6),(6,0,'http://connelly.com/eos-voluptatum-sunt-in-hic-nemo.html','Ut officiis soluta veritatis vel eligendi nobis dolorem. Sit saepe illo non voluptas quis aut. Soluta dolorem blanditiis maiores id. Et soluta ut modi quas recusandae temporibus consequatur.','2020-10-02 06:42:23','2020-10-02 06:42:23',4,6),(7,0,'http://mohr.com/et-vel-aut-quidem-esse-ipsa-commodi-dignissimos','Minima ut fugiat id soluta. Voluptas optio saepe corporis vel. Neque totam ea et quibusdam. Officiis fuga ut ipsam sint.','2020-10-02 06:42:23','2020-10-02 06:42:23',7,5),(8,1,'http://www.bernier.com/dolorem-eligendi-aliquid-ipsum-mollitia-non-voluptatem','Quasi minus unde dignissimos et officia. Sed officia maxime aut eius rerum aliquid consequatur. Unde praesentium vero rem facilis.','2020-10-02 06:42:23','2020-10-02 06:42:23',10,7),(9,0,'https://www.lindgren.com/fugiat-sint-placeat-modi-animi-et-dicta-nam-harum','Porro culpa illo ipsam est aspernatur. Ad aut voluptas sed ea non corrupti. Ipsum nulla harum sapiente ducimus unde alias tenetur nostrum.','2020-10-02 06:42:23','2020-10-02 06:42:23',1,9),(10,1,'https://www.koelpin.org/animi-aperiam-quas-non-ut-dolor-quo-natus','Nostrum enim commodi id sed in dolor fuga beatae. Et nihil aliquid expedita alias debitis. Voluptas aut ratione dicta accusantium fugiat qui. Non autem eveniet maxime quidem et qui enim.','2020-10-02 06:42:23','2020-10-02 06:42:23',12,3),(11,0,'http://www.bauch.com/dolorem-sit-porro-placeat-consequatur-delectus-soluta','Quos adipisci vitae et velit repudiandae est nihil dolorem. Minima rerum illum incidunt est dolor rerum sint.','2020-10-02 06:42:23','2020-10-02 06:42:23',14,10),(12,0,'https://www.cole.org/enim-sint-enim-dolor-at-velit-aut','Omnis natus dolorem dolores quod. Ea non minima esse id. Qui id quasi explicabo. Totam impedit neque eos eos nulla. Et aliquid consectetur non optio et cum quia.','2020-10-02 06:42:23','2020-10-02 06:42:23',8,6),(13,1,'http://padberg.com/est-aut-nostrum-rerum','Fugit nesciunt dolorum quisquam aliquid ea cum. Ad et culpa quae nam ut consequuntur. Tempore ut facere molestiae labore distinctio eveniet vero sint. Modi doloremque adipisci sit voluptate eveniet.','2020-10-02 06:42:23','2020-10-02 06:42:23',13,10),(14,1,'http://erdman.com/','Sunt est eos maiores hic. Qui itaque debitis odit veniam quidem sunt eligendi. Culpa vero eveniet incidunt illo maxime consequuntur est.','2020-10-02 06:42:23','2020-10-02 06:42:23',14,1),(15,1,'https://rice.com/asperiores-eum-ut-quaerat.html','Cumque asperiores autem error amet nostrum. Numquam eius veritatis recusandae. Facere inventore mollitia provident quasi fuga doloremque.','2020-10-02 06:42:23','2020-10-02 06:42:23',15,7),(16,0,'http://ferry.com/sit-et-assumenda-eum-omnis-ut','Est veritatis voluptate totam expedita nostrum voluptas ipsum. Voluptatem voluptate est neque quo eligendi beatae dolorem. Distinctio laudantium quos iste aperiam.','2020-10-02 06:42:23','2020-10-02 06:42:23',3,8),(17,0,'http://klein.com/quisquam-debitis-et-quaerat.html','Nemo tempore quod aut nulla repellat officiis. Sit magnam et rerum commodi. Distinctio dolorum voluptatem et ad voluptas rerum qui totam.','2020-10-02 06:42:23','2020-10-02 06:42:23',7,2),(18,1,'http://www.glover.com/','Et quam fuga vel omnis. Necessitatibus ut laboriosam quaerat aut. Deserunt autem consequatur iure quis dolore quaerat dignissimos assumenda.','2020-10-02 06:42:23','2020-10-02 06:42:23',7,8),(19,1,'http://goodwin.com/et-temporibus-aut-ut-molestias','Inventore voluptatum eos labore sint. Rerum voluptatum repudiandae omnis et quo. Et tempore culpa exercitationem facilis deleniti.','2020-10-02 06:42:23','2020-10-02 06:42:23',4,9),(20,1,'http://waelchi.com/numquam-quia-eius-magni-odit-consequatur','Id esse doloremque ut eligendi cupiditate. Rerum sint consequatur modi. Qui eaque id vitae quod tempora et at. Tenetur dolor ea iste doloribus reprehenderit.','2020-10-02 06:42:23','2020-10-02 06:42:23',6,1),(21,0,'https://steuber.org/reprehenderit-provident-non-rerum-quos-nam-consequatur-veritatis-sint.html','Est id eos facere odit quo iure. Eos et cum quo ut ipsum corporis necessitatibus. Adipisci expedita illum dicta libero commodi eveniet. Dolorem dolor error aperiam.','2020-10-02 06:42:23','2020-10-02 06:42:23',2,1),(22,1,'http://bosco.com/blanditiis-culpa-quis-ut-tempore','Et tenetur deserunt consequatur quia incidunt alias eveniet. In odio vero et perferendis voluptas eos distinctio cum. Impedit est vero aut quis.','2020-10-02 06:42:23','2020-10-02 06:42:23',15,10),(23,1,'http://www.cummings.com/saepe-voluptatem-facere-alias-molestiae-eum-doloremque-reprehenderit','Ratione et dicta dicta non. Cupiditate cum labore voluptas at. Ea eum repellendus aut qui eos.','2020-10-02 06:42:23','2020-10-02 06:42:23',4,7),(24,1,'http://www.lang.org/','Neque a laudantium nostrum consequatur doloremque fugiat. Consequatur omnis modi consequatur exercitationem sapiente. Magni omnis id nobis nesciunt animi id in. Sed impedit dolorem labore.','2020-10-02 06:42:23','2020-10-02 06:42:23',6,7),(25,0,'http://www.langosh.info/laboriosam-aut-sint-dicta-odit-suscipit-reiciendis','Voluptatem ab nihil officia quidem et ea harum tempore. Explicabo voluptatem non nesciunt facere nulla earum accusamus. Dolores in in praesentium placeat ipsam nemo atque ut.','2020-10-02 06:42:23','2020-10-02 06:42:23',2,10);
/*!40000 ALTER TABLE `candidatures` ENABLE KEYS */;
UNLOCK TABLES;
