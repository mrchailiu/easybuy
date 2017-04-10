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
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>易购商城【软帝集团】</title>
		<link type="text/css" rel="stylesheet" href="css/index.css">
		<!-- 引入jquery框架 -->
		<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="js/comm.js"></script>
		<style>
		body{
			font-family: 微软雅黑;
			
		}
		*{
			outline: none;
		}
.div_item {
	width: 252px;
	height: 310px;
	min-height: 280px;
	background-color: #ffffff;
	border: 1px solid #ffffff;
	float: left;
	padding: 1px;
	margin-top: 5px;
	color: #000000;
}

.div_item:HOVER {
	border: 1px solid #ff0000;
}

table td,table th {
	text-align: center;
	vertical-align: middle;
	padding: 0;
}

.m {
	color: #ff0000;
	font-size: 15pt;
	font-family: "黑体";
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
			<!-- 分类菜单部分 -->
			<div class="menu">
				<%
				//声明数据访问对象
				ICategoryDAO cdao = new CategoryDAO();
				//查询所有分类
				List<Category> list = cdao.findAll();
				out.print("<a href='javascript:void(0)' id='0'>全部分类</a>");
				//限制菜单最多显示15个分类
				for(int i = 0;i<15;i++){
					if(list.get(i) != null){
						out.print("<a href='javascript:void(0)' id="+list.get(i).getCid()+">"+list.get(i).getCname()+"</a>");
					}
				}
				out.print("<a href='#' id='more'>更多...</a>");
			%>
			</div>
			<!-- 更多分类显示部分 -->
			<div class="more_block"></div>
			<!-- 内容显示部分 -->
			<div class="content"></div>
			<!-- 分页链接显示部分 -->
			<div class="page_link"></div>
			<!-- 版权部分 -->
			<div class="copy">
				<%@include file="copy.jsp"%>
			</div>
		</div>
	</body>
	<script>
	//js框架:jquery
	$(function() {
		
		var url = "crm/doQueryAll.jsp";
		req(url);
		function req(url){
			$.get(url, function(data) {
				//清空内容
				$(".content").empty();
				//将json字符串转换为js对象
				var pu = eval("(" + data + ")");
				var goods = pu.data;
				if(goods.length > 0){
					for (var i = 0; i < goods.length; i++) {
						var imgPath = "images/holder.png";
						
						if(goods[i].goodsImgs.length > 0){
							 imgPath = goods[i].goodsImgs[0].imgPath;
						}
						
						var name = goods[i].gname;
						var price = (goods[i].price * goods[i].offset).toFixed(2);
						var total = goods[i].total;
						//根据商品信息生成div
						var goods_item = $genDiv(goods[i].gid);
						var tab = $genTab(imgPath,name,price,total);
						$(goods_item).append(tab);
						$(".content").append(goods_item);
						
						$("img").error(function(){
							$(this).attr("src","images/holder.png")
						});
					}
					$genPageLink(pu);
				}else{
					//清空内容
					$(".page_link").empty();
					var none = $("<div>无匹配商品!</div>").css({
						width:"100%",
						height:"300px",
						textAlign:"center",
						lineHeight:"300px",
						color:"red",
					});
					$(".content").append(none);
				}
			});
			
		}
		
		//生成分页链接
		function $genPageLink(pu){
			//清空内容
			$(".page_link").empty();
			var links = "";
			var totalList = 7;//限制最多显示7页
			var cp = pu.currentPage;//当前页
			var total = pu.totalPage;//总页数
			var condition = pu.condition;//查询条件
			if(condition==undefined){
				condition = "";
			}else{
				condition = "&"+condition;
			}
			console.info(condition);
			$(".page_link").append($("<span>&lt;上一页</span>").click(function(){req(url+"?cp="+(cp-1)+condition);}).after("&nbsp;"));
			var start = 1;
			var end = totalList;
			//限制总页数显示
			if(cp >= totalList){
				start = cp - 3;
				end = cp + 3;
				if(end >= total){
					end = total;
				}
				if(end > total-3){
					start = total-6;
				}
			}else{
				start = 1;
				if(cp == 6){
					start = cp - 3;
					end = cp + 3
				}
				if(end >= total){
					end = total;
				}
			}
			//页码显示
			for(var i = start;i <= end;i++){
				if(cp == i){
					links = "<strong>"+i+"</strong>&nbsp;";
				}else{
					links = "<span>"+i+"</span>&nbsp;";
				}
				$(".page_link").append(links);
			}
			$(".page_link").append($("<span>下一页&gt;</span>").click(function(){req(url+"?cp="+(cp+1)+condition);}));
			//排除第一个和最后一个元素设置事件
			$(".page_link span:not(:first,:last)").click(function(){
				req(url+"?cp="+$(this).text()+condition);
			});
		}
		
		//生成div
		function $genDiv(gid){
			var goods_item = $("<a href='crm/details.jsp?gid="+gid+"'><div></div></a>");
			$(goods_item).addClass("div_item");
			return $(goods_item);
		}
		// goodsImgs/120/1448192755033.jpg
		//生成表格
		function $genTab(img, gname, price, storage) {
			console.info(img);
			var tab_xhtml = "<table>"
					+ "<tr><td colspan=2><img src='"+img+"' style='margin:0' width='250px' height='220px'></td></tr>"
					+ "<tr><th colspan=2>" + gname + "</th></tr>"
					+ "<tr><td class='m'>&yen;" + price + "</td><td>库存:" + storage
					+ "</td></tr>" + "</table>";
			tab_xhtml = $(tab_xhtml).css({
				width : "254px",
				height : "280px"
			});
			return $(tab_xhtml);
		}
		//所有div显示鼠标样式为手指状
		$('div').css('cursor','pointer');
		
		//生成剩余分类
/*		$("#more").click(function(){
			$.get("category?ajax=on",function(data){
				var blocks = eval("("+data+")");
				var xhtml = "";
				$(".more_block").empty();
				for(var i = 15;i<blocks.length;i++){
					xhtml+="<a href='javascript:void(0)' id="+blocks[i].cid+">"+blocks[i].cname+"</a>";
				}
				$(".more_block").append($(xhtml));
				$(".more_block").slideDown();
				//分类标签
				$(".more_block a").click(function(){
					var cid = $(this).attr("id");
					if(cid != "more"){
						req(url+"?cid="+cid);
					}
					$(this).parent().slideUp();
				});
			});
		});*/
		//移入"更多"链接时效果
		$("#more").hover(function(){
			$.get("category?ajax=on",function(data){
					var blocks = eval("("+data+")");
					var xhtml = "";
					$(".more_block").empty();
					for(var i = 15;i<blocks.length;i++){
						xhtml+="<a href='javascript:void(0)' id="+blocks[i].cid+">"+blocks[i].cname+"</a>";
					}
					$(".more_block").append($(xhtml));
					$(".more_block").slideDown();
					//更多分类链接被点击切换数据
					$(".more_block a").click(function(){
						var cid = $(this).attr("id");
						if(cid != "more"){
							req(url+"?cid="+cid);
						}
					});
				});
		},function(){});
		$(".more_block").hover(function(){},function(){
			$(this).slideUp();	
		});
		
		//分类标签
		$(".menu a").click(function(){
			var cid = $(this).attr("id");
			if(cid != "more"){
				req(url+"?cid="+cid);
			}
		});
		
		//商品搜索
		$("#search_btn").click(function(){
			var key = $.trim($("#search").val());
			req(url+"?gname="+key);
		});
		
	});
</script>
</html>