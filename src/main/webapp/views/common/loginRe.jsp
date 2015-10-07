<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${root }/static/css/includes/loginRe.css">
<div class="theme-popover" id="log">
	<div class="theme-poptit">
		助策侠祝贺您重出江湖！ <a href="javascript:;" title="关闭" class="close">×</a> <br />
	</div>
	<div class="theme-popbod dform">
		<form class="theme-signin" name="loginform" action="" method="post">
			<ul>
				<li><strong>用户名|手机号：</strong> <input class="ipt" type="text"
					name="log" value="" size="20" /></li>
				<li class="nn"><strong> &nbsp;密 码：</strong> <input class="ipt"
					type="password" name="logpwd" value="" size="20" /></li>
				<li><strong></strong> <input class="btn btn-primary" type="submit" name="submit"
					value=" 登 录 " />&emsp;<a href="">忘记密码？</a>&emsp;<a href="">注册</a></li>
			</ul>
		</form>
	</div>
</div>
<!--登录窗结束体-->
<!--注册窗体-->
<div class="theme-popover" id="reg">
	<div class="theme-poptit">
		助策侠期待你的江湖！ <a href="javascript:;" title="关闭" class="close">×</a> <br />
	</div>
	<div class="theme-popbod dform">
		<form class="theme-signin" name="loginform" action="" method="post">
			<ul>
				<li><strong>用户名：</strong> <input class="ipt" type="text"
					name="username" placeholder="注册侠" size="20" /><span></span></li>
				<li><strong>密 码：</strong> <input class="ipt" type="password"
					name="pwd" value="" size="20" /><span></span></li>
				<li><strong>确认密码：</strong> <input class="ipt" type="password"
					name="conpwd" value="" size="20" /><span></span></li>
				<li><strong>手机号：</strong> <input class="ipt" type="text"
					name="phone" placeholder="您的手机号" size="20" /><span></span></li>
				<li><strong>验证码：</strong> <input class="ipt" type="text"
					name="msg" size="20" /><span class="msgs">获取短信验证码</span></li>
				<li><strong>邮箱：</strong> <input class="ipt" type="text"
					name="email" placeholder="您的联系邮箱" size="20" /><span></span></li>
				<li><strong></strong> <input class="btn btn-primary"
					type="submit" name="reg" value=" 注 册 " /></li>
			</ul>
		</form>
	</div>
</div>
<!--注册窗结束体-->
<!--编辑窗体-->
<div class="theme-popover" id="edit">
	<div class="theme-poptit">
		助策侠期待你的王朝！ <a href="javascript:;" title="关闭" class="close">×</a> <br />
	</div>
	<div class="theme-popbod dform">
		<form class="theme-signin" name="editform" action="#" method="post"
			id="ee">
			<ul>
				<li><strong>用户名：</strong> <input class="ipt" type="text"
					name="log" value="your name" size="20" id="use" /><span></span></li>
				<li><strong>地址：</strong> <input class="ipt" type="password"
					name="pwd" value="***" size="20" id="adr" /><span></span></li>
				<li><strong>手机号：</strong> <input class="ipt" type="password"
					name="pwd" value="***" size="20" id="mob" /><span></span></li>
				<li><strong>微信号：</strong> <input class="ipt" type="password"
					name="pwd" value="***" size="20" id="wei" /><span></span></li>
				<li><input class="btn btn-primary" type="submit" name="submit"
					value=" 编 辑 " class="bj" /><span></span></li>
			</ul>
		</form>
	</div>
</div>
<!--编辑窗结束体-->
<script type="text/javascript" src="${root }/static/js/includes/loginRe.js"></script>
