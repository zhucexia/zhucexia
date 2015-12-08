<%@ page language="java" import="java.util.*,com.keji50.zhucexia.dao.po.CustomerPo" pageEncoding="UTF-8"%>
<!DOCTYPE link PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet" href="${root }/static/css/includes/loginRe.css">
<script type="text/javascript" src="${root}/static/js/includes/loginRe.js"></script>
</head>
<body>
<div class="theme-popover" id="log">
	<div class="theme-poptit">
		登 录！ <a href="javascript:;" title="关闭" class="close">×</a> <br />
	</div>
	<div class="theme-popbod dform">
		<form class="theme-signin" name="loginform" action="" method="post">
			<ul>
				<li><strong>用户名|手机号：</strong> <input class="ipt" type="text"
					name="username" value="" size="20" id="logname"/></li>
				<li class="nn"><strong> &nbsp;密 码：</strong> <input class="ipt"
					type="password" name="password" value="" size="20" id="password"/></li>
				<li ><span id="mess" style="text-align:center;color:red;font-weight:bold;"></span></li>
				<li><strong></strong> <input class="btn btn-primary" type="button" name="submit" onclick="login()"
					value=" 登 录 " />&emsp;
					<input class="btn btn-primary" style="color:#fff" type="button" name="" onclick="losepass()" value="忘记密码？"/>&emsp;
					<input class="btn btn-primary" style="color:#fff" type="button" name="" onclick="regist()" value="注册"/>
				</li>
			</ul>
		</form>
	</div>
</div>
<script type="text/javascript">
		var roots = '${root}';
		function losepass(){
			$("#log").css("display","none");
			$("#reg").css("display","none");
			$(".msgs").html("获取短信验证码");
			$(".lostmobile").hide();
			$(".yzms").hide();
			$(".wei").hide();
			$(".conwei").hide();
			$("#edit").css("display","block");
			/*$("#edit2").css("display","block");
			$("#ee").css("display","none");
			$("#ff").css("display","none"); */
		}
		function cancel(){
			$(".theme-poptit .close").click();
		}
		function regist(){
			$("#log").css("display","none");
			$("#edit").css("display","none");
			$("#reg").css("display","block");
			$(".msgs").html("获取短信验证码");
			$(".uts").html("");
			$(".zcpwd").html("");
			$(".zcconpwd").html("");
			$(".pts").html("");
			$("#messcode").html("");
			$(".zcemail").html("");
			$(".zcts").html("");
		}
</script>
<!--登录窗结束体-->
<!--注册窗体-->
<div class="theme-popover" id="reg">
	<div class="theme-poptit">
		注 册  <a href="javascript:;" title="关闭" class="close">×</a> <br />
	</div>
	<div class="theme-popbod dform">
		<form class="theme-signin" name="loginform" action="" method="post" >
			<input type="hidden" name="type" value="0" />
			<ul>
				<li><strong>*用户名：</strong> <input class="ipt" type="text"
					name="username" placeholder="注册侠" size="20" id="username"/><span class="uts"></span></li>
				<li><strong>*密 码：</strong> <input class="ipt" type="password"
					name="pwd" value="" size="20" id="zcpwd"/><span class="zcpwd"></span></li>
				<li><strong>*确认密码：</strong> <input class="ipt" type="password"
					name="conpwd" value="" size="20" id="zcconpwd"/><span  class="zcconpwd"></span></li>
				<li><strong>*手机号：</strong> <input class="ipt" type="text"
					name="phone" placeholder="您的手机号" size="20" id="phone"/><span class="pts" ></span></li>
				<li><strong>*验证码：</strong> <input class="ipt" type="text"
					name="msg" size="20" id="yzm" style="width:100px;"/><span class="msgs" onclick="mess()">获取短信验证码</span><span id="messcode"></span> </li>
				<li><strong>邮箱：</strong> <input class="ipt" type="text"
					name="email" placeholder="您的联系邮箱" size="20" id="email"/><span class="zcemail"></span></li>
				<li><center><p class="zcts"></p></center></li>
				<li>
					<input class="btn btn-primary" type="button" name="reg" value=" 注 册 " style="margin-left:75px;"/>
					<input class="btn btn-primary" type="button" name="cancal" value=" 取 消 " style="margin-left:100px;color:#fff" onclick="cancel()"/>
				</li>
			</ul>
		</form>
	</div>
</div>
<!--注册窗结束体-->

