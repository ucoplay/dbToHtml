package com.ucoplay.springboot;

import java.util.ArrayList;
import java.util.HashMap;            
import java.util.List;
import java.util.Map;

public class Test {
	public static void main(String[] args) throws Exception{
//		String queryHtmlTemp = "\\src\\main\\resources\\public\\htmlTemplate\\miniQuery.jsp";
//		//System.out.println(queryHtmlTemp.replaceAll("\\", System.getProperty("file.separator")));
//		StringBuffer sBuffer = new StringBuffer(System.getProperty("file.separator"));
//		
//		System.out.println(sBuffer.toString());
		
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		map.put("list1", new ArrayList<String>());
		map.get("list1").add("hello world");
		System.out.println(map.get("list1").get(0));
		map.get("123").add("123");
		System.out.println();;
	}
}
