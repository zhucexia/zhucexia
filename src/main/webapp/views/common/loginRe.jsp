<%@ page language="java" import="java.util.*,com.keji50.zhucexia.dao.po.CustomerPo" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${root }/static/css/includes/loginRe.css">
<div class="theme-popover" id="log">
	<div class="theme-poptit">
		助策侠祝贺您重出江湖！ <a href="javascript:;" title="关闭" class="close">×</a> <br />
	</div>
	<div class="theme-popbod dform">
		<form class="theme-signin" name="loginform" action="" method="post">
			<ul>
				<li><strong>用户名|手机号：</strong> <input class="ipt" type="text"
					name="username" value="" size="20"/></li>
				<li class="nn"><strong> &nbsp;密 码：</strong> <input class="ipt"
					type="password" name="password" value="" size="20" /></li>
				<li ><span id="mess" style="text-align:center;color:red;font-weight:bold;"></span></li>
				<li><strong></strong> <input class="btn btn-primary" type="button" name="submit" onclick="login()"
					value=" 登 录 " />&emsp;<a href="">忘记密码？</a>&emsp;<a href="">注册</a></li>
			</ul>
		</form>
	</div>
</div>
<script type="text/javascript">

		function login(){
			var name=$("input[name='username']").val();
			var password=$("input[name='password']").val();
			$.ajax({
				url : "${root}/customer/login",
				type : 'POST',
				dataType: "json",
				data : {
					username : name,
					password : password,
				},
				success : function(data) {
					var data=eval("(" + data + ")");
					if(data.message=="登录成功"){
						$("#a21").html(data.names);
						$("#logina").html(data.names);
						$("#turnbacka").html("注销");
						$("#b21").html("注销");
						$("#hc").hide();
						$("#hc1").show();
						$("#log").hide();
					}else{
						$("#mess").html("输入的用户名/手机号 或密码有误");
					}
				},
				error:function(data) {
					var data=eval("(" + data + ")");
					$("#mess").html("输入的用户名/手机号 或密码有误");
				}
			});
		}

</script>
<!--登录窗结束体-->
<!--注册窗体-->
<div class="theme-popover" id="reg">
	<div class="theme-poptit">
		助策侠期待你的江湖！ <a href="javascript:;" title="关闭" class="close">×</a> <br />
	</div>
	<div class="theme-popbod dform">
		<form class="theme-signin" name="loginform" action="${root }/customer/reg" method="post">
			<ul>
				<li><strong>用户名：</strong> <input class="ipt" type="text"
					name="username" placeholder="注册侠" size="20" id="username"/><span class="uts" ></span></li>
				<li><strong>密 码：</strong> <input class="ipt" type="password"
					name="password" value="" size="20" /><span></span></li>
				<li><strong>确认密码：</strong> <input class="ipt" type="password"
					name="conpassword" value="" size="20" /><span></span></li>
				<li><strong>手机号：</strong> <input class="ipt" type="text"
					name="mobile" placeholder="您的手机号" size="20" id="mobile"/><span class="pts" ></span></li>
				<li><strong>验证码：</strong> <input class="ipt" type="text"
					name="msg" size="20" /><span class="msgs" onclick="mess()">获取短信验证码</span><span id="messcode"></span> </li>
				<li><strong>邮箱：</strong> <input class="ipt" type="text"
					name="email" placeholder="您的联系邮箱" size="20" /><span></span></li>
				<li><strong></strong> <input class="btn btn-primary"
					type="submit" name="reg" onclick="reg()" value=" 注 册 " /></li>
			</ul>
		</form>
	</div>
</div>
<!--注册窗结束体-->
<script type="text/javascript">
		function mess(){
			var messflag = true;
			var username=$.trim($("input[name='username']").val());
			var password=$.trim($("input[name='password']").val());
			var conpassword=$.trim($("input[name='conpassword']").val());
			var mobile=$.trim($("input[name='mobile']").val());
			if(username=="" || username==null){
				messflag = false;
			}else if(password=="" || password==null){
				messflag = false;
			}else if(conpassword=="" || conpassword==null){
				messflag = false;
			}else if(mobile=="" || mobile==null){
				messflag = false;
			}
			
			if(messflag == true){
				$.ajax({
					url : "${root}/customer/mess",
					type : 'POST',
					dataType: "json",
					data : {
						username : username,
						password : password,
						phonenum: mobile
					},
					success : function(data) {
						var data=eval("(" + data + ")");
						if(data.message=="发送成功"){
							alert(data.message);
							alert(data.names);
							$("#messcode").html(data.names);
						}else{
							alert(data.message);
						}
					},
					error:function(data) {
						var data=eval("(" + data + ")");
						alert(data.message);
					}
				});
			}else{
				
			}
		}
		function login(){
			var name=$("input[name='username']").val();
			var password=$("input[name='password']").val();
			$.ajax({
				url : "${root}/customer/login",
				type : 'POST',
				dataType: "json",
				data : {
					username : name,
					password : password,
				},
				success : function(data) {
					var data=eval("(" + data + ")");
					if(data.message=="登录成功"){
						$("#a21").html(data.names);
						$("#logina").html(data.names);
						$("#turnbacka").html("注销");
						$("#b21").html("注销");
						$("#hc").hide();
						$("#hc1").show();
						$("#log").hide();
					}else{
						$("#mess").html("输入的用户名/手机号 或密码有误");
					}
				},
				error:function(data) {
					var data=eval("(" + data + ")");
					$("#mess").html("输入的用户名/手机号 或密码有误");
				}
			});
		}

</script>



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
					name="password" value="***" size="20" id="adr" /><span></span></li>
				<li><strong>手机号：</strong> <input class="ipt" type="password"
					name="password" value="***" size="20" id="mob" /><span></span></li>
				<li><strong>微信号：</strong> <input class="ipt" type="password"
					name="password" value="***" size="20" id="wei" /><span></span></li>
				<li><input class="btn btn-primary" type="submit" name="submit"
					value=" 编 辑 " class="bj" /><span></span></li>
			</ul>
		</form>
	</div>
</div>
<!--编辑窗结束体-->
<script type="text/javascript" src="${root }/static/js/includes/loginRe.js"></script>
