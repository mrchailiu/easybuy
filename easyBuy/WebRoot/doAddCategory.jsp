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
	//JSP:九大内置对象(request,response,out,config,page,session,exection..)
	
	//获取表单中提交的分类名称和描述
	String cname = request.getParameter("cname");
	String desc = request.getParameter("cdesc");
	
	//1.加载驱动
	Class.forName("com.mysql.jdbc.Driver");
	//2.获取连接
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://127.0.0.1:3306/easyBuy",
			"root",
			"123456");
	//3.获取处理命令   insert into eb_category(cname,summary) values(?,?)
	PreparedStatement ps = conn.prepareStatement("insert into eb_category(cname,summary) values(?,?)");
	ps.setString(1, cname);
	ps.setString(2, desc);
	//4.执行			executeUpdate()
	int i = ps.executeUpdate();//返回值:操作影响 的数据行数
	//5.处理结果 
	if(i > 0){
		//添加成功
		out.println("<script>alert('添加成功');window.location.href='list_category.jsp';</script>");
	}
	//6.关闭资源
	ps.close();
	conn.close();
%>
</body>
</html>