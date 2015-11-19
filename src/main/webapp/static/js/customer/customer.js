//提交修改密码表单
function bb(){
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
					   closeWin();
				   }else{
					   alert("系统繁忙，请稍后重试！");
					   closeWin();
				   }
			   }
		   });
	   //}
   }
}	   

//提交基本信息
function aa(path){
	var file = $("#image").val();
	if(file==""||file==null){
		alert("请先上传图片！")
	}else{
		$("#baseDateForm").submit();
	}
}

function addBaseDataWin(){
	$(".facebox:eq(0)").css({"top":"8%","left":"36%","display":"block"});
	$("#facebox_overlay").css("display","block");
}

function changePwdWin(){
	$(".facebox:eq(1)").css({"top":"8%","left":"36%","display":"block"});
	$("#facebox_overlay").css("display","block");
}

function bindMobileWin(){
	$(".facebox:eq(2)").css({"top":"11%","left":"36%","display":"block"});
	$("#facebox_overlay").css("display","block");
	$("#warning_4").hide();
	$("#warning_6").hide();
}

function bindEmailWin(){
	$(".facebox:eq(3)").css({"top":"15%","left":"36%","display":"block"})
	$("#facebox_overlay").css("display","block");
	$("#warning_8").hide();
	$("#warning_10").hide();
}

function closeWin(){
	$(".facebox").css({"top":"","left":"","display":"none"});
	$("#facebox_overlay").css("display","none");
	location.reload();
}

//预览头像
function previewImage(file)
{
  var MAXWIDTH  = 100;
  var MAXHEIGHT = 100;
  var div = document.getElementById('preview');
  if (file.files && file.files[0])
  {
      div.innerHTML ='<img id=avatar>';
      var img = document.getElementById('avatar');
      img.onload = function(){
        var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
        img.width  =  rect.width;
        img.height =  rect.height;
//         img.style.marginLeft = rect.left+'px';
        img.style.marginTop = rect.top+'px';
      }
      var reader = new FileReader();
      reader.onload = function(evt){img.src = evt.target.result;}
      reader.readAsDataURL(file.files[0]);
  }
  else //兼容IE
  {
    var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
    file.select();
    var src = document.selection.createRange().text;
    div.innerHTML = '<img id=avatar>';
    var img = document.getElementById('avatar');
    img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
    var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
    status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
    div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:"+rect.top+"px;"+sFilter+src+"\"'></div>";
  }
}
function clacImgZoomParam( maxWidth, maxHeight, width, height ){
    var param = {top:0, left:0, width:width, height:height};
    if( width>maxWidth || height>maxHeight )
    {
        rateWidth = width / maxWidth;
        rateHeight = height / maxHeight;
         
        if( rateWidth > rateHeight )
        {
            param.width =  maxWidth;
            param.height = Math.round(height / rateWidth);
        }else
        {
            param.width = Math.round(width / rateHeight);
            param.height = maxHeight;
        }
    }
     
    param.left = Math.round((maxWidth - param.width) / 2);
    param.top = Math.round((maxHeight - param.height) / 2);
    return param;
}

//验证手机是否可用

function toBindMobile(){
	$("#bindedMobile").css("display","none");
	$("#bindMobile").css("display","block");
}

//验证手机发送验证码
function sendMsgBinded(){
	var mobile = $("#old_mobile").val();
	$.ajax({
		url:"/zhucexia/customer/mess",
		data: {"phonenum":mobile},
		type : 'POST',
		dataType: "json",
		success:function(data){
			//发送短信计时
			var data = eval('('+data+')');
			if(data.message=="发送成功"){
				alert("已向您绑定的手机号发送验证码信息");
				var validCode = false;
				var time = 30;
		        var code = $("#code");
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
			}else{
				alert("系统繁忙，请稍后重试");
			}
		}
	});
}


//转向修改绑定手机页面
function toBindMobile(){
	var yzm=$("#id_token").val().trim();
	var mobile = $("#old_mobile").val().trim();
	if(yzm!="" && yzm!=null){
		$.ajax({
			url : "/zhucexia/customer/validateyzm",
			type : 'POST',
			dataType: "json",
			data : {"yzm" : yzm,"mobile":mobile},
			success : function(data) {
				data=eval('('+data+')');
				if(data.message=="输入正确"){
					$("#bindedMobile").css("display","none");
					$("#bindMobile").css("display","block");
				}else{
					alert(data.message);
				}
			}
		});
	}else{
		$("#warning_5 span").html("请输入验证码");
		$("#warning_5").show();
	}
}

//绑定手机发送验证码
function sendMsg(){
	var phone=$("#id_mobile").val().trim();
	var reg = /^1[3578][0-9]{9}$/; 
	var flag = reg.test(phone);
	if(flag){
		//验证手机是否可用
		$.ajax({
			url : "/zhucexia/customer/validatephone",
			type : 'POST',
			dataType: "json",
			data : {
				phonenum : phone,
			},
			success : function(data) {
				var data=eval('(' + data + ')');
				if(data.message=="该手机已占用"){					
					$("#warning_6 span").html("该手机已占用");
					$("#warning_6").show();
				}else{
					$("#warning_6").hide();
					//发送验证码
					$.ajax({
						url:"/zhucexia/customer/mess",
						data: {"phonenum":phone},
						type : 'POST',
						dataType: "json",
						success:function(data){
							//发送短信计时
							var data = eval('('+data+')');
							if(data.message=="发送成功"){
								alert("已向您输入的手机号发送验证码信息");
								var validCode = false;
								var time = 30;
						        var code = $("#code1");
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
							}else{
								alert("系统繁忙，请稍后重试");
							}
						}
					});
				}
			}
		});
	}else{
		$("#warning_6 span").html("请输入正确的手机号");
		$("#warning_6").show();
	}
}



//提交绑定手机表单
function bindMobile() {
	var yzm=$("#id_token_1").val().trim();
	var mobile = $("#id_mobile").val().trim();
	if(yzm!="" && yzm!=null){
		$.ajax({
			url : "/zhucexia/customer/validateyzm",
			type : 'POST',
			dataType: "json",
			data : {"yzm" : yzm,"mobile":mobile},
			success : function(data) {
				var data=eval("(" + data + ")");
				if(data.message !="输入正确"){
					$("#warning_7 span").html(data.message);
					$("#warning_7").show();
				}else{
					$.ajax({
						url:"/zhucexia/customer/bindMobile",
						data : {"mobile":mobile},
						type : "post",
						success : function(data){
							if(data==0){
								alert("绑定成功");
								closeWin();
							}else{
								alert("系统繁忙，请稍后重试")
							}
						}			
					});
				}
			},
		});
	}else{
		$("#warning_7 span").html("请输入验证码");
		$("#warning_7").show();
	}
		
}

//绑定邮箱发送验证邮件
function sendEmail(){
	var type=$("#type").val();
	var email = $("#id_email").val();
	var reg = /^[\w][\w|\.|\_]*@[\w]+(\.[a-zA-Z]{2,4}){1,3}$/;
	var flag = reg.test(email);
	if(flag){
		$.ajax({
			url:"/zhucexia/customer/sendEmail",
			type:"post",
			data:{'email':email,'type':type},
			dataType:'json',
			success:function(){
				alert("已向您发送验证邮件，请查看并完成验证");
				closeWin();
			}
		});
	}else{
		$("#warning_10 span").html("请输入正确的电子邮箱");
		$("#warning_10").show();
	}
}












