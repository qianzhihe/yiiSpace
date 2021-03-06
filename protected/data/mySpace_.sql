/*
SQLyog Trial v10.2 
MySQL - 5.5.16-log : Database - yii_space
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `_user_badge` */

DROP TABLE IF EXISTS `_user_badge`;

CREATE TABLE `_user_badge` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `badge_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`badge_id`),
  KEY `_user_badge_badge_id_fkey` (`badge_id`),
  CONSTRAINT `_user_badge_badge_id_fkey` FOREIGN KEY (`badge_id`) REFERENCES `badge` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `_user_badge` */

/*Table structure for table `action_feed` */

DROP TABLE IF EXISTS `action_feed`;

CREATE TABLE `action_feed` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT 'actor 行为者的id',
  `action_type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '动作类型1表示ar_insert 2表示ar_update（跟object_type一起等价于verb语义） 3是控制器动作',
  `action_time` int(11) DEFAULT NULL COMMENT '动作的时间 注意不是ctime 是动作的时间',
  `data` text NOT NULL COMMENT '标题 和内容的数据 数组序列化后存储 含title和body的数据 原来设计为两个字段 感觉有浪费',
  `object_type` varchar(25) NOT NULL COMMENT '动作的主体 ar_class或者是当前路由(如果是当前路由时object_id可以取一个无意义的值)',
  `object_id` int(11) NOT NULL DEFAULT '0' COMMENT '动作的实体id配合object_type一起可以定位一个ar',
  `target_type` varchar(25) NOT NULL DEFAULT '' COMMENT '动作的目标 to 如添加照片to某相册',
  `target_id` int(11) NOT NULL DEFAULT '0' COMMENT '跟target_type一起可标识一个ar实体',
  `target_owner` int(11) NOT NULL DEFAULT '0' COMMENT '目标的主人一般都是自己根据verb决定',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COMMENT='动态反馈表 是对某人干了什么的图文描述';

/*Data for the table `action_feed` */

insert  into `action_feed`(`id`,`uid`,`action_type`,`action_time`,`data`,`object_type`,`object_id`,`target_type`,`target_id`,`target_owner`) values (77,3,1,1346147288,'a:5:{s:8:\"accepted\";i:0;s:4:\"type\";s:1:\"1\";s:6:\"user_a\";s:1:\"3\";s:6:\"user_b\";s:1:\"3\";s:2:\"id\";s:1:\"5\";}','Relationship',5,'',0,0),(76,3,1,1346147284,'a:5:{s:8:\"accepted\";i:0;s:4:\"type\";s:1:\"1\";s:6:\"user_a\";s:1:\"3\";s:6:\"user_b\";s:1:\"2\";s:2:\"id\";s:1:\"4\";}','Relationship',4,'',0,0),(75,1,1,1346147200,'a:5:{s:8:\"accepted\";i:0;s:4:\"type\";s:1:\"1\";s:6:\"user_a\";s:1:\"1\";s:6:\"user_b\";s:1:\"1\";s:2:\"id\";s:1:\"3\";}','Relationship',3,'',0,0),(74,1,1,1346147172,'a:5:{s:8:\"accepted\";i:0;s:4:\"type\";s:1:\"1\";s:6:\"user_a\";s:1:\"1\";s:6:\"user_b\";s:1:\"3\";s:2:\"id\";s:1:\"2\";}','Relationship',2,'',0,0),(78,2,1,1346148089,'a:5:{s:8:\"accepted\";i:0;s:4:\"type\";s:1:\"1\";s:6:\"user_a\";s:1:\"2\";s:6:\"user_b\";s:1:\"2\";s:2:\"id\";s:1:\"6\";}','Relationship',6,'',0,0);

/*Table structure for table `admin_menu` */

DROP TABLE IF EXISTS `admin_menu`;

CREATE TABLE `admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `root` int(10) unsigned DEFAULT NULL,
  `lft` int(10) unsigned NOT NULL,
  `rgt` int(10) unsigned NOT NULL,
  `level` smallint(5) unsigned NOT NULL,
  `label` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL COMMENT 'url 如 array(user/create); 或者user/create  //user/create 服务端处理时要判断是否转为array 要考虑如果采用前者分号的问题 eval函数',
  `params` tinytext COMMENT 'url 后的请求参数',
  `ajaxoptions` text,
  `htmloptions` text,
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '谁的树 系统默认的是后台树0 ',
  `group_code` varchar(25) NOT NULL DEFAULT 'sys_admin_menu' COMMENT '归类码表示用途的 一般只需要标记根的用途即可 也可以考虑用eav 但考虑到查询问题 所以引入了此字段',
  PRIMARY KEY (`id`),
  KEY `root` (`root`),
  KEY `lft` (`lft`),
  KEY `rgt` (`rgt`),
  KEY `level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='用nestedset保存树关系';

/*Data for the table `admin_menu` */

insert  into `admin_menu`(`id`,`root`,`lft`,`rgt`,`level`,`label`,`url`,`params`,`ajaxoptions`,`htmloptions`,`is_visible`,`uid`,`group_code`) values (8,8,1,20,1,'top_virtual_root',NULL,NULL,NULL,NULL,1,0,'sys_admin_menu_root'),(9,8,4,7,2,'RELATIONS',NULL,NULL,NULL,NULL,1,0,'sys_admin_menu'),(10,8,2,3,2,'HOME',NULL,NULL,NULL,NULL,1,0,'sys_admin_menu'),(11,8,8,15,2,'user',NULL,NULL,NULL,NULL,1,0,'sys_admin_menu'),(12,8,5,6,3,'relationTypes','/friend/relationshipType/adminAdv',NULL,NULL,NULL,1,0,'sys_admin_menu'),(14,8,11,12,3,'User Profile Manager','/user/profileField/admin',NULL,NULL,NULL,1,0,'sys_admin_menu'),(16,8,9,10,3,'用户管理','/user/admin/admin',NULL,NULL,NULL,1,0,'sys_admin_menu'),(18,8,13,14,3,'新增用户profile字段','/user/profileField/create',NULL,NULL,NULL,1,0,'sys_admin_menu'),(19,8,16,19,2,'modules',NULL,NULL,NULL,NULL,1,0,'sys_admin_menu'),(20,8,17,18,3,'manage','module/admin',NULL,NULL,NULL,1,0,'sys_admin_menu');

