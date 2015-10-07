<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div id="top" class="top">
    <div class="container">
        <div class="logo">
            <h1><a title="" href="index.html"><img src="${root }/static/images/header/logo.png" alt=""></a></h1></div>
        <div class="top-tool"><img src="${root }/static/images/header/c1.jpg">4009207898
            <img src="${root }/static/images/header/c2.jpg"><a href="javascript:;" class="J_dialog" data="log">登陆</a> |
            <a href="javascript:;" class="J_dialog" data="reg">注册</a> &nbsp;
        </div>
        <div id="nav">
            <ul id="menu" class="navigation">
                <li id="index" class="nav-lilink"><a href="http://www.zhucexia.com/index.html" class="nav-alink" title="网站首页"> 网站首页</a>
                    <div class="exnav">
                        <ul class="children level-0"></ul>
                    </div>
                </li>
                <li id="about" class="nav-lilink"><a href="http://www.zhucexia.com/about.html" class="nav-alink" title="关于我们"> 关于我们</a>
                    <div class="exnav">
                        <ul class="children level-0"></ul>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<jsp:include page="/views/common/loginRe.jsp" />