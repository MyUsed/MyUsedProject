package com.spring.vertx.controller;

import java.sql.SQLXML;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sun.javafx.sg.prism.NGShape.Mode;
import com.sun.org.apache.regexp.internal.recompile;


@Controller
public class chatController {
	@Autowired
	private SqlMapClientTemplate SqlMapClientTemplate;
	
	// ä�ù� ����
	@RequestMapping("chat.nhn")
	public ModelAndView main(Map<String, Object> map, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String sessionId = (String)session.getAttribute("memId");
		int count = (int)SqlMapClientTemplate.queryForObject("chat.oncount", sessionId);	// chatonoff�÷��� 0�̳� 1�̳�
		if(count == 0){	// ä�ÿ� �������� �ƴϸ�
			SqlMapClientTemplate.update("chat.on", sessionId);	// ä�ù濡 �����ϸ� 1
		}
		int totalcount = (int)SqlMapClientTemplate.queryForObject("chat.totalCount", null);	// ä�ù� �������� ��
		mav.addObject("totalcount", totalcount);
		mav.setViewName("/views/chat.jsp");
		return mav;
	}
	
	// ä�ù� �������� ��
	@RequestMapping("oncount.nhn")
	public ModelAndView oncount(){
		ModelAndView mv = new ModelAndView();
		int totalcount = (int)SqlMapClientTemplate.queryForObject("chat.totalCount", null);	// ä�ù� �������� ��
		mv.addObject("totalcount", totalcount);
		mv.setViewName("/views/count.jsp");
		return mv;
	}
	
	@RequestMapping("idlist.nhn")
	public ModelAndView idlist(){
		ModelAndView mv = new ModelAndView();
		List list = SqlMapClientTemplate.queryForList("chat.onId", null);	// ä�ù濡 �����ִ� ����� ID 
		mv.addObject("list", list);
		mv.setViewName("/views/idlist.jsp");
		return mv;
	}
	
	@RequestMapping("chatExit.nhn")
	public String chatExit(HttpSession session){
		System.out.println("exit");
		String sessionId = (String)session.getAttribute("memId");
		SqlMapClientTemplate.update("chat.off", sessionId);
		return "/views/chatExit.jsp";
	}
}