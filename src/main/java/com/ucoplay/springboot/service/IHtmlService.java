package com.ucoplay.springboot.service;
import java.util.List;

public interface IHtmlService {
	public static final String StartTag = "<!-- ==start== -->";
	public static final String EndTag = "<!-- ==end== -->";
	public static final String ContainerStartTag = "<!--container_tag_start-->";
	public static final String ContainerEndTag = "<!--container_tag_end-->";
	List<String> genQueryPage() throws Exception;
	List<String> genDetailHtml() throws Exception;
}
