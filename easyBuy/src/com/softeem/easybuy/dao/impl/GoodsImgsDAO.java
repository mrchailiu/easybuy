package com.softeem.easybuy.dao.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.softeem.easybuy.dao.IGoodsImgsDAO;
import com.softeem.easybuy.dbhelper.CallBack;
import com.softeem.easybuy.dbhelper.DAOHelper;
import com.softeem.easybuy.dbhelper.DBUtils;
import com.softeem.esaybuy.dto.GoodsImgs;

public class GoodsImgsDAO implements IGoodsImgsDAO {

	private Connection conn;

	public GoodsImgsDAO() {
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
		// TODO Auto-generated method stub
		return false;
	}

	public Object findById(Object id) {
		// TODO Auto-generated method stub
		return null;
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
		// TODO Auto-generated method stub
		return null;
	}

	public List<GoodsImgs> findByGoodsId(final int gid) {
		String sql = "select * from eb_goodsimgs where gid=?";
		return DAOHelper.executeQuery(sql, new CallBack() {
			public List getResults(ResultSet rs) {
				List list = new ArrayList();
				try {
					GoodsImgs img = null;
					while(rs.next()){
						img = new GoodsImgs();
						int imgid = rs.getInt("imgid");
						String imgName = rs.getString("imgName");
						String imgPath = rs.getString("imgPath");
						img.setImgid(imgid);
						img.setImgName(imgName);
						img.setImgPath(imgPath);
						img.setGid(gid);
						
						list.add(img);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return list;
			}
		}, gid);
	}

}
