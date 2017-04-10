package com.softeem.easybuy.dbhelper;

import java.sql.ResultSet;
import java.util.List;

/**
 * 回调接口
 * @author MRChai
 *
 */
public interface CallBack {

	public List getResults(ResultSet rs);
}
