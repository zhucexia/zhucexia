package com.keji50.zhucexia.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 网站会员控制器
 *
 * @author chao.li
 * @version
 * @since Ver 1.1
 * @Date 2015年9月18日 下午4:43:23
 *
 * @see
 */

@Controller
@RequestMapping(value = "/user")
public class UserController {

    @RequestMapping(value = "/index")
    public String index() {
        return "user/index";
    }

}
