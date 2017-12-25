package com.ucoplay.springboot.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ucoplay.springboot.service.impl.MysqlDynamicDBService;

@Controller
public class DynamicDBServiceController {
	
	@RequestMapping("/queryMysqlUserTables")
	@ResponseBody
	public List getAllUserTables(@RequestBody MysqlDynamicDBService mysqlDynamicDBService) {
		try {
			return mysqlDynamicDBService.getAllUserTables();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("查询用户表出错!"+e.getMessage());
			return null;
		}
	}
}
