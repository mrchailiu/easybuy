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
<!-- 引入样式 -->
<link type="text/css" rel="stylesheet" href="css/index.css">
<!-- 引入jquery框架 -->
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/comm.js"></script>
<style>
.gimgs {
	width: 380px;
	height: 380px;
	float: left;
}

.gdetails {
	height: 380px;
	width: 640px;
	padding-top: 20px;
	margin-left: 380px;
}

.buybox {
	width: 40px;
	height: 50%;
	padding: 3px;
	font-size: 15pt;
	color: #808080;
}

.name, .price, .total, .buynum {
	width: 100%;
	min-height: 50px;
	text-indent: 1cm;
	line-height: 50px;
}

.name {
	text-indent: 0;
	font-size: 20pt;
}

.price {
	background-color: #FFF2E8;
	font-size: 18pt;
	color: #ff0000;
}

.total {
	font-size: 15pt;
}

.btngroup {
	padding: 10px;
}

.btn_buy, .btn_cart {
	padding: 10px 25px;
	border: 0;
	background-color: #FFA500;
	color: #ffffff;
	font-size: 12pt;
	font-weight: bold;
}

.btn_cart {
	background: url('images/cart.png') 7px 11px no-repeat #FFA500;
}

.btn_cart:HOVER {
	background-color: #FF8E00;
}

.btn_buy:HOVER {
	background-color: #FF8E00;
}

.label {
	font-size: 12pt;
	color: #000000;
	margin-right: 20px;
}

.img_item {
	width: 50px;
	height: 50px;
	border: 1px solid #808080;
}

.img_item:HOVER {
	border-color: #ff0000;
}

.dialog {
	position: absolute;
	z-index: 1003;
	width: 320px;
	height: 180px;
	line-height:180px;
	background-color: #ffffff;
	border:2px solid #FF8E00;
	display: none;
	align-items:center;
	justify-content:center;
}
</style>
</head>
<body>
	<!-- 外层框架 -->
	<div class="main">
		<!-- 顶端，登录注册，订单购物车链接 -->
		<div class="top">
			<%@include file="top.jsp"%>
		</div>
		<!-- logo和全文搜索框 -->
		<div class="search">
			<%@include file="query.jsp"%>
		</div>
		<!-- 内容显示部分 -->
		<div class="content">
			<%
				String gid = request.getParameter("gid");
					IGoodsDAO gdao = new GoodsDAO();
					Goods goods = (Goods)gdao.findById(gid);
					List<GoodsImgs> imgs = goods.getGoodsImgs();
					String p = "images/holder.png";
					if(imgs.size()>0){
						p = imgs.get(0).getImgPath();
					}
					
					double price = goods.getPrice();
					double offset = goods.getOffset();
					if(offset < 1){
						price = price*offset;
					}
					DecimalFormat fmt = new DecimalFormat("##.##");
			%>
			<input type="hidden" value="<%=goods.getTotal()%>" id="t" />
			<div class="gimgs">
				<img src="<%=p%>" width="300px" height="300px" id="main_img"
					style="padding: 5px" />
				<table id="imgList">
					<tr>
						<%
							for(int i = 0;i<imgs.size();i++){
						%>
						<td class="img_item"><img src="<%=imgs.get(i).getImgPath()%>"
							width="100%" height="100%" /></td>
						<%
							}
						%>
					</tr>
				</table>
			</div>
			<div class="gdetails">
				<form id="goods_details">
					<input type="hidden" id="gid" name="gid" value="<%=goods.getGid()%>" />
					<input type="hidden" name="name" value="<%=goods.getGname()%>" />
					<input type="hidden" name="price" value="<%=fmt.format(price)%>" />
					<input type="hidden" name="cname" value="<%=goods.getCategory().getCname()%>" /> 
					<input type="hidden" name="img" value="<%=p%>">
					<input type="hidden" name="flag" value="add">
					<div class="name"><%=goods.getGname()%></div>
					<div class="price">
						<span class="label">价格:</span>￥<%=fmt.format(price)%>
						<%
							if(goods.getOffset() < 1.0){
						%>
						<span style="font-size: 13pt; color: #000000"><del>
								原价:<%=goods.getPrice()%></del></span>
						<%
							}
						%>
					</div>
					<div class="total">
						<span class="label">库存:</span><%=goods.getTotal()%></div>
					<div class="buynum">
						<span class="label">购买:</span> <a href="" id="m"><img
							src="images/minus.png" /></a>&nbsp;<input type="text" name="buy"
							readonly class="buybox" value="1">&nbsp;<a href="" id="p"><img
							src="images/plus.png" /></a>
					</div>
					<div class="btngroup">
						<input type="button" value="立即购买" class="btn_buy" /> <input
							type="button" value="加入购物车" class="btn_cart" />
					</div>
				</form>
			</div>
		</div>
		<div class="dialog">
			<img src="images/empty_cart.png">已成功加入购物车...
		</div>
		<!-- 版权部分 -->
		<div class="copy">
			<%@include file="copy.jsp"%>
		</div>
	</div>
</body>
<script>
	//js框架:jquery
	$(function() {

		//所有div显示鼠标样式为手指状
		$('div,a,input[type=button]').css('cursor', 'pointer');
		$('img').css('border', '0px');
		$('img').error(function(){
			$(this).attr("src","images/holder.png");
			$('table').remove("#imgList");
		});
		//购买数改变
		$("#m").click(function() {
			var v = $(".buybox").val();
			v--;
			if (v < 1) {
				v = 1;
			}
			$(".buybox").val(v);
		});
		$("#p").click(function() {
			var v = $(".buybox").val();
			var t = $("#t").val();
			v++;
			if (v > t) {
				v = t;
			}
			$(".buybox").val(v);
		});
		//显示图片切换
		$('.img_item').hover(function() {
			$("#main_img").attr("src", ($(this).children("img").attr("src")));
		});

		//加入购物车
		$('.btn_cart').click(function() {
		/*	var data = $("#goods_details").serializeArray();
			var json = "{";
			$.each(data, function(i, obj) {
				json += "'" + obj.name + "':'" + obj.value + "',";
			});
			json = json.substring(0, json.length - 1) + "}";
			//取出所有数据集合
			var list = $.cookie('list');
			list = list == undefined?"[]":list;
			list = eval('('+list+')');//json字符串转换为对象
			list.push(json);//向数组中添加新数据
			//存储到cookie（id->data）有效期:7天
			//JSON.stringify(list)将对象转换为json字符串
			$.cookie("list", JSON.stringify(list), {
				expires : 7
			});*/
			var data = $("#goods_details").serialize();
			$.post('cart',data,function(resp){
				if(resp == 1){
					//显示对话框				
					genDialog($(".dialog"));
				}
			});
		});

		 function genDialog(divName){   
		        var top = ($(window).height() - $(divName).height())/2;   
		        var left = ($(window).width() - $(divName).width())/2;   
		        var scrollTop = $(document).scrollTop();   
		        var scrollLeft = $(document).scrollLeft();   
		        $(divName).css({ 
		        	position : 'absolute', 
		        	'top' : top + scrollTop, 
		        	left : left + scrollLeft,
		        	display:'flex'
		        }).show(); 
		        setTimeout(function(){
		        	$(divName).css("display","none");
		        },2000);
		}
		 
	});
</script>
</html>