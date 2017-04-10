/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50146
Source Host           : localhost:3306
Source Database       : easybuy

Target Server Type    : MYSQL
Target Server Version : 50146
File Encoding         : 65001

Date: 2016-04-17 16:03:43
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `eb_address`
-- ----------------------------
DROP TABLE IF EXISTS `eb_address`;
CREATE TABLE `eb_address` (
  `addrid` int(11) NOT NULL AUTO_INCREMENT,
  `province` varchar(32) DEFAULT NULL,
  `city` varchar(32) DEFAULT NULL,
  `area` varchar(32) DEFAULT NULL,
  `street` varchar(256) DEFAULT NULL,
  `receiveUser` varchar(32) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`addrid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of eb_address
-- ----------------------------
INSERT INTO `eb_address` VALUES ('1', '湖北省', '武汉市', '江夏区', '光谷大道光谷金融港A4', '你大哥', '13247116002', '1');

-- ----------------------------
-- Table structure for `eb_admin`
-- ----------------------------
DROP TABLE IF EXISTS `eb_admin`;
CREATE TABLE `eb_admin` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(64) DEFAULT '123456',
  `phone` varchar(16) DEFAULT NULL,
  `power` int(11) DEFAULT '1',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of eb_admin
-- ----------------------------
INSERT INTO `eb_admin` VALUES ('1', 'admin', '123456', '110', '1');

-- ----------------------------
-- Table structure for `eb_category`
-- ----------------------------
DROP TABLE IF EXISTS `eb_category`;
CREATE TABLE `eb_category` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(32) NOT NULL,
  `summary` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of eb_category
-- ----------------------------
INSERT INTO `eb_category` VALUES ('1', '手机', '高端低端各式各样！');

-- ----------------------------
-- Table structure for `eb_customer`
-- ----------------------------
DROP TABLE IF EXISTS `eb_customer`;
CREATE TABLE `eb_customer` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(64) NOT NULL,
  `sex` varchar(8) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of eb_customer
-- ----------------------------
INSERT INTO `eb_customer` VALUES ('1', 'softeem', 'softem112233', null, null, '86639004');

-- ----------------------------
-- Table structure for `eb_goods`
-- ----------------------------
DROP TABLE IF EXISTS `eb_goods`;
CREATE TABLE `eb_goods` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `gname` varchar(64) NOT NULL,
  `price` double DEFAULT NULL,
  `offset` double DEFAULT NULL,
  `publishTime` date DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of eb_goods
-- ----------------------------
INSERT INTO `eb_goods` VALUES ('1', '小米7', '99', '5', '2016-04-17', '100', '1');

-- ----------------------------
-- Table structure for `eb_goodsimgs`
-- ----------------------------
DROP TABLE IF EXISTS `eb_goodsimgs`;
CREATE TABLE `eb_goodsimgs` (
  `imgid` int(11) NOT NULL AUTO_INCREMENT,
  `imgName` varchar(64) NOT NULL,
  `imgPath` varchar(2000) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  PRIMARY KEY (`imgid`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of eb_goodsimgs
-- ----------------------------

-- ----------------------------
-- Table structure for `eb_orders`
-- ----------------------------
DROP TABLE IF EXISTS `eb_orders`;
CREATE TABLE `eb_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNo` varchar(32) NOT NULL,
  `orderCount` int(11) DEFAULT '1',
  `orderTime` date DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `totalPrice` double DEFAULT NULL,
  `addrid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of eb_orders
-- ----------------------------
INSERT INTO `eb_orders` VALUES ('1', '20160417031435', '1', '2016-04-17', '1', '1', '0', '49.5', '1');
