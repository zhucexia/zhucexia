SET FOREIGN_KEY_CHECKS=0;

-- 后台系统管理表结构部分
-- ----------------------------
-- 系统权限表
-- ----------------------------
DROP TABLE IF EXISTS `sys_power`;
CREATE TABLE `sys_power` (
  `id` int(11) unsigned auto_increment NOT NULL COMMENT '主键ID',
  `code` varchar(32) NOT NULL COMMENT '权限菜单代码',
  `name` varchar(64) NOT NULL COMMENT '权限菜单名称',
  `state` varchar(1) COLLATE utf8_bin DEFAULT 's' COMMENT '数据状态 c:草稿 s;已审核 d:删除',
  `create_by` varchar(64) COMMENT '创建人',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(32) COMMENT '更新人',
  `update_time` datetime DEFAULT now() COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `sys_power_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统权限表';

INSERT INTO sys_power(code, name, state, create_by, update_by) VALUES ('customer_manage', '客户管理', 's', 'admin', 'admin');
INSERT INTO sys_power(code, name, state, create_by, update_by) VALUES ('good_type_manage', '商品类型管理', 's', 'admin', 'admin');

-- ----------------------------
-- 系统角色表
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) unsigned auto_increment NOT NULL COMMENT '主键ID',
  `code` varchar(32) NOT NULL COMMENT '角色代码',
  `name` varchar(64) NOT NULL COMMENT '角色名称',
  `state` varchar(1) DEFAULT 's' COMMENT '数据状态 c:草稿 s;已审核 d:删除',
  `create_by` varchar(64) COMMENT '创建人',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(64) COMMENT '更新人',
  `update_time` datetime DEFAULT now() COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `sys_role_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统角色表';

INSERT INTO sys_role(code, name, state, create_by, update_by) VALUES ('sys_admin', '系统管理员', 's', 'admin', 'admin');


-- ----------------------------
-- 系统角色权限对应关系表
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_power`;
CREATE TABLE `sys_role_power` (
  `id` int(11) unsigned auto_increment NOT NULL COMMENT '主键ID',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `power_id` int(11) NOT NULL COMMENT '权限id',
  `power_insert` varchar(1) DEFAULT '1' COMMENT '插入权限， 0:未开通， 1已开通',
  `power_delete` varchar(1) DEFAULT '1' COMMENT '删除权限， 0:未开通， 1已开通',
  `power_select` varchar(1) DEFAULT '1' COMMENT '查询权限， 0:未开通， 1已开通',
  `power_update` varchar(1) DEFAULT '1' COMMENT '更新权限， 0:未开通， 1已开通',
  PRIMARY KEY (`id`),
  KEY `sys_role_power_id` (`id`),
  KEY `sys_role_power_r_role_id` (`role_id`),
  KEY `sys_role_power_r_power_id` (`power_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统角色权限对应关系表';

-- ----------------------------
-- 系统管理员信息表
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) unsigned auto_increment NOT NULL COMMENT '主键id',
  `username` varchar(64) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码 ',
  `realname` varchar(30) DEFAULT NULL COMMENT '真实姓名',
  `role_id` varchar(32) DEFAULT NULL COMMENT '角色id',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机号',
  `email` varchar(96) DEFAULT NULL COMMENT '邮箱',
  `company` varchar(64) DEFAULT NULL COMMENT '公司信息',
  `address` varchar(256) DEFAULT NULL COMMENT '地址',
  `dept_name` varchar(64) DEFAULT NULL COMMENT '部门名称',
  `state` varchar(1) NOT NULL DEFAULT 's' COMMENT '数据状态 c:草稿 s;已审核 d:删除',  
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT now() COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `sys_user_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统管理员信息表';

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
  `linkman` varchar(64) DEFAULT NULL COMMENT '推荐人',
  `mobile` varchar(11) DEFAULT NULL,
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

-------------------------------
-- 客户短信信息表 
-------------------------------
DROP TABLE IF EXISTS `customer_sms`;
CREATE TABLE `customer_sms` (
	`id` int(11) unsigned auto_increment NOT NULL,
  	`type` varchar(32) DEFAULT '0' COMMENT '0: 手机号绑定',
  	`mobile` varchar(11) NOT NULL COMMENT '手机号',
  	`validation_code` varchar(32) NOT NULL COMMENT '验证码',
  	`validation_expire` datetime NOT NULL COMMENT '验证内容有效时间',
  	`ip` varchar(32) COMMENT '客户ip地址',
  	`smsid` varchar(32) COMMENT '短信厂商回执id',
  	`create_by` varchar(64) DEFAULT 'system' COMMENT '创建人',
  	`create_time` datetime DEFAULT now() COMMENT '创建时间',
  	`update_by` varchar(64) DEFAULT 'system' COMMENT '修改人',
  	`update_time` datetime DEFAULT now() COMMENT '修改时间',
  	PRIMARY KEY (`id`),
  	KEY `customer_sms_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='客户短信信息表';

