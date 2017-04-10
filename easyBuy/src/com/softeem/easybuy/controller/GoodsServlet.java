package com.softeem.easybuy.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.softeem.easybuy.dao.IGoodsDAO;
import com.softeem.easybuy.dao.impl.GoodsDAO;
import com.softeem.jspsmart.upload.SmartUpload;
import com.softeem.jspsmart.upload.SmartUploadException;

/**
 * Servlet implementation class GoodsServlet
 */
public class GoodsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GoodsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * http:超文本传输协议
	 * 请求头--客户端发起请求时附带到后台的参数或配置
	 * 		   常用两种请求方式:
	 * 			1.get请求(将请求输入附加在请求地址后，通常请求服务端数据时使用)只能提交1024字节(1kb)以内的数据
	 * 			2.post请求(讲请求数据附加在请求头中，通过用于向服务端提交大量数据时使用)
	 * 响应头--包含服务端反馈回来的信息
	 * 
	 * 响应状态码
	 * 200~		200			（OK）
	 * 400~		404 405		（not found）
	 * 500~		500 501		（server error）
	 * 
	 * 客户端发送get请求时，执行该方法
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("get.....");
		doPost(request, response);
	}

	/**
	 * 客户端发送post请求时，执行该方法
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String flag = request.getParameter("flag");
		if(flag != null){
			if(flag.equals("del")){
				del(request,response);
			}else if(flag.equals("info")){
				info(request,response);
			}else if(flag.equals("edit")){
				edit(request,response);
			}
		}else{
			try {
				//创建SmartUpload对象
				SmartUpload su = new SmartUpload();
				//初始化SmartUpload对象
				su.initialize(this, request, response);
				//设置允许上传的文件类型
				su.setAllowedFilesList("png,jpg,gif,jpeg,bmp");
				//设置允许上传的单个文件大小
				su.setMaxFileSize(1024*1024*10);//最大10M
				//设置允许上传的文件的总大小
				su.setTotalMaxFileSize(1024*1024*100);//最大100M
				//上传
				su.upload();
				//将文件默认设置上传到服务器的c盘指定目录中
				String baseDir = "c:/files/test/img";
				//服务器路径
//				String baseDir = request.getSession().getServletContext().getRealPath("/files");
				//根据字符串创建File对象
				java.io.File dir = new java.io.File(baseDir);
				if(!dir.exists()){
					if(dir.mkdirs()){
						System.out.println("目录创建完成:"+dir.getAbsolutePath());
					}
				}
				//将所有文件保存到指定目录中
				su.save(baseDir);
			
			/*	
				//获取上传文件的数量
				Files files =  su.getFiles();
				int count = files.getCount();
				System.out.println(count+"<---文件数");
				//获取每一个文件并存储到指定目录中
				for(int i = 0;i<count;i++){
					File file = files.getFile(i);
					//判断文件是否包含内容
					if(file.getSize() > 0){
						System.out.println("--->保存"+file.getSize()+"--->"+file.getFileName());
						//保存文件到指定目录
//						file.saveAs(baseDir);
					}
				}
			*/
			} catch (SmartUploadException e) {
				e.printStackTrace();
			}
		}
		
	}
	//编辑商品
	private void edit(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}
	//商品详情
	private void info(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}
	//删除商品
	private void del(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String id = request.getParameter("gid");
		IGoodsDAO dao = new GoodsDAO();
		if(dao.delete(id)){
			response.sendRedirect("list_goods.jsp");
		}
	}

}
