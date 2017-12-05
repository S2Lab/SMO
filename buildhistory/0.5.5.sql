-- MySQL dump 10.13  Distrib 5.7.18, for Win64 (x86_64)
--
-- Host: localhost    Database: smo
-- ------------------------------------------------------
-- Server version	5.7.18-log

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `username` char(30) NOT NULL,
  `password` char(30) DEFAULT NULL,
  `permission` char(10) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES ('player1','123','player','2017-11-06 12:00:00'),('player2','456','player','2017-11-06 12:00:00'),('player3','789','player','2017-11-06 12:00:00'),('root','root123','admin','2017-11-06 12:00:00'),('testnew1','123','player','2017-11-28 15:47:04');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bonus_content`
--

DROP TABLE IF EXISTS `bonus_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bonus_content` (
  `id_key` char(20) NOT NULL,
  `id_item` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT '1',
  KEY `id_key_in_bonus_content_idx` (`id_key`),
  KEY `id_item_in_bonus_content_idx` (`id_item`),
  CONSTRAINT `id_item_in_bonus_content` FOREIGN KEY (`id_item`) REFERENCES `data_item` (`id_item`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_key_in_bonus_content` FOREIGN KEY (`id_key`) REFERENCES `bonus_key` (`id_key`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bonus_content`
--

LOCK TABLES `bonus_content` WRITE;
/*!40000 ALTER TABLE `bonus_content` DISABLE KEYS */;
INSERT INTO `bonus_content` VALUES ('123ABC123',10,-1,50),('123ABC123',11,-1,25),('123ABC123',12,-1,10);
/*!40000 ALTER TABLE `bonus_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bonus_key`
--

DROP TABLE IF EXISTS `bonus_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bonus_key` (
  `id_key` char(20) NOT NULL,
  `name_key` text,
  `remain` int(11) NOT NULL DEFAULT '0',
  `time_begin` datetime NOT NULL,
  `time_end` datetime NOT NULL,
  PRIMARY KEY (`id_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bonus_key`
--

LOCK TABLES `bonus_key` WRITE;
/*!40000 ALTER TABLE `bonus_key` DISABLE KEYS */;
INSERT INTO `bonus_key` VALUES ('12345678901234567890','测试用key',-100,'2017-01-01 00:00:00','2019-12-31 00:00:00'),('123ABC123','测试用key2',10000,'2017-01-01 00:00:00','2019-12-31 00:00:00');
/*!40000 ALTER TABLE `bonus_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_crafting`
--

DROP TABLE IF EXISTS `data_crafting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_crafting` (
  `id_crafting` int(11) NOT NULL,
  `class_need` text,
  `lv_need` int(11) DEFAULT NULL,
  `class_sub_need` text,
  `lv_sub_need` int(11) DEFAULT NULL,
  `exp_need` int(11) DEFAULT '0',
  `gold_need` int(11) DEFAULT '0',
  `product_id_item` int(11) NOT NULL,
  `product_amount` int(11) NOT NULL DEFAULT '1',
  `des` text,
  PRIMARY KEY (`id_crafting`),
  KEY `id_item_in_crafting_idx` (`product_id_item`),
  CONSTRAINT `id_item_in_crafting` FOREIGN KEY (`product_id_item`) REFERENCES `data_item` (`id_item`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_crafting`
--

LOCK TABLES `data_crafting` WRITE;
/*!40000 ALTER TABLE `data_crafting` DISABLE KEYS */;
INSERT INTO `data_crafting` VALUES (0,'',1,'',0,0,0,80,1,'合成铁锭'),(2,'',0,'',0,0,0,81,1,'合成铜锭');
/*!40000 ALTER TABLE `data_crafting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_crafting_raw`
--

DROP TABLE IF EXISTS `data_crafting_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_crafting_raw` (
  `id_crafting` int(11) NOT NULL,
  `raw_id_item` int(11) NOT NULL,
  `raw_amount` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_crafting`,`raw_id_item`,`raw_amount`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_crafting_raw`
--

LOCK TABLES `data_crafting_raw` WRITE;
/*!40000 ALTER TABLE `data_crafting_raw` DISABLE KEYS */;
INSERT INTO `data_crafting_raw` VALUES (0,60,1),(2,61,1);
/*!40000 ALTER TABLE `data_crafting_raw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_enchant`
--

DROP TABLE IF EXISTS `data_enchant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_enchant` (
  `id_enchant` int(11) NOT NULL,
  `name_enchant` text NOT NULL,
  `des` text,
  PRIMARY KEY (`id_enchant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_enchant`
--

LOCK TABLES `data_enchant` WRITE;
/*!40000 ALTER TABLE `data_enchant` DISABLE KEYS */;
INSERT INTO `data_enchant` VALUES (0,'test_enchant','这是一个测试附魔');
/*!40000 ALTER TABLE `data_enchant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_func`
--

DROP TABLE IF EXISTS `data_func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_func` (
  `id_range` int(11) NOT NULL,
  `func_type` char(10) NOT NULL,
  `id_target` int(11) NOT NULL,
  `name_to_show` char(20) NOT NULL,
  `time_cost` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_range`,`func_type`,`id_target`),
  CONSTRAINT `id_range_in_data_func` FOREIGN KEY (`id_range`) REFERENCES `data_range` (`id_range`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_func`
--

LOCK TABLES `data_func` WRITE;
/*!40000 ALTER TABLE `data_func` DISABLE KEYS */;
INSERT INTO `data_func` VALUES (1,'resource',10,'采矿',0),(7,'relax',0,'休息',0),(7,'shop',0,'系统商店',0),(8,'relax',0,'休息',0);
/*!40000 ALTER TABLE `data_func` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_item`
--

DROP TABLE IF EXISTS `data_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_item` (
  `id_item` int(11) NOT NULL,
  `name_item` text NOT NULL,
  `rarity` tinyint(4) NOT NULL DEFAULT '0',
  `order_type` tinyint(4) NOT NULL,
  `des` text,
  `is_usable` tinyint(4) NOT NULL DEFAULT '0',
  `is_wearable` tinyint(4) NOT NULL DEFAULT '0',
  `is_dropable` tinyint(4) NOT NULL DEFAULT '0',
  `is_soldable` tinyint(4) NOT NULL DEFAULT '0',
  `is_enchantable` tinyint(4) NOT NULL DEFAULT '0',
  `is_strenthenable` tinyint(4) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `slot` tinyint(4) NOT NULL DEFAULT '0',
  `atk_p` int(11) NOT NULL DEFAULT '0',
  `def_p` int(11) NOT NULL DEFAULT '0',
  `atk_m` int(11) NOT NULL DEFAULT '0',
  `def_m` int(11) NOT NULL DEFAULT '0',
  `speed` int(11) NOT NULL DEFAULT '0',
  `acc` int(11) NOT NULL DEFAULT '0',
  `hp` int(11) NOT NULL DEFAULT '0',
  `hp_re` int(11) NOT NULL DEFAULT '0',
  `hp_limit` int(11) NOT NULL DEFAULT '0',
  `mp` int(11) NOT NULL DEFAULT '0',
  `mp_re` int(11) NOT NULL DEFAULT '0',
  `mp_limit` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_item`
--

LOCK TABLES `data_item` WRITE;
/*!40000 ALTER TABLE `data_item` DISABLE KEYS */;
INSERT INTO `data_item` VALUES (0,'test_item',0,-1,'这是一个测试物品',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(1,'测试物品2',0,-1,'这也是一个测试物品',1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(2,'测试物品3',0,-1,'这个物品用来给玩家5个金锭',1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(10,'铁锭',0,-1,'一种基础材料,用来制作其它东西.',0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(11,'金锭',1,-1,'一种基础材料,用来制作其它东西.',0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(12,'银锭',1,-1,'一种基础材料,用来制作其它东西.',0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(20,'木材',0,-1,'普通木材,常见材料之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(21,'硬木材',0,-1,'硬质木材,硬质木材,常见材料之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(23,'精灵木',1,-1,'蕴含魔力的木材',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(40,'石头',0,-1,'普通石头,常见材料之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(41,'黑石',1,-1,'硬度比普通石头大,除此之外没有什么特殊之处',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(60,'铁矿石',0,-1,'常见矿石之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(61,'铜矿石',0,-1,'常见矿石之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(62,'金矿石',1,-1,'稀有矿石之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(63,'秘银矿石',2,-1,'稀有矿石之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(80,'铁锭',0,-1,'常见金属材料之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(81,'铜锭',0,-1,'常见金属材料之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(82,'金锭',1,-1,'稀有金属材料之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(83,'秘银锭',1,-1,'稀有金属材料之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(87,'合金锭',1,-1,'由多种金属制成的合金,非常坚硬',0,0,1,1,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0),(89,'虚空金属锭',3,-1,'这金属摸起来不凉,不如说,像是有生命的温暖..?',0,0,1,1,0,0,30,0,0,0,0,0,0,0,0,0,0,0,0,0),(102,'月向花',0,-1,'喜欢月光的花',0,0,1,1,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0),(103,'希波特草',0,-1,'蕴含魔力的小草',0,0,1,1,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0),(200,'村民口粮',0,-1,'村子里最好吃的口粮.恢复些许HP',1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(201,'下级体力药剂',0,-1,'恢复少量HP',1,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(202,'普通体力药剂',0,-1,'恢复一些HP',1,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(203,'上级体力药剂',1,-1,'恢复大量HP',1,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(204,'大师体力药剂',2,-1,'恢复巨量HP',1,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(205,'下级伤害药剂',0,-1,'我也不知道为什么我会想喝这个',1,0,1,1,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0),(206,'普通伤害药剂',0,-1,'我真的不知道为什么我会想喝这个',1,0,1,1,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0),(207,'上级伤害药剂',0,-1,'我确实不知道为什么我会想喝这个',1,0,1,1,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0),(208,'大师伤害药剂',0,-1,'我为什么想喝..鬼知道啊!',1,0,1,1,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0),(209,'体力完全恢复药剂',3,-1,'恢复全部HP',1,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(220,'村民酒',0,-1,'村子里最好喝的酒,恢复少量MP',1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(221,'下级法力药剂',0,-1,'恢复少量MP',1,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(222,'普通法力药剂',0,-1,'恢复一些MP',1,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(223,'上级法力药剂',1,-1,'恢复大量MP',1,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(224,'大师法力药剂',2,-1,'恢复巨量MP',1,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(229,'法力完全恢复药剂',3,-1,'恢复全部MP',1,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(240,'力量卷轴',4,-1,'永久少量提升角色力量属性',1,0,1,1,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0),(241,'力量之书',5,-1,'永久提升角色力量属性',1,0,1,1,0,0,100,0,0,0,0,0,0,0,0,0,0,0,0,0),(244,'智慧卷轴',4,-1,'永久少量提升角色智慧属性',1,0,1,1,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0),(245,'智慧之书',5,-1,'永久提升角色智慧属性',1,0,1,1,0,0,100,0,0,0,0,0,0,0,0,0,0,0,0,0),(248,'敏捷卷轴',4,-1,'永久少量提升角色敏捷属性',1,0,1,1,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0),(249,'敏捷之书',5,-1,'永久提升角色敏捷属性',1,0,1,1,0,0,100,0,0,0,0,0,0,0,0,0,0,0,0,0),(252,'经验卷轴',4,-1,'提供少量经验',1,0,1,1,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0),(253,'经验之书',5,-1,'提供大量经验',1,0,1,1,0,0,100,0,0,0,0,0,0,0,0,0,0,0,0,0),(280,'小钱袋',3,-1,'装着一些钱币的样子',1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(281,'钱袋',3,-1,'装着很多钱币的样子',1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(282,'大钱袋',3,-1,'金币互相碰撞的声音让人激动',1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(283,'村民的包裹',1,-1,'里面装着的,是村民们的希望..?',1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(284,'下级药水袋',1,-1,'装有下级药水各5',1,0,1,1,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0),(285,'普通药水袋',1,-1,'装有普通药水各5',1,0,1,1,0,0,15,0,0,0,0,0,0,0,0,0,0,0,0,0),(286,'上级药水袋',2,-1,'装有上级药水各5',1,0,1,1,0,0,20,0,0,0,0,0,0,0,0,0,0,0,0,0),(288,'诡异的盒子',3,-1,'看起来就很诡异的盒子',1,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0),(300,'风化的碎骨',0,-1,'小块怪物的碎骨',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(301,'大块的碎骨',0,-1,'大块碎骨',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(305,'龙骨',2,-1,'龙骨,稀有素材之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(308,'小块怪物毛皮',0,-1,'小块的怪物毛皮',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(309,'大块的怪物毛皮',0,-1,'大块怪物毛皮',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(313,'龙鳞',2,-1,'龙鳞,稀有素材之一',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(316,'蛛丝',0,-1,'黏糊糊的蛛丝',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(317,'坚韧蛛丝',0,-1,'非常耐拉扯的蛛丝',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(324,'牙齿',0,-1,'怪物牙齿',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(327,'毒牙',1,-1,'还在滴毒的怪物牙齿',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0),(332,'怪物血液',0,-1,'怪物的血液,隐约有魔力气息散出',0,0,1,1,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0),(334,'龙血',3,-1,'即使已经死去,龙的血液仍旧在散发强大的气息',0,0,1,1,0,0,20,0,0,0,0,0,0,0,0,0,0,0,0,0),(336,'炽热的龙血',4,-1,'被魔力激发的龙力让人颤抖',0,0,1,1,0,0,30,0,0,0,0,0,0,0,0,0,0,0,0,0),(520,'伊瑞希亚魔力粉末',2,-1,'由伊瑞希亚的魔导工匠制作的魔力粉末',0,0,1,1,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0),(521,'伊瑞希亚天空石',2,-1,'产自伊瑞希亚的魔石',0,0,1,1,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0),(560,'虚空之种',3,-1,'由虚空之力凝结成的种子',0,0,1,1,0,0,20,0,0,0,0,0,0,0,0,0,0,0,0,0),(561,'虚空碎片',3,-1,'蕴含虚空之力的碎片',0,0,1,1,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0),(600,'村民头盔',0,-1,'村子里最好的头盔',1,1,1,0,0,0,0,1,0,1,0,1,0,0,0,0,0,0,0,0),(601,'村民护胸',0,-1,'村子里最好的护胸',1,1,1,0,0,0,0,2,0,3,0,3,0,0,0,0,0,0,0,0),(602,'村民护腿',0,-1,'村子里最好的护腿',1,1,1,0,0,0,0,3,0,2,0,2,0,0,0,0,0,0,0,0),(603,'村民靴',0,-1,'村子里最好的靴子',1,1,1,0,0,0,0,4,0,1,0,1,1,1,0,0,0,0,0,0),(604,'粗制铁头盔',0,-1,'粗劣制作的铁质头盔',1,1,1,1,0,0,2,1,0,0,0,0,0,0,0,0,0,0,0,0),(605,'粗制铁护胸',0,-1,'粗劣制作的铁质护胸',1,1,1,1,0,0,2,2,0,0,0,0,0,0,0,0,0,0,0,0),(606,'粗制铁护腿',0,-1,'粗劣制作的铁质护腿',1,1,1,1,0,0,2,3,0,0,0,0,0,0,0,0,0,0,0,0),(607,'粗制铁靴',0,-1,'粗劣制作的铁质靴子',1,1,1,1,0,0,2,4,0,0,0,0,0,0,0,0,0,0,0,0),(608,'精良铁头盔',0,-2,'制作精良的铁质头盔',1,1,1,1,0,1,3,1,0,0,0,0,0,0,0,0,0,0,0,0),(609,'精良铁护胸',0,-2,'制作精良的铁护胸',1,1,1,1,0,1,3,2,0,0,0,0,0,0,0,0,0,0,0,0),(610,'精良铁护腿',0,-2,'制作精良的铁护腿',1,1,1,1,0,1,3,3,0,0,0,0,0,0,0,0,0,0,0,0),(611,'精良铁靴',0,-2,'制作精良的铁靴',1,1,1,1,0,1,3,4,0,0,0,0,0,0,0,0,0,0,0,0),(620,'合金头盔',1,-2,'坚硬的头盔',1,1,1,1,1,1,5,1,0,0,0,0,0,0,0,0,0,0,0,0),(621,'合金护胸',1,-2,'坚硬的护胸',1,1,1,1,1,1,5,2,0,0,0,0,0,0,0,0,0,0,0,0),(622,'合金护腿',1,-2,'坚硬的护腿',1,1,1,1,1,1,5,3,0,0,0,0,0,0,0,0,0,0,0,0),(623,'合金靴',1,-2,'坚硬的靴子',1,1,1,1,1,1,5,4,0,0,0,0,0,0,0,0,0,0,0,0),(628,'炽热龙血头盔',4,-2,'赋予穿戴者强大力量的头盔',1,1,1,1,1,1,50,1,0,0,0,0,0,0,0,0,0,0,0,0),(629,'炽热龙血护胸',4,-2,'赋予穿戴者强大力量的护胸',1,1,1,1,1,1,50,2,0,0,0,0,0,0,0,0,0,0,0,0),(630,'炽热龙血护腿',4,-2,'赋予穿戴者强大力量的护腿',1,1,1,1,1,1,50,3,0,0,0,0,0,0,0,0,0,0,0,0),(631,'炽热龙血靴',4,-2,'赋予穿戴者强大力量的靴子',1,1,1,1,1,1,50,4,0,0,0,0,0,0,0,0,0,0,0,0),(632,'虚空之盔',4,-2,'虚空之力在头盔表面律动',1,1,1,1,1,1,50,1,0,0,0,0,0,0,0,0,0,0,0,0),(633,'虚空之护胸',4,-2,'虚空之力在护胸表面律动',1,1,1,1,1,1,50,2,0,0,0,0,0,0,0,0,0,0,0,0),(634,'虚空之护腿',4,-2,'虚空之力在护腿表面律动',1,1,1,1,1,1,50,3,0,0,0,0,0,0,0,0,0,0,0,0),(635,'虚空之靴',4,-2,'虚空之力在靴子表面律动',1,1,1,1,1,1,50,4,0,0,0,0,0,0,0,0,0,0,0,0),(700,'伊始之石',4,-1,'传说是世界诞生之时就生成的石头,表面微弱的魔力波动在彰示着久远的历史',1,1,0,0,0,0,60,7,0,0,0,0,0,0,0,0,0,0,0,0),(900,'炽热龙血长剑',4,-2,'赋予穿戴者强大力量的长剑',1,1,1,1,1,1,50,10,0,0,0,0,0,0,0,0,0,0,0,0),(901,'炽热龙血战斧',4,-2,'赋予穿戴者强大力量的战斧',1,1,1,1,1,1,50,10,0,0,0,0,0,0,0,0,0,0,0,0),(902,'炽热龙血短刃',4,-2,'赋予穿戴者强大力量的短刃',1,1,1,1,1,1,50,10,0,0,0,0,0,0,0,0,0,0,0,0),(905,'虚空长剑',4,-2,'挥动时隐约能看到空间被划破后的裂缝',1,1,1,1,1,1,50,10,0,0,0,0,0,0,0,0,0,0,0,0),(1900,'光辉圣剑',10,1,'传说中勇者使用的剑,蕴含强大的力量',1,1,0,0,1,1,100,10,0,0,0,0,0,0,0,0,0,0,0,0),(1901,'万里的探求之魔导书',10,2,'传说记录现世所有知识的魔导书',1,1,0,0,1,1,100,10,0,0,0,0,0,0,0,0,0,0,0,0),(1902,'阿瓦隆胸甲',10,3,'曾拯救世界的英雄流传下来的胸甲',1,1,0,0,1,1,100,2,0,0,0,0,0,0,0,0,0,0,0,0),(1903,'真视贤者头盔',10,4,'能赋予佩戴者看破一切假象能力的头盔',1,1,0,0,1,1,100,1,0,0,0,0,0,0,0,0,0,0,0,0),(1904,'谎言项链',10,5,'能以\"谎言\"扭转攻击的项链',1,1,0,0,1,1,100,9,0,0,0,0,0,0,0,0,0,0,0,0),(1905,'森罗万象之戒',10,6,'含有未知能力的戒指',1,1,0,0,1,1,100,8,0,0,0,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `data_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_loot`
--

DROP TABLE IF EXISTS `data_loot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_loot` (
  `id_loot` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '-1',
  `amount_min` int(11) NOT NULL DEFAULT '0',
  `amount_max` int(11) NOT NULL DEFAULT '0',
  `probability` float NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_loot`,`id_item`),
  KEY `id_item_in_monster_loots_idx` (`id_item`),
  CONSTRAINT `id_item_in_monster_loots` FOREIGN KEY (`id_item`) REFERENCES `data_item` (`id_item`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_loot`
--

LOCK TABLES `data_loot` WRITE;
/*!40000 ALTER TABLE `data_loot` DISABLE KEYS */;
INSERT INTO `data_loot` VALUES (0,0,-1,1,1,1),(10,60,-1,1,3,1),(10,61,-1,0,2,1),(10,62,-1,0,1,1);
/*!40000 ALTER TABLE `data_loot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_monster`
--

DROP TABLE IF EXISTS `data_monster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_monster` (
  `id_moster` int(11) NOT NULL,
  `name_monster` char(30) DEFAULT NULL,
  `atk_p` int(11) NOT NULL DEFAULT '0',
  `def_p` int(11) NOT NULL DEFAULT '0',
  `atk_m` int(11) NOT NULL DEFAULT '0',
  `def_m` int(11) NOT NULL DEFAULT '0',
  `speed` int(11) NOT NULL DEFAULT '0',
  `acc` int(11) NOT NULL DEFAULT '0',
  `hp_limit` int(11) NOT NULL DEFAULT '0',
  `hp_re` int(11) NOT NULL DEFAULT '0',
  `hp` int(11) NOT NULL DEFAULT '0',
  `mp_limit` int(11) NOT NULL DEFAULT '0',
  `mp_re` int(11) NOT NULL DEFAULT '0',
  `mp` int(11) NOT NULL DEFAULT '0',
  `des` text,
  `is_offensive` tinyint(4) NOT NULL DEFAULT '0',
  `rarity` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_moster`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_monster`
--

LOCK TABLES `data_monster` WRITE;
/*!40000 ALTER TABLE `data_monster` DISABLE KEYS */;
INSERT INTO `data_monster` VALUES (0,'测试怪物',1,1,1,1,1,1,1,1,1,1,1,1,'这是一个测试怪物',0,0),(1,'测试怪物2',1,1,1,1,1,1,1,1,1,1,1,1,'这是测试用怪物',0,0),(2,'测试怪物3',1,1,1,1,1,1,1,1,1,1,1,1,'这还是测试用怪物',0,0);
/*!40000 ALTER TABLE `data_monster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_range`
--

DROP TABLE IF EXISTS `data_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_range` (
  `id_range` int(11) NOT NULL,
  `name_range` text NOT NULL,
  `func` text NOT NULL,
  `pos` text NOT NULL,
  `inner_des` text NOT NULL,
  `des` text NOT NULL,
  `area` char(10) NOT NULL,
  PRIMARY KEY (`id_range`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_range`
--

LOCK TABLES `data_range` WRITE;
/*!40000 ALTER TABLE `data_range` DISABLE KEYS */;
INSERT INTO `data_range` VALUES (1,'矿场',' ','121.365383,37.52679;121.36625,37.526683;121.366008,37.525123;121.36515,37.525316','北操','一片重要的资源区','ytld'),(2,'资源区',' ','121.363331,37.526672;121.364265,37.526576;121.364202,37.5262;121.363277,37.526275','金工实习区','一片资源区','ytld'),(3,'矿场',' ','121.360407,37.527352;121.361646,37.527177;121.361449,37.525706;121.360047,37.525896','三座逸夫楼','一片矿场','ytld'),(4,'后山据点',' ','121.360353,37.528157;121.361776,37.527978;121.361673,37.527341;121.359984,37.52737','后山汽修厂','后山的据点','ytld'),(5,'资源区',' ','121.361943,37.527084;121.36329,37.526916;121.363164,37.526096;121.361826,37.5262','蔚山学院','资源区哟','ytld'),(6,'资源区',' ','121.3617,37.526111;121.363146,37.526025;121.363025,37.525309;121.361583,37.52542','土木学院','也是资源区哟','ytld'),(7,'生活区',' ','121.363389,37.526994;121.364314,37.526908;121.364278,37.526636;121.363371,37.526726','北23','生活区','ytld'),(8,'生活区',' ','121.363506,37.527706;121.364444,37.52762;121.364337,37.526973;121.363411,37.527044','北22那边的一片楼','生活区哟','ytld'),(9,'资源区',' ','121.364179,37.529378;121.364741,37.529432;121.364974,37.529175;121.365311,37.527593;121.364543,37.527672;121.364399,37.528731','女生宿舍对面的一大片篮球场','资源区','ytld'),(10,'交易行',' ','121.365819,37.529525;121.366564,37.529622;121.366636,37.52901;121.366012,37.528953;121.36594,37.529364','商业区','贸易的中心','ytld'),(11,'BOSS点',' ','121.365653,37.533446;121.366313,37.533614;121.366317,37.533131;121.365603,37.533016','后山亭子','强大的怪物在此徘徊','ytld');
/*!40000 ALTER TABLE `data_range` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_shop`
--

DROP TABLE IF EXISTS `data_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_shop` (
  `id_shop` int(11) NOT NULL,
  `id_trade` int(11) NOT NULL,
  `name` text,
  `id_item_sold` int(11) NOT NULL,
  `amount_sold` int(11) NOT NULL DEFAULT '1',
  `gold_need` int(11) NOT NULL,
  `silver_need` int(11) NOT NULL,
  `copper_need` int(11) NOT NULL,
  `irisia_need` int(11) NOT NULL,
  `des` text,
  PRIMARY KEY (`id_shop`,`id_trade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_shop`
--

LOCK TABLES `data_shop` WRITE;
/*!40000 ALTER TABLE `data_shop` DISABLE KEYS */;
INSERT INTO `data_shop` VALUES (0,0,'下级药水礼包',284,1,0,0,0,0,'免费领取!'),(0,1,'普通药水礼包',285,1,0,0,0,0,'免费领取!'),(0,2,'上级药水礼包',286,1,0,0,0,0,'免费领取!'),(0,3,'兑换合金',87,10,0,0,0,100,'来点合金如何'),(0,4,'诡异的礼包',288,1,0,0,0,0,'一个诡异的盒子');
/*!40000 ALTER TABLE `data_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_strenthen`
--

DROP TABLE IF EXISTS `data_strenthen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_strenthen` (
  `id_strenthen` int(11) NOT NULL,
  `name_strenthen` text NOT NULL,
  `des` text,
  PRIMARY KEY (`id_strenthen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_strenthen`
--

LOCK TABLES `data_strenthen` WRITE;
/*!40000 ALTER TABLE `data_strenthen` DISABLE KEYS */;
INSERT INTO `data_strenthen` VALUES (0,'test_strenthen','这是一个测试强化');
/*!40000 ALTER TABLE `data_strenthen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_list`
--

DROP TABLE IF EXISTS `friend_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_list` (
  `username` char(30) NOT NULL,
  `friendname` char(30) NOT NULL,
  `begintime` datetime NOT NULL,
  PRIMARY KEY (`username`,`friendname`),
  CONSTRAINT `username_in_fl_friend` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `username_in_fl_user` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_list`
--

LOCK TABLES `friend_list` WRITE;
/*!40000 ALTER TABLE `friend_list` DISABLE KEYS */;
INSERT INTO `friend_list` VALUES ('player1','player2','2017-01-01 12:00:00');
/*!40000 ALTER TABLE `friend_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `username` char(30) NOT NULL,
  `id_item` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  PRIMARY KEY (`username`,`id_item`),
  KEY `id_item_in_inventory_idx` (`id_item`),
  CONSTRAINT `id_item_in_inventory` FOREIGN KEY (`id_item`) REFERENCES `data_item` (`id_item`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `username_in_inventory` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES ('player1',10,210,-1,0),('player1',11,210,-1,0),('player1',12,444,-1,0),('player2',2,69,-1,0),('player2',11,211,-1,0),('player2',12,130,-1,0),('player2',60,202,-1,0),('player2',62,6,-1,0),('player2',80,214,-1,0),('player2',81,1,-1,0),('player2',87,10,-1,0),('player2',201,1,-1,0),('player2',205,12,-1,0),('player2',206,15,-1,0),('player2',207,15,-1,0),('player2',221,5,-1,0),('player2',244,13,-1,0),('player2',245,14,-1,0),('player2',280,14,-1,0),('player2',284,2,-1,0),('player2',285,2,-1,0),('player2',286,2,-1,0),('player2',288,12,-1,0),('player2',305,34,-1,0),('player2',600,1,-1,0),('player2',601,1,-1,0),('player2',602,1,-1,3),('player2',603,1,-1,4),('player2',609,1,-1,0),('player2',700,1,-1,7),('player2',1900,1,1,10),('player2',1902,1,3,2),('player2',1903,1,-1,1),('player2',1905,1,-1,8),('player3',10,14,-1,0),('player3',12,11,-1,0),('testnew1',283,1,-1,0);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_enchant`
--

DROP TABLE IF EXISTS `item_enchant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_enchant` (
  `order` int(11) NOT NULL,
  `id_enchant` int(11) NOT NULL,
  `lv_enchant` int(11) NOT NULL,
  PRIMARY KEY (`order`,`id_enchant`),
  KEY `id_enchant_in_item_enchant_idx` (`id_enchant`),
  CONSTRAINT `id_enchant_in_item_enchant` FOREIGN KEY (`id_enchant`) REFERENCES `data_enchant` (`id_enchant`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_in_enchant` FOREIGN KEY (`order`) REFERENCES `inventory` (`id_item`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_enchant`
--

LOCK TABLES `item_enchant` WRITE;
/*!40000 ALTER TABLE `item_enchant` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_enchant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `last_action`
--

DROP TABLE IF EXISTS `last_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `last_action` (
  `username` char(30) NOT NULL,
  `ipaddr` char(15) NOT NULL,
  `loc_x` double NOT NULL,
  `loc_y` double NOT NULL,
  `last_time` datetime NOT NULL,
  `freeze_to` datetime NOT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `username_in_last_action` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `last_action`
--

LOCK TABLES `last_action` WRITE;
/*!40000 ALTER TABLE `last_action` DISABLE KEYS */;
INSERT INTO `last_action` VALUES ('player1','45.77.28.103',121.363847,37.526844,'2017-12-05 15:55:39','0000-00-00 00:00:00'),('player2','127.0.0.1',121.363847,37.526844,'2017-12-05 16:24:20','0000-00-00 00:00:00'),('player3','127.0.0.1',121.36388,37.52684,'2017-11-19 16:55:38','0000-00-00 00:00:00'),('testnew1','223.104.187.8',121.363847,37.526844,'2017-11-28 16:20:32','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `last_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monster`
--

DROP TABLE IF EXISTS `monster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monster` (
  `id_monster` int(11) NOT NULL,
  `loc_x` double NOT NULL DEFAULT '0',
  `loc_y` double NOT NULL DEFAULT '0',
  `time_begin` datetime NOT NULL,
  `time_end` datetime NOT NULL,
  KEY `id_monster_in_monster_idx` (`id_monster`),
  CONSTRAINT `id_monster_in_monster` FOREIGN KEY (`id_monster`) REFERENCES `data_monster` (`id_moster`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monster`
--

LOCK TABLES `monster` WRITE;
/*!40000 ALTER TABLE `monster` DISABLE KEYS */;
INSERT INTO `monster` VALUES (0,10,10,'2017-01-01 00:00:00','2018-01-01 00:00:00'),(0,0,0,'2017-01-01 00:00:00','2018-01-01 00:00:00'),(0,0,5,'2017-01-01 00:00:00','2018-01-01 00:00:00'),(0,5,5,'2017-01-01 00:00:00','2018-01-01 00:00:00'),(0,5,15,'2017-01-01 00:00:00','2018-01-01 00:00:00'),(0,25,15,'2017-01-01 00:00:00','2018-01-01 00:00:00'),(0,35,15,'2017-01-01 00:00:00','2018-01-01 00:00:00');
/*!40000 ALTER TABLE `monster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player` (
  `username` char(30) NOT NULL,
  `atk_p` int(11) NOT NULL,
  `def_p` int(11) NOT NULL,
  `atk_m` int(11) NOT NULL,
  `def_m` int(11) NOT NULL,
  `speed` int(11) NOT NULL,
  `acc` int(11) NOT NULL,
  `hp_limit` int(11) NOT NULL,
  `hp_re` int(11) NOT NULL,
  `hp` int(11) NOT NULL,
  `mp_limit` int(11) NOT NULL,
  `mp_re` int(11) NOT NULL,
  `mp` int(11) NOT NULL,
  `class` text NOT NULL,
  `lv` int(11) NOT NULL,
  `class_sub` text,
  `lv_sub` int(11) DEFAULT NULL,
  `gold` int(11) NOT NULL DEFAULT '0',
  `silver` int(11) NOT NULL DEFAULT '0',
  `copper` int(11) NOT NULL DEFAULT '0',
  `irisia` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`),
  CONSTRAINT `username_in_player` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES ('player1',10,4,1,4,1,2,3,4,3,13,13,42,'fighter',29,NULL,NULL,0,0,0,0),('player2',2,12,21,31,12,12,10,2,10,300,13,30,'magician',10,NULL,NULL,400,400,523,533),('player3',1,10,2,12,30,40,50,5,10,100,10,13,'fighter',1,NULL,NULL,0,0,0,0),('testnew1',5,2,0,1,3,3,30,1,30,10,1,10,'sword',1,'',0,100,0,0,0);
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sign_msg`
--

DROP TABLE IF EXISTS `sign_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sign_msg` (
  `id_msg` int(11) NOT NULL,
  `id_sign` int(11) NOT NULL,
  `writer` char(30) NOT NULL,
  `type` char(15) NOT NULL,
  `msg` text NOT NULL,
  `time_begin` datetime NOT NULL,
  `time_end` datetime NOT NULL,
  PRIMARY KEY (`id_msg`,`id_sign`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sign_msg`
--

LOCK TABLES `sign_msg` WRITE;
/*!40000 ALTER TABLE `sign_msg` DISABLE KEYS */;
INSERT INTO `sign_msg` VALUES (-2,0,'firok2','common','前台输入的信息2','2017-01-01 00:00:00','2017-12-01 00:00:00'),(-1,0,'firok','common','用户从前台输入的信息','2017-01-01 00:00:00','2017-12-01 00:00:00'),(0,0,'system','world','测试信息','2017-01-01 12:00:00','2017-02-01 12:00:00'),(1,0,'system','world','测试信息2','2017-01-01 12:00:00','2017-03-01 12:00:00'),(2,1,'system','world','测试信息3','2017-01-01 12:00:00','2017-03-01 12:00:00'),(3,1,'system','world','测试信息4','2017-01-01 12:00:00','2017-03-01 12:00:00');
/*!40000 ALTER TABLE `sign_msg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `union`
--

DROP TABLE IF EXISTS `union`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union` (
  `id_union` int(11) NOT NULL,
  `name_union` text NOT NULL,
  `establisher_union` char(30) DEFAULT NULL,
  `establish_time` datetime NOT NULL,
  PRIMARY KEY (`id_union`),
  KEY `username_in_unions_idx` (`establisher_union`),
  CONSTRAINT `username_in_unions` FOREIGN KEY (`establisher_union`) REFERENCES `accounts` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `union`
--

LOCK TABLES `union` WRITE;
/*!40000 ALTER TABLE `union` DISABLE KEYS */;
INSERT INTO `union` VALUES (0,'test_union','player1','2017-11-06 12:00:00'),(1,'test_union2','player2','2017-11-06 12:00:00');
/*!40000 ALTER TABLE `union` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `union_member`
--

DROP TABLE IF EXISTS `union_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `union_member` (
  `id_union` int(11) NOT NULL,
  `username` char(30) NOT NULL,
  `time_join` datetime NOT NULL,
  `permission` char(15) NOT NULL,
  PRIMARY KEY (`id_union`,`username`),
  KEY `username_in_union_member_idx` (`username`),
  CONSTRAINT `id_union_in_union_member` FOREIGN KEY (`id_union`) REFERENCES `union` (`id_union`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `username_in_union_member` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `union_member`
--

LOCK TABLES `union_member` WRITE;
/*!40000 ALTER TABLE `union_member` DISABLE KEYS */;
INSERT INTO `union_member` VALUES (0,'player1','2017-11-06 12:00:00','owner'),(0,'player3','2017-11-06 12:00:00','member'),(1,'player2','2017-11-06 12:00:00','owner');
/*!40000 ALTER TABLE `union_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workspace`
--

DROP TABLE IF EXISTS `workspace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workspace` (
  `name` text,
  `value` text,
  `des` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workspace`
--

LOCK TABLES `workspace` WRITE;
/*!40000 ALTER TABLE `workspace` DISABLE KEYS */;
/*!40000 ALTER TABLE `workspace` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-05 17:31:36
