package com.kh.artspark.kakao.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.artspark.kakao.model.service.KakaoService;
import com.kh.artspark.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class KakaoController {

	
	@Autowired
	private KakaoService kakaoService;
	
	@GetMapping("kakao-login")
	public String login() {
		return "member/login";
	}
	
	@GetMapping("oauth")
	public String socialLogin(String code,HttpSession session) throws IOException, ParseException,org.json.simple.parser.ParseException {
	
		String accessToken= kakaoService.getToken(code);
		session.setAttribute("accessToken",accessToken);
		
		Member member = kakaoService.getUserInfo(accessToken);
		
		session.setAttribute("loginUser", member);
		
		return "redirect:/";
	}
	
	@GetMapping("kakao-logout")
	public String logout(HttpSession session) {
		
		
		String accessToken = (String)session.getAttribute("accessToken");
		kakaoService.logout(accessToken);
		session.removeAttribute("loginUser");
		
		return "redirect:/";
		
		
	}
	
	

	

		
		
}