<!--忘记密码窗体-->
<div class="theme-popover" id="edit">
	<div class="theme-poptit">
		找 回 密 码！ <a href="javascript:;" title="关闭" class="close">×</a> <br />
	</div>
	<div class="theme-popbod dform">
		<!-- <div style="padding:0px 0px 20px 30px;margin-left:20px;text-align:left;font-size:15.5px;" id="edit1">
			<a href="javascript:editByMobile();" style="color:#000;text-decoration:none">通过验证手机号找回密码</a>
		</div>
		<div style="padding:0px 0px 20px 30px;margin-left:20px;text-align:left;font-size:15.5px;" id="edit2">
			<a href="javascript:editByEmail();" style="color:#000;text-decoration:none">通过验证邮箱找回密码</a>
		</div> -->
		<form class="theme-signin" name="editform" action="#" method="post"
			id="ee" style="display:block">
			<ul>
				<li><strong>手 机 号：</strong> <input class="ipt" type="text"
					name="phonenumber" size="20" id="mob" /><span class="lostmobile"></span></li>
				<li><strong>验 证 码：</strong> <input class="ipt" type="text"
					name="regmsg" size="20" id="getmess" style="width:100px;"/><span class="msgs" id="messages" onclick="lostpwd()">获取短信验证码</span> <span class="yzms"></span>
				</li>
				<li><strong>新  密 码：</strong> <input class="ipt" type="password"
					name="pwd" value="" size="20" id="wei" /><span class="wei"></span></li>
				<li><strong>确认密码：</strong> <input class="ipt" type="password"
					name="conpwds" value="" size="20" id="conwei"/><span class="conwei"></span></li>
				<li>
					<input class="btn btn-primary" type="button" name="uppass" value=" 确 认 " class="bj" style="margin-left: 75px;"/>
					<input class="btn btn-primary" type="button" name="cancal" value=" 取 消 " style="margin-left:100px;color:#fff" onclick="cancel()"/>
				</li>
			</ul>
		</form>
		<!-- <form class="theme-signin" name="editform1" method="post" id="ff" style="display:none" action="">
			<input id="type1" type="hidden" name="type1" value="1" />
			<ul>
				<li>
					<strong>用 户 名：</strong>
					<input class="ipt" type="text" name="username" id="username1"/>
					<span id="prompt_1" style="color:red;"></span>
				</li>
				<li>
					<strong>电子邮箱：</strong>
					<input class="ipt" type="text" name="email" id="email1"/>
					<span id="prompt_2" style="color:red;"></span>
				</li>
				<li>
					<strong>验 证 码：</strong>
					<input class="ipt" type="text" name="code" id="code"/>
					<span class="msgs" id="messages" onclick="lostpwd1()">获取短信验证码</span>
					<span id="prompt_3" style="color:red;"></span>
				</li>
				<li>
					<strong>新 密 码：</strong>
					<input class="ipt" type="password" name="newPwd" id="newPwd"/>
					<span id="prompt_4" style="color:red;"></span>
				</li>
				<li>
					<strong>确认密码：</strong>
					<input class="ipt" type="password" name="finalPwd" id="newPwd"/>
					<span id="prompt_5" style="color:red;"></span>
				</li>
				<li>
					<input id="editByEmail" class="btn btn-primary" type="button" name="editByEmail" value="确认"/>
					<span id="prompt_6" style="color:red;"></span>
				</li>
			</ul>
		</form> -->
	</div>
</div>
<!--忘记密码窗结束体-->

<!--材料-->
<!-- <div class="theme-popover" id="cl">
	<div class="theme-poptit">
		提交材料！ <a href="javascript:;" title="关闭" class="close">×</a> <br />
	</div>
	<div class="theme-popbod dform">
		<form class="theme-signin" name="editform" action="#" method="post"
			id="ee">
			<ul>
				<li>
				<strong>收货人姓名：</strong> <input type="text" class="ipt" placeholder="收货人姓名" ></li>
				<li>
				<strong>联系电话：</strong> <input type="text" class="ipt"  placeholder="11位手机号" >
				</li>
				<li><strong>收货人地址： </strong> <select id="loc_province"  style="width:100px;">
   						 </select>
					    <select id="loc_city" style="width:100px; margin-left: 10px">
					    </select>
					    <select id="loc_town" style="width:100px;margin-left: 10px">
					    </select>
   				</li>
				<li><strong>邮政编码：</strong>  <input type="text" class="ipt" placeholder="邮政编码" ></li>
				<li><strong>地址标签：</strong>  <input type="text" class="ipt" placeholder='地址标签：如"家"、"公司"。限5个字内'  ></li>
				
				<li><center><span></span><input class="btn btn-primary" type="button" class="ipt" name="address"
					value=" 提  交  " class="bj" /> <input class="btn btn-primary" type="button" class="ipt" name="download"
					value="下载信息  " class="bj" /></span></center></li>
				
			</ul>
		</form>		
   <label>收货人姓名<span>*</span></label> 
                <input type="text" name="userAddress[consignee]" id="Consignee" class="input" placeholder="收货人姓名" maxlength="15" autocomplete='off'>
  <br/> <label>联系电话<span>*</span></label> 
                <input type="text" name="userAddress[tel]" class="input" id="Telephone" placeholder="11位手机号" autocomplete='off'>
   <br/>地址： <select id="loc_province" style="width:120px;">
    </select>
    <select id="loc_city" style="width:120px; margin-left: 10px">
    </select>
    <select id="loc_town" style="width:120px;margin-left: 10px">
    </select>
   
    <br>
    <br>
    <br/><label>邮政编码<span>*</span></label> 
                <input type="text" name="userAddress[zipcode]" id="Zipcode" class="input" placeholder="邮政编码"  autocomplete='off'>
                
                 <br/> <label>地址标签<span>*</span></label> 
                <input type="text" name="userAddress[tag]" id="Tag" class="input" placeholder='地址标签：如"家"、"公司"。限5个字内'  >
    <input type="button" id="btnval" value="获取值" style="padding:5px 15px;"/>
    <input type="button" id="btntext" value="获取文本" style="padding:5px 15px;" />
	 <input type="button" id="bb" value="获取文本" style="padding:5px 15px;" />


	</div>
