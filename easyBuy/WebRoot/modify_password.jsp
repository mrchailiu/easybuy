<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
	<head>
		<title>EasyBuy后台管理-修改密码</title>
		<meta charset="utf-8"/>
		<script src="js/jquery-1.8.3.min.js"></script>
		<link type="text/css" rel="stylesheet" href="css/comm.css"/>
	</head>
	<body>
		<div class="title">系统设置--&gt;&gt;修改密码</div>
		<div class="form_box">
			<form>
				<table>
					<tr>
						<td width="25%" align="right">原始密码:</td>
						<td>
							<input type="password" name="oldpass" required class="txt" placeholder="请输入原始密码"/>
						</td>
					<tr>
					<tr>
						<td align="right" valign="top">新密码:</td>
						<td>
							<input type="password" class="txt" required name="newpass" value="" placeholder="请输入新密码"/>
						</td>
					<tr>
					<tr>
						<td align="right" valign="top">重复密码:</td>
						<td>
							<input type="password" class="txt" required name="repass" value="" placeholder="请输入重复密码"/>
						</td>
					<tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="确认修改" class="btn"/>
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
