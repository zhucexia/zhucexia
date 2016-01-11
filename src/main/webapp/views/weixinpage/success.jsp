<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%
	// Set request data code convertion
	request.setCharacterEncoding("UTF-8");
	// Application common variables
	String root = request.getContextPath();
	request.setAttribute("root",root);	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript" src="${root}/static/js/common/jquery-1.7.1.min.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script language="javascript">
function callpay(){
		//加载
		wx.config({
		    debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		    appId: '${StringUtil.wrapString(requestAttributes.appId)}', // 必填，公众号的唯一标识
		    timestamp: '${StringUtil.wrapString(requestAttributes.timeStamp)}', // 必填，生成签名的时间戳
		    nonceStr: '${StringUtil.wrapString(requestAttributes.nonceStr)}', // 必填，生成签名的随机串
		    signature: '${StringUtil.wrapString(requestAttributes.signature)}',// 必填，签名，见附录1
		    jsApiList: [
		    'checkJsApi',
		            'chooseWXPay'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		});
		wx.ready(function(){
		//支付
		wx.chooseWXPay({
		    timestamp: '${StringUtil.wrapString(requestAttributes.timeStamp)}', // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
		    nonceStr: '${StringUtil.wrapString(requestAttributes.nonceStr)}', // 支付签名随机串，不长于 32 位
		    package: '${StringUtil.wrapString(requestAttributes["package"])}', // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
		    signType: '${StringUtil.wrapString(requestAttributes.signType)}', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
		    paySign: '${StringUtil.wrapString(requestAttributes.paySign)}', // 支付签名
		    success: function (res) {
		        // 支付成功后的回调函数
		        WeixinJSBridge.log(res.err_msg);
		        //alert("支付接口:"+res.err_code + res.err_desc + res.err_msg);
		        if(!res.err_msg){
		                    //支付完后.跳转到成功页面.
		        location.href="orderconfirm?orderId=${StringUtil.wrapString(requestAttributes.out_trade_no)}";
		        }
		    }
		});
		    // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
		});
		wx.error(function(res){
		    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
		});
		wx.checkJsApi({
		    jsApiList: ['chooseWXPay'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
		    success: function(res) {
		    //alert("检测接口:"+res.err_msg);
		    }
		    });
}
</script>
	<script>
		function getCode(){
			var id=${id}
			location.href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx7eb46e5ce64de326&redirect_uri=https%3A%2F%2Fwww.zhucexia.com%2FWXOrder%2FmakeSurePrice&response_type=code&scope=snsapi_base&state="+id+"#wechat_redirect"
		}
	</script>
</head>
<body>
	<form>
		<input type="button" value="确认" onlick="callpay();">
	</form>
</body>
</html>