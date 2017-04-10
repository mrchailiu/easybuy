package com.softeem.easybuy.dbhelper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * 数据库连接工具类
 * @author MRChai
 */
public class DBUtils {

	private static final String DRIVER="com.mysql.jdbc.Driver";
	//125.220.74.141
	private static final String URL="jdbc:mysql://localhost:3306/easybuy";
	private static final String USER="root";
	private static final String PASSWORD="123456";
	private static Connection conn;
	
	private DBUtils(){};
	
	//加载驱动
	static{
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	//获取连接
	public static Connection getConn(){
		try {
			if(conn == null ||conn.isClosed()){
				conn = DriverManager.getConnection(URL, USER, PASSWORD);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	//关闭资源
	public static void closeConn(Connection conn){
		try {
			if(conn != null)conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
