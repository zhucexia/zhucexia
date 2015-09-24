SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- 客户信息表
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` int(11) unsigned auto_increment NOT NULL,
  `type` varchar(32) DEFAULT '0' COMMENT '0: 普通会员    1:企业会员',
  `username` varchar(64) NOT NULL,
  `password` varchar(32) NOT NULL,
  `sex` varchar(1) DEFAULT NULL COMMENT '0: 男，  1: 女',
  `company_name` varchar(128) DEFAULT NULL,
  `company_address` varchar(128) DEFAULT NULL,
  `linkman` varchar(64) DEFAULT NULL,
  `phone_number` varchar(11) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `qq` varchar(20) DEFAULT NULL,
  `realname` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `remark` varchar(512) DEFAULT NULL,
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT now() COMMENT '修改时间',
  `maritalstatus` varchar(50) DEFAULT NULL COMMENT '婚姻状况',
  `schooling` varchar(50) DEFAULT NULL COMMENT '受教育程度',
  `salary` varchar(50) DEFAULT NULL COMMENT '月收入',
  `is_pinlessmobile` varchar(1) DEFAULT NULL COMMENT '是否绑定手机  0未绑定   1已绑定',
  `is_pinlessemail` varchar(1) DEFAULT NULL COMMENT '是否绑定邮箱   0为绑定  1已绑定',
  `pic` varchar(500) DEFAULT NULL COMMENT '用户头像地址',
  `pic_id` varchar(500) DEFAULT NULL COMMENT '用户头像ID',
  PRIMARY KEY (`id`),
  KEY `customer_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='客户信息表';

-- ----------------------------
-- 客户收货地址信息表
-- ----------------------------
DROP TABLE IF EXISTS `customer_address`;
CREATE TABLE `customer_address` (
  `id` int(11) unsigned auto_increment NOT NULL,
  `customer_id` int(11)  NOT NULL,
  `name` varchar(100)  DEFAULT NULL,
  `phone_number` varchar(11)  DEFAULT NULL,
  `address` varchar(500)  DEFAULT NULL,
  `zip_code` varchar(16)  DEFAULT NULL,
  `is_default` varchar(1)  DEFAULT NULL COMMENT '是否是默认地址',
  `remark` varchar(500)  DEFAULT NULL,
  `street` varchar(500)  DEFAULT NULL,
  `areaRegion` varchar(100)  DEFAULT NULL,
  `telephone` varchar(16)  DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='客户收货地址信息表';

-- ----------------------------
-- 文件信息表， 用于客户头像文件、 商品文件等
-- ----------------------------
DROP TABLE IF EXISTS `file_upload`;
CREATE TABLE `file_upload` (
  `id` varchar(32) NOT NULL COMMENT '文件id',
  `app_id` varchar(32) DEFAULT NULL COMMENT '业务id, 对于商品为商品ID， 对于客户为客户ID',
  `app_type` varchar(32) NOT NULL COMMENT '业务类型, customer : 客户相关业务,  good : 商品相关业务',
  `suffix` varchar(8) NOT NULL COMMENT '文件后缀',
  `original_name` varchar(64)  NOT NULL,
  `relative_path` varchar(128) NOT NULL,
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT now() COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `file_upload_id` (`id`),
  KEY `file_upload_app_id` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='文件信息表';

-- ----------------------------
-- 商品类型信息表
-- ----------------------------
DROP TABLE IF EXISTS `good_type`;
CREATE TABLE `good_type` (
  `id` int(11) unsigned auto_increment NOT NULL COMMENT '类别id',
  `code` varchar(30) NOT NULL COMMENT '商品类型代码， company_register_basic : 公司注册基础套餐, company_register_service : 公司注册附加套餐',
  `name` varchar(64) NOT NULL COMMENT '商品类型名称',
  `sort` int(11) DEFAULT NULL COMMENT '序号',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '修改人id',
  `update_time` datetime DEFAULT now() COMMENT '修改时间',
  `state` varchar(1) DEFAULT 's' COMMENT '数据状态 c:草稿 s;已审核 d:删除',
  PRIMARY KEY (`id`),
  KEY `good_type_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='商品类型信息表';