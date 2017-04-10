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
<title>EasyBuy商城后台管理</title>
<meta charset="utf-8">
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<link type="text/css" rel="stylesheet" href="css/main.css" />
</head>
<body leftmargin="0" topmargin="0">
	<div id="main">
		<div id="top">
			<a href="main.jsp"><img border="0" src="images/logo.png"
				style="position: absolute; top: 17px; left: 5px" /></a>
			<div id="title">EasyBuy商城后台管理</div>
		</div>
		<div id="left">
			<ul class="menu_main">
				<li class="menu_first"><a>商品管理</a>
					<ul>
						<li><a href='category' target="right">商品上架</a></li>
						<li><a href='list_goods.jsp' target="right">商品列表</a></li>
					</ul></li>
				<li class="menu_first"><a>分类管理</a>
					<ul>
						<li><a href='add_category.jsp' target="right">分类添加</a></li>
						<li><a href='list_category.jsp' target="right">分类列表</a></li>
					</ul></li>
				<li class="menu_first"><a>订单管理</a>
					<ul>
						<li><a href="" target="right">订单列表</a></li>
					</ul></li>
				<li class="menu_first"><a>客户管理</a>
					<ul>
						<li><a href="" target="right">客户列表</a></li>
						<li><a href="" target="right">权限设置</a></li>
					</ul></li>
				<li class="menu_first"><a>系统设置</a>
					<ul>
						<li><a href="" target="right">个人信息</a></li>
						<li><a href="modify_password.jsp" target="right">修改密码</a></li>
						<li><a href="add_admin.jsp" target="right">新增管理员</a></li>
						<li><a href="" target="right">管理员列表</a></li>
						<li><a href="" target="right">系统退出</a></li>
					</ul></li>
			</ul>
		</div>
		<div id="right">
			<iframe src="welcome.jsp" name="right" width="100%" height="100%"
				frameborder="0"></iframe>
		</div>
	</div>
</body>
<script>
		$(function(){
			$(".menu_first > a").click(function(){
				var list = $(this).next("ul");
				list.slideToggle("fast");
			});
			
			$(".menu_first > ul > li").hover(
			function(){
				$(this).css('display','block');
				$(this).css('background','#F0F0F0');
				$(this).children('a').css('color','#000000');
			},function(){
				$(this).css('display','block');
				$(this).css('background-color','#808080');
				$(this).children('a').css('color','#ffffff');
			});
			$('.menu_first  li a').click(function(){
				if($(this).attr('href') == '' || $(this).attr('href')==null){
					alert('攻城狮正在东莞相亲,成功后功能将上线!!!');
					return false;
				}
			});
		});
	</script>
</html>