</div> -->
<!--材料-->
<script type="text/javascript">
	/* function editByMobile(){
		$("#edit1").css("display","none");
		$("#edit2").css("display","none");
		$("#ee").css("display","block");
	}
	
	function editByEmail(){
		$("#edit1").css("display","none");
		$("#edit2").css("display","none");
		$("#ff").css("display","block");
	} */
	
		
	 /* $("#conwei").blur(function(){
			var cons=$("#wei").val();
			var conpw=$(this).val();
			if(cons==conpw&&conpw!=""&&conpw!=null){
				$(".conwei").html("输入正确");
				$(".conwei").css({"font-weight":"bold","color":"#0099FF"});
				$(".conwei").show();
				lost=true;
			}else if(conpw==""||conpw==null){
				lost=false;
				$(".conwei").html("请确认密码");
				$(".conwei").show();
			}else{
				lost=false;
				$(".conwei").html("两次输入密码不同");
				$(".conwei").show();
			}
		})  */
	//忘记密码时对输入的手机号进行是否注册过判断
	$("#mob").blur(function(){
		var phone=$("#mob").val();
		if(phone!="" && phone!=null){
			$.ajax({
				url : "${root}/customer/validatelost",
				type : 'POST',
				dataType: "json",
				data : {
					phonenum : phone,
				},
				success : function(data) {
					var data=eval("(" + data + ")");
					if(data.message=="该号已占用"){
						lost=true;
						$(".lostmobile").html("");
					}else{
						lost=false;
						$(".lostmobile").html("输入有误或未曾注册");
						$(".lostmobile").show();
					}
				},
				error:function(data) {
					var data=eval("(" + data + ")");
					}
			});
		}else{
			$(".lostmobile").html("请输入手机号");
			$(".lostmobile").show();
		}
			
	});
	
	//忘记密码时发送短信
	 function lostpwd(){
		var phone=$("#mob").val();
		if(phone=="" || phone==null ){
			$(".lostmobile").html("请输入手机号");
			$(".lostmobile").css({"color":"red","font-weight":"bold"});
			$(".lostmobile").show();
			return ;
		}else {
			$.ajax({
				url : "${root}/customer/mess",
				type : 'POST',
				dataType: "json",
				data : {
					phonenum: phone
				},
				success : function(data) {
					var data=eval("(" + data + ")");
					if(data.message=="发送成功"){
					}
				},
				error:function(data) {
					var data=eval("(" + data + ")");
				}
			});
		}
	} 
	//注册时发送短信验证	
	function mess(){
		var messflag = true;
		var username=$.trim($("#username").val());
		var pwd=$.trim($("input[name='pwd']").val());
		var conpwd=$.trim($("input[name='conpwd']").val());
		var phone=$.trim($("input[name='phone']").val());
		if(username=="" || username==null){
			messflag = false;
		}else if(pwd=="" || pwd==null){
			messflag = false;
		}else if(conpwd=="" || conpwd==null){
			messflag = false;
		}else if(phone=="" || phone==null){
			messflag = false;
		}
			 
		if(messflag == true && ($(".msgs").html()=="获取短信验证码" || $(".msgs").html()=="重新获取")){
			$.ajax({
				url : "${root}/customer/mess",
				type : 'POST',
				dataType: "json",
				data : {
					username : username,
					password : pwd,
					phonenum: phone
				},
				success : function(data) {
					var data=eval("(" + data + ")");
					if(data.message=="发送成功"){
						
					}else{
						
					}
				},
				error:function(data) {
					var data=eval("(" + data + ")");
					
				}
				});
			}else{
				
			}
		}
	
		//登录操作
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
						$(".xf").html(data.names); 
						$("#a21").html("注销");
						$("#b21").html("注销");
						var dd=$("#qq").css("display");
						if(dd=="none"){
							$("#qq").show();
							$("#ww").hide();
						}else{
							$("#hc").hide();
							$("#hc1").show();
						}
						$("#log").hide();
						window.location.reload();
					}else{
						$("#mess").html("输入的用户名/手机号 或密码有误");
						$("#mess").show();
					}
				},
				error:function(data) {
					var data=eval("(" + data + ")");
					$("#mess").html("输入的用户名/手机号 或密码有误");
				}
			});
		}
		
		//忘记密码操作
		 $('input[name="uppass"]').click(function() {
		    	var newpass=$("#wei").val();
		    	var con=$("#conwei").val();
		    	var mess=$("#getmess").val();
		    	var phone=$.trim($("#mob").val());
		    	
		    	if(phone==""){
		    		lost=false
		    		$(".lostmobile").html("请输入手机号");
		    		$(".lostmobile").css({"color":"red","font-weight":"bold"});
		    		$(".lostmobile").show();
		    		return ;
		    	}
		    	if(mess==""){
		    		lost=false
		    		$(".yzms").html("请输入验证码");
		    		$(".yzms").css({"color":"red","font-weight":"bold"});
		    		$(".yzms").show();
		    		return ;
		    	}else{
		    		$(".yzms").html("");
		    		$(".yzms").show();
		    	}
		    	if(newpass==""){
		    		lost==false;
		    		$(".wei").html("请输入新密码");
		    		$(".wei").css({"color":"red","font-weight":"bold"});
		    		$(".wei").show();
		    		return ;
		    	} else{
		    		$(".wei").html("");
		    	} 
		    	if(con==""){
		    		lost=false;
		    		$(".conwei").html("请再次输入密码");
		    		$(".conwei").css({"color":"red","font-weight":"bold"});
		    		$(".conwei").show();
		    		return ;
		    	}else if(newpass!=con){
		    		lost=false;
		    		$(".conwei").html("两次输入密码不同");
		    		$(".conwei").css({"color":"red","font-weight":"bold"});
		    		$(".conwei").show();
		    		return ;
		    	}else if(newpass==con){
		    		
		    		lost=true;
		    		$(".conwei").html("");
		    	}
		    	if($("#messages").html()=="获取短信验证码" || $("#messages").html()=="重新获取"){
		    		lost==false;
		    		return;
		    	}  
		        if (lost==true ) {
		        	var name=$("#use").val();
					var password=$("#wei").val();
					$.ajax({
						url : "${root}/customer/updatepass",
						type : 'POST',
						dataType: "json",
						data : {
							password : newpass,
							mess:mess,
							phonenum:phone,
						},
						success : function(data) {
							var data=eval("(" + data + ")");
							if(data.message=="找回成功"){
								$("#edit").css("display","none");
								var newpass=$("#wei").val("");
						    	var con=$("#conwei").val("");
						    	var mess=$("#getmess").val("");
						    	var phone=$("#mob").val("");
							}else{
								$(".yzms").html(data.message);
							}
							alert(data.message);
							
						},
						error:function(data) {
							var data=eval("(" + data + ")");
							alert(data.message);
						}
					});
		        } else {
		            return ;
		        }
		    });
		//发送验证邮件前检查用户名和邮箱是否存在
		function checkDate(){
			var flag=true;
			var username=$("#username1").val().trim();
			var email=$("#email1").val().trim();
			var reg = /^[\w][\w|\.|\_]*@[\w]+(\.[a-zA-Z]{2,4}){1,3}$/;
			if(username==""||username==null){
				$("#prompt_1").html("请输入用户名");
				$("#prompt_1").show();
				flag=false;
			}
			if(!reg.test(email)){
				$("#prompt_2").html("请输入正确的电子邮箱");
				$("#prompt_2").show();
				flag=false;
			}
			if(flag){
				$.ajax({
					async:false,
					url:"${root}/customer/checkEmail",
					data:{"username":username,"email":email},
					type:"post",
					success:function(data){
						return data;
					}
				});
			}else{
				
			}
		}
		//发送修改密码验证邮件
		function lostpwd1(){
			
			var email=$("#email1").val().trim();
			alert(email);
			var type=$("#type1").val();
			alert(type);
			$.ajax({
				url:"${root}/customer/sendEmail",
				type:"post",
				data:{'email':email,'type':type},
				success:function(data){
					
				}
			});
		} 
		
		//通过邮箱修改密码
		/* var code=$("#code").val().trim(); */
		

</script>
</body>
</html>
