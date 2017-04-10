<%@page import="com.softeem.esaybuy.dto.Admin"%>
<%@page import="com.softeem.easybuy.dao.IAdminDAO"%>
<%@page import="com.softeem.easybuy.dao.impl.AdminDAO"%>
<%@page import="com.softeem.easybuy.dbhelper.DBUtils"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//获取登录表单中提交账号和密码
		String name = request.getParameter("uname");
		String pass = request.getParameter("upass");
		//JDBC:java连接数据库
		//1.加载驱动(*.jar)
		IAdminDAO dao = new AdminDAO();
		Admin a = new Admin();
		a.setUsername(name);
		Object obj = dao.findSingleObj(a);
		if(obj != null){
			Admin admin = (Admin)obj;
			if(admin.getPassword().equals(pass)){
				//ok
				//登录成功
				response.sendRedirect("main.jsp");//跳转到主界面
			}else{
				//密码错误
				out.println("<script>alert('密码错误!');history.back()</script>");
			}
		}else{
			//密码错误
			out.println("<script>alert('账号不存在!');history.back()</script>");
		}
	%>
</body>
</html>