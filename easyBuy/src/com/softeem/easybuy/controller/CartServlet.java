package com.softeem.easybuy.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.softeem.easybuy.util.JsonUtils;
import com.softeem.esaybuy.dto.Cart;

/**
 * Servlet implementation class CartServlet
 */
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CartServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String flag = request.getParameter("flag");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		if ("add".equals(flag)) {
			addCart(request, response);
		}else if("read".equals(flag)){
			showCarts(request, response);
		}else if("del".equals(flag)){
			delCarts(request,response);
		}

	}
	//删除购物车数据
	private void delCarts(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String[] data = request.getParameterValues("ids");
		List<Cart> carts = readCarts(request, response);
		Iterator<Cart> it = carts.iterator();
		Cart cart = null;
		//使用迭代器删除元素
		while(it.hasNext()){
			cart = it.next();
			for (String id : data) {
				if(cart.getGid().equals(id)){
					it.remove();
					break;
				}
			}
		}
		//保存
		save(response, carts);
		showCarts(request, response);
	}
	//添加cookie
	public void save(HttpServletResponse response,List<Cart> carts) throws UnsupportedEncodingException{
		String json = JsonUtils.toJson(carts);
		json = URLEncoder.encode(json, "utf-8");
		Cookie cookie = new Cookie("list", json);
		cookie.setMaxAge(60 * 60 * 24 * 30);
		response.addCookie(cookie);
	}
	//显示购物车
	private void showCarts(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		List<Cart> carts = readCarts(request, response);
		PrintWriter out = response.getWriter();
		if(carts.size() < 1){
			out.print(0);
		}else{
			out.print(JsonUtils.toJson(carts));
		}
		out.flush();
	}

	// 添加购物车
	private void addCart(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String gid = request.getParameter("gid");
		String name = request.getParameter("name");
		double price = Double.parseDouble(request.getParameter("price"));
		int total = Integer.parseInt(request.getParameter("buy"));
		String img = request.getParameter("img");
		Cart c = new Cart(gid, name, price, total, img);
		BigDecimal bd = new BigDecimal(price * total);
		double t = bd.setScale(2,BigDecimal.ROUND_DOWN).doubleValue();
		c.setTotalPrice(t);
		
		List<Cart> carts = readCarts(request, response);
		carts.add(c);
		save(response, carts);
		PrintWriter out = response.getWriter();
		out.print(1);
		out.flush();
	}
	//读取Cookie
	public List<Cart> readCarts(HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		// 获取所有Cookie
		Cookie[] cookies = request.getCookies();
		List<Cart> carts = new ArrayList<Cart>();
		String value = "";
		for (int i = 0; i < cookies.length; i++) {
			String key = cookies[i].getName();
			if ("list".equals(key)) {
				// 取出购物车集合字符串表示
				value = cookies[i].getValue();
				break;
			}
		}
		if (!value.equals("")) {
			value = URLDecoder.decode(value, "utf-8");
			carts = JsonUtils.getCarts(value);
		}
		return carts;
	}

}
