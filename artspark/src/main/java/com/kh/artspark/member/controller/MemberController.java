package com.kh.artspark.member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.artspark.member.model.service.MemberService;
import com.kh.artspark.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MemberController {
	
	private final MemberService memberService;
	private final BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@GetMapping("memberList")
	public void memberList() {
		
		List<Member> memberList = memberService.memberList();
		for(Member m : memberList) {
			log.info("회원정보: {} ", m.toString());
		}
		
	}
	
	
	@GetMapping("login")
	public String loginPage() {
	    return "co"; // 로그인 페이지의 뷰 이름 반환
	}
	
	//로그인 할때 암호화된 비밀번호도 받아서 확인후 연결(bcrypt로 하고 oauth 방식으로 변경 예정...공부중....)
	@PostMapping("login")
	public ModelAndView login(Member member, ModelAndView mv, HttpSession session) {
		
		Member loginUser = memberService.login(member);
		
		log.info("로그인: {}", loginUser.getMemId());
		log.info("비밀번호: {}", loginUser.getMemPwd());
		if (loginUser != null && member.getMemPwd().equals(loginUser.getMemPwd())) {
		//if(loginUser != null && bcryptPasswordEncoder.matches(member.getMemPwd(), loginUser.getMemPwd())){
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:/");
		}else {
			mv.addObject("errorMsg","로그인 실패!").setViewName("common/errorPage");
		}
		
	}
	
	
	@GetMapping("login")
	public String loginPage() {
	    return "member/login"; // 로그인 페이지의 뷰 이름 반환
	}
	
	//로그인 할때 암호화된 비밀번호도 받아서 확인후 연결(bcrypt로 하고 oauth 방식으로 변경 예정...공부중....)
	@PostMapping("login")
	public ModelAndView login(Member member, ModelAndView mv, HttpSession session) {
		
		Member loginUser = memberService.login(member);
		
		log.info("로그인: {}", loginUser.getMemId());
		log.info("비밀번호: {}", loginUser.getMemPwd());
		if (loginUser != null && member.getMemPwd().equals(loginUser.getMemPwd())) {
		//if(loginUser != null && bcryptPasswordEncoder.matches(member.getMemPwd(), loginUser.getMemPwd())){
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:/");
		}else {
			mv.addObject("errorMsg","로그인 실패!").setViewName("common/errorPage");
		}

		
		return mv;
	}
	
	
	//로그아웃!!
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginUser");
		return "redirect:/";
	}
}
