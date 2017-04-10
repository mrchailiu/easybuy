<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
	<head>
		<title>EasyBuy后台管理-分类添加</title>
		<meta charset="utf-8"/>
		<script src="js/jquery-1.8.3.min.js"></script>
		<link type="text/css" rel="stylesheet" href="css/comm.css"/>
	</head>
	<body>
		<div class="title">分类管理--&gt;&gt;分类添加</div>
		<div class="form_box">
			<form action="doAddCategory.jsp">
				<table>
					<tr>
						<td width="25%" align="right">类别名:</td>
						<td>
							<input type="text" name="cname" required class="txt" placeholder="请输入分类名称"/>
						</td>
					<tr>
					<tr>
						<td align="right" valign="top">描述:</td>
						<td>
							<textarea class="txt" name="cdesc" placeholder="请输入分类描述" style="height:180px;"></textarea>
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
</html>
