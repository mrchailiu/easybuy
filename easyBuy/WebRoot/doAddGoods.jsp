<%@page import="java.sql.*"%>
<%@page import="com.softeem.easybuy.dbhelper.DBUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.softeem.jspsmart.upload.SmartUpload"%>
<%@page import="com.softeem.jspsmart.upload.Request"%>
<%@page import="com.softeem.jspsmart.upload.Files"%>
<%@page import="com.softeem.jspsmart.upload.File"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//商品上架(图片上传)
	//创建SmartUpload对象
	SmartUpload su = new SmartUpload();
	//初始化
	su.initialize(pageContext);
	//设置允许上传的文件类型
	su.setAllowedFilesList("jpg,png,jpeg,bmp,gif");
	//设置允许上传单个文件的大小
	su.setMaxFileSize(1024*1024*10);//10M
	//设置允许上传的总文件大小
	su.setTotalMaxFileSize(1024*1024*100);//100M
	//上传
	su.upload();
	//在文件存储之前先将商品数据加入数据库
	Request req = su.getRequest();
	//1.获取商品信息(从页面表单获取)
	String gname = req.getParameter("gname");//获取商品名
	String cid = req.getParameter("cid");//获取商品分类id
	String offset = req.getParameter("offset");//获取折扣
	String price = req.getParameter("price");//获取商品单价
	String num = req.getParameter("num");//获取商品库存
	Connection conn = DBUtils.getConn();//获取数据库连接
	String sql = "insert into eb_goods(gname,price,offset,total,cid,publishTime) values(?,?,?,?,?,?)";
	PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);//获取与处理命令，同时返回加入数据库表中记录的主键
	ps.setString(1,gname);//设置商品名
	ps.setDouble(2, Double.parseDouble(price));//设置单价
	ps.setDouble(3, Integer.parseInt(offset)/100.0);//设置折扣
	ps.setInt(4,Integer.parseInt(num));//设置库存
	ps.setInt(5,Integer.parseInt(cid));//设置分类id
	ps.setDate(6,new Date(System.currentTimeMillis()));//设置商品的上架时间
	int i = ps.executeUpdate();//执行添加
	int gid = 0;//初始被添加的商品id
	ResultSet rs = ps.getGeneratedKeys();
	if(i > 0 && rs.next()){
		gid = rs.getInt(1);//获取被添加的商品在数据库中生成的id
		System.out.println("添加成功,生成的商品id---->"+gid);
	}
	//2.将图片存储到服务器
	String server = request.getSession().getServletContext().getRealPath("/goodsImgs");//获取服务器的路径
	String path = server+"/"+gid;//设置配图存储的目录
	java.io.File baseDir = new java.io.File(path);//根据给定的目录构建一个File对象
	if(baseDir.mkdirs()){
		System.out.println("目录已生成---->"+path);
	}
	su.save(path);//将文件存储到指定目录
	//3.将图片数据加入数据表
	Files files = su.getFiles();//获取上传的所有文件
	for(int n = 0;n<files.getCount();n++){	//遍历所有的文件对象
		File file = files.getFile(n);
		if(file.getSize() > 0){
				String fname = file.getFileName();//获取文件名 1
				String fpath = "goodsImgs/" + gid + "/" + fname;//获取文件绝对路径 2
				sql = "insert into eb_goodsImgs(imgName,imgPath,gid) values(?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, fname);
				ps.setString(2, fpath);
				ps.setInt(3, gid);
				ps.executeUpdate();//执行图片添加
		}
	}
	//结束
	out.println("<script>alert('上架成功!');window.location.href='list_goods.jsp';</script>");
%>
</body>
</html>