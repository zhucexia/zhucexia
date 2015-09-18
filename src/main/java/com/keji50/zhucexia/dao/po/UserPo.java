package com.keji50.zhucexia.dao.po;

import lombok.Data;

/**
 * 网站会员对象
 *
 * @author   chao.li
 * @version  
 * @since    Ver 1.1
 * @Date	 2015年9月18日		上午11:04:03
 *
 * @see 	 
 */
@Data
public class UserPo {
    
    // 会员ID
    private Integer id;
    
    // 用户名
    private String username;
    
    // 密码
    private String password;
    
    // 手机号
    private String phoneNumber;
    
    // 邮箱
    private String email;
    
    public static void main() {
        new UserPo().setEmail("test@sina.com");
    }
}

