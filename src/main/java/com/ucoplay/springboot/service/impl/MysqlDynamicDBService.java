package com.ucoplay.springboot.service.impl;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.ucoplay.springboot.model.mysql.InfomationSchema;
import com.ucoplay.springboot.service.IDynamicDB;

public class MysqlDynamicDBService extends DBService implements IDynamicDB{
	static final String jdbcDriver = "com.mysql.jdbc.Driver";
	String mysqlURL = "jdbc:mysql://%s/%s?useUnicode=true&characterEncoding=UTF-8";
	
	public Connection getConnection() throws Exception {
		return getConnection(jdbcDriver, this.url, this.dbname, this.user, this.pwd);
	}
	
	@Override
	public Connection getConnection(String jdbcDriver, String url, String dbname, String user, String pwd)
			throws Exception {
		Class.forName(jdbcDriver);
		return DriverManager.getConnection(String.format(mysqlURL, url,dbname), user, pwd);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getAllUserTables(){
		try(Connection connection = getConnection();
			  PreparedStatement pStmt = connection.prepareStatement(getQueryUserTableSql());
			  ResultSet resultSet = pStmt.executeQuery();) {
			return resultsetToModel(resultSet);
		} catch (Exception e) {
			e.printStackTrace();
			List<String> errorList = new ArrayList<String>();
			errorList.add(e.getMessage());
			return errorList;
		}	
	}
	
	String getQueryUserTableSql() {
		StringBuffer sBuffer = new StringBuffer("");
		sBuffer.append("select * from information_schema.`COLUMNS` ")
				   .append(" where TABLE_SCHEMA = '").append(dbname).append("'");
		return sBuffer.toString();
	}
	
	static List<InfomationSchema> resultsetToModel(ResultSet rs)throws Exception{
		List<InfomationSchema> list = new ArrayList<InfomationSchema>();
		Field[] fields = InfomationSchema.class.getDeclaredFields();
		if (rs!=null) {
			while(rs.next()) {
				InfomationSchema infomationSchema = new InfomationSchema();
				for(Field field:fields) {
					field.setAccessible(true);
					try {
						if (field.getType().getSimpleName().equals("String")) {
							field.set(infomationSchema, rs.getString(field.getName()));
						}else if(field.getType().getSimpleName().equals("long")) {
							field.set(infomationSchema, rs.getLong(field.getName()));
						}
					} catch (Exception e) {
						System.out.println("field:"+rs.getString("column_name"));
					}
					
				}
				list.add(infomationSchema);
			}
		}
		return list;
	}
}
