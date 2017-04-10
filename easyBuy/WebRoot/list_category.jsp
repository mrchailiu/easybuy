<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
	<head>
		<title>EasyBuy后台管理-分类列表</title>
		<meta charset="gbk"/>
		<link type="text/css" rel="stylesheet" href="css/comm.css"/>
		<style>
		table tr{
			height:30px;
			color:#000000;
		}
		table{
			border-collapse:collapse;
			text-align:center;
		}
		table tr:hover{
			background-color:#96AAC8;
			opacity:0.5;
			color:#ffffff;
			font-weight:bold;
		}
	</style>
	</head>
	<%
		//查询所有分类
		//加载驱动
		Class.forName("com.mysql.jdbc.Driver");
		//获取连接
		Connection conn = DriverManager.getConnection(
				"jdbc:mysql://127.0.0.1:3306/easybuy",
				"root",
				"123456");
		//获取处理命令
		PreparedStatement ps = conn.prepareStatement("select * from eb_category");
		//执行查询
		ResultSet rs= ps.executeQuery();
	%>
	<body>
		<div class="title">分类管理--&gt;&gt;分类列表</div>
		<div class="form_box">
			<form>
				<table>
					<tr>
						<th>编号</th>
						<th>分类</th>
						<th>操作</th>
					</tr>
					<% 
					int index = 1;
					while(rs.next()){ %>
						<tr>
							<td><%=index++ %></td>
							<td><%=rs.getString("cname") %></td>
							<td>
								<a href="javascript:del(<%=rs.getInt("cid")%>)"><img border="0" title="删除" src="images/delete.png"/></a>
								&nbsp;&nbsp;
								<a href=""><img border="0" title="详情" src="images/info.png"/></a>
							</td>
						</tr>
					<% } %>
				</table>
			</form>
		</div>
	</body>
	<script>
		function del(cid){
			if(window.confirm('确认删除')){
				window.location.href="doDelCategory.jsp?cid="+cid;
			}			
		}
	</script>
</html>
