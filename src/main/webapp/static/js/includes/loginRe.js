$(function() {
	var bool = false;
    $('.J_dialog').click(function(event) {
        var data = $(this).attr('data');
        //$('.theme-popover').filter('#'+data).slideDown(200);
        if(data=='log'){
        	$("#reg").css("display","none");
        	$("#edit").css("display","none");
        	$("#log").css("display","block");
        	$("#logname").val("");
        	$("#password").val("");
        	$("#mess").hide();
        }
        if(data=='reg'){
        	regist();
        }
        
    });
    $('.theme-poptit .close').click(function(){
        $('.theme-popover').slideUp(200);
        $("#username").val("");
		$("input[name='pwd']").val("");
		$("input[name='conpwd']").val("");
		$("input[name='phone']").val("");
		$("input[name='email']").val("");
		$("#yzm").val("");
		$("#wei").val("");
    	$("#conwei").val("");
    	$("#getmess").val("");
    	$("#mob").val("");
    	bool = true;
    });

    var rules = {
        'username' : /^\w{3,12}$/,
        'pwd' : /^\w{6,20}$/,
        'conpwd' : function(value){
        	return value!=""&&value==$("input[name='pwd']").val();
        },
        'phone' : /^1[3578][0-9]{9}$/,
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
        if(value==""||value==null||rule==""||rule==null){
        	$this.next().not('.msgs').html("");
        	return
        }else{
        	if($.isFunction(rule)?rule(value):rule.test(value)) {
        		//return;
        		$this.next().text(SUCMSG).removeClass('error-text').addClass('success-text');
        	}else{
        		//flag = false;
        	}
        }
        /*if($.isFunction(rule) && rule(value) || rule.constructor == RegExp && rule.test(value)){
            flag = true;
        }else{
        	flag = false;
            $this.next().text(errormsg.name).removeClass('success-text').addClass('error-text');
        }*/
    });
    //发送短信倒计时
    var validCode = false;
    $(".msgs").click(function() {
        var pts=$(".pts").html() ; var los=$(".lostmobile").html();
    	validCode = false;
    	if(($(this).html()=="获取短信验证码" || $(this).html()=="重新获取") && (($("#phone").val()!="" &&pts != "该号已占用" )||($("#mob").val()!=""&&los!="输入有误或未曾注册"))){
	        var time = 30;
	        var code = $(this);
            code.addClass("msgs1");
            var t = setInterval(function() {
            	validCode = true;
                time--;
                code.html(time + "秒");
                if (time == 0||bool) {
                	bool=false;
                    clearInterval(t);
                    code.html("重新获取");
                    validCode = false;
                    code.removeClass("msgs1");
                }
                
            }, 1000)
        }
      
    })
    
    //验证用户名是否注册过
    var validName = true;
    $("#username").blur(function(){
    		var name=$("#username").val();
    		if(rules['username'].test(name)){
    			$.ajax({
    				url : roots+"/customer/validateuser",
    				type : 'POST',
    				dataType: "json",
    				data : {
    					username : name,
    				},
    				success : function(data) {
    					var data=eval("(" + data + ")");
    					if(data.message=="该用户已占用"){
    						$(".uts").html("该用户已占用");
    						validName=false;
    					}else{
    						validName=true;
    					}
    				}
    			});
    		}else{
    			validName=false;
    		}
    	});

    //验证手机是否被占用过
    var validMobile = true;
    $("#phone").blur(function(){
		var phone=$("#phone").val();
		if(rules['phone'].test(phone)){
			$.ajax({
				url : roots+"/customer/validatephone",
				type : 'POST',
				dataType: "json",
				data : {
					phonenum : phone,
				},
				success : function(data) {
					var data=eval("(" + data + ")");
					if(data.message=="该手机已占用"){
						
						$(".pts").html("该手机已占用");
						validMobile=false;
					}else{
						validMobile=true;
					}
				},
			});
		}else{
			validMobile=false;
		}
	});
    
    //验证手机验证码
    $("#yzm").blur(function(){
		var yzm=$(this).val();
		var mobile=$("#phone").val();
		if(yzm!="" && yzm!=null){
			$.ajax({
				url : roots+"/customer/validateyzm",
				type : 'POST',
				dataType: "json",
				data : {
					'yzm' : yzm,'mobile':mobile
				},
				success : function(data) {
					var data=eval("(" + data + ")");
					if(data.message !="输入正确"){
						$("#messcode").html(data.message);
						$("#messcode").css({"color":"red","font-weight":"bold"});
					}else{
						$("#messcode").html("输入正确");
						$("#messcode").css({"color":"#0099FF","font-weight":"bold"});
					}
				},
				error:function(data) {
					var data=eval("(" + data + ")");
					$("#messcode").html();
				}
			});
		}else{
			$("#messcode").html("请输入验证码");
			$("#messcode").css({"color":"red","font-weight":"bold"});
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
    	var flag = true;
    	var name=$("#username").val();
		var password=$("#zcpwd").val();
		var cpassword=$("#zcconpwd").val();
		var mobile=$("#phone").val();
		var email=$("#email").val();
		var yzm=$("#yzm").val();
    	if(!validName){
    		flag = false;
    	}
    	if(!rules['pwd'].test(password)){
    		flag = false;
    	}
    	if(!rules['conpwd'](cpassword)){
    		flag = false;
    	}
    	if(!validMobile){
    		flag = false;
    	}
    	if (email != '') {
    	   var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
    	   if (!reg.test(email)) {
    		   flag==false;
    		   $(".zcemail").html("邮箱格式不正确");
    	   }
    	}
    	if($("#messcode").html()!="输入正确"){
    		flag==false;
    	}   	
    	if (flag) {
			$.ajax({
				url : roots+"/customer/reg",
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
        	$(".zcts").html("请完成带*号的全部内容");
        	$(".zcts").css({"color":"red","font-weight":""})
        }
    });

})