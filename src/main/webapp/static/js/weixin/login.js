$("#do_login").click(function (){
			var mobile = $("#login_name").val();
			var password = $("#login_pwd").val();
			var reg1 = /^1[3578][0-9]{9}$/;
			var reg2 = /^[\w|_-]{6,20}$/;
			var flag = true;
			if(!reg1.test(mobile)){
				flag = false;
			}
			if(!reg2.test(password)){
				flag = false;
			}
			alert('111111111111');
			if(flag){
				$.ajax({
					url:"${root}/WXUser/login",
					type:"post",
					data:{"mobile":mobile,"password":password},
					success:function(data){
						if(data==0){
							var aim ='${aim}';
							alert('22222222222222222222');
							if(aim==1){
								location.href="${root}/WXOrder/orderManage";									
							}
							if(aim==2){
								var ids='${ids}';
								location.href="${root}/wxsales/toBookOrders?ids="+ids;
							}
							if(aim==3){
								location.href="${root}/WXUser/userCenter"
							}
						}
						if(data==1){
							alert("手机号或密码错误！");
						}
					}
				});
			}else{
				alert("请输入正确的手机号和密码！");
			}
		});

$("#regist").click(function(){
	var mobile = $("#reg_name").val();
});