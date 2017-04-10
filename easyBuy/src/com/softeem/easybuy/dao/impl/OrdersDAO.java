package com.softeem.easybuy.dao.impl;

import java.sql.Connection;
import java.util.List;

import com.softeem.easybuy.dao.IOrdersDAO;
import com.softeem.easybuy.dbhelper.DBUtils;

public class OrdersDAO implements IOrdersDAO {

	private Connection conn;

	public OrdersDAO() {
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

}
