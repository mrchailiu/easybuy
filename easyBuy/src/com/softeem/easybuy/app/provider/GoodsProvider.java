package com.softeem.easybuy.app.provider;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.softeem.easybuy.dao.IGoodsDAO;
import com.softeem.easybuy.dao.impl.GoodsDAO;
import com.softeem.esaybuy.dto.Goods;

public class GoodsProvider extends HttpServlet {

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String flag = request.getParameter("flag");
		int op = flag != null?Integer.parseInt(flag):0;
		String json = null;
		switch(op){
		case 1:
			//查询所有
			json = queryAll(request);
			break;
		case 2:
			//根据id查询
			json = queryById(request);
			break;
		}
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.print(json);
		out.flush();
	}

	
	private String queryAll(HttpServletRequest request) {
		int totalPage = 0;
		IGoodsDAO dao = new GoodsDAO();
		int count = dao.getGoodsCount();
		totalPage = (int)Math.ceil((double)count/Constant.PAGESIZE);
		int cp = Integer.parseInt(request.getParameter("cp"));
		cp = cp<1?1:cp;//防止无限上一页
		cp = cp>totalPage?totalPage:cp;//防止无限下一页
		List<Goods> goods =dao.findByPage(Constant.PAGESIZE, cp);
		return new Gson().toJson(goods);
	}


	private String queryById(HttpServletRequest request) {
		String gid = request.getParameter("gid");
		IGoodsDAO dao = new GoodsDAO();
		Object obj = dao.findById(gid);
		return new Gson().toJson(obj);
	}

}
