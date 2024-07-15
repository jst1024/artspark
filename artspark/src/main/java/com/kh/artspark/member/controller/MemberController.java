package com.kh.artspark.member.controller;

import java.text.Format;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.artspark.member.model.service.MemberService;
import com.kh.artspark.member.model.vo.Mail;
import com.kh.artspark.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MemberController {
	
	private final MemberService memberService;
	private final BCryptPasswordEncoder bcryptPasswordEncoder;
	private final JavaMailSender sender;
	
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
	
	@GetMapping("lostPwd")
	public String lostPwd() {
		return "member/lostPwd";
	}

	//비밀번호 찾기 -- 수정중...
	/*
	@ResponseBody
    @PostMapping(value = "findPwd", produces = "text/html; charset=UTF-8")
    public String findPwd(String memId, String memEmail, String newPwd, Model model) {
        Member member = memberService.findByMemIdAndEmail(memId, memEmail);

        if (member == null) {
            return "USER_NOT_FOUND";
        }

        String encodedNewPwd = bcryptPasswordEncoder.encode(newPwd);
        member.setMemPwd(encodedNewPwd);

        boolean updateResult = memberService.updatePwd(member);

        if (updateResult) {
            return "SUCCESS";
        } else {
            return "UPDATE_FAILED";
        }
    }
    */
	//비밀번호 수정
	@ResponseBody
	@PostMapping(value = "changePwd", produces = "text/html; charset=UTF-8")
	public String changePwd(Member member, String changePwd) {
	    member.setMemPwd(bcryptPasswordEncoder.encode(changePwd));
	    return memberService.changePwd(member) > 0 ? "SUCCESS" : "ERROR";
	}
	
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
	
	
	//메일 전송
	@GetMapping("mailInput")
	public String forwardInputForm() {
		return "mail/input";
	}
	
	//메일로 비밀번호 받고 새롭게 로그인
	@ResponseBody
	@PostMapping("auth-mail")
	public String authMailService(@RequestParam("memId") String memId, @RequestParam("memNickname") String memNickname, @RequestParam("memEmail") String memEmail, HttpServletRequest request) throws MessagingException {
	    Member member = memberService.getMember(memId, memNickname, memEmail);
	    
	    if (member == null) {
	        return "error";
	    }
	    
	    String remoteAddr = request.getRemoteAddr();
	    
	    // 새로운 임시 비밀번호 생성
	    String newPassword = createPwd();
	    
	    // 임시 비밀번호 암호화
	    String encryptedPassword = bcryptPasswordEncoder.encode(newPassword);
	    
	    // 회원 정보 업데이트
	    member.setMemPwd(encryptedPassword);
	    memberService.updatePassword(member);
	    
	    Mail mail = Mail.builder().who(remoteAddr).code(newPassword).build();
	    
	    int result = memberService.sendMail(mail);
	    
	    MimeMessage message = sender.createMimeMessage();
	    MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
	    
	    helper.setTo(memEmail);
	    helper.setSubject("[artSpark] 새로운 비밀번호가 발급되었습니다.");
	    helper.setText("새로운 비밀번호: " + newPassword + "\n로그인 후 반드시 비밀번호를 변경해주세요.");
	    
	    sender.send(message);
	    
	    return "success";
	}

	private String createPwd() {
	    // 임시 비밀번호를 원하는 방식으로 생성하는 코드 작성 (예: 난수 생성)
	    // 여기서는 간단하게 랜덤한 8자리 숫자를 생성하는 예시를 보여줍니다.
		String numbers = "0123456789";
	    Random random = new Random();
	    StringBuilder Pwd = new StringBuilder();
	    
	    for (int i = 0; i < 4; i++) {
	        int index = random.nextInt(numbers.length());
	        Pwd.append(numbers.charAt(index));
	    }
	    return Pwd.toString();
	}




}


