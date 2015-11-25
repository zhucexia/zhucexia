<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
#cs_box {width:120px; height:220px; color:#FFF; background:#54a7ff; position:fixed; right:10px; top:100px; border-radius:10px; z-index:1000}
#cs_box span {height:20px; line-height:20px;display:block;}
.cs_close {color:#FFF; position:absolute; right:10px; top:8px; cursor:pointer; font-size:20px;font-family:Verdana, Geneva, sans-serif}
.cs_title {font-size:14px; margin:10px; font-weight:bold;}
.cs_img {width:100px; height:100px; background:#FFF; margin:10px;background-image:url(http://demo.lanrenzhijia.com/2014/service1119/images/lanrenzhijia.jpg) }
.cs_info {font-size:12px; margin:0px 10px; overflow:hidden; text-align:center;}
.cs_btn {width:100px; height:25px; background:#333; margin:5px 10px; border-radius:5px; font-size:12px; line-height:25px; color:#FFF; text-align:center; cursor:pointer;}
</style>
</head>
<body>
<!-- 代码部分begin -->
<div id='cs_box'>
	<span class='cs_title'>在线咨询</span>
	<span class='cs_close'>x</span>
	<div class='cs_img'></div>
	<span class='cs_info'>有什么可以帮到你</span>
	<div class='cs_btn'>点击咨询</div>
</div>
<script src="http://www.lanrenzhijia.com/ajaxjs/lanrenzhijia.js"></script>
<script>
	myEvent(window,'load',function(){
		cs_box.set({
			img_path : 'http://demo.lanrenzhijia.com/2014/service1119/images/lanrenzhijia.jpg',	//设置图片路径
			qq : '343382252',	//设置QQ号码'19276507'
		});
	});
</script>
</body>
</html>