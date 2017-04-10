package com.softeem.esaybuy.dto;

import java.io.Serializable;

/**
 * 商品图片
 * @author MRChai
 *
 */
public class GoodsImgs implements Serializable{

	private int imgid;		//ID
	private String imgName;	//图片名称
	private String imgPath;	//路径
	private int gid;		//所属商品id
	
	public int getImgid() {
		return imgid;
	}
	public void setImgid(int imgid) {
		this.imgid = imgid;
	}
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	public int getGid() {
		return gid;
	}
	public void setGid(int gid) {
		this.gid = gid;
	}
}
