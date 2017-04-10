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
	//删除指定id的分类
	String id = request.getParameter("cid");
	int cid = Integer.parseInt(id);//将字符串类型id转换成整数类型
	//加载驱动
	Class.forName("com.mysql.jdbc.Driver");
	//获取连接
	Connection conn = DriverManager.getConnection(
			"jdbc:mysql://127.0.0.1:3306/easybuy",
			"root",
			"123456");
	//获取处理命令
	PreparedStatement ps = conn.prepareStatement("select * from eb_goods where cid=?");
	ps.setInt(1,cid);
	//执行
	ResultSet rs = ps.executeQuery();
	//处理结果
	if(rs.next()){
		//说明当前分类下包含商品,所以该分类不允许删除
		out.println("<script>alert('该类别下还有商品,请先移除商品信息!');history.back()</script>");
	}else{
		//删除分类
		ps = conn.prepareStatement("delete from eb_category where cid=?");
		ps.setInt(1, cid);
		int i = ps.executeUpdate();
		if(i > 0 ){
			out.println("<script>alert('删除成功!');window.location.href='list_category.jsp';</script>");
		}
	}
	//关闭资源
	rs.close();
	ps.close();
	conn.close();
%>
</body>
</html>