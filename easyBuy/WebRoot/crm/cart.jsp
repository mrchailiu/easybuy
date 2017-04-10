<%@page import="java.text.DecimalFormat"%>
<%@page import="com.softeem.esaybuy.dto.GoodsImgs"%>
<%@page import="com.softeem.esaybuy.dto.Goods"%>
<%@page import="com.softeem.easybuy.dao.IGoodsDAO"%>
<%@page import="com.softeem.easybuy.dao.impl.GoodsDAO"%>
<%@page import="com.softeem.esaybuy.dto.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.softeem.easybuy.dao.impl.CategoryDAO"%>
<%@page import="com.softeem.easybuy.dao.ICategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="css/index.css">
<!-- 引入jquery框架 -->
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="layer/layer.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/comm.js"></script>
<style>
.none_cart{
	width:1024px;
	height:300px;
	display: none;
	align-items:center;
	justify-content:center;
}
.other a{
	border:1px solid #FFA500;
	padding:8px;
	text-decoration: none;
	margin-left: 5px;
	color:#FFA500;
}
.other a:HOVER {
	background-color: #FFA500;
	color:#ffffff;
}
#tab_cart{
	border-collapse:collapse;
	width:100%;
	border: 1px solid #CCCCCC;
	margin:10px 0;
}
#tab_cart th{
	background-color: #E5E5E5;
	border-bottom: 1px solid #FFA500;
}
#tab_cart td{
	padding:2px;
	font-size: 10pt;
	text-align: center;
}
#tab_cart td img{
	border:1px solid #EEEEEE;
}
#tab_cart tr:HOVER{
	background: #E0E0E0;
}
#cash{
	width:100%;
	height:50px;
	line-height:50px;
	background-color: #E5E5E5;
}
#cash div{
	line-height: 50px;
}
#cash_op{
	float:left;
	width:500px;
	height:50px;
	text-indent: 1cm;
}
#cash_op a{
	color:#000000;
	text-decoration: none;
	font-size: 10pt;
} 
#cash_op a:HOVER{
	color:#ff0000;
	text-decoration: underline;
}
#cash_cale{
	float:left;
	width:374px;
	height:50px;
	text-align: right;
}
#cash span{
	padding:0 10px;
	color:#ff0000;
	font-size:20pt;
}
#cash #a_cash{
	width:150px;
	height:100%;
	background-color:#F73E1C;
	text-decoration:none;
	font-size: 15pt;
	border-radius:2px;
	font-weight: 300;
	color:#ffffff;
	font-family:"黑体"; 
	text-align:center;
	display: inline-block;
}
#cash #a_cash:HOVER {
	background-color: #CF5724;
}
</style>
</head>
<body>
	<!-- 外层框架 -->
	<div class="main">
		<!-- 顶端，登录注册，订单购物车链接 -->
		<div class="top">
			<%@include file="top.jsp" %>
		</div>
		<!-- logo和全文搜索框 -->
		<div class="search">
			<%@include file="query.jsp" %>
		</div>
		<!-- 内容显示部分 -->
		<div class="content">
			<div class="none_cart">
				<img alt="" src="images/empty_cart.png">
				<span>您的购物车还是空的,您可以</span><br>
				<div class="other">
					<%
						Object obj = session.getAttribute("user");
						if(obj == null){
					%>
					<a href="">立即登录</a>
					<%} %>
					<a href="crm/index.jsp">马上去购物</a>
				</div>
			</div>
		</div>
		<!-- 版权部分 -->
		<div class="copy">
			<%@include file="copy.jsp" %>
		</div>
	</div>
</body>
<script>
	//js框架:jquery
	$(function() {
			$.get('cart?flag=read',function(data){
				if(data == 0){
					$('.none_cart').css("display","flex");
				}else{
					var totalPay = 0;
					$(".content").empty();
					var list = eval("("+data+")");
					var tab = "<table id='tab_cart'>"+
								"<tr>"+
								"<th width=10%><input type='checkbox' id='sel_all'>全选</th>"+
								"<th width=40% colspan=2>商品信息</th>"+
								"<th width=15%>单价</th>"+
								"<th width=15%>数量</th>"+
								"<th width=10%>金额(元)</th>"+
								"</tr>";
					for(var i = 0;i<list.length;i++){
						var g = list[i];
						tab += "<tr>";
						tab += "<td><input type='checkbox' name='ck' value='"+g.gid+"'></td>";
						tab += "<td><img src='"+g.img+"' width='80px' height='80px'></td>";
						tab += "<td>"+g.name+"</td>";
						tab += "<td>"+g.price+"</td>";
						tab += "<td>"+g.total+"</td>";
						tab += "<td style='color:#ff0000;font-weight:bold;'>"+g.totalPrice+"</td>";
						tab += "</tr>";
						totalPay += g.totalPrice;
					}
					//截取小数点后两位
					totalPay = totalPay.toFixed(2);
					tab += "</table>";
					$(".content").append($(tab));
					$('img').error(function(){
						$(this).attr("src","images/holder.png");
					});
					//全选
					$("#sel_all").click(function(){
						if($(this).attr("checked") == "checked"){
							$("input[type='checkbox']").attr("checked",true);
						}else{
							$("input[type='checkbox']").attr("checked",false);
						}
					});
					//结算部分
					var cash = "<div id='cash'><div id='_cash'><div id='cash_op'><a href='javascript:void(0)' id='del_cart' >删除选中</a></div><div id='cash_cale'>合计:<span>&yen;"+totalPay+"</span></div></div><a href='javascript:void(0)' id='a_cash'>结算</a><div>";
					$(".content").append($(cash));
					
					//删除购物车数据
					$("#del_cart").click(function(){
						var cks = $("input[name='ck']:checked");
						//判断是否选中商品
						if(cks.length>0){
							layer.confirm('确定从购物车中移除选中项?', {icon: 3, title:'提示'}, function(index){
								var data = "";
								$(cks).each(function(){
									var id = $(this).val();
									data += "ids="+id+"&";
								});
								//获取需要删除的数据
								data = data.substring(0,data.length-1);
								$.post("cart?flag=del",data,function(){
									//重新加载数据
									location.reload();
								})
								//关闭窗口 
								layer.close(index);
							});
						}else{
							layer.alert('请选择需要移除的商品',{icon:2});
						}
					});
					//结算
					$("#a_cash").click(function(){
						alert("cash");
					});
				}
			});
	});
</script>
</html>