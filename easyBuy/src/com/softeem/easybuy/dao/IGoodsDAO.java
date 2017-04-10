package com.softeem.easybuy.dao;

import java.util.List;

import com.softeem.esaybuy.dto.Goods;

public interface IGoodsDAO extends IBaseDAO{

	
	public List<Goods> findByPage(int pageSize,int currentPager);
	
	public int getGoodsCount();
}
