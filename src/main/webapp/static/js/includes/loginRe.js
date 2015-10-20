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
        'password' : function(value){
            return value.length >=6 && value.length <= 20 && value !== '';
        },
        'conpassword' : function(value){
            return value === $('input[name="password"]').val() && value !== '';
        },
        'mobile' : /^\d{11}/,
        'email' : /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/

    };
    var SUCMSG = '输入成功';
    var errormsg  = {
        'username' : '用户名应该为3-20位之间',
        'password' : '密码应该为6-20位之间',
        'conpassword' : '输入密码要一致',
        'mobile' : '手机号为11位数字',
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
        }
        if($.isFunction(rule) && rule(value) || rule.constructor == RegExp && rule.test(value)){
            $this.next().text(SUCMSG).removeClass('error-text').addClass('success-text');
            flag = true;
        }else{
            $this.next().text(errormsg.name).removeClass('success-text').addClass('error-text');
        }
    });
    //获取短信验证码
    var validCode = false;
    $(".msgs").click(function() {

        var pts=$(".pts").html() ; var los=$(".lostmobile").html();
    	validCode = false;
    	if(($(this).html()=="获取短信验证码" || $(this).html()=="重新获取") && ($("#phone").val()!="" || $("#mob").val()!="该号已占用" ) && (pts != "该号已占用" && los!="输入有误或未曾注册")){
	        var time = 30;
	        var code = $(this);
       var code = $(this);
        if (validCode) {
            validCode = false;
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
    	}
    })

    
    $("#username").blur(function(){
    		var name=$("#username").val();
    		if(name!="" || name!=null){
    			$.ajax({
    				url : "/zhucexia/customer/validateuser",
    				type : 'POST',
    				dataType: "json",
    				data : {
    					username : name,
    				},
    				success : function(data) {
    					var data=eval("(" + data + ")");
    					if(data.message=="已经被占用"){
    						$(".uts").html("已经被占用");
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
					if(data.message=="该号已占用"){
						
						$(".pts").html("该号已占用");
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
	/*   $("#mobile").blur(function(){
		var mobile=$("#mobile").val();
		alert(mobile);
		if(mobile!="" || mobile!=null){
			alert("进入ajax");
=======
    
    //验证手机验证码
    $("#yzm").blur(function(){
		var yzm=$(this).val();
		if(yzm!="" || yzm!=null){
>>>>>>> branch 'master' of https://github.com/zhucexia/zhucexia.git
			$.ajax({
				url : "/zhucexia/customer/validatephone",
				type : 'POST',
				dataType: "json",
				data : {
					phonenum : mobile,
				},
				success : function(data) {
					var data=eval("(" + data + ")");
					if(data.message=="该号已占用"){
						
						$(".pts").html("该号已占用");
						validCode=false;
						if(flag==false || validCode==false){
				    		 $(".pts").css("color","red");
				    		 alert("添加红色");
				    	 }else{
				    		 $(".pts").css("color","#0099FF");
				    	 }
					}else{
						if($("#mobile").val().length==11){
							validCode=true;
						}else{
							validCode=false;
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
					alert("出错");
				}
			});
		}
		
	});
    function colorselect(){
    	 if(flag==false || validCode==false){
    		 alert("进入颜色选择");
    		 alert(flag);alert(validCode);
    		 $(this).next().css("color","red");
    		 $(".pts").css("color","red");
         	$(".uts").css("color","red");
    	    }else if(flag==true && validCode==true){
    	    	alert("进入正确颜色选择");
    	    	$(this).children(".ts").css("color","#0099FF");
    	    }
    }*/   
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
    	}
    	if($("input[name='username']").val()=="" || $("input[name='username']").val()==null){
    		flag==false;
    	}
        if (flag==true && validCode==true) {
        	var name=$("#username").val();
			var password=$("input[name='pwd']").val();
			var mobile=$("input[name='phone']").val();
			var email=$("input[name='email']").val();
			$.ajax({
				url : "/zhucexia/customer/reg",
				type : 'POST',
				dataType: "json",
				data : {
					username : name,
					password : password,
					phonenum: mobile,
					email: email,
				},
				success : function(data) {
					var data=eval("(" + data + ")");
					alert(data.message);
				},
				error:function(data) {
					var data=eval("(" + data + ")");
					alert(data.message);
				}
			});
        } else {
            return false;
        }
    });

})
