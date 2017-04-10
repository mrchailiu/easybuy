package com.softeem.easybuy.dao;

import java.util.List;

import com.softeem.esaybuy.dto.GoodsImgs;

public interface IGoodsImgsDAO extends IBaseDAO{

	public List<GoodsImgs> findByGoodsId(int gid);
}
