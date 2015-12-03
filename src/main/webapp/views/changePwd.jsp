<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet" href="${root }/static/css/includes/loginRe.css">
</head>
<body>
	<div class="theme-popover" id="edit">
		<div class="theme-poptit">
		重 置 密 码！ <a href="javascript:;" title="关闭" class="close">×</a> <br />
		</div>
		<div class="theme-popbod dform">
			<form class="theme-signin" name="editform" action="#" method="post"
			id="ee" style="display:none">
				<ul>
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
</body>
</html>