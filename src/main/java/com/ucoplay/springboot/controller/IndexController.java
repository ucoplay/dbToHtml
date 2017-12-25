package com.ucoplay.springboot.controller;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ucoplay.springboot.service.impl.MiniuilHtmlService;

@Controller
public class IndexController {

	@Autowired
	ObjectMapper objectMapper;
	
	@RequestMapping("/")
	public String index() {
		return "ftl/index";
	}
	
	@RequestMapping("/downLoadMiniuiQueryTemplate")
	public ResponseEntity<String> downLoadMiniuiQueryHtml(@RequestParam String colInfoListString){
		try {
			List<Map<String, String>> colInfoList = objectMapper.readValue(colInfoListString,new TypeReference<List<Map<String, String>>>() {
			});
			//生成下载的jsp文件
			MiniuilHtmlService service = new MiniuilHtmlService();
			service.setColInfoList(colInfoList);
			List<String> htmlLines = service.genQueryPage();
			
			//头文件，指示为文件下载
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition", "attachment;filename=queryHtml.jsp");
		
			
			StringBuffer stringBuffer = new StringBuffer(1024);
			for(String s:htmlLines) {
				stringBuffer.append(s);
				stringBuffer.append("\n");
			}
			return new ResponseEntity<String>(stringBuffer.toString(),headers,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>(e.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
		} 
	}
}