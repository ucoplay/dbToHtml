package com.ucoplay.springboot.service.impl;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import com.ucoplay.springboot.service.IHtmlService;

public class MiniuilHtmlService implements IHtmlService {
	String queryHtmlTemp = "\\src\\main\\resources\\public\\htmlTemplate\\miniQuery.jsp";
	List<Map<String, String>> colInfoList;
	
	public void setColInfoList(List<Map<String, String>> colInfoList) {
		this.colInfoList = colInfoList;
	}

	@Override
	public List<String> genQueryPage() throws Exception {
		Path path = Paths.get(System.getProperty("user.dir")+queryHtmlTemp);
		List<String> htmlLines = Files.readAllLines(path,Charset.forName("UTF-8"));
		List<String> replaceHtmlLines = locateReplaceStringList(htmlLines);
		int countTD = countTD(replaceHtmlLines);
		String newRowStart = replaceHtmlLines.get(0);
		String newRowEnd = replaceHtmlLines.get(replaceHtmlLines.size()-1);
		String contentRow = replaceHtmlLines.get(1);
		replaceHtmlLines.clear();
		boolean newRow = true;
		String content = null;
		Map<String, String> colInfo;
		for(int i=0;i<colInfoList.size();i++) {
			if(newRow) {
				replaceHtmlLines.add(newRowStart);
				newRow = false;
			}
			colInfo = colInfoList.get(i);
			content = String.format(contentRow,colInfo.get("column_comment"),colInfo.get("column_name"),colInfo.get("column_name"),colInfo.get("widgetType"));
			replaceHtmlLines.add(content);
			if ((i+1)%countTD==0||(i+1)==colInfoList.size()) {
				replaceHtmlLines.add(newRowEnd);
				newRow = true;
			}
		}
		return htmlLines;
	}

	@Override
	public List<String> genDetailHtml() throws Exception {
		return null;
	}
	
	public static List<String> locateReplaceStringList(List<String> htmlLines){
		int start=0,end=0;
		for(int i=0;i<htmlLines.size();i++) {
			String line = htmlLines.get(i);
			if (line.trim().equals(IHtmlService.StartTag)) {
				start = i+1;
			}else if(line.trim().equals(IHtmlService.EndTag)) {
				end = i;
			}
		}
		return htmlLines.subList(start, end);
	}
	
	public static int countTD(List<String> htmlLines) 
	{
		int count = 0;
		for(String line:htmlLines) {
			if (line.trim().startsWith("<td")&&line.trim().endsWith("</td>")) {
				count++;
			}
		}
		return count;
	}

}
