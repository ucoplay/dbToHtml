package com.ucoplay.springboot.service.impl;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ucoplay.springboot.service.IHtmlService;

public class MiniuilHtmlService implements IHtmlService {
	String pathSeparator = System.getProperty("file.separator");
	String queryHtmlTemp = pathSeparator+"src"+pathSeparator+"main"+pathSeparator+"resources"+pathSeparator+"public"+pathSeparator+"htmlTemplate"+pathSeparator+"miniQuery.jsp";
	List<Map<String, String>> colInfoList;
	
	public void setColInfoList(List<Map<String, String>> colInfoList) {
		this.colInfoList = colInfoList;
	}

	@Override
	public List<String> genDetailHtml() throws Exception {
		return null;
	}
	
	/**
	 * 查找标记<!--container_tag_start-->到<!--container_tag_end-->之间的内容			
	 * @return
	 */
	public static List<String> locateContainerStringList(List<String> htmlLines){
		int start=0,end=0;
		for(int i=0;i<htmlLines.size();i++) {
			String line = htmlLines.get(i);
			if (line.trim().equals(IHtmlService.ContainerStartTag)) {
				start = i+1;
			}else if(line.trim().equals(IHtmlService.ContainerEndTag)) {
				end = i;
				return htmlLines.subList(start, end);
			}
		}
		return null;
	}

	/**
	 * 查找<!--content_repeat:开始的那行
	 * @param replaceHtmlLines
	 * @return
	 */
	String locateContentRuleString(List<String> replaceHtmlLines) {
		for(String s:replaceHtmlLines) {
			if (s.trim().startsWith("<!--content_repeat:")) {
				return s.trim().replace("<!--content_repeat:", "").replace("-->", "").trim();
			}
		}
		return null;
	}
	/**
	 * 返回<!--content_repeat:开始的下一行
	 * @param replaceHtmlLines
	 * @return
	 */
	String locateContentString(List<String> replaceHtmlLines) {
		for(int i=0;i<replaceHtmlLines.size();i++) {
			if (replaceHtmlLines.get(i).trim().startsWith("<!--content_repeat:")) {
				return replaceHtmlLines.get(i+1);
			}
		}
		return null;
	}
	
	/**
	 * 替换container标记的部分
	 * @param htmlLines
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	void replaceContainerRepeat(List<String> htmlLines) throws Exception{
		List<String> replaceHtmlLines = locateContainerStringList(htmlLines);
		String containerStartTag = replaceHtmlLines.get(0);
		String containerEndTag = replaceHtmlLines.get(replaceHtmlLines.size()-1);
		String contentString = locateContentString(replaceHtmlLines);
		String contentReplaceRule = locateContentRuleString(replaceHtmlLines);
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> ruleObject = mapper.readValue(contentReplaceRule, Map.class);
		int repeat = (int)ruleObject.get("repeat");
		List<String> colAttrNameList =(ArrayList<String>)ruleObject.get("columns");//在模板页面指定的column数组
		
		boolean newRow = true;
		replaceHtmlLines.clear();//清空再添加
		Map<String, String> colInfo = null;
		for(int i=0;i<colInfoList.size();i++) {//循环替换
			colInfo = colInfoList.get(i);
			if (newRow) {
				replaceHtmlLines.add(containerStartTag);
				newRow = false;
			}
			List<String> colAttrValueList = new ArrayList<String>();
			for(String attribute:colAttrNameList) {
				colAttrValueList.add(colInfo.get(attribute));
			}
			String content = String.format(contentString,colAttrValueList.toArray());
			replaceHtmlLines.add(content);
			if((i+1)%repeat==0||(i+1)>=colInfoList.size()) {
				replaceHtmlLines.add(containerEndTag);
				newRow = true;
			}
		}
	}
	
	/***
	 * 替换标记为<!--single_repeat:的html
	 * @param htmlLines
	 */
	@SuppressWarnings("unchecked")
	void replaceSingleRepeat(List<String> htmlLines) throws Exception {
		List<String> replaceLines = locateSingleRepeat(htmlLines);
		if (replaceLines.size()<2) {
			return;
		}
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, Object> json = objectMapper.readValue(replaceLines.get(0), Map.class);
		int repeat = (int)json.get("repeat");
		List<String> colAttrNames =(List<String>)json.get("columns");
		
		String content = replaceLines.get(1);
		replaceLines.clear();
		for( int i=0;i<repeat&&i<colInfoList.size();i++) {
			List<String> colAttrValues = new ArrayList<String>();
			for(String attribute:colAttrNames) {
				colAttrValues.add(colInfoList.get(i).get(attribute));
			}
			replaceLines.add(String.format(content, colAttrValues.toArray()));
		}
	}
	public List<String>  locateSingleRepeat(List<String> htmlLines) {
		for(int i=0;i<htmlLines.size();i++) {
			String line = htmlLines.get(i);
			if (line.trim().startsWith("<!--single_repeat:")) {
				htmlLines.set(i,line.replace("<!--single_repeat:","").replace("-->", "").trim());
				return htmlLines.subList(i, i+2);
			}
		}
		return null;
	}
	/**
	 * 生成查询页面
	 */
	@Override
	public List<String> genQueryPage() throws Exception {
		Path path = Paths.get(System.getProperty("user.dir")+queryHtmlTemp);
		List<String> htmlLines = Files.readAllLines(path,Charset.forName("UTF-8"));
		replaceContainerRepeat(htmlLines);
		replaceSingleRepeat(htmlLines);
		return htmlLines;
	}
	 
}
