package com.kh.artspark.notice.controller;


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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.artspark.common.model.vo.ImgFile;
import com.kh.artspark.common.model.vo.PageInfo;
import com.kh.artspark.common.template.PageTemplate;
import com.kh.artspark.notice.model.service.NoticeService;
import com.kh.artspark.notice.model.vo.Notice;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class NoticeController {
	
	private final NoticeService noticeService;
	
	
	/**
	 * 
	 * @param page = 요청 파라미터 page 를 컨트롤러 메서드의 page파라미터에 매핑. 기본값이 1로 작성되어 요청에 page가 없더라도 page가 기본적으로 page=1로 설정된다.
	 * @param model = 요청 처리 후 응답시 requestScope에 값을 담기 위한 객체
	 * @return
	 */
	@GetMapping("/noticelist")
	public String forwarding(@RequestParam(value="page", defaultValue="1") int page, Model model) {
		
		int listCount = noticeService.noticeCount(); 
		int currentPage = page; 
		int pageLimit = 5; 
		int boardLimit = 10;
		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit); 
		int startPage = ((currentPage-1) / pageLimit) * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;;
		
		
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
		
		List<Notice> noticeList = noticeService.noticeFindAll(map);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "notice/noticeList";
	}
		/*
		// 결과를 Map에 담기
		 Map<String, Integer> pageInfo = new HashMap<>();
	        pageInfo.put("listCount", listCount);
	        pageInfo.put("currentPage", currentPage);
	        pageInfo.put("pageLimit", pageLimit);
	        pageInfo.put("boardLimit", noticeLimit);
	        pageInfo.put("maxPage", maxPage);
	        pageInfo.put("startPage", startPage);
	        pageInfo.put("endPage", endPage);
	        pageInfo.put("startValue", startValue);
	        pageInfo.put("endValue", endValue);
	        
	        
	        List<Notice> noticeList = noticeService.noticeFindAll(pageInfo);
	        
	        // 전체 결과를 담을 Map
	        Map<String, Object> result = new HashMap<>();
	        result.put("pageInfo", pageInfo);
	        result.put("noticeList", noticeList);
	        
	        return result;
		*/

	
	/**
	 * 
	 * @param condition = noticeList.jsp에서 입력한 value속성값 : 조건(제목 또는 내용)
	 * @param page = 요청 파라미터 page 를 컨트롤러 메서드의 page파라미터에 매핑. 기본값이 1로 작성되어 요청에 page가 없더라도 page가 기본적으로 page=1로 설정된다.
	 * @param keyword = 검색을 위해 직접 입력한 값
	 * @param model 요청 처리 후 응답시 requestScope에 값을 담기 위한 객체
	 * @return
	 */
	@GetMapping("noticeSearchCount")
	public String noticeSearchCount(String condition, @RequestParam(value="page", defaultValue = "1") int page, String keyword, Model model) {
		
		Map<String, String> map = new HashMap();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		// 검색 결과 수
		int searchCount = noticeService.noticeSearchCount(map);
		//페이지 정보 설정
		int currentPage = page;
		int pageLimit = 5;
		int boardLimit = 10;
		
		//pageTemplate클래스에서 가져와서(get) pageInfo에 담아줌
		PageInfo pageInfo = PageTemplate.getPageInfo(searchCount, currentPage, pageLimit, boardLimit);
		// RowBounds 객체 생성
		RowBounds rowBounds = new RowBounds((currentPage - 1) * boardLimit, boardLimit);
		// 조건과 페이징 정보를 사용하여 공지사항 목록 조회
		List<Notice> noticeList = noticeService.noticeFindByConditionAndKeyword(map, rowBounds);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("keyword", keyword);
		model.addAttribute("condition", condition);
		
		return "notice/noticeList";
	}
	@GetMapping("noticeInsert")
	public String noticeInsert() {
		return "notice/noticeInsert";
	}
	
	@PostMapping("noticeInsert")
	public String insert(Notice notice,
			HttpSession session,
			Model model,
			MultipartFile upfile) { 

		ImgFile imgFile = new ImgFile();
		
		if(
				!upfile.getOriginalFilename().equals("") 
				&& upfile.getOriginalFilename() 
				!= null) 
		{
			imgFile.setOriginName(upfile.getOriginalFilename());
			imgFile.setChangeName(saveFile(upfile, session));
			imgFile.setImgFilePath("resources/uploadFiles/" + imgFile.getChangeName());
			imgFile.setBoardType("공지");
		}

		if(noticeService.insertNotice(notice, imgFile) > 0) {
			session.setAttribute("alertMsg", "게시글 작성 성공~!");
			return "redirect:/noticelist"; // 무조건 리다이렉트 해야함. 	
		}else {
			model.addAttribute("errorMsg", "게시글 작성 실패!");
			return "common/errorPage";
		}	
	}
	
    public String saveFile(MultipartFile upfile, HttpSession session) {
		String originName = upfile.getOriginalFilename();
		String ext = originName.substring(originName.lastIndexOf('.')+1, originName.length());
		
		int num = (int)(Math.random() * 900) + 100; // 날짜형식 뒤에 붙을 난수 값 설정
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); // 시간메서드 날짜형식지정
		
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/"); // 경로 지정

		String changeName = "ArtSpark_" + currentTime + "_" + num + ext; 		// 새로운 파일 명
		try {
			upfile.transferTo(new File(savePath + changeName)); // 파일경로 + 파일이름
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
		return changeName;
	}
    
	// public ModelAndView findByBoardNo(HttpServletRequest request, @RequestParam(value="boardNo") int boardNo) {
	// 리퀘스트서블릿 - 디스패처서블릿에 담아서 보내줌. 리퀘스트파람이란? HTTP 요청 파라미터를 컨트롤러 메서드의 파라미터에 바인딩하는 데 사용됩니다. 주로 GET 요청의 쿼리 스트링이나 POST 요청의 폼 데이터에서 값을 추출할 때 사용됩니다.
	// int abc = Integer.parseInt("123"); // '파싱한다'라고 표현함. 형변환과는 다른개념임. 기본형->참조형(o). 참조형->기본형(x)
    
	//log.info("{}", imgFile);
	//응답화면 지정
    
	//get방식이기때문에 DML(CRUD)이 성공할 수도 있고 실패할 수도 있음. 카운트가 증가되면 상제조회가 되도록.
	// 실패여부 확인
	@GetMapping("noticeDetail")
	public ModelAndView noticeFindById(int noticeNo, ModelAndView mv) {

		Notice notice = noticeService.noticeFindById(noticeNo);
		ImgFile imgFile = noticeService.findImgFileByNoticeNo(noticeNo);
		
		if(notice != null) {
			mv.addObject("notice",notice);
			mv.addObject("imgFile", imgFile);
			mv.setViewName("notice/noticeDetail");	

		} else {
			mv.addObject("errorMsg", "게시글 상세조회에 실패했습니다.").setViewName("common/errorPage");
		}


		return mv;
	}
	
	@PostMapping("deleteNotice")
	public String deleteNotice(int noticeNo, String filePath, HttpSession session, Model model) {
        if (filePath != null && !"".equals(filePath)) {
            // 파일 경로가 존재하는 경우 해당 파일을 삭제
            new File(session.getServletContext().getRealPath(filePath)).delete();
        }
		if (noticeService.deleteNotice(noticeNo) > 0) {
	        session.setAttribute("alertMsg", "게시글 삭제 성공");
	        return "redirect:/noticelist";
	    } else {
	        model.addAttribute("errorMsg", "게시글 삭제 실패");
	        return "common/errorPage";
	    }
	}
	@PostMapping("updateNotice")
	public ModelAndView updateNotice(ModelAndView mv, int noticeNo) {
		mv.addObject("imgFile", noticeService.findImgFileByNoticeNo(noticeNo));
		mv.addObject("notice", noticeService.noticeFindById(noticeNo)).setViewName("notice/noticeUpdate");
		return mv;
	}
	
	@PostMapping("noticeUpdate")
	public String update(Notice notice, HttpSession session, MultipartFile reUpFile, Model model) {
	    ImgFile imgFile = new ImgFile();
	    
	    // 새로운 첨부파일이 존재하는 경우
	    if(!reUpFile.getOriginalFilename().equals("") && reUpFile.getOriginalFilename() != null ) { 
	        
	        String changeName = saveFile(reUpFile, session); // 새로운 파일 저장
	        imgFile.setOriginName(reUpFile.getOriginalFilename());
	        imgFile.setChangeName(changeName);
	        imgFile.setImgFilePath("resources/uploadFiles/" + changeName);
	        imgFile.setBoardNo(notice.getNoticeNo());
	        imgFile.setBoardType("공지");       
	        model.addAttribute("imgFile", imgFile);
	    }
	    if (noticeService.updateNotice(notice, imgFile) > 0) {
	        session.setAttribute("alertMsg", "수정 완료");
	        
	        return "redirect:noticeDetail?noticeNo=" + notice.getNoticeNo();        
	    } else {
	        session.setAttribute("errorMsg", "정보 수정 실패");
	        
	        return "common/errorPage";
	    }
	}
		
}