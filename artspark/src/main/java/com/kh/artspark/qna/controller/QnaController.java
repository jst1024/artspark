package com.kh.artspark.qna.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.common.model.vo.PageInfo;
import com.kh.artspark.common.template.PageTemplate;
import com.kh.artspark.member.model.vo.Member;
import com.kh.artspark.qna.model.service.QnaService;
import com.kh.artspark.qna.model.vo.Answer;
import com.kh.artspark.qna.model.vo.ProductAnswer;
import com.kh.artspark.qna.model.vo.ProductQna;
import com.kh.artspark.qna.model.vo.Qna;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class QnaController {
	
	private final QnaService qnaService;
	
	@GetMapping("/qnalist")
	public String forwarding(@RequestParam(value="page", defaultValue="1") int page, Model model) {
		int listCount = qnaService.qnaCount(); 
		int currentPage = page;
		int pageLimit = 5;
		int boardLimit = 10;
		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit); // 가장 마지막 페이지가 몇 번 페이지인지(총 페이지의 개수)
		int startPage = ((currentPage-1) / pageLimit) * pageLimit + 1; // 그 화면상 하단에 보여질 페이징바의 시작하는 페이지넘버
		int endPage = startPage + pageLimit - 1;; // 그 화면상 하단에 보여질 페이징바의 끝나는 페이지넘버
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pageInfo = PageInfo.builder()
				.listCount(listCount)
				.currentPage(currentPage)
				.pageLimit(pageLimit)
				.boardLimit(boardLimit)
				.maxPage(maxPage)
				.startPage(startPage)
				.endPage(endPage)
				.build(); 
		
		Map<String,Integer> map = new HashMap<>();
		int startValue = (currentPage - 1) * boardLimit + 1;
		int endValue = startValue + boardLimit - 1;
		
		map.put("startValue", startValue);
		map.put("endValue", endValue);
		
		List<Qna> qnaList = qnaService.qnaFindAllWithAnswers(map);
		
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("pageInfo", pageInfo);
		return "qna/qnaList";
	}
	
	@GetMapping("qnaSearchCount")
	public String qnaSearchCount(String condition, @RequestParam(value="page", defaultValue = "1") int page, String keyword, Model model) {
		Map<String, String> map = new HashMap<>();
		map.put("condition", condition);	
		map.put("keyword", keyword);
		
		int searchCount = qnaService.qnaSearchCount(map);
		int currentPage = page;
		int pageLimit = 5;
		int boardLimit = 10;
		
		PageInfo pageInfo = PageTemplate.getPageInfo(searchCount, currentPage, pageLimit, boardLimit);
		RowBounds rowBounds = new RowBounds((currentPage - 1) * boardLimit, boardLimit);

		List<Qna> qnaList = qnaService.qnaFindConditionAndKeyword(map, rowBounds);
		
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("keyword", keyword);
		model.addAttribute("condition", condition);
		
		return "qna/qnaList";
	}

	@GetMapping("qnaInsert")
	public String qnaInsert() {
		return "qna/qnaInsert";
	}
	
	@PostMapping("qnaInsert")
	public String insert(Qna qna, HttpSession session, Model model, MultipartFile upfile) { 
		ImgFile imgFile = new ImgFile();
		
		if (!upfile.getOriginalFilename().equals("") && upfile.getOriginalFilename() != null) {
		    imgFile.setOriginName(upfile.getOriginalFilename());
		    imgFile.setChangeName(saveFile(upfile, session));
		    imgFile.setImgFilePath("resources/uploadFiles/" + imgFile.getChangeName());
		    imgFile.setBoardType("문의");
		}

		if (qna.getSecret() == null || qna.getSecret().isEmpty()) {
		    qna.setSecret("N");
		}

		if (qnaService.insertQna(qna, imgFile) > 0) {
		    session.setAttribute("alertMsg", "게시글 작성 성공~!");
		    return "redirect:/qnalist";
		} else {
		    model.addAttribute("errorMsg", "게시글 작성 실패!");
		    return "common/errorPage";
		}
	}
	public String saveFile(MultipartFile upfile, HttpSession session) {
		String originName = upfile.getOriginalFilename();
		String ext = originName.substring(originName.lastIndexOf('.')+1);
		
		int num = (int) (Math.random() * 900) + 100;
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		String changeName = "ARTSPARK_" + currentTime + "_" + num + "." + ext;
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}
	
	@GetMapping("qnaDetail")
	public ModelAndView qnaFindById(int qnaNo, ModelAndView mv) {
		Qna qna = qnaService.qnaFindById(qnaNo);
		ImgFile imgFile = qnaService.findImgFileByQnaNo(qnaNo);
		if(qna != null) {
			mv.addObject("qna", qna);
			mv.addObject("imgFile", imgFile);
			mv.setViewName("qna/qnaDetail");
		} else {
			mv.addObject("errorMsg", "게시글 상세조회에 실패했습니다.").setViewName("common/errorPage");
		}
		return mv;
	}
	
	@PostMapping("deleteQna")
	public String deleteQna(int qnaNo, String filePath, HttpSession session, Model model) {
		if (filePath != null && !"".equals(filePath)) {
			new File(session.getServletContext().getRealPath(filePath)).delete();
		}
		if(qnaService.deleteQna(qnaNo) > 0) {
	        session.setAttribute("alertMsg", "게시글 삭제 성공");
	        return "redirect:/qnalist";
	    } else {
	        model.addAttribute("errorMsg", "게시글 삭제 실패");
	        return "common/errorPage";
	    }
	}
	@PostMapping("updateQna")
	public ModelAndView updateQna(ModelAndView mv, int qnaNo) {
		mv.addObject("imgFile", qnaService.findImgFileByQnaNo(qnaNo))
		  .addObject("qna", qnaService.qnaFindById(qnaNo)).setViewName("qna/qnaUpdate");
		return mv;
	}
	@PostMapping("qnaUpdate")
	public String qnaUpdate(Qna qna, HttpSession session, MultipartFile reUpFile, Model model) {
	    ImgFile imgFile = new ImgFile();
	    
	    if(!reUpFile.getOriginalFilename().equals("")) {
	        String changeName = saveFile(reUpFile, session);
	        imgFile.setOriginName(reUpFile.getOriginalFilename());
	        imgFile.setChangeName(changeName);
	        imgFile.setImgFilePath("resources/uploadFiles/" + changeName);
	        imgFile.setBoardNo(qna.getQnaNo());
	        imgFile.setBoardType("문의");
	        model.addAttribute("imgFile", imgFile);
	    }

	    if (qnaService.updateQna(qna, imgFile) > 0) {
	        session.setAttribute("alertMsg", "수정 완료");
	        return "redirect:qnaDetail?qnaNo=" + qna.getQnaNo();
	    } else {
	        session.setAttribute("errorMsg", "정보 수정 실패");
	        return "common/errorPage";
	    }
	}
	@GetMapping("answerInsert")
	public String answerInsert() {
		return "qna/answerInsert";
	}

	@PostMapping("insertAnswer")
	public String insertAnswer(Answer answer, HttpSession session, Model model, MultipartFile upfile, @RequestParam int qnaNo) { 
	    ImgFile imgFile = new ImgFile();
	    
	    if (!upfile.getOriginalFilename().equals("") && upfile.getOriginalFilename() != null) {
	        imgFile.setOriginName(upfile.getOriginalFilename());
	        imgFile.setChangeName(saveFile(upfile, session));
	        imgFile.setImgFilePath("resources/uploadFiles/" + imgFile.getChangeName());
	        imgFile.setBoardType("답변");
	    }
	    if (qnaService.insertAnswer(answer, imgFile) > 0) {
	        session.setAttribute("alertMsg", "답변 작성 성공~!");
	        return "redirect:/qnalist";
	    } else {
	        model.addAttribute("errorMsg", "게시글 작성 실패!");
	        return "common/errorPage";
	    }
	}
	@GetMapping("answerDetail")
	public ModelAndView getAnswerDetail(@RequestParam int answerNo, ModelAndView mv) {
	    Answer answer = qnaService.findAnswerById(answerNo); // 답변을 조회하는 메서드
	    ImgFile imgFile = qnaService.findImgFileByAnswerNo(answerNo); // 답변에 첨부된 이미지 파일 조회

	    if (answer != null) {
	        mv.addObject("answer", answer);
	        mv.addObject("imgFile", imgFile);
	        mv.setViewName("qna/answerDetail");
	    } else {
	        mv.addObject("errorMsg", "답변 상세조회에 실패했습니다.").setViewName("common/errorPage");
	    }
	    return mv;
	}
	
	/*
    @GetMapping("myAdminQna")
    public String showAdminQna() {
        return "qna/myAdminQna";
    }

    @GetMapping("myProductQna")
    public String showProductQna() {
        return "qna/myProductQna";
    }

    @GetMapping("myReceivedQna")
    public String showReceivedQna() {
        return "qna/myReceivedQna";
    }
	*/
	
	
	// 마이페이지에서의 답변
    @GetMapping("getAnswerDetail")
    @ResponseBody
    public Answer getAnswerDetail(@RequestParam int answerNo) {
        Answer answer = qnaService.findAnswerById(answerNo);
        return answer;
    }
	
	// 판매자 문의
    @GetMapping("artistQna")
    public String showArtistQna(@RequestParam("productNo") int productNo, Model model) {
        model.addAttribute("productNo", productNo);
        return "product/productQna";
    }
    @PostMapping("artistQna")
    public String submitProductQna(ProductQna productQna, HttpSession session) {
        if (qnaService.insertProductQna(productQna) > 0) {
            session.setAttribute("alertMsg", "문의가 성공적으로 등록되었습니다.");
            return "redirect:/product/" + productQna.getProductNo();
        } else {
            session.setAttribute("errorMsg", "문의 등록 실패!");
            return "common/errorPage";
        }
    }
    // 판매자문의-답변
    @GetMapping("productAnswerInsert")
    public String productAnswerInsert(@RequestParam int qnaNo, Model model) {
        model.addAttribute("qnaNo", qnaNo);
        return "qna/productAnswer";
    }

    // 판매자 답변 등록
    @PostMapping("productInsertAnswer")
    public String productInsertAnswer(ProductAnswer productAnswer, HttpSession session, Model model) {
        
        Member loginUser = (Member) session.getAttribute("loginUser");
        
        if (loginUser == null) {
            return "redirect:/loginPage"; // 로그인 페이지로 리다이렉트
        }

        productAnswer.setMemId(loginUser.getMemId());

        if (qnaService.insertProductAnswer(productAnswer) > 0) {
            session.setAttribute("alertMsg", "답변 작성 성공~!");
            return "redirect:/myPage";
        } else {
            model.addAttribute("errorMsg", "답변 작성 실패!");
            return "common/errorPage";
        }
    }
}
