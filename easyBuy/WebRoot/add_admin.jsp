<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
	<head>
		<title>EasyBuy后台管理-管理员添加</title>
		<meta charset="utf-8"/>
		<script src="js/jquery-1.8.3.min.js"></script>
		<link type="text/css" rel="stylesheet" href="css/comm.css"/>
	</head>
	<body>
		<div class="title">系统设置--&gt;&gt;新增管理员</div>
		<div class="form_box">
			<form>
				<table>
					<tr>
						<td width="25%" align="right">账号:</td>
						<td>
							<input type="text" name="name" required class="txt" placeholder="请输入分类名称"/>
						</td>
					<tr>
					<tr>
						<td align="right" valign="top">密码:</td>
						<td>
							<input type="password" class="txt" name="password" value="123456" placeholder="请输入密码"/>
						</td>
					<tr>
					<tr>
						<td align="right" valign="top">确认密码:</td>
						<td>
							<input type="password" class="txt" name="repassword" value="123456" placeholder="请输入重复密码"/>
						</td>
					<tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="添加" class="btn"/>
						</td>
					<tr>
				</table>
			</form>
		</div>
	</body>
	<script>
		$(function(){
			
		});
	</script>
</html>
