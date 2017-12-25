package com.ucoplay.springboot.service;

import java.io.File;
import java.util.List;

import com.ucoplay.springboot.model.mysql.InfomationSchema;

public interface IHtmlService {
	public static final String StartTag = "<!-- ==start== -->";
	public static final String EndTag = "<!-- ==end== -->";
	List<String> genQueryPage() throws Exception;
	List<String> genDetailHtml() throws Exception;
}