-------------------------------
-- 客户邮箱验证信息表 
-------------------------------
DROP TABLE IF EXISTS `customer_email`;
CREATE TABLE `customer_email` (
	`id` int(11) unsigned auto_increment NOT NULL,
  	`type` varchar(32) DEFAULT '0' COMMENT '0: 邮箱绑定，  1:重置密码',
  	`customer_id` int(11) NOT NULL COMMENT '客户id',
  	`email` varchar(100) NOT NULL COMMENT '邮箱地址',
  	`validation_code` varchar(32) NOT NULL COMMENT '验证码',
  	`validation_expire` datetime NOT NULL COMMENT '验证内容有效时间',
  	`ip` varchar(32) COMMENT '客户ip地址',
  	`state` varchar(1) DEFAULT '0' COMMENT '数据状态  0:未验证， 1:已验证',
  	`create_by` varchar(64) DEFAULT 'system' COMMENT '创建人',
  	`create_time` datetime DEFAULT now() COMMENT '创建时间',
  	`update_by` varchar(64) DEFAULT 'system' COMMENT '修改人',
  	`update_time` datetime DEFAULT now() COMMENT '修改时间',
  	PRIMARY KEY (`id`),
  	KEY `customer_email_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='客户邮箱验证信息表 ';

-- ----------------------------
-- 客户收货地址信息表
-- ----------------------------
DROP TABLE IF EXISTS `customer_address`;
CREATE TABLE `customer_address` (
  `id` int(11) unsigned auto_increment NOT NULL,
  `customer_id` int(11)  NOT NULL,
  `name` varchar(100)  DEFAULT NULL,
  `mobile` varchar(11)  DEFAULT NULL COMMENT '手机号',
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
-- 客户收藏商品信息表
-- ----------------------------
DROP TABLE IF EXISTS `customer_favorite`;
CREATE TABLE `customer_favorite` (
  `id` int(11) unsigned auto_increment NOT NULL COMMENT '主键id',
  `good_id` int(11) NOT NULL COMMENT '商品id',
  `good_name` varchar(128) NOT NULL COMMENT '商品名称',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `favorite_id` (`id`),
  KEY `favorite_good_id` (`good_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='客户收藏商品信息表';

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
  PRIMARY KEY (`id`),f
  KEY `good_type_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='商品类型信息表';

-- ----------------------------
-- 商品信息表
-- ----------------------------
DROP TABLE IF EXISTS `good`;
CREATE TABLE `good` (
  `id` int(32) unsigned auto_increment NOT NULL COMMENT '商品id',
  `code` varchar(32) NOT NULL COMMENT '商品编码',
  `name` varchar(128) NOT NULL COMMENT '商品名称',
  `good_type_id` int(11) DEFAULT NULL COMMENT '商品类别id',
  `good_type_name` varchar(64) DEFAULT NULL COMMENT '商品类别名称',
  `price_range` varchar(50) NOT NULL COMMENT '价格范围',
  `price_market` decimal(18,2) DEFAULT NULL COMMENT '市场价',
  `pic_id` varchar(32) NOT NULL COMMENT '商品图片ID',
  `pic` varchar(128) NOT NULL COMMENT '商品图片',
  `register_cost` varchar(50) DEFAULT NULL COMMENT '注册时长',
  `apply_condition` varchar(100) DEFAULT NULL COMMENT '申请条件',
  `detail_content` varchar(1000) DEFAULT NULL COMMENT '商品详细内容, 富文本',
  `begin_sale_time` datetime DEFAULT NULL COMMENT '上架时间',
  `end_sale_time` datetime DEFAULT NULL COMMENT '下架时间',
  `total_sales` int(11) DEFAULT NULL COMMENT '总销量',
  `daily_sales` int(11) DEFAULT NULL COMMENT '当日销量',
  `index_show` varchar(1) DEFAULT '1' COMMENT '是否首页展示， 0:不显示  1:显示 ',
  `state` varchar(1) DEFAULT 's' COMMENT '数据状态 c:草稿 s;审核 d:下架',
  `initialNum` decimal(18,0) DEFAULT NULL COMMENT '期初初始数量',
  `remark` varchar(160) COMMENT '商品备注',
  `click_count` int(11) DEFAULT 0 COMMENT '商品点击数',
  `comment_count` int(11) DEFAULT 0 COMMENT '商品的评论数',
  `sort` int(11) DEFAULT NULL COMMENT '商品排序',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人id',
  `update_time` datetime DEFAULT now() COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `good_id` (`id`),
  KEY `good_code` (`code`),
  KEY `good_good_type_id` (`good_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='商品信息表';


-- ----------------------------
-- 商品可选条件属性表
-- ----------------------------
DROP TABLE IF EXISTS `good_attr`;
CREATE TABLE `good_attr` (
  `id` int(11) unsigned auto_increment NOT NULL COMMENT '条件属性id',
  `good_type_id` int(11) NOT NULL COMMENT '商品类型id',
  `code` varchar(16) NOT NULL COMMENT '条件代码',
  `name` varchar(64) NOT NULL COMMENT '条件名称',
  `sort` int(11) NOT NULL COMMENT '排序序号',
  `remark` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `state` varchar(1) COLLATE utf8_bin DEFAULT 's' COMMENT '数据状态 c:草稿 s;审核 d:删除',
  `option_value` varchar(1024) DEFAULT NULL COMMENT '可选值',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT now() COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `good_attr_id` (`id`),
  KEY `good_attr_good_type_id` (`good_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='商品可选条件属性表';


-- ----------------------------
-- 商品可选条件属性枚举值表
-- ----------------------------
DROP TABLE IF EXISTS `good_attr_value`;
CREATE TABLE `good_attr_value` (
  `id` int(11) unsigned auto_increment NOT NULL COMMENT '商品条件属性枚举值表',
  `good_id` int(11) NOT NULL COMMENT '商品id',
  `good_attr_id` int(11) NOT NULL COMMENT '商品可选条件id',
  `attr_value` varchar(512) NOT NULL COMMENT '可选条件值',
  `sort` int(11) DEFAULT NULL COMMENT '序号',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT now() COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `good_attr_value_id` (`id`),
  KEY `good_attr_value_good_id` (`good_id`),
  KEY `good_attr_value_good_attr_id` (`good_attr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT '商品可选条件属性枚举值表';

-- ----------------------------
-- 商品价格表
-- ----------------------------
DROP TABLE IF EXISTS `good_price`;
CREATE TABLE `good_price` (
  `id` int(11) unsigned auto_increment NOT NULL COMMENT '主键id',
  `good_id` int(11) NOT NULL COMMENT '商品id',
  `good_attr` varchar(100) COMMENT '商品可选条件，格式为attr1:value1,attr2:value2,attr3:value3 ..., 通过用户选择的条件， 决定商品的价格，  如果为null， 表示该商品只有一个价格， 没有可选条件。',
  `price` decimal(18,2) DEFAULT NULL COMMENT '商品价格',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT now() COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `good_price_id` (`id`),
  KEY `good_price_good_id` (`good_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='商品价格表';

-- ----------------------------
-- 商品购买绑定关系表
-- ----------------------------
DROP TABLE IF EXISTS `good_relation`;
CREATE TABLE `good_relation` (
  `id` int(11) unsigned auto_increment NOT NULL COMMENT '主键id',
  `good_id` int(11) NOT NULL COMMENT '商品id',
  `related_good_id` int(11) NOT NULL COMMENT '关联商品id',
  `related_good_name` varchar(128) NOT NULL COMMENT '关联商品名称',
  `is_necessary` varchar(1) DEFAULT '0' COMMENT '是否必要， 0不必要    1必要',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT now() COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `good_relation_id` (`id`),
  KEY `good_relation_good_id` (`good_id`),
  KEY `good_relation_related_good_id` (`related_good_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='商品购买绑定关系表';

-- ----------------------------
-- 支付方式信息表
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `id` int(11) unsigned auto_increment  NOT NULL COMMENT '主键id',
  `code` varchar(32) NOT NULL COMMENT '支付方式代码',
  `name` varchar(32) NOT NULL COMMENT '支付方式名称',
  `payment_fee` decimal(18,2) DEFAULT 0 COMMENT '优惠费率',
  `remark` varchar(512) DEFAULT NULL,
  `state` varchar(1) DEFAULT 's' COMMENT '数据状态 c:草稿 s;审核 d:删除',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人姓名',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '修改人姓名',
  `update_time` datetime DEFAULT now() COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `payment_id` (`id`),
  KEY `payment_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='支付方式信息表';

-- ----------------------------
-- 订单表
-- ----------------------------
DROP TABLE IF EXISTS `sale_order`;
CREATE TABLE `sale_order` (
  `id` int(11) unsigned auto_increment NOT NULL COMMENT '主键id',
  `order_no` varchar(25) NOT NULL COMMENT '订单号',
  `type` varchar(1) DEFAULT '0' COMMENT '0:商城订单 1:线下订单',
  `customer_id` int(11) NOT NULL COMMENT '客户id',
  `customer_name` varchar(64) NOT NULL COMMENT '客户名称',
  `order_money` decimal(18,2) NOT NULL COMMENT '订单金额',
  `address` varchar(128) NOT NULL COMMENT '收货地址',
  `mobile` varchar(16) NOT NULL COMMENT '手机号',
  `telephone` varchar(16) COMMENT '电话号码',
  `email` varchar(64) COMMENT '邮箱',
  `zip_code` varchar(8) COMMENT '邮政编码',
  `payment_id` int(11) COMMENT '支付方式id',
  `payment_code` varchar(32) COMMENT '支付方式代码',
  `payment_name` varchar(64) COMMENT '支付方式名称',
  `delivery_id` int(11) COMMENT '发货方式',
  `delivery_code` varchar(32) COMMENT '发货方式代码',
  `delivery_name` varchar(64) COMMENT '发货方式名称',
  `order_state` varchar(1) DEFAULT '0' COMMENT '订单状态 ， 0：未确认、 1：已确认、 2：交易成功、 9：交易取消',
  `payment_state` varchar(1) DEFAULT '0' COMMENT '付款状态     0,未收款   1,已付清',
  `delivery_state` varchar(1) DEFAULT '0' COMMENT '发货状态   0未发货       1,已发货',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT now() COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT now() COMMENT '修改时间',
  `alipay_trade_no` varchar(32) DEFAULT NULL COMMENT '支付宝订单号',
  `delivery_trade_no` varchar(32) DEFAULT NULL COMMENT '物流订单号',
  `orderstate_time` datetime DEFAULT NULL COMMENT '订单确认时间',
  `payment_time` datetime DEFAULT NULL COMMENT '付款时间',
  `delivery_time` datetime COMMENT '发货时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消订单时间',
  PRIMARY KEY (`id`),
  KEY `sale_order_id` (`id`),
  KEY `sale_order_no` (`order_no`),
  KEY `order_customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='订单表';

-- ----------------------------
-- 订单明细表
-- ----------------------------
DROP TABLE IF EXISTS `sale_order_detail`;
CREATE TABLE `sale_order_detail` (
  `id` int(11) unsigned auto_increment NOT NULL COMMENT '主键id',
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `order_no` varchar(25) NOT NULL COMMENT '订单号',
  `good_id` int(11) NOT NULL COMMENT '商品id',
  `good_name` varchar(128) NOT NULL COMMENT '商品名称',
  `good_price_id` int(11) NOT NULL COMMENT '商品价格id',
  `good_price` decimal(18,2) NOT NULL COMMENT '商品价格',
  `good_num` int(5) NOT NULL DEFAULT 1 COMMENT '商品数量',
  `total_price` decimal(18,2) NOT NULL COMMENT '总价格',
  PRIMARY KEY (`id`),
  KEY `sale_order_detail_id` (`id`),
  KEY `order_detail_sale_order_id` (`order_id`),
  KEY `order_detail_sale_order_no` (`order_no`),
  KEY `order_detail_good_id` (`good_id`),
  KEY `order_detail_good_price_id` (`good_price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='订单明细表';
