package com.softeem.easybuy.app.provider;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.softeem.easybuy.dao.ICategoryDAO;
import com.softeem.easybuy.dao.impl.CategoryDAO;

public class CategoryProvider extends HttpServlet {


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String flag =request.getParameter("flag");
		int op = flag != null?Integer.parseInt(flag):0;
		String json=null;
		switch(op){
		case 1:
			json = queryAll(request,response);
			break;
		case 2:
			json = queryById(request,response);
			break;
		case 3:
			json = queryGoodsByGid(request,response);
			break;
		case 4:
//			json = deleteById(request,response);
			break;
			default:
				break;
		}
		PrintWriter pw = response.getWriter();
		pw.print(json);
		pw.flush();
	}
	
	/**
	 * 根据分类id查询商品数据
	 * @param request
	 * @param response
	 * @return
	 */
	private String queryGoodsByGid(HttpServletRequest request,
			HttpServletResponse response) {
		String cid = request.getParameter("cid");
		ICategoryDAO cdao = new CategoryDAO();
		List list = cdao.findMultipleObj(Integer.parseInt(cid));
		System.out.println(list+"#######");
		return new Gson().toJson(list);
	}

	/**
	 * 查询分类根据id
	 * @param request
	 * @param response
	 * @return
	 */
	private String queryById(HttpServletRequest request,
			HttpServletResponse response) {
		String cid = request.getParameter("cid");
		ICategoryDAO cdao = new CategoryDAO();
		Object obj = cdao.findById(Integer.parseInt(cid));
		return new Gson().toJson(obj);
	}

	/**
	 * 查询所有分类
	 * @param request
	 * @param response
	 * @return
	 */
	private String queryAll(HttpServletRequest request,
			HttpServletResponse response) {
		ICategoryDAO cdao = new CategoryDAO();
		List list = cdao.findAll();
		return new Gson().toJson(list);
	}

	/**
	 * 
	 * 根据id删除分类
	 * @param request
	 * @param response
	 * @return
	 */
	private String deleteById(HttpServletRequest request,
			HttpServletResponse response) {
		String cid = request.getParameter("cid");
		ICategoryDAO cdao = new CategoryDAO();
		boolean result = cdao.delete(Integer.parseInt(cid));
		return new Gson().toJson(result);
	}


}
