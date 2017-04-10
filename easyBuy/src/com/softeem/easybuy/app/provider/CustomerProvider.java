package com.softeem.easybuy.app.provider;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.softeem.easybuy.service.CustomerService;
import com.softeem.easybuy.service.ServiceModel;
import com.softeem.esaybuy.dto.Customer;

public class CustomerProvider extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String flag = request.getParameter("flag");
		int op = flag != null?Integer.parseInt(flag):0;
		String json = "";
		switch (op) {
		case 1:
			json = login(request);
			break;
		case 2:
			json = reg(request);
			break;
		}
		PrintWriter pw = response.getWriter();
		pw.print(json);
		pw.flush();
	}
	
	//×¢²á
	private String reg(HttpServletRequest request) {
		String uname = request.getParameter("uname");
		String upass = request.getParameter("upass");
		CustomerService service = new CustomerService();
		ServiceModel model = service.register(new Customer(uname, upass));
		return new Gson().toJson(model);
	}
	//µÇÂ¼
	private String login(HttpServletRequest request) {
		String uname = request.getParameter("uname");
		String upass = request.getParameter("upass");
		CustomerService service = new CustomerService();
		ServiceModel model = service.login(new Customer(uname, upass));
		return new Gson().toJson(model);
	}

}
