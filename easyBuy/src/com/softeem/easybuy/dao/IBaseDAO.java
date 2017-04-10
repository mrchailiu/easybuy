package com.softeem.easybuy.dao;

import java.util.List;

public interface IBaseDAO {

	/**
	 * 添加
	 * @param obj	需要添加的对象
	 * @return	添加结果 true:成功；false:失败
	 */
	public boolean save(Object obj);
	
	/**
	 * 修改
	 * @param obj
	 * @return 修改结果 true:成功；false:失败
	 */
	public boolean update(Object obj);
	
	/**
	 * 删除
	 * @param id	需要被删除记录的id
	 * @return 删除结果 true:成功；false:失败
	 */
	public boolean delete(Object id);
	
	/**
	 * 根据id查询
	 * @param id	需要查询的记录id
	 * @return 返回查询到的对象，null表示对象不存在
	 */
	public Object findById(Object id);
	
	/**
	 * 查询所有
	 * @return	返回所有记录
	 */
	public List findAll();
	
	/**
	 * 根据属性查询单个对象
	 * @param obj
	 * @return
	 */
	public Object findSingleObj(Object obj);
	
	/**
	 * 根据属性查询批量对象
	 * @param obj
	 * @return
	 */
	public List findMultipleObj(Object obj);
	
}
