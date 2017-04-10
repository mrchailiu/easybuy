package com.softeem.esaybuy.dto;

import java.io.Serializable;

/**
 * dto：数据传输对象
 * dao:数据访问对象
 * ORM:对象(java对象)关系(关系型数据库)映射
 * 关系型数据库中的一条记录对应一个java类中的对象
 * 收货地址
 * @author MRChai
 *
 */
public class Address implements Serializable {

	private int addrid;			//ID
	private String province;	//省
	private String city;		//市
	private String area;		//区
	private String street;		//详细街道
	private String receiveUser;	//收货人
	private String phone;		//收货人手机号
	private Customer user;		//地址所属用户
	
	public int getAddrid() {
		return addrid;
	}
	public void setAddrid(int addrid) {
		this.addrid = addrid;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getReceiveUser() {
		return receiveUser;
	}
	public void setReceiveUser(String receiveUser) {
		this.receiveUser = receiveUser;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Customer getUser() {
		return user;
	}
	public void setUser(Customer user) {
		this.user = user;
	}
}
