//提交修改密码表单
function bb(){
	   alert("bb");
	   //清空提示信息
	   /* $("#warning_1").hide();
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
		   $("#warning_1 span").html("当前密码为空");
		   $("#warning_1").show;
		   flag=false;
	   }
	   if(newPwd==""){
		   $("#warning_2 span").html("新密码为空");
		   $("#warning_2").show;
		   flag=false;
	   }
	   if(oldPwd==""){
		   $("#warning_3 span").html("确认密码为空");
		   $("#warning_3").show;
		   flag=false;
	   }else if(!oldPwd.equals(newPwd)){
		   $("#warning_3 span").html("两次输入密码不同");
		   $("#warning_3").show;
		   flag=false;
	   }
	   if(flag){ */
		   $.ajax({
			   url:"${root}/customer/changePwd",
			   data:$("#changePwd").serialize(),
			   type:"post",
			   success:function(data){
				   if(data==0){
					   alert("初始密码错误，请重新输入！");
				   }else if(data==1){
					   alert("修改密码成功！");
				   }else{
					   alert("系统繁忙，请稍后重试！");
				   }
			   }
		   });
	   //}
   }

$("#baseDate").click(function(){	   
	   $("#facebox").css("display","block");
});

$("#changePwd").click(function(){
	   $("#facebox1").css("display","block");
});

$("#bingdMobile").click(function(){
	$("#facebox2").css("display","block");
});

$(".close").click(function(){
	   $(".facebox").css("display","none");
});

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
$("#id_mobile").blur(function(){
	var phone=$("#id_mobile").val();
	var reg = /^1[3578][0-9]{9}$/;
	var flag = reg.test(phone);
	if(flag){
		$.ajax({
			url : "/zhucexia/customer/validatephone",
			type : 'POST',
			dataType: "json",
			data : {
				phonenum : phone,
			},
			success : function(data) {
				var data=eval("(" + data + ")");
				if(data.message=="该手机已占用"){					
					$(".pts").html("该手机已占用");
				}else{
					$(".pts").html("手机号可用");
				}
			},
		});
	}else{
		$(".pts").html("请输入正确的手机号");
	}
	
});

//绑定手机发送验证码
function sendmsg(){
	msgflag = true;
	if($(".pts").html()!="手机号可用"){
		msgflag = false;
	}
	if(msgflag){
		$.ajax({
			url:"${root}/customer/mess",
			data: {"mobile":mobile},
			type : 'POST',
			dataType: "json",
			success:function(){
				
			}
		});
	}
}

//发送短信倒计时
var validCode = false;
$(".msgs").click(function() {
    var pts=$(".pts").html() ;
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
//验证手机验证码
 $("#id_token").blur(function(){
		var yzm=$(this).val();
		if(yzm!="" || yzm!=null){
			$.ajax({
				url : "/zhucexia/customer/validateyzm",
				type : 'POST',
				dataType: "json",
				data : {
					yzm : yzm,
				},
				success : function(data) {
					var data=eval("(" + data + ")");
					if(data.message !="输入正确"){
						validCode=false;
						$("#messcode").html(data.message);
						$("#messcode").css({"color":"red","font-weight":"bold"});
					}else{
						validCode=true;
						$("#messcode").html("验证通过");
					}
				},
				error:function(data) {
					var data=eval("(" + data + ")");
					$("#messcode").html();
				}
			});
		}else{
			$("#messcode").html("不能为空");
		}
			
	});

//提交绑定手机表单
function cc() {
	var username = '<%=customer.getUsername()%>';
	var mobile = $("#id_mobile").val().trim;
	if($("#messcode").html()=="验证通过"){
		$.ajax({
			url:"${root}/costomer/bindMobile",
			data : {"username":username,"mobile":mobile},
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