package com.ucoplay.springboot;

import java.util.ArrayList;
import java.util.List;

public class Test {
	public static void main(String[] args) throws Exception{
		String string = "<td class=\"inputLable\">%s：</td><td><input name=\"%s\" id=\"%s\" class=\"%s inputWidth\" /></td>";
		List<String> list = new ArrayList<String>();
		list.add("test");
		list.add("test1");
		list.add("test2");
		list.add("test3");
		System.out.println(String.format(string, list.toArray()));
	}
}
