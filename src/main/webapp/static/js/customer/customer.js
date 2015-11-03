//提交修改密码表单
function bb(){
	   alert("bb");
	   //清空提示信息
	    $("#warning_1").hide();
	   $("#warning_2").hide();
	   $("#warning_3").hide();	
	   $("#warning_4").hide();
	   //获取要提交的数据
	   var oldPwd=$("#id_oldpassword").val().trim();
	   var newPwd=$("#id_password1").val().trim();
	   var finalPwd=$("#id_password2").val().trim();
	   //检验输入数据的格式
	   var flag=true;
	   if(oldPwd==""){
		   $("#warning_1 span").html("<font color='red'>当前密码为空</font>");
		   $("#warning_1").show();
		   flag=false;
	   }
	   if(newPwd==""){
		   $("#warning_2 span").html("<font color='red'>新密码为空</font>");
		   $("#warning_2").show();
		   flag=false;
	   }
	   if(oldPwd==""){
		   $("#warning_3 span").html("<font color='red'>确认密码为空</font>");
		   $("#warning_3").show();
		   flag=false;
	   }else if(finalPwd!=newPwd){
		   $("#warning_3 span").html("<font color='red'>两次输入密码不同</font>");
		   $("#warning_3").show();
		   flag=false;
	   }
	   if(flag){ 
		   $.ajax({
			   url:"/zhucexia/customer/changePwd",
			   data:{"oldPwd":oldPwd,"newPwd":newPwd},
			   type:"post",
			   success:function(data){
				   if(data==2){
					   alert("初始密码错误，请重新输入！");
				   }else if(data==0){
					   alert("修改密码成功！");
				   }else{
					   alert("系统繁忙，请稍后重试！");
				   }
			   }
		   });
	   //}
   }
}	   

function addBaseData(){
	alert("qqqq");
	$(".facebox:eq(0)").css({"top":"8%","left":"36%","display":"block"});
}

function changePwd(){
	   $(".facebox:eq(1)").css({"top":"8%","left":"36%","display":"block"});
}

function bindMobile(){
	$(".facebox:eq(2)").css({"top":"11%","left":"36%","display":"block"});
	$("#warning_4").hide();
	$("#warning_5").hide();
}

function closeWin(){
	   $(".facebox").css({"top":"","left":"","display":"none"});
}

//提交基本信息表单
function aa(){
	alert("aa")
	   $.ajax({
		   url:"${root}/customer/setBaseDate",
		   data:$("#baseDateForm").serialize(),
		   type:"POST",
		   success:function(data){
			   $("div.content .face-block").html(data);
		   }
	   });
	return false;
}
//验证手机是否可用


//绑定手机发送验证码
function sendMsg(){
	var mobile=$("#id_mobile").val().trim();
	var checkMsg=$("#warning_4 span").html();
	if(checkMsg=="true"){
		$.ajax({
			url:"/zhucexia/customer/mess",
			data: {"phonenum":mobile},
			type : 'POST',
			dataType: "json",
			success:function(){
				alert("已发送短信");
			}
		});
	}
}

//发送短信倒计时
var validCode = false;
$("#send_token_btn").click(function() {
    var pts=$("#warning_4 span").html() ;
	validCode = false;
	if(($(this).html()=="获取短信验证码" || $(this).html()=="重新获取") && ($("#phone").val()!="" || pts != "该号已占用" )){
        var time = 30;
        var code = $(this);
        code.addClass("msgs1");
        var t = setInterval(function() {
        	validCode = true;
            time--;
            code.html(time + "秒");
            if (time == 0) {
                clearInterval(t);
                code.html("重新获取");
                validCode = false;
                code.removeClass("msgs1");
            }
            
        }, 1000)
    }
  
})


//提交绑定手机表单
function cc() {
	var mobile = $("#id_mobile").val().trim();
	if($("#warning_5 span").html()=="验证通过"){
		$.ajax({
			url:"/zhucexia/customer/bindMobile",
			data : {"mobile":mobile},
			type : "post",
			success : function(data){
				if(data==0){
					alert("绑定成功");
				}else{
					alert("系统繁忙，请稍后重试")
				}
			}			
		});
	}
}