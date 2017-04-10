package com.softeem.easybuy.dao.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.softeem.easybuy.dao.ICategoryDAO;
import com.softeem.easybuy.dao.IGoodsDAO;
import com.softeem.easybuy.dao.IGoodsImgsDAO;
import com.softeem.easybuy.dbhelper.CallBack;
import com.softeem.easybuy.dbhelper.DAOHelper;
import com.softeem.easybuy.dbhelper.DBUtils;
import com.softeem.esaybuy.dto.Category;
import com.softeem.esaybuy.dto.Goods;
import com.softeem.esaybuy.dto.GoodsImgs;

public class GoodsDAO implements IGoodsDAO {

	private Connection conn;

	public GoodsDAO() {
		conn = DBUtils.getConn();
	}
	
	public boolean save(Object obj) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean update(Object obj) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean delete(Object obj) {
		String sql = "delete from eb_goods where gid=?";
		return DAOHelper.executeUpdate(DBUtils.getConn(), sql, obj);
	}

	public Object findById(final Object id) {
		String sql = "select * from eb_goods where gid=?";
		return DAOHelper.executeQuery(sql, new CallBack() {
			public List getResults(ResultSet rs) {
				List<Goods> list = new ArrayList<Goods>();
				try {
					if(rs.next()){
						Goods goods = new Goods();
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
						List<GoodsImgs> imgs =imgDAO.findByGoodsId(Integer.parseInt(id.toString()));
						
						goods.setCategory(c);
						goods.setGid(Integer.parseInt(id.toString()));
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
		}, id).get(0);
	}

	public List findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	public Object findSingleObj(Object obj) {
		// TODO Auto-generated method stub
		return null;
	}

	public List findMultipleObj(Object obj) {
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<Goods> findByPage(int pageSize, int currentPage) {
		String sql = "select * from eb_goods limit ?,?";
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
		},String.valueOf((currentPage-1)*pageSize),String.valueOf(pageSize));
	}
	
	/**
	 * 获取商品总数
	 */
	public int getGoodsCount() {
		String sql = "select count(*) from eb_goods";
		Object obj = DAOHelper.executeQuery(sql, new CallBack() {
			public List getResults(ResultSet rs) {
				List list = new ArrayList();
				try {
					if(rs.next()){
						int count = rs.getInt(1);
						list.add(count);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return list;
			}
		}).get(0);
		return obj != null?Integer.parseInt(obj.toString()):0;
	}

}
