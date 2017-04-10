<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@page import="com.softeem.easybuy.dbhelper.DBUtils"%>
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
		<title>EasyBuy后台管理-商品列表</title>
		<meta charset="gbk"/>
		<link type="text/css" rel="stylesheet" href="css/comm.css"/>
		<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="layer/layer.js"></script>
		<script type="text/javascript" src="js/comm.js"></script>
		<style>
		table tr{
			height:30px;
			color:#000000;
		}	
		table tr:hover{
			background-color:#96AAC8;
			color:#ffffff;
			font-weight:bold;
		}
		table{
			text-align:center;
			border-collapse:collapse;
		}
		table tr th a{
			color:#ffffff;
			text-decoration: none;/*去除连接下划线*/
		}
		table tr th a:HOVER{
			color:#FF0000;
			text-decoration: underline;/*显示下划线*/
		}
	</style>
	</head>
	<body>
		<div class="title">商品管理--&gt;&gt;商品列表</div>
		<div class="form_box">
			<form>
				<table>
					<tr>
						<th>编号</th>
						<th>名称</th>
						<th>单价</th>
						<th>分类</th>
						<th>库存</th>
						<th>折扣</th>
						<th>操作</th>
					</tr>
					<%
						int currentPage = 1;//初始当前为第一页
						int pageSize = 10;//初始每页大小10
						int totalPage = 0;//初始化总页数为0
						int totalNum = 0;//初始化总记录数为0
						//获取当前页
						String cp = request.getParameter("currentPage");
						if(cp != null){
							currentPage = Integer.parseInt(cp);//将字符串类型转换为整型
						}
						//防止无限上一页
						if(currentPage < 1){
							currentPage = 1;
						}
						Connection conn = DBUtils.getConn();//获取数据库连接
						//查询总记录数
						String sql = "select count(*) from eb_goods";
						PreparedStatement ps = conn.prepareStatement(sql);
						ResultSet rs = ps.executeQuery();
						if(rs.next()){
							totalNum = rs.getInt(1);//获取总记录数
						}
						//获取总页数
						if(totalNum % pageSize == 0){
							totalPage = totalNum / pageSize;//能除尽
						}else{
							totalPage = totalNum / pageSize + 1;//不能除尽
						}
						//防止当前页无限下一页
						if(currentPage > totalPage){
							currentPage = totalPage;
						}
						
						sql = "select * from eb_goods order by gid desc limit ?,?";
						ps = conn.prepareStatement(sql);//获取预处理命令
						ps.setInt(1, (currentPage-1)*pageSize);
						ps.setInt(2, pageSize);
						rs = ps.executeQuery();//执行查询获取结果集
						
						
						DecimalFormat format = new DecimalFormat("##.##");//用于数字格式化的工具对象
						while(rs.next()){
							int cid = rs.getInt("cid");
							sql = "select cname from eb_category where cid=?";
							ps = conn.prepareStatement(sql);
							ps.setInt(1, cid);
							ResultSet rs2 = ps.executeQuery();
							String cname = "";
							if(rs2.next()){
								cname = rs2.getString("cname");//查询出指定id的分类名
							}
					%>
					<tr>
						<td><%=rs.getInt("gid") %></td>
						<td width="50%"><%=rs.getString("gname") %></td>
						<td><%="&yen;"+rs.getDouble("price") %></td>
						<td><%=cname %></td>
						<td><%=rs.getInt("total")>0?rs.getInt("total"):"<font color='red'>库存不足</font>" %></td>
						<td><%=format.format(rs.getDouble("offset")*10) %></td>
						<td>
							<a href="goods?flag=edit&gid=<%=rs.getInt("gid")%>"><img border="0" title="编辑" src="images/update.png"/></a>
							&nbsp;&nbsp;
							<a href="goods?flag=info&gid=<%=rs.getInt("gid")%>"><img border="0" title="详情" src="images/info.png"/></a>
							&nbsp;&nbsp;
							<a href="" class="goods_del" cl_tip="<%=rs.getInt("gid")%>"><img border="0" title="删除" src="images/delete.png"/></a>
						</td>
					</tr>
					<%} %>
					<tr>
						<th colspan="8">
							<span>共<%=totalNum%>条记录</span>
							<a href="list_goods.jsp?currentPage=1">首页</a>
							<a href="list_goods.jsp?currentPage=<%=currentPage-1%>">上一页</a>
								<%=currentPage %>/<%=totalPage%>
							<a href="list_goods.jsp?currentPage=<%=currentPage+1%>">下一页</a>
							<a href="list_goods.jsp?currentPage=<%=totalPage%>">尾页</a>
							<span>跳转到<select id="goPage">
										<%for(int i = 1;i<=totalPage;i++){
											if(currentPage == i){
												%>
												<option value="<%=i%>" selected="selected"><%=i %></option>
												<% 
											}else{
											%>
											<option value="<%=i%>"><%=i %></option>
										<%
											}
										}
										%>
									</select>页</span>
						</th>
					</tr>
				</table>
			</form>
		</div>
	</body>
	<script>
	$(function(){
		$("#goPage").change(function(){
			window.location.href="list_goods.jsp?currentPage="+$(this).val();
		});
		$(".goods_del").click(function(){
			var id = $(this).attr("cl_tip");
			layer.confirm('确认删除该项商品?',{icon:3,title:'警告'},function(index){
				location.href="goods?flag=del&gid="+id;
				layer.close(index);
			});
		});
	});
	</script>
</html>
