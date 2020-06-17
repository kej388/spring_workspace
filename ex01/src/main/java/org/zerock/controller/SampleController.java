package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.TodoDTO;

@Controller
@RequestMapping("/sample/*")
//@Log4j
public class SampleController {
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, false));
	}
	
	@RequestMapping(value = "/basic", method= {RequestMethod.GET, RequestMethod.POST})
	public void basic() {
		//log.info("basic..............");
		System.out.println("basic......");
	}
	
	@GetMapping("/ex01")
	public String ex01(SampleDTO dto) {
		System.out.println("" + dto); // 문자열로 변환하기 위해서
		
		return "list";	// list.jsp로 이동
	}
	
	@GetMapping("/ex02")
	public String ex02(@RequestParam("name") String name, @RequestParam("age") int age) {
		System.out.println("name : " + name);
		System.out.println("age: " + age);
		
		return "ex02";
	}
	
	@GetMapping("/ex03")
	public String ex03(TodoDTO todo) {
		System.out.println("todo : " + todo);
		return "ex03";
	}
	
	@GetMapping("/ex04")
	public String ex04(SampleDTO dto, @ModelAttribute("page") int page) {
		System.out.println("dto: " + dto);
		System.out.println("page: " + page);
		
		return "/sample/ex04";
		
		// rttr.addFlashAttribute("name", "aaa");
		// rttr.addFlashAttribute("age", 10);
		// return "redirect:/sample/list"
	}
	
	@GetMapping("/ex05")
	public void ex05() {
		System.out.println("/ex05........");
	}
	
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		System.out.println("/ex06.............");
		
		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("aaa");
		
		return dto;
	}
	
	@GetMapping("/ex07")
	public @ResponseBody List<SampleDTO> ex07() {
		List<SampleDTO> arrayList = new ArrayList<SampleDTO>();
		
		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("aaa");
		
		SampleDTO dto2 = new SampleDTO();
		dto2.setAge(11);
		dto2.setName("bbb");
		
		arrayList.add(dto);
		arrayList.add(dto2);
		
		return arrayList;
	}
	
	@GetMapping("/ex08")
	public ResponseEntity<String> ex08() {
		System.out.println("/ex08.........");
		
		String msg = "{\"name\": \"홍길동\"}";
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json;charset=UTF-8");
		
		return new ResponseEntity<String>(msg, header, HttpStatus.OK);
	}
}
