package com.softeem.easybuy.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.softeem.easybuy.service.CategoryService;

/**
 * M:模型层(数据模型，业务模型)
 * V:视图层(jsp)
 * C:控制层(servlet)
 * 
 * Servlet implementation class CategoryServlet
 */
public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("ajax");
		//查询所有分类，并返回到前端
		CategoryService service= new CategoryService();
		//获取所有分类
		List list = service.searAll();
		if("on".equals(type)){
			//生成分类菜单
			String json = new Gson().toJson(list);
			response.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
		}else{
			//将集合存入request范围
			request.setAttribute("c", list);
			//页面跳转（同时将请求数据向下继续传递）
			request.getRequestDispatcher("add_goods.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
