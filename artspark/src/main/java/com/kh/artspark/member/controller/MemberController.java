package com.kh.artspark.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	
	
	@GetMapping("loginPage")
	public String loginPage() {
	    return "member/login"; // 로그인 페이지의 뷰 이름 반환
	}
	
	//로그인 할때 암호화된 비밀번호도 받아서 확인후 연결(bcrypt로 하고 oauth 방식으로 변경 예정...공부중....)
	@PostMapping("login")
	public ModelAndView login(Member member, ModelAndView mv, HttpSession session) {
	    Member loginUser = memberService.login(member);
	    if(loginUser !=null && bcryptPasswordEncoder.matches(member.getMemPwd(),loginUser.getMemPwd())){
	    //if (loginUser != null && member.getMemPwd().equals(loginUser.getMemPwd())) {
	    	log.info("아이디: {}",loginUser.getMemId());
	    	log.info("비밀번호: {}",loginUser.getMemPwd());
	        if ("D".equals(loginUser.getMemCategory())) {
	            // 블랙리스트 사용자
	            mv.addObject("blacklistUser", true);
	            mv.setViewName("redirect:/");
	        } else {
	            // 정상 사용자
	            session.setAttribute("loginUser", loginUser);
	            mv.setViewName("redirect:/");
	        }
	    } else {
	    	//비밀번호나 아이디 오류
	        mv.addObject("errorMsg", "아이디/비밀번호 오류입니다.!").setViewName("common/errorPage");
	    }
	    
	    return mv;
	}
	

	@GetMapping("updatePage")
	public String upatePage() {
	    return "member/changeInfo"; // 로그인 페이지의 뷰 이름 반환
	}
	
	@PostMapping("update")
	public String update(Member member, HttpSession session, Model model) {
		
		log.info("수정 요청 멤버:{}",member);
	
		// 1 / 0
		if(memberService.update(member) > 0) {
			
			session.setAttribute("loginUser",memberService.login(member));
			session.setAttribute("alertMsg","정보 수정 성공");	
		
			return "redirect:/";
			
		}else {
			model.addAttribute("errorMsg","정보 수정에 실패했습니다.");
			return "common/errorPage";
		}
		
	}
	
	@GetMapping("updateProduct")
	public String upateProduct() {
	    return "member/changeProduct"; // 로그인 페이지의 뷰 이름 반환
	}
	
	@PostMapping("productUpdate")
	public String productUpdate(Member member, HttpSession session, Model model) {
		
		log.info("수정 요청 멤버:{}",member);
	
		// 1 / 0
		if(memberService.update(member) > 0) {
			
			session.setAttribute("loginUser",memberService.login(member));
			session.setAttribute("alertMsg","정보 수정 성공");	
		
		
			return "redirect:/";
			
		}else {
			model.addAttribute("errorMsg","정보 수정에 실패했습니다.");
			return "common/errorPage";
		}
		
	}
	
	
	@GetMapping("joinPage")
	public String joinPage() {
		return "member/join";
	}
	
	@PostMapping("join")
	public String join(Member member, Model model) {
		
		log.info("회원가입 객체 : {}", member);
		String encPwd = bcryptPasswordEncoder.encode(member.getMemPwd());
		member.setMemPwd(encPwd);;
		member.setMemCategory("A");  //회원가입하면 일반회원 카테고리를 가지고 가입한다.
		String viewName ="";
		if(memberService.insert(member) > 0) {//성공 => 메인~
			
			viewName ="redirect:/";
		}else {
			
			model.addAttribute("errorMsg","회원가입실패");
			
			viewName =" common/errorPage";
		}		
			return viewName;

	}
	
	//로그아웃!!
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginUser");
		return "redirect:/";
	}
	
	@ResponseBody
	@GetMapping("idcheck")
	public String checkId(String checkId) {
		return memberService.idCheck(checkId) > 0 ? "ERROR" : "SUCCESS";
	}
	
	
	@GetMapping("findId")
    public Map<String, Object> findId(@RequestParam String memEmail) {
        Map<String, Object> response = new HashMap<>();
        
        String foundId = memberService.findId(memEmail);
        
        if (foundId != null) {
            response.put("success", true);
            response.put("id", foundId);
        } else {
            response.put("success", false);
            response.put("errorMsg", "해당 이메일로 등록된 아이디가 없습니다.");
        }
        return response;
    }
	
}
