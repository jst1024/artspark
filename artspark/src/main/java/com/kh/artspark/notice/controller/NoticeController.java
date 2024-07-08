package com.kh.artspark.notice.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.artspark.common.model.vo.PageInfo;
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
	}
	

