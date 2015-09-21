package com.keji50.zhucexia.dao.po;

import com.keji50.zhucexia.dao.mapper.UserPoMapper;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

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
    
    public static void main(String[] args) {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("spring-context.xml");
        UserPoMapper userPoMapper = (UserPoMapper) applicationContext.getBean("userPoMapper");
        
        UserPo user = new UserPo();
        user.setUsername("testuser");
        user.setPassword("userpassword");
        user.setEmail("l@1.live.com");
        user.setPhoneNumber("13503030303");
        System.out.println(userPoMapper.insert(user));
    }
}

