package com.ucoplay.springboot.service;

import java.sql.Connection;
import java.util.List;

public interface IDynamicDB {
	Connection getConnection(String jdbcDriver,String url,String dbname,String user,String pwd) throws Exception;
	List getAllUserTables() throws Exception;
}
