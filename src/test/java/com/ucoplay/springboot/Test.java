package com.ucoplay.springboot;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;
import com.ucoplay.springboot.service.impl.MiniuilHtmlService;

public class Test {
	public static void main(String[] args) throws Exception{
//		MiniuilHtmlService miniuilHtmlService = new MiniuilHtmlService();
//		List<Map<String, String>> colInfoList = new ArrayList<Map<String, String>>();
//		Map<String, String> col1 = new HashMap<String,String>();
//		col1.put("column_name", "name");
//		col1.put("column_comment", "姓名");
//		col1.put("widgetType", "mini-textbox");
//		Map<String, String> col2 = new HashMap<String,String>();
//		col2.put("column_name", "sex");
//		col2.put("column_comment", "性别");
//		col2.put("widgetType", "mini-combobox");
//		colInfoList.add(col1);
//		colInfoList.add(col2);
//		miniuilHtmlService.setColInfoList(colInfoList);
//		miniuilHtmlService.genQueryPage();
		String string= "[{\"table_schema\":\"partysys\",\"table_name\":\"bm_zyxx\",\"column_name\":\"spid\",\"ordinal_position\":\"1\",\"column_default\":\"\",\"is_nullable\":\"NO\",\"data_type\":\"varchar\",\"character_maximum_length\":6,\"column_key\":\"PRI\",\"column_comment\":\"专业id\",\"expanded\":false,\"_level\":1,\"checked\":true,\"widgetType\":\"mini-textbox\",\"_id\":363,\"_uid\":363},{\"table_schema\":\"partysys\",\"table_name\":\"bm_zyxx\",\"column_name\":\"spname\",\"ordinal_position\":\"2\",\"column_default\":null,\"is_nullable\":\"YES\",\"data_type\":\"varchar\",\"character_maximum_length\":100,\"column_key\":\"\",\"column_comment\":\"专业名称\",\"expanded\":false,\"_level\":1,\"checked\":true,\"widgetType\":\"mini-combobox\",\"_id\":364,\"_uid\":364}]";
		ObjectMapper objectMapper = new ObjectMapper();
		List<Map<String,String>> colInfoList = objectMapper.readValue(string,new TypeReference<List<Map<String,String>>>() {
		});
		for(Map<String, String> col:colInfoList) {
			System.out.println(col.get("column_name"));
		}
	}
}
