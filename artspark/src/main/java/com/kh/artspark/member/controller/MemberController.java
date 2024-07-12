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
	
	

	@GetMapping("lostId")
	public String lostId() {
		return "member/lostId";
	}
	
	//아이디 찾기
	@PostMapping("findId")
    public String findId(@RequestParam("memNickname") String memNickname,@RequestParam("memEmail") String memEmail,Model model) {
		//닉네임,이메일 값을 받아서 비교 후 맞으면 아이디 찾기를 모달 창으로 띄운다.
        Map<String, String> params = new HashMap<>();
        params.put("memNickname", memNickname);
	    params.put("memEmail", memEmail);
	    String foundId = memberService.findId(params);
        if (foundId != null) {
        	log.info("아이디 찾기 : {}",foundId);
            model.addAttribute("foundId", foundId);
        } else {
        	log.info("오류 : {}",foundId);
            model.addAttribute("errorMessage", "찾는 아이디가 없습니다.");
        }
        
        return "member/findId";
    }
	
	//비밀번호 찾기 -- 수정중...
    /*
	@ResponseBody
	@PostMapping(value = "findPwd", produces = "text/html; charset=UTF-8")
    public String findPwd(Member member, String memPwd,Model model) {
        Member loginUser = memberService.login(member);

        if (loginUser == null) {
            return "USER_NOT_FOUND";
        }

        if (bcryptPasswordEncoder.matches(member.getMemPwd(), loginUser.getMemPwd())) {
            String encodedNewPwd = bcryptPasswordEncoder.encode(memPwd);

            
            member.setMemPwd(encodedNewPwd);
            
            boolean updateResult = memberService.updatePwd(memPwd);
            
            if (updateResult) {
            	model.addAttribute("alertMsg","비밀번호 변경에 성공했습니다.");
                return memberService.updatePwd(encodedNewPwd) > 0 ? "SUCCESS" : "ERROR";
            } else {
            	model.addAttribute("alretMsg","비밀번호 변경에 실패했습니다.");
                return "common/errorPage";
            }
        } else {
        	model.addAttribute("errorMsg","비밀번호를 다시 입력해주세요.");
            return  "redirect:/";
        }
    }
	
	*/
	//비밀번호 수정
	
	//회원탈퇴
	@PostMapping("delete")
	public String delete(@RequestParam("memPwd") String inputPwd, Model model, HttpSession session) {
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    String encPwd = loginUser.getMemPwd();
	    
	    if (bcryptPasswordEncoder.matches(inputPwd, encPwd)) {
	        if (memberService.delete(loginUser.getMemId()) > 0) {
	            session.setAttribute("alertMsg", "회원이 탈퇴되었습니다.");
	            session.removeAttribute("loginUser");
	            return "redirect:/";
	        } else {
	            model.addAttribute("errorMsg", "회원탈퇴에 실패했습니다.");
	            return "common/errorPage";
	        }
	    } else {
	        model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
	        return "redirect:/updatePage";  // 회원 정보 수정 페이지로 리다이렉트
	    }
	}
}


