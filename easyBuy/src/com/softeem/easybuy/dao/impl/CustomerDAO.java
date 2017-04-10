package com.softeem.easybuy.dao.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.softeem.easybuy.dao.ICustomerDAO;
import com.softeem.easybuy.dbhelper.CallBack;
import com.softeem.easybuy.dbhelper.DAOHelper;
import com.softeem.easybuy.dbhelper.DBUtils;
import com.softeem.esaybuy.dto.Customer;

public class CustomerDAO implements ICustomerDAO {

	private Connection conn;

	public CustomerDAO() {
		conn = DBUtils.getConn();
	}

	//×¢²á
	public boolean save(Object obj) {
		Customer user = (Customer)obj;
		String sql = "insert into eb_customer(username,password) values(?,?)";
		return DAOHelper.executeUpdate(conn, sql,user.getUsername(),user.getPassword());
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

	//µÇÂ¼
	public Object findSingleObj(Object obj) {
		final Customer user = (Customer)obj;
		String sql = "select * from eb_customer where username=?";
		List list = DAOHelper.executeQuery(sql, new CallBack() {
			public List getResults(ResultSet rs) {
				List list = new ArrayList();
				try {
					if(rs.next()){
						Customer c = new Customer();
						c.setUserid(rs.getInt("userid"));
						c.setUsername(user.getUsername());
						c.setPassword(rs.getString("password"));
						c.setPhone(rs.getString("phone"));
						c.setSex(rs.getString("sex"));
						c.setBirthday(rs.getDate("birthday"));
						list.add(c);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return list;
			}
		}, user.getUsername());
		return list.size()>0?list.get(0):null;
	}

	public List findMultipleObj(Object obj) {
		// TODO Auto-generated method stub
		return null;
	}

}
