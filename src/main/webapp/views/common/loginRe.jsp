<%@ page language="java" import="java.util.*,com.keji50.zhucexia.dao.po.CustomerPo" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${root }/static/css/includes/loginRe.css">
<div class="theme-popover" id="log">
	<div class="theme-poptit">
		登 录！ <a href="javascript:;" title="关闭" class="close">×</a> <br />
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
					value=" 登 录 " />&emsp;<a href="javascript:losepass()" class="J_dialog mm" data="edit">忘记密码？</a>&emsp;<a href="javascript:regist() "class="J_dialog mm" data="reg">注册</a></li>
			</ul>
		</form>
	</div>
</div>
<script type="text/javascript">
		function losepass(){
			$("#log").css("display","none");
			$("#reg").css("display","none");
		}
		function regist(){
			$("#log").css("display","none");
			$("edit").css("display","none");
		}
</script>
<!--登录窗结束体-->
<!--注册窗体-->
<div class="theme-popover" id="reg">
	<div class="theme-poptit">
		注 册  <a href="javascript:;" title="关闭" class="close">×</a> <br />
	</div>
	<div class="theme-popbod dform">
		<form class="theme-signin" name="loginform" action="" method="post">
			<ul>
				<li><strong>用户名：</strong> <input class="ipt" type="text"
					name="username" placeholder="注册侠" size="20" id="username"/><span class="uts"></span></li>
				<li><strong>密 码：</strong> <input class="ipt" type="password"
					name="pwd" value="" size="20" id="zcpwd"/><span class="zcpwd"></span></li>
				<li><strong>确认密码：</strong> <input class="ipt" type="password"
					name="conpwd" value="" size="20" id="zcconpwd"/><span  class="zcconpwd"></span></li>
				<li><strong>手机号：</strong> <input class="ipt" type="text"
					name="phone" placeholder="您的手机号" size="20" id="phone"/><span class="pts" ></span></li>
				<li><strong>验证码：</strong> <input class="ipt" type="text"
					name="msg" size="20" id="yzm" style="width:100px;"/><span class="msgs" onclick="mess()">获取短信验证码</span><span id="messcode"></span> </li>
				<li><strong>邮箱：</strong> <input class="ipt" type="text"
					name="email" placeholder="您的联系邮箱" size="20" id="email"/><span class="zcemail"></span></li>
				<li ><center><p class="zcts"></p></center></li>
				<li> <center><input class="btn btn-primary"
					type="button" name="reg" value=" 注 册 " /></center></li>
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
		<form class="theme-signin" name="editform" action="#" method="post"
			id="ee">
			<ul>
				<li><strong>手 机 号：</strong> <input class="ipt" type="text"
					name="phonenumber" size="20" id="mob" /><span class="lostmobile" style="color:red;"></span></li>
				<li><strong>验 证 码：</strong> <input class="ipt" type="text"
					name="regmsg" size="20" id="getmess" style="width:100px;"/><span class="msgs" id="messages" onclick="lostpwd()">获取短信验证码</span> <span class="yzms"></span>
				</li>
				<li><strong>新  密 码：</strong> <input class="ipt" type="password"
					name="pwd" value="" size="20" id="wei" /><span class="wei"></span></li>
				<li><strong>确认密码：</strong> <input class="ipt" type="password"
					name="conpwds" value="" size="20" id="conwei"/><span class="conwei"></span></li>
				<li><input class="btn btn-primary" type="button" name="uppass"
					value=" 确 认 " class="bj" /><span></span></li>
			</ul>
		</form>
	</div>
</div>
<!--忘记密码窗结束体-->

<!--材料-->
<div class="theme-popover" id="cl">
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
  <!--  <label>收货人姓名<span>*</span></label> 
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
                <input type="text" name="userAddress[tag]" id="Tag" class="input" placeholder='地址标签：如"家"、"公司"。限5个字内'  > -->
   <!--  <input type="button" id="btnval" value="获取值" style="padding:5px 15px;"/>
    <input type="button" id="btntext" value="获取文本" style="padding:5px 15px;" />
	 <input type="button" id="bb" value="获取文本" style="padding:5px 15px;" /> -->


	</div>
</div>
<!--材料-->
<script type="text/javascript">
	var lost=false;	
	 $("#conwei").blur(function(){
			var cons=$("#wei").val();
			var conpw=$(this).val();
			if(cons !=conpw){
				$(".conwei").html("密码输入不一致!!!");
				lost=false;
			}else{
				lost=true;
				$(".conwei").html("输入正确");
				$(".conwei").css({"font-weight":"bold","color":"#0099FF"});
			}
		}) 
	//忘记密码时对输入的手机号进行是否注册过判断
	$("#mob").blur(function(){
		var phone=$("#mob").val();
		if(phone!="" || phone!=null){
			$.ajax({
				url : "/zhucexia/customer/validatelost",
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
					}
				},
				error:function(data) {
					var data=eval("(" + data + ")");
					}
			});
		}else{
			$(".lostmobile").html("手机不能为空");
		}
			
	});
	
	//忘记密码时发送短信
	 function lostpwd(){
		var phone=$.trim($("#mob").val());
		if(phone=="" || phone==null ){
			$(".lostmobile").html("手机号不能为空");
			lost = false;
			return ;
		}else if(lost==false){
			return ;
		}
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
	
						alert(data.message);
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
		
		//忘记密码操作
		 $('input[name="uppass"]').click(function() {
			 	alert("忘记密码操作");
		    	var newpass=$("#wei").val();
		    	var con=$("#conwei").val();
		    	var mess=$("#getmess").val();
		    	var phone=$.trim($("#mob").val());
		    	
		    	if(phone==""){
		    		lost=false
		    		$(".lostmobile").html("不能为空");
		    		$(".lostmobile").css({"color":"red","font-weight":"bold"});
		    		return ;
		    	}
		    	if(mess==""){
		    		lost=false
		    		$(".yzms").html("不能为空");
		    		$(".yzms").css({"color":"red","font-weight":"bold"});
		    		return ;
		    	}else{
		    		$(".yzms").html("");
		    	}
		    	if(newpass==""){
		    		lost==false;
		    		$(".wei").html("不能为空");
		    		$(".wei").css({"color":"red","font-weight":"bold"});
		    		return ;
		    	} else{
		    		$(".wei").html("");
		    	} 
		    	if(con==""){
		    		lost=false;
		    		$(".conwei").html("不能为空");
		    		$(".conwei").css({"color":"red","font-weight":"bold"});
		    		return ;
		    	}else if(newpass!=con){
		    		lost=false;
		    		$(".conwei").html("密码不一致");
		    		$(".conwei").css({"color":"red","font-weight":"bold"});
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
		        	alert("执行忘记密码！！ajax");
		        	var name=$("#use").val();
					var password=$("#wei").val();
					$.ajax({
						url : "/zhucexia/customer/updatepass",
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
