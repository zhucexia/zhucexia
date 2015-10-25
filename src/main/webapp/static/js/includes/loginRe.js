$(function() {
    $('.J_dialog').click(function(event) {
        var data = $(this).attr('data');
        $('.theme-popover').filter('#'+data).slideDown(200);
    });
    $('.theme-poptit .close').click(function(){
        $(this).parents('.theme-popover').slideUp(200);
    });

    var flag = false;

    var rules = {
        'username' : function(value){
            return value.length >= 3 && value.length <= 12 && value !== '';
        },
        'pwd' : function(value){
            return value.length >=6 && value.length <= 20 && value !== '';
        },
        'conpwd' : function(value){
            return value === $('input[name="pwd"]').val() && value !== '';
        },
        'phone' : /^\d{11}/,
        'email' : /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/

    };
    var SUCMSG = '输入成功';
    var errormsg  = {
        'username' : '用户名应该为3-20位之间',
        'pwd' : '密码应该为6-20位之间',
        'conpwd' : '输入密码要一致',
        'phone' : '手机号为11位数字',
        'email' : '请输入正确的EMAIL格式'
    }
    $('.theme-signin input').focus(function() {
      var $this = $(this),
        name = $this.attr('name');
        $this.next().not('.msgs').text(errormsg[name]).removeClass('success-text').addClass('error-text');
    }).blur(function() {
        var $this = $(this),
            name = $this.attr('name'),
            value = $this.val(),
            rule = rules[name];
        if(!rule) {
            flag = true;
            return;
        }else{
        	flag = false;
        }
        if($.isFunction(rule) && rule(value) || rule.constructor == RegExp && rule.test(value)){
            $this.next().text(SUCMSG).removeClass('error-text').addClass('success-text');
            flag = true;
        }else{
        	flag = false;
            $this.next().text(errormsg.name).removeClass('success-text').addClass('error-text');
        }
    });
    //发送短信倒计时
    var validCode = false;
    $(".msgs").click(function() {
        var pts=$(".pts").html() ; var los=$(".lostmobile").html();
    	validCode = false;
    	if(($(this).html()=="获取短信验证码" || $(this).html()=="重新获取") && ($("#phone").val()!="" || $("#mob").val()!="该号已占用" ) && (pts != "该号已占用" && los!="输入有误或未曾注册")){
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
    
    //验证用户名是否注册过
    $("#username").blur(function(){
    		var name=$("#username").val();
    		if(name != "" || name!=null){
    			$.ajax({
    				url : "/zhucexia/customer/validateuser",
    				type : 'POST',
    				dataType: "json",
    				data : {
    					username : name,
    				},
    				success : function(data) {
    					var data=eval("(" + data + ")");
    					if(data.message=="该用户已占用"){
    						$(".uts").html("该用户已占用");
    						validCode=false;
    						if(flag==false || validCode==false){
   				    		 $(".uts").css("color","red");
   				    	    }else if(flag==true && validCode==true){
   				    	      $(".uts").css("color","#0099FF");
   				    	    }
    					
    					}else{
    						validCode=true;
    						if($("#username").val().length>=3){
    							validCode=true;
    						}else{
    							validCode=false;
    						}	
    						
    						if(flag==false || validCode==false){
      				    		 $(".uts").css("color","red");
      				    	    }else if(flag==true && validCode==true){
      				    	      $(".uts").css("color","#0099FF");
      				    	    }
    					}
    				},
    				error:function(data) {
    					var data=eval("(" + data + ")");
    				}
    			});
    		}
    		
    	});

    //验证手机是否被占用过
    $("#phone").blur(function(){
		var phone=$("#phone").val();
		if(phone!="" || phone!=null){
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
						validCode=false;
						if(flag==false || validCode==false){
				    		 $(".pts").css("color","red");
				    	 }else{
				    		 $(".pts").css("color","#0099FF");
				    	 }
					}else{
						
						if($("#phone").val().length==11){
							validCode=true;
						}else{
							validCode=false;
							$(".pts").html("手机号为11位数字");
						}		
						if(flag==false || validCode==false){
				    		$(".pts").css("color","red");
				    		
				    	 }else if(flag==true && validCode==true){
				    	    $(".pts").css("color","#0099FF");
				    	 }
					}
				},
				error:function(data) {
					var data=eval("(" + data + ")");
				}
			});
		}
		
	});
    
    //验证手机验证码
    $("#yzm").blur(function(){
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
						$("#messcode").html("");
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
    
    //头部我的订单特效
    $(".aa").hover(function(){
    	$(".cc").css("display","block");
    	},function(){
    	$(".cc").css("display","none");
    	});
  //提交按钮,所有验证通过方可提交
    $('input[name="reg"]').click(function() {
    	var name=$("#username").val();
		var password=$("#zcpwd").val();
		var cpassword=$("#zcconpwd").val();
		var mobile=$("#phone").val();
		var email=$("#email").val();
		var yzm=$("#yzm").val();
    	if(name=="" || password=="" || cpassword=="" || mobile=="" || yzm=="" || email==""){
    		$(".zcts").html("完整以上全部内容");
    		$(".zcts").css({"font-weight":"bold","color":"red"});
    		flag==false;
    		return ;
    	}else{
    		$(".zcts").html("");
    	}
    	 if (email != '') {
    	    var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
    	    if (!reg.test(email)) {
    	    	flag==false;
        		return ;
    	  }
    	}
    	if($(".msgs").html()=="获取短信验证码" || $(".msgs").html()=="重新获取"){
    		flag==false;
    		return;
    	}   	
    	if (flag==true && validCode==true) {
    		alert(flag);alert(validCode);
			$.ajax({
				url : "/zhucexia/customer/reg",
				type : 'POST',
				dataType: "json",
				data : {
					username : name,
					password : password,
					phonenum: mobile,
					email: email,
					smscode:yzm,
				},
				success : function(data) {
					var data=eval("(" + data + ")");
					alert(data.message);
					if(data.message=="注册成功"){
						$("#username").val("");
						$("input[name='pwd']").val("");
						$("input[name='conpwd']").val("");
						$("input[name='phone']").val("");
						$("input[name='email']").val("");
						$("#yzm").val("");
						$("#reg").hide();
					}
				},
				error:function(data) {
					var data=eval("(" + data + ")");
					alert(data.message);
					
				}
			});
        } else {
         
        }
    });

})