<%@page import="java.util.Collections"%>
<%@page import="com.softeem.esaybuy.dto.PageUtils"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.softeem.esaybuy.dto.GoodsImgs"%>
<%@page import="com.softeem.esaybuy.dto.Goods"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@page import="com.softeem.easybuy.dbhelper.DBUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		int currentPage = 1;//初始当前页
		int	pageSize = 12;//初始每页大小
		int totalPage = 0;//初始总页数
		int totalNum = 0;//初始总记录数
		String sql1 = "select count(*) from eb_goods where total>0";
		String sql2 = "select * from eb_goods where total>0 order by gid desc limit ?,?";
		String cid = request.getParameter("cid");
		String goodsname = request.getParameter("gname");

		PageUtils pu = new PageUtils();
		if(cid != null && !"0".equals(cid)){
			//分类查询
			sql1 = "select count(*) from eb_goods where total > 0 and cid="+cid;
			sql2 = "select * from eb_goods where total > 0 and cid="+cid+" order by gid desc limit ?,? ";
			pu.setCondition("cid="+cid);
		}else if(goodsname != null && !"".equals(goodsname)){
			//商品名模糊检索
			sql1 = "select count(*) from eb_goods where total > 0 and gname like '%"+goodsname+"%'";
			sql2 = "select * from eb_goods where total > 0 and gname like '%"+goodsname+"%' order by gid desc limit ?,? ";
			pu.setCondition("gname like '%"+goodsname+"%'");
		}
		
		String cp = request.getParameter("cp");
		if(cp != null){
			currentPage = Integer.parseInt(cp);
		}
		//防止无线上一页
		if(currentPage < 1){
			currentPage = 1;
		}
		
		//声明集合用于临时存储查询到的所有商品信息
		List<Goods> goods = new ArrayList<Goods>();	
		//获取数据库连接
		Connection conn = DBUtils.getConn();
		PreparedStatement ps = conn.prepareStatement(sql1);
		ResultSet rs = ps.executeQuery();
		if(rs.next()){
			totalNum = rs.getInt(1);
		}
		totalPage = totalNum % pageSize == 0?totalNum/pageSize:totalNum/pageSize+1;
		//防止无限下一页
		if(currentPage > totalPage){
			currentPage = totalPage;
		}
		ps = conn.prepareStatement(sql2);
		ps.setInt(1, (currentPage-1)*pageSize);
		ps.setInt(2, pageSize);
		rs = ps.executeQuery();
		Goods g = null;
		while(rs.next()){
			g = new Goods();
			int gid = rs.getInt("gid");				//商品id
			String gname = rs.getString("gname");	//商品名
			double price = rs.getDouble("price");	//单价
			double offset = rs.getDouble("offset");	//折扣
			int total = rs.getInt("total");			//库存
			g.setGid(gid);
			g.setGname(gname);
			g.setOffset(offset);
			g.setPrice(price);
			g.setTotal(total);
			//根据商品id查询该商品的下的所有图片
			List<GoodsImgs> imgs = new ArrayList<GoodsImgs>();
			ps = conn.prepareStatement("select * from eb_goodsimgs where gid="+gid);
			ResultSet rs2 = ps.executeQuery();
			GoodsImgs img = null;
			while(rs2.next()){
				img = new GoodsImgs();
				int imgid = rs2.getInt("imgid");
				String name = rs2.getString("imgName");
				String path = rs2.getString("imgPath");
				img.setImgid(imgid);
				img.setImgName(name);
				img.setImgPath(path);
				//将图片添加到集合
				imgs.add(img);
			}
			if(imgs.size()<1){
				img = new GoodsImgs();
				img.setImgPath("/images/holder.png");
			}
			//将所有图片的集合作为商品对象的属性添加上商品中
			g.setGoodsImgs(imgs);
			//将商品对象加入集合
			goods.add(g);
		}
		
		pu.setCurrentPage(currentPage);
		pu.setTotalNum(totalNum);
		pu.setTotalPage(totalPage);
		pu.setPageSize(pageSize);
		pu.setData(goods);
		PrintWriter writer = response.getWriter();
		writer.print(pu.toString());
		writer.flush();
	%>