/*Table structure for table `badge` */

DROP TABLE IF EXISTS `badge`;

CREATE TABLE `badge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `slug` varchar(32) NOT NULL,
  `desc` text,
  `exp` int(11) DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `user_count` int(11) DEFAULT '0',
  `t_insert` datetime DEFAULT NULL,
  `t_update` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `badge_slug_ukey` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `badge` */

insert  into `badge`(`id`,`name`,`slug`,`desc`,`exp`,`active`,`user_count`,`t_insert`,`t_update`) values (1,'First login','login-first','Logged for the first time',0,1,0,NULL,NULL),(2,'List viewer','list-my','View my badges',0,1,0,NULL,NULL);

/*Table structure for table `cmt_thread` */

DROP TABLE IF EXISTS `cmt_thread`;

CREATE TABLE `cmt_thread` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `root` int(10) unsigned DEFAULT NULL,
  `lft` int(10) unsigned NOT NULL,
  `rgt` int(10) unsigned NOT NULL,
  `level` smallint(5) unsigned NOT NULL,
  `cmt_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `root` (`root`),
  KEY `lft` (`lft`),
  KEY `rgt` (`rgt`),
  KEY `level` (`level`),
  KEY `cmt_id` (`cmt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmt_thread` */

/*Table structure for table `dashboard` */

DROP TABLE IF EXISTS `dashboard`;

CREATE TABLE `dashboard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `position` varchar(50) CHARACTER SET armscii8 COLLATE armscii8_bin NOT NULL DEFAULT '146,383',
  `render` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `size` varchar(50) NOT NULL DEFAULT '334,140',
  `allowdelete` tinyint(4) NOT NULL,
  `ajaxrequest` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

/*Data for the table `dashboard` */

insert  into `dashboard`(`id`,`user_id`,`title`,`content`,`position`,`render`,`active`,`size`,`allowdelete`,`ajaxrequest`) values (32,0,'Ajax demo1','','170.5500030517578,123.63333129882812','',1,'207,41',0,'/sdashboard/dashboard/demoAjax'),(35,0,'A second portlet','with some content but [b]no ajax[/b]','178,367.08331298828125','',1,'218,51',0,''),(36,0,'Default portlet','[size=200]A default portlet[/size]','159,628.0908813476562','',1,'296,87',0,'');

/*Table structure for table `group` */

DROP TABLE IF EXISTS `group`;

CREATE TABLE `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `creator` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` enum('public','private','private-member-invite','private-self-invite') NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `group` */

insert  into `group`(`id`,`name`,`description`,`creator`,`created`,`type`,`active`) values (1,'test1','sdfsdfsdf',1,'2012-08-18 14:21:45','public',1);

/*Table structure for table `group_member` */

DROP TABLE IF EXISTS `group_member`;

CREATE TABLE `group_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT '0',
  `requested` tinyint(1) NOT NULL DEFAULT '0',
  `invited` tinyint(1) NOT NULL DEFAULT '0',
  `requested_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `invited_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `join_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `inviter` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `group_member` */

/*Table structure for table `group_topic` */

DROP TABLE IF EXISTS `group_topic`;

CREATE TABLE `group_topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `creator` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `group` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `group_topic` */

insert  into `group_topic`(`id`,`name`,`creator`,`created`,`active`,`group`) values (1,'test topic',1,'2012-08-18 15:16:00',1,1),(2,'test2',1,'2012-08-18 16:38:32',1,1);

/*Table structure for table `msg` */

DROP TABLE IF EXISTS `msg`;

CREATE TABLE `msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` int(11) NOT NULL,
  `recipient` int(11) NOT NULL,
  `sent` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `read` tinyint(1) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `msg` */

insert  into `msg`(`id`,`sender`,`recipient`,`sent`,`read`,`subject`,`message`) values (12,1,2,'2012-08-14 23:16:14',1,'斯蒂芬','斯蒂芬'),(13,1,2,'2012-08-14 23:18:03',1,'速度飞洒地方','斯蒂芬 '),(14,1,2,'2012-08-14 23:18:03',1,'速度飞洒地方','斯蒂芬 '),(15,1,2,'2012-08-14 23:20:40',1,'中文还是可以的啦','吼吼吼吼吼'),(16,1,1,'2012-08-14 23:23:41',1,'收到发送到','地方规定发给'),(17,1,3,'2012-08-18 16:28:57',0,'dfgdsf','sdfsdfs'),(18,1,2,'2012-11-09 13:04:20',0,'sdfsdf','dfgdfgdfgdf');

/*Table structure for table `photo` */

DROP TABLE IF EXISTS `photo`;

CREATE TABLE `photo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned DEFAULT NULL,
  `album_id` int(10) NOT NULL DEFAULT '0',
  `title` varchar(255) DEFAULT '',
  `desc` text NOT NULL,
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'resized max deminsion for display',
  `orig_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'original uploaded image',
  `ext` varchar(4) NOT NULL DEFAULT '',
  `size` varchar(10) DEFAULT '',
  `tags` varchar(255) NOT NULL DEFAULT '',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `rate` float NOT NULL DEFAULT '0',
  `rate_count` int(11) NOT NULL DEFAULT '0',
  `cmt_count` int(11) NOT NULL DEFAULT '0',
  `is_featured` tinyint(4) NOT NULL DEFAULT '0',
  `status` enum('approved','disapproved','pending') NOT NULL DEFAULT 'pending',
  `hash` varchar(32) NOT NULL DEFAULT '',
  `categories` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Hash` (`hash`),
  KEY `Owner` (`uid`),
  KEY `Date` (`create_time`),
  FULLTEXT KEY `ftMain` (`title`,`tags`,`desc`,`categories`),
  FULLTEXT KEY `ftTags` (`tags`),
  FULLTEXT KEY `ftCategories` (`categories`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `photo` */

insert  into `photo`(`id`,`uid`,`album_id`,`title`,`desc`,`path`,`orig_path`,`ext`,`size`,`tags`,`create_time`,`views`,`rate`,`rate_count`,`cmt_count`,`is_featured`,`status`,`hash`,`categories`) values (7,1,17,NULL,'','uploads/photo/14b78418_1_0580202001354080827.gif','uploads/photo/14b78418_1_0572068001354080827.gif','',NULL,'',0,8,4,5,0,0,'pending','150ea03ec2e732c40cc6f2d67e7b738f',''),(6,1,17,NULL,'','uploads/photo/14b78418_1_0536732001354080827.jpg','uploads/photo/14b78418_1_0354406001354080827.jpg','',NULL,'',0,4,4,5,0,0,'pending','4fdd716936ea044df6bfb7f7fd1b5f4d',''),(5,1,17,NULL,'','uploads/photo/14b78418_1_0186442001354080827.jpg','uploads/photo/14b78418_1_0904550001354080826.jpg','',NULL,'',0,4,3.3333,3,0,0,'pending','889db8de76d6801e6d54d038e265e85b',''),(8,1,14,'klll','','uploads/photo/14b78418_1_0149329001354082256.jpg','uploads/photo/14b78418_1_0967305001354082255.jpg','',NULL,'',0,1,0,0,0,0,'pending','7b906bf144e9780e836e4ff7790c7f33',''),(9,1,18,NULL,'','uploads/photo/14b78418_1_0469778001354083471.gif','uploads/photo/14b78418_1_0434331001354083471.gif','',NULL,'',0,6,4,2,0,0,'pending','35f235aec029932f729686997bb56282',''),(10,1,18,'sdf','','uploads/photo/14b78418_1_0695832001354115228.jpg','uploads/photo/14b78418_1_0415269001354115215.jpg','',NULL,'',0,12,5,3,0,0,'pending','f140b59579d9a0e37e2635250d13d1e6',''),(11,1,14,'dsfsdfdf','','uploads/photo/14b78418_1_0338850001354202427.gif','uploads/photo/14b78418_1_0779175001354202426.gif','',NULL,'',0,2,5,1,0,0,'pending','99f201acbb1706cf46e2600716c14255',''),(12,1,14,'dsfsdfdf','','uploads/photo/14b78418_1_0786619001354202427.gif','uploads/photo/14b78418_1_0774837001354202427.gif','',NULL,'',0,0,3,1,0,0,'pending','8e80c03905ece04f05d5d0643865acbe',''),(13,1,14,'dsfsdfdf','','uploads/photo/14b78418_1_0846882001354202427.jpg','uploads/photo/14b78418_1_0795038001354202427.jpg','',NULL,'',0,1,5,1,0,0,'pending','c866ab522343b1f80d153283d1d14846',''),(14,2,19,'yteen','','uploads/photo/14b78418_2_0576444001354434888.jpg','uploads/photo/14b78418_2_0216119001354434888.jpg','',NULL,'',0,47,5,2,0,0,'pending','d7f69143f8e937b31fc85c42414bc980',''),(15,2,19,'yteen','','uploads/photo/14b78418_2_0903833001354434888.jpg','uploads/photo/14b78418_2_0862540001354434888.jpg','',NULL,'',0,40,3.5,2,0,0,'pending','3f4148cf362badc0c9b6ec71fc3b84e3',''),(16,2,20,'fgdfg','','uploads/photo/14b78418_2_0620196001354435271.gif','uploads/photo/14b78418_2_0436555001354435271.gif','',NULL,'',0,0,4,2,0,0,'pending','fe8c3a4a952e2c6a5e17dca4046d1ab2',''),(17,2,20,'fgdfg','','uploads/photo/14b78418_2_0706584001354435271.jpg','uploads/photo/14b78418_2_0662943001354435271.jpg','',NULL,'',0,16,3.5,2,0,0,'pending','c6d4f4aeb8077329252f303218bff299',''),(18,1,14,'dsfsdf','','uploads/photo/14b78418_1_0165501001354603881.gif','uploads/photo/14b78418_1_0000093001354603879.gif','',NULL,'',0,5,5,1,0,0,'pending','84efd6df578978564df480a70eecf953',''),(19,1,17,'dd','','uploads/photo/14b78418_1_0874141001354718058.gif','uploads/photo/14b78418_1_0783212001354718057.gif','',NULL,'',0,18,4,2,0,0,'pending','99a7ad42c41ba8d70145cbbea343292f',''),(20,1,18,'的','','uploads/photo/14b78418_1_0268352001355038984.jpg','uploads/photo/14b78418_1_0375692001355038981.jpg','',NULL,'',0,2,5,1,0,0,'pending','5aecb131e0487aea7445d233545781e4',''),(21,1,18,'的','','uploads/photo/14b78418_1_0455574001355038989.jpg','uploads/photo/14b78418_1_0333254001355038989.jpg','',NULL,'',0,1,5,1,0,0,'pending','eb2c823e25120f00f269899aec06129d','');

/*Table structure for table `photo_album` */

DROP TABLE IF EXISTS `photo_album`;

CREATE TABLE `photo_album` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `name` varchar(60) NOT NULL,
  `desc` varchar(255) DEFAULT '',
  `create_time` int(11) unsigned DEFAULT NULL,
  `update_time` int(11) unsigned DEFAULT NULL,
  `cover_uri` varchar(255) DEFAULT NULL,
  `mbr_count` int(11) DEFAULT '0',
  `views` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `is_hot` varchar(1) NOT NULL DEFAULT '0',
  `privacy` tinyint(1) DEFAULT NULL,
  `privacy_data` text,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `cTime` (`create_time`),
  KEY `mTime` (`update_time`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `photo_album` */

insert  into `photo_album`(`id`,`uid`,`name`,`desc`,`create_time`,`update_time`,`cover_uri`,`mbr_count`,`views`,`status`,`is_hot`,`privacy`,`privacy_data`) values (15,3,'dii','yiing2\r\n',NULL,NULL,NULL,0,0,1,'0',NULL,NULL),(18,1,'njia',NULL,NULL,NULL,NULL,0,0,1,'0',NULL,NULL),(19,2,'test','hhehhe\r\n',NULL,NULL,NULL,0,0,1,'0',NULL,NULL),(14,1,'jj','pp\r\n',NULL,NULL,NULL,0,0,1,'0',NULL,NULL),(20,2,'tt','jj\r\n',NULL,NULL,NULL,0,0,1,'0',NULL,NULL),(10,1,'danteng','pp',NULL,NULL,NULL,0,0,1,'0',NULL,NULL),(17,1,'danteng','pp',NULL,NULL,NULL,0,0,1,'0',NULL,NULL),(13,1,'速度飞洒地方','速度飞洒地方',NULL,NULL,NULL,0,0,1,'0',NULL,NULL),(16,3,'罪人','啊',NULL,NULL,NULL,0,0,1,'0',NULL,NULL);

/*Table structure for table `photo_album_cmt` */

DROP TABLE IF EXISTS `photo_album_cmt`;

CREATE TABLE `photo_album_cmt` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id 主键',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '对评论的评论',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论的目标id 即ar的主键',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'author_id 评论者 0 表示游客身份',
  `content` text NOT NULL COMMENT '评论内容',
  `mood` tinyint(4) NOT NULL DEFAULT '0' COMMENT '心情',
  `rate` int(11) NOT NULL DEFAULT '0' COMMENT '投票总分 5星制',
  `rate_count` int(11) NOT NULL DEFAULT '0' COMMENT '投票次数',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '评论的时间',
  `replies` int(11) NOT NULL DEFAULT '0' COMMENT '回复数',
  PRIMARY KEY (`id`),
  KEY `cmt_object_id` (`object_id`,`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `photo_album_cmt` */

/*Table structure for table `photo_cmt` */

DROP TABLE IF EXISTS `photo_cmt`;

CREATE TABLE `photo_cmt` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id 主键',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '对评论的评论',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论的目标id 即ar的主键',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'author_id 评论者 0 表示游客身份',
  `content` text NOT NULL COMMENT '评论内容',
  `mood` tinyint(4) NOT NULL DEFAULT '0' COMMENT '心情',
  `rate` int(11) NOT NULL DEFAULT '0' COMMENT '投票总分 5星制',
  `rate_count` int(11) NOT NULL DEFAULT '0' COMMENT '投票次数',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '评论的时间',
  `replies` int(11) NOT NULL DEFAULT '0' COMMENT '回复数',
  PRIMARY KEY (`id`),
  KEY `cmt_object_id` (`object_id`,`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `photo_cmt` */

/*Table structure for table `photo_favorite` */

DROP TABLE IF EXISTS `photo_favorite`;

CREATE TABLE `photo_favorite` (
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '目标对象ar的id',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动作执行者',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`object_id`,`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `photo_favorite` */

/*Table structure for table `photo_rating` */

DROP TABLE IF EXISTS `photo_rating`;

CREATE TABLE `photo_rating` (
  `pt_id` int(10) unsigned NOT NULL DEFAULT '0',
  `pt_rating_count` int(11) NOT NULL DEFAULT '0',
  `pt_rating_sum` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `med_id` (`pt_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `photo_rating` */

insert  into `photo_rating`(`pt_id`,`pt_rating_count`,`pt_rating_sum`) values (7,5,20),(5,3,10),(6,5,20),(10,3,15),(9,2,8),(14,2,10),(17,2,7),(16,2,8),(15,2,7),(19,2,8),(18,1,5),(13,1,5),(11,1,5),(12,1,3),(21,1,5),(20,1,5);

/*Table structure for table `photo_view_track` */

DROP TABLE IF EXISTS `photo_view_track`;

CREATE TABLE `photo_view_track` (
  `id` int(10) unsigned NOT NULL,
  `viewer` int(10) unsigned NOT NULL,
  `ip` int(10) unsigned NOT NULL,
  `ts` int(10) unsigned NOT NULL,
  KEY `id` (`id`,`viewer`,`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `photo_view_track` */

insert  into `photo_view_track`(`id`,`viewer`,`ip`,`ts`) values (10,1,0,1354295444),(7,1,0,1354295801),(6,1,0,1354295834),(6,2,0,1354295922),(7,2,0,1354295977),(9,1,0,1354297211),(5,1,0,1354334958),(14,2,16777343,1355036255),(15,2,16777343,1354976719),(10,2,16777343,1354686988),(17,2,16777343,1354963048),(5,2,16777343,1354442196),(13,1,16777343,1354518829),(6,0,16777343,1354554312),(17,0,16777343,1354673645),(5,0,16777343,1354554792),(15,0,16777343,1354555918),(14,1,16777343,1354690616),(18,1,16777343,1354603897),(14,0,16777343,1354673645),(15,1,16777343,1354680083),(7,0,16777343,1354716174),(8,1,16777343,1354717798),(19,1,16777343,1354718065),(19,0,16777343,1354724009),(17,1,16777343,1354726037),(11,1,16777343,1354728667),(18,0,16777343,1355038837),(18,2,16777343,1354972425),(19,2,16777343,1354972548),(20,1,16777343,1355038998),(21,1,16777343,1355042194);

/*Table structure for table `photo_vote_track` */

DROP TABLE IF EXISTS `photo_vote_track`;

CREATE TABLE `photo_vote_track` (
  `pt_id` int(10) unsigned NOT NULL DEFAULT '0',
  `pt_ip` varchar(20) DEFAULT NULL,
  `pt_date` datetime DEFAULT NULL,
  KEY `med_ip` (`pt_ip`,`pt_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `photo_vote_track` */

insert  into `photo_vote_track`(`pt_id`,`pt_ip`,`pt_date`) values (19,'127.0.0.1','2012-12-06 00:50:04'),(7,'127.0.0.1','2012-12-06 00:49:40'),(10,'127.0.0.1','2012-12-06 00:48:57'),(9,'127.0.0.1','2012-12-06 00:48:52'),(16,'127.0.0.1','2012-12-06 00:47:31'),(17,'127.0.0.1','2012-12-06 00:47:21'),(15,'127.0.0.1','2012-12-06 00:46:56'),(14,'127.0.0.1','2012-12-06 00:46:48'),(18,'127.0.0.1','2012-12-06 01:31:28'),(13,'127.0.0.1','2012-12-06 01:31:34'),(11,'127.0.0.1','2012-12-06 01:31:39'),(12,'127.0.0.1','2012-12-06 01:31:54'),(6,'127.0.0.1','2012-12-06 15:23:25'),(5,'127.0.0.1','2012-12-06 15:23:48'),(21,'127.0.0.1','2012-12-09 16:14:02'),(20,'127.0.0.1','2012-12-09 16:14:24');

/*Table structure for table `relationship` */

DROP TABLE IF EXISTS `relationship`;

CREATE TABLE `relationship` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'A unique ID for the relationship between the two users',
  `type` int(11) NOT NULL COMMENT 'The type of relationship (a reference to the relationship_types table)',
  `user_a` int(11) NOT NULL COMMENT 'The user who initiated the relationship, a relation to the users table',
  `user_b` int(11) NOT NULL COMMENT 'The user who usera initiated a relationship with, a relation to the users table',
  `accepted` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Indicates if this is a mutual relationship (which is only used if the relationship type is a mutual relationship)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `relationship` */

insert  into `relationship`(`id`,`type`,`user_a`,`user_b`,`accepted`) values (1,1,1,2,1),(2,1,1,3,1),(3,1,1,1,1),(4,1,3,2,1),(5,1,3,3,1),(6,1,2,2,1);

/*Table structure for table `relationship_type` */

DROP TABLE IF EXISTS `relationship_type`;

CREATE TABLE `relationship_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'A unique ID for the relationship type',
  `name` varchar(25) NOT NULL COMMENT 'The name of the relationship type, for example, friend',
  `plural_name` varchar(25) DEFAULT NULL COMMENT 'Plural version of the relationship type,for example, friends',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'If this relationship type is active, and should users be able to form such relationships?',
  `mutual` tinyint(1) DEFAULT '1' COMMENT 'Does this relationship require it to be a mutual connection, or can users connect without the permission of the other?',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `relationship_type` */

insert  into `relationship_type`(`id`,`name`,`plural_name`,`active`,`mutual`) values (1,'Friend','friends',1,1),(2,'Colleague','Colleagues',1,1),(3,'Jogging buddies','Jogging buddies',1,1);

/*Table structure for table `settings` */

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(64) NOT NULL DEFAULT 'system',
  `key` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_key` (`category`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `settings` */

insert  into `settings`(`id`,`category`,`key`,`value`) values (1,'cate1','key1','s:27:\"hello actionTestCmsSettings\";'),(2,'action_feed','Relationship','s:61:\"application.modules.friend.components.RelationshipFeedHandler\";'),(3,'cate1','key2','a:2:{s:1:\"k\";s:1:\"v\";s:2:\"k2\";i:2;}');

/*Table structure for table `status` */

DROP TABLE IF EXISTS `status`;

CREATE TABLE `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID of the status',
  `update` longtext NOT NULL COMMENT 'The content of the update',
  `type` int(11) NOT NULL COMMENT 'Reference to the status types table',
  `creator` int(11) NOT NULL COMMENT 'The ID of the poster',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time status was posted',
  `profile` int(11) NOT NULL COMMENT 'Profile the status was posted on',
  `approved` tinyint(1) DEFAULT '1' COMMENT 'If the status is approved or notIf the status is approved or not',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

/*Data for the table `status` */

insert  into `status`(`id`,`update`,`type`,`creator`,`created`,`profile`,`approved`) values (1,'hi  welcome to my space just test',1,1,'2012-08-15 12:25:53',1,1),(2,'realy funny',1,1,'2012-08-15 12:36:44',1,1),(3,'good good study day day up',1,1,'2012-08-15 12:40:20',1,1),(4,'yes',1,1,'2012-08-15 12:41:27',1,1),(5,'说的方法斯蒂芬发',1,1,'2012-08-15 12:43:29',1,1),(6,'速度飞洒地方',1,1,'2012-08-15 12:52:15',1,1),(7,'funny video',3,1,'2012-08-15 13:00:30',1,1),(8,'asadfsdf',3,1,'2012-08-15 13:01:03',1,1),(9,'this is great framework',4,1,'2012-08-15 13:01:49',1,1),(10,'this is great framework',4,1,'2012-08-15 13:03:21',1,1),(11,'sdfsdf',2,1,'2012-08-15 13:07:04',1,1),(12,'sdfsdfsadf',2,1,'2012-08-15 13:07:58',1,1),(13,'dff',2,1,'2012-08-15 13:09:17',1,1),(14,'sdfsdf',2,1,'2012-08-15 13:13:25',1,1),(15,'呵呵呵给你这六个眼',1,1,'2012-08-15 13:26:27',2,1),(16,'sdgfdsfg',1,2,'2012-08-15 13:36:13',2,1),(17,'hehhe 给管理员试试',1,2,'2012-08-15 13:36:43',1,1),(18,'阿斯顿飞说道',2,1,'2012-08-15 13:44:26',1,1),(19,'hello  i love 有',1,1,'2012-08-15 14:54:32',2,1),(20,'ffsadfsd',1,1,'2012-08-15 23:57:43',1,1),(21,'sdfsdfsd',1,1,'2012-08-16 12:26:43',1,1),(22,'thy it',1,1,'2012-08-16 14:05:55',3,1),(23,'hehahha it works ',1,1,'2012-08-16 14:06:18',3,1),(24,'测试发送图片',2,1,'2012-08-16 18:24:26',1,1),(25,'jj pp',1,2,'2012-08-16 23:13:04',1,1),(26,'ffdgdfgdfs',1,1,'2012-08-17 16:18:02',1,1),(27,'sdfsdf',2,1,'2012-08-17 16:18:32',1,1),(28,'蛋疼的表情',1,1,'2012-08-19 09:39:36',2,1),(29,'fdgdfg',2,1,'2012-08-24 22:03:01',1,1),(30,'今天把actionFeed 算搞的差不多了 算是比较难的一个主题了',1,2,'2012-08-28 18:18:33',2,1),(31,'主要参考了这个',4,2,'2012-08-28 18:19:31',2,1),(32,'投票系统的设计：',4,1,'2012-09-13 21:41:44',1,1),(33,'投票设计',4,1,'2012-09-13 21:46:53',1,1),(34,'地发生地方',2,1,'2012-10-27 23:59:00',1,1),(35,'啊呀呀呀呀和',1,1,'2012-11-01 12:26:28',1,1),(36,'呀呀呀哟',1,1,'2012-11-05 23:45:48',1,1),(37,'地发生地方说的方法斯蒂芬',2,3,'2012-11-05 23:47:46',3,1),(38,'ekjjdsjjfjsajdf',1,1,'2012-11-06 12:42:04',1,1),(39,'dsafsdf',2,1,'2012-11-06 12:42:40',1,1),(40,'泡别人那里 发表东东去了',1,1,'2012-11-06 12:43:59',3,1),(41,'撒旦随碟附送',1,1,'2012-11-06 13:37:02',1,1),(42,'jjjjjjjjjj',1,1,'2012-11-07 23:26:48',2,1),(43,'sdfsdfsdf',1,1,'2012-11-20 11:07:04',1,1);

/*Table structure for table `status_image` */

DROP TABLE IF EXISTS `status_image`;

CREATE TABLE `status_image` (
  `id` int(11) NOT NULL,
  `image` varchar(255) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `status_image` */

insert  into `status_image`(`id`,`image`) values (11,'1345007223_1345007223.jpg'),(12,'1345007278_1345007278.jpg'),(13,'1345007357_1345007357.jpg'),(14,'uploads/status/1345007605_1345007605.gif'),(18,'uploads/status/1345009466_1345009466.jpg'),(24,'uploads/status/1345112665_1345112665.jpg'),(27,'uploads/status/1345191512_1345191512.jpg'),(29,'uploads/status/1345816981_1345816981.jpg'),(34,'uploads/status/1351353539_1351353539.gif'),(37,'uploads/status/1352130465_1352130465.gif'),(39,'uploads/status/1352176959_1352176959.jpg');

/*Table structure for table `status_link` */

DROP TABLE IF EXISTS `status_link`;

CREATE TABLE `status_link` (
  `id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `status_link` */

insert  into `status_link`(`id`,`url`,`description`) values (33,'http://stackoverflow.com/questions/3433391/how-to-restrict-user-not-to-vote-an-article-more-than-once','禁止多次投票');

/*Table structure for table `status_plugin` */

DROP TABLE IF EXISTS `status_plugin`;

CREATE TABLE `status_plugin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID of the status plugin',
  `name` varchar(25) NOT NULL COMMENT 'The name of the type of status',
  `type_reference` varchar(120) NOT NULL COMMENT 'A machine readable name for the type, used as the file name of template bits (that is, no spaces or punctuation)',
  `description` varchar(255) NOT NULL,
  `plugin_class` varchar(255) NOT NULL COMMENT 'the class for this type',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `status_plugin` */

/*Table structure for table `status_type` */

DROP TABLE IF EXISTS `status_type`;

CREATE TABLE `status_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID of the status type',
  `type_name` varchar(25) NOT NULL COMMENT 'The name of the type of status',
  `type_reference` varchar(120) NOT NULL COMMENT 'A machine readable name for the type, used as the file name of template bits (that is, no spaces or punctuation)',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Indicates whether the status type is active or not',
  `type_name_other` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `status_type` */

insert  into `status_type`(`id`,`type_name`,`type_reference`,`active`,`type_name_other`) values (1,'Changed their status to','update',1,''),(2,'Posted an image','image',1,''),(3,'Uploaded a video','video',1,''),(4,'Posted a link','link',1,'');

/*Table structure for table `status_video` */

DROP TABLE IF EXISTS `status_video`;

CREATE TABLE `status_video` (
  `id` int(11) NOT NULL,
  `video_id` varchar(50) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `status_video` */

insert  into `status_video`(`id`,`video_id`) values (7,'YCiY1y3uJ3o'),(8,'YCiY1y3uJ3o');

/*Table structure for table `sys_event` */

DROP TABLE IF EXISTS `sys_event`;

CREATE TABLE `sys_event` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `from_module` varchar(128) NOT NULL DEFAULT '''app''' COMMENT 'from unit name , equal to the module id',
  `action` varchar(125) NOT NULL DEFAULT 'none' COMMENT 'action name : n+v or v+n (deleteUser or userDelete)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `alert_handler` (`from_module`,`action`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `sys_event` */

/*Table structure for table `sys_event2listener` */

DROP TABLE IF EXISTS `sys_event2listener`;

CREATE TABLE `sys_event2listener` (
  `event_id` int(11) NOT NULL,
  `listener_id` int(11) NOT NULL,
  PRIMARY KEY (`event_id`,`listener_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_event2listener` */

/*Table structure for table `sys_event_listener` */

DROP TABLE IF EXISTS `sys_event_listener`;

CREATE TABLE `sys_event_listener` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `class` varchar(128) NOT NULL DEFAULT '',
  `file` varchar(255) NOT NULL DEFAULT '',
  `eval` text,
  `from_module` varchar(50) NOT NULL DEFAULT '''app''' COMMENT 'from wich module default is app means from sys',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `sys_event_listener` */

/*Table structure for table `sys_hook` */

DROP TABLE IF EXISTS `sys_hook`;

CREATE TABLE `sys_hook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host_module` varchar(80) NOT NULL DEFAULT '''app''' COMMENT '宿主模块id',
  `hook_name` varchar(255) NOT NULL COMMENT '钩子名称executionPoint执行点 键值而已 如blogCreate',
  `client_module` varchar(80) NOT NULL DEFAULT '''app''' COMMENT '挂接方模块id',
  `client_hook_name` varchar(255) NOT NULL COMMENT '挂接方hook名字 用来删除的如blogOnUserDelete',
  `hook_content` text NOT NULL COMMENT '序列化或其他格式存储的hook内容自己定义解析格式',
  `priority` tinyint(5) NOT NULL DEFAULT '0' COMMENT '优先级',
  `type` varchar(25) NOT NULL DEFAULT '''custom''' COMMENT 'custome,action,filter',
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQUE` (`client_hook_name`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

/*Data for the table `sys_hook` */

insert  into `sys_hook`(`id`,`host_module`,`hook_name`,`client_module`,`client_hook_name`,`hook_content`,`priority`,`type`,`create_time`) values (117,'app','test','app','appOnAppTest2','dddhi can not be blank ',0,'\'custom\'',1353774204),(126,'app','createUrl','photo','photo_appCreateUrl','{\"route\":[\"album\\/member\",\"\\/album\\/member\"],\"paramsExpression\":\"isset($_GET[\'u\'])?$params+array(\'u\'=>$_GET[\'u\']):$params;\"}',0,'\'custom\'',1354555272);

/*Table structure for table `sys_module` */

DROP TABLE IF EXISTS `sys_module`;

CREATE TABLE `sys_module` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` varchar(32) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `vendor` varchar(64) NOT NULL DEFAULT '',
  `version` varchar(32) NOT NULL DEFAULT '',
  `dependencies` varchar(255) NOT NULL DEFAULT '',
  `ctime` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

/*Data for the table `sys_module` */

insert  into `sys_module`(`id`,`module_id`,`title`,`vendor`,`version`,`dependencies`,`ctime`) values (44,'friend','','','','',1346038195);

/*Table structure for table `sys_object_cmt` */

DROP TABLE IF EXISTS `sys_object_cmt`;

CREATE TABLE `sys_object_cmt` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_name` varchar(50) NOT NULL,
  `table_cmt` varchar(50) NOT NULL,
  `table_track` varchar(50) NOT NULL,
  `per_view` smallint(6) NOT NULL,
  `is_ratable` smallint(1) NOT NULL,
  `is_on` smallint(1) NOT NULL,
  `is_mood` smallint(1) NOT NULL,
  `trigger_table` varchar(32) NOT NULL,
  `trigger_field_id` varchar(32) NOT NULL,
  `trigger_field_cmts` varchar(32) NOT NULL,
  `class` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `sys_object_cmt` */

/*Table structure for table `sys_object_view` */

DROP TABLE IF EXISTS `sys_object_view`;

CREATE TABLE `sys_object_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '唯一 一般是ar类名称',
  `table_track` varchar(32) NOT NULL COMMENT '跟踪每次点击的表名',
  `period` int(11) NOT NULL DEFAULT '86400' COMMENT '多长时间内不重复累积',
  `trigger_table` varchar(32) NOT NULL COMMENT '触发的主表 即ar所对应的表名',
  `trigger_field_id` varchar(32) NOT NULL DEFAULT '''id''' COMMENT '主键名称',
  `trigger_field_views` varchar(32) NOT NULL DEFAULT '''views''' COMMENT '记录点击量的字段名称',
  `enable` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否启用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `sys_object_view` */

insert  into `sys_object_view`(`id`,`name`,`table_track`,`period`,`trigger_table`,`trigger_field_id`,`trigger_field_views`,`enable`) values (21,'photo','photo_view_track',86400,'photo','id','views',1);

/*Table structure for table `sys_object_vote` */

DROP TABLE IF EXISTS `sys_object_vote`;

CREATE TABLE `sys_object_vote` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_name` varchar(50) NOT NULL COMMENT 'ar 的类名',
  `table_rating` varchar(50) NOT NULL COMMENT 'rating表名字',
  `table_track` varchar(50) NOT NULL COMMENT '投票跟踪表 防止重复投票',
  `row_prefix` varchar(20) NOT NULL COMMENT '行前缀 join表时防止冲突',
  `max_votes` smallint(2) NOT NULL COMMENT '最大投票数 一般是5',
  `duplicate_sec` int(10) NOT NULL COMMENT '判断是重复的秒数阈值',
  `trigger_table` varchar(60) NOT NULL,
  `trigger_field_rate` varchar(60) NOT NULL,
  `trigger_field_rate_count` varchar(60) NOT NULL,
  `trigger_field_id` varchar(60) NOT NULL,
  `override_class` varchar(256) NOT NULL DEFAULT '' COMMENT '重载类别名 最好用相对于applicaiton的',
  `post_name` varchar(50) NOT NULL DEFAULT 'rate' COMMENT '投票时用的postParam名称',
  `is_on` smallint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `sys_object_vote` */

insert  into `sys_object_vote`(`id`,`object_name`,`table_rating`,`table_track`,`row_prefix`,`max_votes`,`duplicate_sec`,`trigger_table`,`trigger_field_rate`,`trigger_field_rate_count`,`trigger_field_id`,`override_class`,`post_name`,`is_on`) values (19,'photo','photo_rating','photo_vote_track','pt_',5,0,'photo','rate','rate_count','id','','rate',1);

/*Table structure for table `tbl_comments` */

DROP TABLE IF EXISTS `tbl_comments`;

CREATE TABLE `tbl_comments` (
  `object_name` varchar(50) NOT NULL,
  `object_id` int(12) NOT NULL,
  `cmt_id` int(12) NOT NULL AUTO_INCREMENT,
  `cmt_parent_id` int(12) DEFAULT NULL,
  `author_id` int(12) DEFAULT NULL,
  `user_name` varchar(128) DEFAULT NULL,
  `user_email` varchar(128) DEFAULT NULL,
  `cmt_text` text,
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  `cmt_replies` int(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cmt_id`),
  KEY `owner_name` (`object_name`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

/*Data for the table `tbl_comments` */

insert  into `tbl_comments`(`object_name`,`object_id`,`cmt_id`,`cmt_parent_id`,`author_id`,`user_name`,`user_email`,`cmt_text`,`create_time`,`update_time`,`status`,`cmt_replies`) values ('User',1,29,0,1,NULL,NULL,'sdfsdgdfgdsf',1354983552,1354984184,2,0),('User',1,30,0,1,NULL,NULL,'sdfsdgsdg',1354983558,1354984182,2,0),('User',1,31,0,1,NULL,NULL,'sdgdfgdf',1354983571,1354984179,2,0),('User',2,32,0,2,NULL,NULL,'weeert',1354983805,NULL,1,0),('User',2,33,0,2,NULL,NULL,'afsdfgdfdfgdf',1354983814,NULL,1,0),('User',2,34,0,2,NULL,NULL,'wefsadgsdafg',1354983829,1355032768,2,0),('User',1,35,0,1,NULL,NULL,'dfggg',1355042449,NULL,1,0),('User',1,36,0,1,NULL,NULL,'sdfgdfg',1355042455,NULL,1,0),('User',1,37,0,1,NULL,NULL,'hhhhhh\r\n',1355042468,NULL,1,0),('User',1,38,0,1,NULL,NULL,'dsfsdgsdfgsdfg',1355042473,NULL,1,0),('User',1,39,0,1,NULL,NULL,'ppjj',1355042480,NULL,1,0),('User',1,40,0,1,NULL,NULL,'dsgdsfgfdh',1355042492,NULL,1,0),('User',1,41,40,1,NULL,NULL,'dsfsfsadf',1355043372,1355047464,2,0),('User',1,42,41,1,NULL,NULL,'dsfsdfsdf',1355043385,1355047460,2,0),('User',1,43,42,1,NULL,NULL,'efsdgdsfgdfsgdsfgdsf',1355043391,1355045343,2,0),('User',1,44,43,1,NULL,NULL,'sdfsadgsdfgsd',1355043395,1355045317,2,0),('User',1,45,44,1,NULL,NULL,'sdgfdfgdfhgfdg',1355043400,NULL,1,0),('User',1,46,45,1,NULL,NULL,'sdfsdfgdfgdfh',1355043406,1355045295,2,0),('User',1,47,46,1,NULL,NULL,'sdfgdfgfdghfgh',1355043410,NULL,1,0),('User',1,48,47,1,NULL,NULL,'dfgdfghdfgh',1355043414,NULL,1,0),('User',1,49,48,1,NULL,NULL,'dfghfghfgh',1355043418,NULL,1,0),('User',1,50,49,1,NULL,NULL,'sfdfhfghfgh',1355043422,NULL,1,0),('User',1,51,36,1,NULL,NULL,'ffffffffg',1355047450,1355047455,2,0);

/*Table structure for table `tbl_migration` */

DROP TABLE IF EXISTS `tbl_migration`;

CREATE TABLE `tbl_migration` (
  `version` varchar(255) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_migration` */

insert  into `tbl_migration`(`version`,`apply_time`) values ('m000000_000000_base',1343115971),('m110805_153437_installYiiUser',1343115996),('m110810_162301_userTimestampFix',1343115996);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(128) NOT NULL DEFAULT '',
  `email` varchar(128) NOT NULL DEFAULT '',
  `activkey` varchar(128) NOT NULL DEFAULT '',
  `superuser` int(1) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '0',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastvisit_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_username` (`username`),
  UNIQUE KEY `user_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`email`,`activkey`,`superuser`,`status`,`create_at`,`lastvisit_at`) values (1,'yiqing','32ee7d239bcc2eff68f47ca70bd6e4a7','webmaster@example.com','8abda1b47ccc436c2aaf3eb5912d3971',1,1,'2012-07-24 15:46:36','2012-12-09 09:59:07'),(2,'yiqing2','32ee7d239bcc2eff68f47ca70bd6e4a7','66104992@qq.com','c1a5a5f7d1cc198d132d2d367ca08877',0,1,'2012-07-27 10:29:01','2012-12-02 07:53:49'),(3,'yiqing3','32ee7d239bcc2eff68f47ca70bd6e4a7','yiqing_95@qq.com','f07550b610f3388b17ffc6b62aecb1ad',0,1,'2012-08-11 14:15:02','2012-11-26 07:56:32');

/*Table structure for table `user_profile` */

DROP TABLE IF EXISTS `user_profile`;

CREATE TABLE `user_profile` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `photo` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_profile_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `user_profile` */

insert  into `user_profile`(`user_id`,`first_name`,`last_name`,`photo`) values (1,'Administrator','Admin','uploads/user/13521981471352198148.jpg'),(2,'qing','yii','uploads/user/13515238331351523833.jpg'),(3,'qing','yii','uploads/user/13518713151351871315.gif');

/*Table structure for table `user_profile_field` */

DROP TABLE IF EXISTS `user_profile_field`;

CREATE TABLE `user_profile_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `varname` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `field_type` varchar(50) NOT NULL DEFAULT '',
  `field_size` int(3) NOT NULL DEFAULT '0',
  `field_size_min` int(3) NOT NULL DEFAULT '0',
  `required` int(1) NOT NULL DEFAULT '0',
  `match` varchar(255) NOT NULL DEFAULT '',
  `range` varchar(255) NOT NULL DEFAULT '',
  `error_message` varchar(255) NOT NULL DEFAULT '',
  `other_validator` text,
  `default` varchar(255) NOT NULL DEFAULT '',
  `widget` varchar(255) NOT NULL DEFAULT '',
  `widgetparams` text,
  `position` int(3) NOT NULL DEFAULT '0',
  `visible` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `user_profile_field` */

insert  into `user_profile_field`(`id`,`varname`,`title`,`field_type`,`field_size`,`field_size_min`,`required`,`match`,`range`,`error_message`,`other_validator`,`default`,`widget`,`widgetparams`,`position`,`visible`) values (1,'first_name','First Name','VARCHAR',255,3,2,'','','Incorrect First Name (length between 3 and 50 characters).','','','','',1,3),(2,'last_name','Last Name','VARCHAR',255,3,2,'','','Incorrect Last Name (length between 3 and 50 characters).','','','','',2,3),(3,'photo','photo','VARCHAR',255,0,0,'','','','','','','',0,3);

/*Table structure for table `yiisession` */

DROP TABLE IF EXISTS `yiisession`;

CREATE TABLE `yiisession` (
  `id` char(32) NOT NULL,
  `expire` int(11) DEFAULT NULL,
  `data` longblob,
  `user_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `yiisession` */

insert  into `yiisession`(`id`,`expire`,`data`,`user_id`) values ('3bpej6kso1cnurkk1uhetc8460',1355053103,'ea7393d1cc9e1969b4c77702b7cf53db__id|s:1:\"1\";ea7393d1cc9e1969b4c77702b7cf53db__name|s:6:\"yiqing\";ea7393d1cc9e1969b4c77702b7cf53db__states|a:0:{}',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
