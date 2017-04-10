package com.softeem.easybuy.dbhelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.softeem.esaybuy.dto.Admin;

/**
 * 通用数据访问对象
 * @author MRChai
 */
public class DAOHelper {

	//执行更新操作(封装通用增，删，改)
	public static boolean executeUpdate(Connection conn, String sql,
			Object...params) {
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					ps.setObject(i + 1, params[i]);
				}
			}
			int rows = ps.executeUpdate();
			if(rows > 0)return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//封装通用查询
	public static List executeQuery(String sql,CallBack call,Object... params){
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DBUtils.getConn();
			ps =conn .prepareStatement(sql);
			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					ps.setObject(i + 1, params[i]);
				}
			}
			rs = ps.executeQuery();
			//回调
			return call.getResults(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
