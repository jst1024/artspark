package com.kh.artspark.request.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.text.SimpleDateFormat;
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

import com.google.gson.Gson;
import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.common.model.vo.PageInfo;
import com.kh.artspark.common.template.PageTemplate;
import com.kh.artspark.request.model.service.RequestService;
import com.kh.artspark.request.model.vo.Reply;
import com.kh.artspark.request.model.vo.Request;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class RequestController {
	
	private final RequestService requestService;
	
	@GetMapping("/requestlist")
	public String forwarding(@RequestParam(value="page", defaultValue="1") int page, Model model) {
		
		int listCount = requestService.requestCount(); // 공지사항 게시글 총 개수 => NOTICE테이블로부터 SELECT COUNT(*)활용해서 조회
		int currentPage = page; // 현재페이지(사용자가 요청한 페이지)
		int pageLimit = 5; // 페이지 하단에 보여질 페이징바의 최대 개수 => 5개로 고정 
		int boardLimit = 10; // 한 페이지에 보여질 게시글의 최대 개수 => 10개로 고정
		
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
		
		Map<String,Integer> map = new HashMap();
		
		int startValue = (currentPage - 1) * boardLimit + 1;
		int endValue = startValue + boardLimit - 1;
		
		map.put("startValue", startValue);
		map.put("endValue", endValue);
		
		List<Request> requestList = requestService.requestFindAll(map);
		
		model.addAttribute("requestList", requestList);
		model.addAttribute("pageInfo", pageInfo);
		//log.info("{}", requestList);
		//log.info("{}", listCount);
		return "request/requestList";
	
	}
	
	@GetMapping("requestSearchCount")
	public String requestSearchCount(String condition, String category, @RequestParam(value="page", defaultValue = "1") int page, String keyword, Model model) {
		
		//log.info(" 검색 조건 : {}", condition);
		//log.info(" 검색 카테고리 : {}", category);
		//log.info(" 검색 키워드 : {}", keyword);
		
		
		
		//map에 담기
		Map<String, String> map = new HashMap();
		map.put("condition", condition);
		map.put("category", category);		
		map.put("keyword", keyword);
		// service로
		
		int searchCount = requestService.requestSearchCount(map);
		// log.info("검색 조건에 부합하는 행의 수 : {}", searchCount);
		int currentPage = page;
		int pageLimit = 5;
		int boardLimit = 10;
		
		//pageTemplate클래스에서 가져와서(get) pageInfo에 담아줌
		PageInfo pageInfo = PageTemplate.getPageInfo(searchCount, currentPage, pageLimit, boardLimit);
		
		// offset(몇번 건너뛰고 가져갈 것인지 엑셀에서의 offset을 생각x ex. offset 4 => 50개를 조회하고 앞에 40를 제외하고 나머지를 들고간다.)
		RowBounds rowBounds = new RowBounds((currentPage - 1) * boardLimit, boardLimit);

		
		List<Request> requestList = requestService.requestFindConditionAndKeyword(map, rowBounds);
		//log.info("{}", requestList);
		//log.info("{}", searchCount);
		
		model.addAttribute("requestList", requestList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("keyword", keyword);
		model.addAttribute("condition", condition);
		model.addAttribute("category", category);
		
		return "request/requestList";
	}
	@GetMapping("requestInsert")
	public String requestInsert() {
		return "request/requestInsert";
	}
	
	@PostMapping("requestInsert")
	public String insert(Request request,
			HttpSession session,
			Model model,
			MultipartFile upfile) { 

		ImgFile imgFile = new ImgFile();
		
//		log.info("{}",upfile);
		
		if(!upfile.getOriginalFilename().equals("") && upfile.getOriginalFilename() != null) {
			
			imgFile.setOriginName(upfile.getOriginalFilename());
			imgFile.setChangeName(saveFile(upfile, session));
			imgFile.setImgFilePath("resources/uploadFiles/" + imgFile.getChangeName());
			imgFile.setBoardType("의뢰");
		}
		
		log.info("{}", imgFile.getChangeName());
		
		//첨부파일이 존재하지 않을 경우 board : 제목 / 내용 / 작성자
		// 첨부파일이 존재할 경우 board : 제목 / 내용 / 작성자 / 원봉명 / 변경된 경로와 이름
		if(requestService.insertRequest(request, imgFile) > 0) {
			session.setAttribute("alertMsg", "게시글 작성 성공~!");
			return "redirect:/requestlist"; // 무조건 리다이렉트 해야함. 
		
		}else {
			model.addAttribute("errorMsg", "게시글 작성 실패!");
			return "common/errorPage";
		}
	}
	public String saveFile(MultipartFile upfile, HttpSession session) {
			
		String originName = upfile.getOriginalFilename();
		
		String ext = originName.substring(originName.lastIndexOf(".") + 1, originName.length());
		// "abc.ddd.txt" => 뒤에 . 기준
		
		int num = (int)(Math.random() * 900) + 100; // 값의 범위를 곱한다. 그런뒤에 시작값을 더해준다.
		// Math.random() : 0.0 ~ 0.9999999....
		
		// 시간메서드
		// log.info("currentTime : {}", new Date());
		
		String currentTime = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); // 작성일에도 영향을 미침
		
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/"); // /가 없으면 파일이 들어가지 않는다.
		// 새로운 파일 명
		String changeName = "ArtSpark" + currentTime + "_" + num + ext;
		
		try {
			upfile.transferTo(new File(savePath + changeName)); // 파일경로 + 파일이름
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}
	@GetMapping("requestDetail")
	public ModelAndView requestFindById(int reqNo, ModelAndView mv) {
		//log.info("{}", reqNo);
		Request request = requestService.requestFindById(reqNo);
		ImgFile imgFile = requestService.findImgFileByReqNo(reqNo);
		if(requestService.increaseCount(reqNo) > 0) {
		mv.addObject("request",request);
		mv.addObject("imgFile", imgFile);
		mv.setViewName("request/requestDetail");	
		//응답화면 지정
		} else {
				mv.addObject("errorMsg", "게시글 상세조회에 실패했습니다.").setViewName("common/errorPage");
		}
		//get방식이기때문에 DML(CRUD)이 성공할 수도 있고 실패할 수도 있음. 카운트가 증가되면 상제조회가 되도록.
		// 실패여부 확인

		return mv;
	}
	@PostMapping("deleteRequest")
	public String deleteRequest(int reqNo, String filePath, HttpSession session, Model model) {
        if (filePath != null && !"".equals(filePath)) {
            // 파일 경로가 존재하는 경우 해당 파일을 삭제
            new File(session.getServletContext().getRealPath(filePath)).delete();
        }
		if (requestService.deleteRequest(reqNo) > 0) {
	        session.setAttribute("alertMsg", "게시글 삭제 성공");
	        return "redirect:/requestlist";
	    } else {
	        model.addAttribute("errorMsg", "게시글 삭제 실패");
	        return "common/errorPage";
	    }
	}
	
	@PostMapping("updateRequest")
	public ModelAndView updateRequest(ModelAndView mv, int reqNo) {
		mv.addObject("imgFile", requestService.findImgFileByReqNo(reqNo))
		  .addObject("request", requestService.requestFindById(reqNo)).setViewName("request/requestUpdate");
		return mv;
	}
	
	@PostMapping("requestUpdate")
	public String requestUpdate(Request request, HttpSession session, MultipartFile reUpFile, Model model) {
	    ImgFile imgFile = new ImgFile();
	    
	    // 새로운 첨부파일이 존재하는 경우
	    if(!reUpFile.getOriginalFilename().equals("")) { // 빈문자열과 같지 않으면 (새로운 첨부파일이 있다.)
	        // 새로운 파일 저장
	        String changeName = saveFile(reUpFile, session);
	        imgFile.setOriginName(reUpFile.getOriginalFilename());
	        imgFile.setChangeName(changeName);
	        imgFile.setImgFilePath("resources/uploadFiles/" + changeName);
	        imgFile.setBoardNo(request.getReqNo());
	        imgFile.setBoardType("의뢰");
	        
	        //log.info("{}", request);
	        //log.info("{}", imgFile);
	       
	        model.addAttribute("imgFile", imgFile);
	    }

	    if (requestService.updateRequest(request, imgFile) > 0) {
	        session.setAttribute("alertMsg", "수정 완료");
	        return "redirect:requestDetail?reqNo=" + request.getReqNo();
	    } else {
	        session.setAttribute("errorMsg", "정보 수정 실패");
	        return "common/errorPage";
	    }
	}
	
	@GetMapping("reqReply")
	public Request requestAndReply(int reqNo) {
		return requestService.requestAndReply(reqNo);
	}
	
	@ResponseBody
	@GetMapping(value="reply", produces="application/json; charset=UTF-8")
	public String selectReply(int reqNo) {
		return new Gson().toJson(requestService.selectReply(reqNo));	
	}
	
	@ResponseBody
	@PostMapping("reply")
	public String saveReply(Reply reply) {
		return requestService.insertReply(reply) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@PostMapping("/deleteReply")
	public String deleteReply(@RequestParam("replyNo") int replyNo) {
	    //log.info("{}", replyNo);
	    int result = requestService.deleteReply(replyNo);
	    return result > 0 ? "success" : "fail";
	}
	
}
