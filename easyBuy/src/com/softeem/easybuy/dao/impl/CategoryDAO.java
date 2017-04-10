package com.softeem.easybuy.dao.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.softeem.easybuy.dao.ICategoryDAO;
import com.softeem.easybuy.dao.IGoodsImgsDAO;
import com.softeem.easybuy.dbhelper.CallBack;
import com.softeem.easybuy.dbhelper.DAOHelper;
import com.softeem.easybuy.dbhelper.DBUtils;
import com.softeem.esaybuy.dto.Category;
import com.softeem.esaybuy.dto.Goods;
import com.softeem.esaybuy.dto.GoodsImgs;

public class CategoryDAO implements ICategoryDAO {

	private Connection conn;

	public CategoryDAO() {
		conn = DBUtils.getConn();
	}
	//添加分类
	public boolean save(Object obj) {
		String sql = "insert into eb_category(cname,summary) values(?,?)";
		Category c = (Category)obj;
		return DAOHelper.executeUpdate(conn, sql, c.getCname(),c.getSummary());
	}

	public boolean update(Object obj) {
		// TODO Auto-generated method stub
		return false;
	}
	//删除分类（物理删除） 输入对象id
	public boolean delete(Object id) {
		String sql = "delete from eb_category where cid=?";
		return DAOHelper.executeUpdate(conn, sql, id);
	}
	//根据id查询分类
	public Object findById(Object id) {
		String sql = "select cid,cname,summary from eb_category where cid=?";
		return DAOHelper.executeQuery(sql, new CallBack() {
			public List getResults(ResultSet rs) {
				List list = new ArrayList();
				try {
					if(rs.next()){
						Category c = new Category();
						c.setCid(rs.getInt("cid"));
						c.setCname(rs.getString("cname"));
						c.setSummary(rs.getString("summary"));
						list.add(c);
					}else{
						list.add(null);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return list;
			}
		}, id).get(0);
	}

	//查询所有分类
	public List findAll() {
		String sql = "select cid,cname,summary from eb_category";
		return DAOHelper.executeQuery(sql, new CallBack() {
			public List getResults(ResultSet rs) {
				List list = new ArrayList();
				Category c = null;
				try {
					while(rs.next()){
						c = new Category();
						c.setCid(rs.getInt("cid"));
						c.setCname(rs.getString("cname"));
						c.setSummary(rs.getString("summary"));
						list.add(c);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return list;
			}
		}, null);
	}

	public Object findSingleObj(Object obj) {
		// TODO Auto-generated method stub
		return null;
	}

	public List findMultipleObj(Object obj) {
		String sql = "select * from eb_goods where cid=?";
		return DAOHelper.executeQuery(sql, new CallBack() {
			public List getResults(ResultSet rs) {
				List<Goods> list = new ArrayList<Goods>();
				try {
					while(rs.next()){
						Goods goods = new Goods();
						int gid = rs.getInt("gid");
						String gname = rs.getString("gname");
						double price = rs.getDouble("price");
						double offset = rs.getDouble("offset");
						Date date = rs.getDate("publishtime");
						int total = rs.getInt("total");
						int cid = rs.getInt("cid");
						ICategoryDAO cdao = new CategoryDAO();
						//查询分类
						Category c = (Category)cdao.findById(cid);
						IGoodsImgsDAO imgDAO = new GoodsImgsDAO();
						//查询商品所有图片
						List<GoodsImgs> imgs =imgDAO.findByGoodsId(gid);
						
						goods.setCategory(c);
						goods.setGid(gid);
						goods.setGname(gname);
						goods.setOffset(offset);
						goods.setPrice(price);
						goods.setPublishTime(date);
						goods.setTotal(total);
						goods.setGoodsImgs(imgs);
						
						list.add(goods);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return list;
			}
		}, obj);
	}

}
