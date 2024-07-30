

package com.kh.artspark.member.controller;


import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.artspark.member.model.service.MemberService;
import com.kh.artspark.member.model.vo.Artist;
import com.kh.artspark.member.model.vo.BuyOption;
import com.kh.artspark.member.model.vo.Interest;
import com.kh.artspark.member.model.vo.Mail;
import com.kh.artspark.member.model.vo.Member;
import com.kh.artspark.member.model.vo.OrderBuyOption;

import com.kh.artspark.qna.model.service.QnaService;
import com.kh.artspark.qna.model.vo.ProductQna;
import com.kh.artspark.qna.model.vo.Qna;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MemberController {
	
	private final MemberService memberService;
	private final BCryptPasswordEncoder bcryptPasswordEncoder;
	private final JavaMailSender sender;
	private final QnaService qnaService; // QnaService 주입
	
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
	
	//일반회원 정보 수정
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
	
	//판매자 정보수정
	@GetMapping("updateProduct")
	public String updateProduct(HttpSession session, Model model) {
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    if (loginUser != null) {
	        loginUser.setMemCategory("B");
	        
	        // 데이터베이스 업데이트
	        if (memberService.update(loginUser) > 0) {
	            // 세션 업데이트
	            session.setAttribute("loginUser", loginUser);
	            
	            Artist artist = memberService.getArtist(loginUser.getMemId());
	            model.addAttribute("loginUser", loginUser);
	            model.addAttribute("artist", artist);
	            log.info("artist : {}", artist);
	            log.info("Updated loginUser : {}", loginUser);
	        } else {
	            // 업데이트 실패 처리
	            model.addAttribute("errorMsg", "판매자로 변경하는데 실패했습니다.");
	            return "common/errorPage";
	        }
	    }
	    return "member/changeProduct";
	}
	
	@PostMapping("productUpdate")
	public String productUpdate(@ModelAttribute Artist artist,
	                            @ModelAttribute Member member,
	                            @RequestParam("profileImage") MultipartFile file,
	                            HttpSession session,
	                            Model model) {
	    


	    // 파일 업로드 처리
	    if (!file.isEmpty()) {
	        try {
	            // 파일 저장 경로 설정
	            String uploadPath = session.getServletContext().getRealPath("/resources/uploadFiles/");
	            
	            // 원본 파일명
	            String originalFileName = file.getOriginalFilename();
	            
	            // 새로운 파일명 생성 및 저장
	            String newFileName = saveFile(file, session);
	            
	            // 파일 저장
	            File destFile = new File(uploadPath + newFileName);
	            file.transferTo(destFile);
	            
	            // Artist 객체에 파일 정보 설정
	            artist.setArtistOriginName(originalFileName);
	            artist.setArtistChangeName(newFileName);
	            artist.setArtistPath("/resources/uploadFiles/" + newFileName);
	            
	            log.info("artist2: {}", artist);
	            
	            // model에 artist 추가 (JSP 페이지로 전달)
	            model.addAttribute("artist", artist);
	            
	        } catch (IOException e) {
	            log.error("파일 업로드 실패", e);
	            model.addAttribute("errorMsg", "파일 업로드에 실패했습니다.");
	            return "common/errorPage";
	        }
	    }

	    // Member 정보 업데이트
	    int memberUpdateResult = memberService.updateMember(member);
	    
	    // Artist 정보 업데이트 또는 삽입
	    int artistResult = memberService.insertOrUpdateArtist(artist);
	    
	    if (memberUpdateResult > 0 && artistResult > 0) {
	        // 세션 업데이트
	        Member updatedMember = memberService.getMemberById(member.getMemId());
	        session.setAttribute("loginUser", updatedMember);
	        session.setAttribute("alertMsg", "정보 수정 성공");
	        return "redirect:/";
	    } else {
	        model.addAttribute("errorMsg", "정보 수정에 실패했습니다.");
	        return "common/errorPage";
	    }
	}

	public String saveFile(MultipartFile upfile, HttpSession session) {
	    
	    String originName = upfile.getOriginalFilename();
	    String ext = originName.substring(originName.lastIndexOf('.') + 1);
	    
	    int num = (int) (Math.random() * 900) + 100;
	    String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	    
	    String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
	    
	    String changeName = "ARTSPARK_" + currentTime + "_" + num + "." + ext;
	    
	    try {
	        upfile.transferTo(new File(savePath + changeName));
	    } catch (IOException e) {
	        log.error("파일 업로드 실패", e);
	        // 예외 처리
	    }
	    
	    return changeName;
	}

	//회원가입
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
	
	//아이디 체크
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
	
	//비밀번호 찾기 
	@GetMapping("lostPwd")
	public String lostPwd() {
		return "member/lostPwd";
	}


	//비밀번호 수정
	@ResponseBody
	@PostMapping(value = "changePwd", produces = "text/html; charset=UTF-8")
	public String changePwd(Member member, String changePwd) {
	    member.setMemPwd(bcryptPasswordEncoder.encode(changePwd));
	    return memberService.changePwd(member) > 0 ? "SUCCESS" : "ERROR";
	}
	
	//회원탈퇴
	@PostMapping("delete")
	public String delete(@RequestParam("memPwd") String memPwd, Model model, HttpSession session) {
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    String encPwd =bcryptPasswordEncoder.encode(memPwd);
	    
	    if (bcryptPasswordEncoder.matches(memPwd, encPwd)) {
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

	//주문관리로 이동
	@GetMapping("orderManage")
	public String ordermanage() {
		return "member/orderManage";
	}
	
	@GetMapping("orderHistory")
	public String orderHistory(HttpSession session, Model model) {
	    Member member = (Member)session.getAttribute("loginUser");
	    List<OrderBuyOption> orderBuyOptions = memberService.orderBuyOption(member.getMemId());
	    
	    // 각 주문의 총 금액 계산하기
	    for (OrderBuyOption order : orderBuyOptions) {
	        int totalAmount = 0;
	        for (BuyOption option : order.getBuyOptionList()) {
	            totalAmount += option.getBuyOptionPrice() * option.getBuyOptionAmount();
	        }
	        order.setTotalAmount(totalAmount);
	    }
	    
	    model.addAttribute("orderBuyOptions", orderBuyOptions);
	    
	    log.info("주문 내역: {}", orderBuyOptions);
	    
	    return "member/orderManage";  // 주문 내역 페이지로 이동
	}
	
	//관심 판매자
	@GetMapping("interestPage")
	public String interestPage() {
		return "member/interest";
	}
	
	@GetMapping("interestSeller")
	public String interestSeller(HttpSession session, Model model) {
		Member member = (Member)session.getAttribute("loginUser");
		List<Interest> interestThing = memberService.interest(member.getMemId()); 
		
		model.addAttribute("interestThing", interestThing);
		log.info("관심: {} ", interestThing);
		
		
		return "member/interest";
	}
	
	// 마이페이지
	@GetMapping("myPage")
	public String myPage(HttpSession session, Model model) {
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "redirect:/loginPage"; // 로그인 페이지로 리다이렉트
	    }

	    // 내가 작성한 문의 목록 조회
	    List<Qna> myQna = qnaService.getMyQna(loginUser.getMemId());
	    model.addAttribute("myQna", myQna);

	    // 내가 작성한 상품 문의 목록 조회
	    List<ProductQna> myProductQna = qnaService.getMyProductQna(loginUser.getMemId());
	    model.addAttribute("myProductQna", myProductQna);

	    // 내 상품에 등록된 문의 목록 조회
	    List<ProductQna> receivedProductQna = qnaService.getReceivedProductQna(loginUser.getMemId());
	    model.addAttribute("receivedProductQna", receivedProductQna);

	    return "member/myPage";
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}


