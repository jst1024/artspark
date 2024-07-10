package com.kh.artspark.notice.controller;


import java.io.File;
import java.io.IOException;
import java.sql.Date;
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
	
	@GetMapping("/noticelist")
	public String forwarding(@RequestParam(value="page", defaultValue="1") int page, Model model) {
		
		int listCount = noticeService.noticeCount(); // 공지사항 게시글 총 개수 => NOTICE테이블로부터 SELECT COUNT(*)활용해서 조회
		int currentPage = page; // 현재페이지(사용자가 요청한 페이지)
		int pageLimit = 5; // 페이지 하단에 보여질 페이징바의 최대 개수 => 5개로 고정 
		int boardLimit = 10; // 한 페이지에 보여질 게시글의 최대 개수 => 10개로 고정
		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit); // 가장 마지막 페이지가 몇 번 페이지인지(총 페이지의 개수)
		int startPage = ((currentPage-1) / pageLimit) * pageLimit + 1; // 그 화면상 하단에 보여질 페이징바의 시작하는 페이지넘버
		int endPage = startPage + pageLimit - 1;; // 그 화면상 하단에 보여질 페이징바의 끝나는 페이지넘버
		
		/* 총 페이지
		 *   1. listCount를 double로 변환
		 *   2. listCount / noticeLimit => 만약 소숫점으로 떨어진다면
		 *   3. Math.ceil()을 이용해서 결과를 올림처리
		 *   4. 결과값을 int로 형 변환
		 */
		
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
				.build(); // 각각의 필드에 객체를 담아서 빌드 (순서에 상관이 없다는 특징이 있다.)
		
		
		Map<String,Integer> map = new HashMap();
		
		int startValue = (currentPage - 1) * boardLimit + 1;
		int endValue = startValue + boardLimit - 1;
		
		map.put("startValue", startValue);
		map.put("endValue", endValue);
		
		List<Notice> noticeList = noticeService.noticeFindAll(map);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageInfo", pageInfo);
		
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
		return "notice/noticeList";
		}
	@GetMapping("noticeSearchCount")
	public String noticeSearchCount(String condition, @RequestParam(value="page", defaultValue = "1") int page, String keyword, Model model) {
		
		//log.info(" 검색 조건 : {}", condition);
		//log.info(" 검색 키워드 : {}", keyword);
		
		//map에 담기
		Map<String, String> map = new HashMap();
		map.put("condition", condition);
		map.put("keyword", keyword);
		// service로
		
		int searchCount = noticeService.noticeSearchCount(map);
		// log.info("검색 조건에 부합하는 행의 수 : {}", searchCount);
		int currentPage = page;
		int pageLimit = 5;
		int boardLimit = 10;
		
		//pageTemplate클래스에서 가져와서(get) pageInfo에 담아줌
		PageInfo pageInfo = PageTemplate.getPageInfo(searchCount, currentPage, pageLimit, boardLimit);
		
		// offset(몇번 건너뛰고 가져갈 것인지 엑셀에서의 offset을 생각x ex. offset 4 => 50개를 조회하고 앞에 40를 제외하고 나머지를 들고간다.)
		RowBounds rowBounds = new RowBounds((currentPage - 1) * boardLimit, boardLimit);

		
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
		
//		log.info("{}",upfile);
		
		if(!upfile.getOriginalFilename().equals("")) {
			
			 saveFile(upfile, session); 
			 
			// 첨부파일이 존재하면.
			// 1. 업로드 완료
			// 2. Board객체에 originName + changeName에 담아줘야한다.
			
			imgFile.setOriginName(upfile.getOriginalFilename());
			imgFile.setChangeName(saveFile(upfile, session));
			imgFile.setImgFilePath("resources/uploadFiles/" + imgFile.getChangeName());
			imgFile.setBoardType("공지");
		}
		
		log.info("{}", imgFile.getChangeName());
		
		//첨부파일이 존재하지 않을 경우 board : 제목 / 내용 / 작성자
		// 첨부파일이 존재할 경우 board : 제목 / 내용 / 작성자 / 원봉명 / 변경된 경로와 이름
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
		
		String ext = originName.substring(originName.lastIndexOf("."));
		// "abc.ddd.txt" => 뒤에 . 기준
		
		int num = (int)(Math.random() * 900) + 100; // 값의 범위를 곱한다. 그런뒤에 시작값을 더해준다.
		// Math.random() : 0.0 ~ 0.9999999....
		
		// 시간메서드
		// log.info("currentTime : {}", new Date());
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date(num));
		
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
	@GetMapping("noticeDetail")
	public ModelAndView noticeFindById(int noticeNo, ModelAndView mv) {
		// public ModelAndView findByBoardNo(HttpServletRequest request, @RequestParam(value="boardNo") int boardNo) {
		// 리퀘스트서블릿 - 디스패처서블릿에 담아서 보내줌. 리퀘스트파람이란? HTTP 요청 파라미터를 컨트롤러 메서드의 파라미터에 바인딩하는 데 사용됩니다. 주로 GET 요청의 쿼리 스트링이나 POST 요청의 폼 데이터에서 값을 추출할 때 사용됩니다.
		// int abc = Integer.parseInt("123"); // '파싱한다'라고 표현함. 형변환과는 다른개념임. 기본형->참조형(o). 참조형->기본형(x)
		Notice notice = noticeService.noticeFindById(noticeNo);
		ImgFile imgFile = noticeService.findImgFileByNoticeNo(noticeNo);
		log.info("{}", imgFile);
		if(notice != null) {
		mv.addObject("notice",notice);
		mv.addObject("imgFile", imgFile);
		mv.setViewName("notice/noticeDetail");	
		//응답화면 지정
		} else {
				mv.addObject("errorMsg", "게시글 상세조회에 실패했습니다.").setViewName("common/errorPage");
		}
		//get방식이기때문에 DML(CRUD)이 성공할 수도 있고 실패할 수도 있음. 카운트가 증가되면 상제조회가 되도록.
		// 실패여부 확인

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
	@PostMapping("noticeUpdate")
	public ModelAndView noticeUpdate(ModelAndView mv, int noticeNo) {
		mv.addObject("notice", noticeService.noticeFindById(noticeNo)).setViewName("notice/noticeUpdate");
		return mv;
	}
	/*
	@PostMapping("noticeUpdate")
	public String update(Notice notice, HttpSession session, MultipartFile reUpFile) {
		
		
		 * -> boardTitle, boardContent
		 * + reUpfile
		 * 
		 * 1. 기존 첨부파일X, 새로운 첨부파일x => 그렇구나~ 더 할게 없음.
		 * 2. 기존 첨부파일O, 새로운 첨부파일x => ORIGIN : 기존 첨부파일 이름, CHANGE : 기존 첨부파일 경로 (기존 파일이 날라갈 수 있음.)
		 * 3. 기존 첨부파일X, 새로운 첨부파일O => ORIGIN : 새로운 첨부파일 이름, CHANGE : 새로운 첨부파일 경로
		 * 4. 기존 첨부파일O, 새로운 첨부파일O => ORIGIN : 새로운 첨부파일 이름, CHANGE : 새로운 첨부파일 경로 
		 * 
		 
		if(!reUpFile.getOriginalFilename().equals("")) { // 빈문자열과 같지 않으면 (새로운 첨부파일이 있다.)
			board.setOriginName(reUpFile.getOriginalFilename());
			board.setChangeName(saveFile(reUpFile, session));
		}
		// 담은 값을 notice까지
		if(noticeService.update(board)>0) {
			session.setAttribute("alertMsg", "수정완료");
			return "redirect:noticeDetail?noticeNo=" + notice.getnoticeNo();
		}else {
			session.setAttribute("errorMsg", "정보수정 실패");
			return "common/errorPage";
		}
	}	
	*/
		
}
	

