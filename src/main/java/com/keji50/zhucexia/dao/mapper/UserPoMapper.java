/**
 * UserPoMapper.java
 * com.keji50.zhucexia.dao.mapper
 *
 * Function： TODO 
 *
 *   ver     date      		author
 * ──────────────────────────────────
 *   		 2015年9月18日 		chao.li
 *
 * Copyright (c) 2015, Howbuy Rights Reserved.
 */

package com.keji50.zhucexia.dao.mapper;

import com.keji50.zhucexia.dao.po.UserPo;

/**
 * 会员对象数据库访问接口
 *
 * @author chao.li
 * @version
 * @since Ver 1.1
 * @Date 2015年9月18日 下午4:24:05
 *
 * @see
 */
public interface UserPoMapper {

    /**
     * 新增会员记录
     *
     * @param user
     *            会员对象
     */
    int insert(UserPo user);

}
