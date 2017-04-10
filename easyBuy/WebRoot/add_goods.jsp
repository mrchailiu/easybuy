<%@page import="com.softeem.esaybuy.dto.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!doctype html>
<html>
	<head>
		<title>EasyBuy后台管理-商品添加</title>
		<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
		<link type="text/css" rel="stylesheet" href="css/comm.css"/>
		<style>
			.fbtn{
				width:120px;
				height:30px;
			}
			.fileImg{
				height:30px;
				width:50%;
			}
		</style>
	</head>
	<body>
		<div class="title">商品管理--&gt;&gt;商品上架</div>
		<div class="form_box">
			<form action="doAddGoods.jsp" method="post" enctype="multipart/form-data">
				<table>
					<tr>
						<td width="25%" align="right">名称:</td>
						<td>
							<input type="text" name="gname" class="txt" required placeholder="请输入商品名称"/>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">分类:</td>
						<td>
							<select class="txt" name="cid">
								<%
									//获取后台提交过来的集合数据
									List<Category> list = (List<Category>)request.getAttribute("c");
									for(Category ca:list){
								%>
									<option value="<%=ca.getCid()%>"><%=ca.getCname() %></option>
									<%} %>
							</select>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">单价:</td>
						<td>
							<input type="text" name="price" required pattern="^[+]{0,1}(\d+)$|^[+]{0,1}(\d+\.\d+)$" class="txt" placeholder="请输入商品单价"/>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">折扣:</td>
						<td>
							<input type="range" id="range" name="offset" value="100" class="txt" min="0" max="100"/><span id="showOffset">100%</span>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">库存:</td>
						<td>
							<input type="number" name="num" value="1" required  class="txt" min="1" placeholder="请输入商品库存量"/>
						</td>
					</tr>
					<tr>
						<td align="right" valign="top">图片:</td>
						<td>
							<input type="file" name="img" class="fileImg"/><input type="button" class='fbtn' id="addBtn" value="添加更多图片">
							<div id="more"></div>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="添加" class="btn"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
	<script>
		$(function(){
			$("input[type='range']").change(function(){
				var v = $(this).val();
				$('#showOffset').text(v+"%");
			});
			
			$("#addBtn").click(function(){
				var filePlugin = $("<input type='file' name='img' class='fileImg'/>");
				var delBtn = $("<input type='button' value='移除' class='fbtn'/>");
				var br = $("<br/>");
				var bs = $("#more br");
				if(bs.length < 9){			
					$("#more").append(filePlugin);
					$("#more").append(delBtn);
					$("#more").append(br);
					delBtn.click(function(){
						//移除节点
						var inp = $("#more :input");
						bs = $("#more br");
						$(inp[inp.length-1]).remove();
						$(inp[inp.length-2]).remove();
						$(bs[bs.length-1]).remove();
					});
				}else{
					alert("最多10张，已达到上限");
				}
			});
		});
	</script>
</html>
