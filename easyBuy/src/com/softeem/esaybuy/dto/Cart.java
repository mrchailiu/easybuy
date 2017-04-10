package com.softeem.esaybuy.dto;

import java.io.Serializable;

/**
 * ¹ºÎï³µ
 * @author MRChai
 *
 */
public class Cart implements Serializable {

	private String gid;
	private String name;
	private double price;
	private int total;
	private String img;
	private double totalPrice;
	
	public Cart() {
		// TODO Auto-generated constructor stub
	}
	
	public Cart(String gid, String name, double price, int total, String img) {
		super();
		this.gid = gid;
		this.name = name;
		this.price = price;
		this.total = total;
		this.img = img;
	}

	public String getGid() {
		return gid;
	}
	public void setGid(String gid) {
		this.gid = gid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
}
