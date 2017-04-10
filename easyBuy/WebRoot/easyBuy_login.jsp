<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>EasyBuy后台管理-系统登录</title>
		<meta charset="utf-8">
		<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="js/admin_login.js"></script>
		<link type="text/css" rel="stylesheet" href="css/admin_login.css"/>
	</head>
	<body leftmargin="0" onload="changeImg()">
		<div class="main_bar">
			<div id="login_form">
				<div class="title">
					EasyBuy系统登录
				</div>
				<form action="doLogin.jsp" method="post" onsubmit="return check()">
				<div id="form_widget">
					<br>
					<input type="text" name="uname" placeholder="请输入账号" id="box_name" class="txt" value="用户名" onfocus="this.value=''" onblur="if(this.value=='')this.value='用户名'"/>
					<br>
					<input type="password" name="upass" placeholder="请输入密码" id="box_pass" class="txt"  value="password" onfocus="this.value=''" onblur="if(this.value=='')this.value='password'"/>
					<br>
					<input type="text" id="vcode" placeholder="验证码"  value="验证码" onfocus="this.value=''" onblur="if(this.value=='')this.value='验证码'"/><span id="code" title="看不清,换一张">ETF5</span>
					<div id="search_pass_link">
						<a href="">忘记密码?</a>
					</div>
					<input type="submit" value="登录" class="btn" onmouseover="this.style.backgroundColor='#FF8D00'" onmouseout="this.style.backgroundColor='#FC5628'">
					<br>
					<div id="copyright">
						Power By MRchai&copy;CopyRight since 2016
					</div>
				</div>
				</form>
			</div>
		</div>
	</body>
</html>