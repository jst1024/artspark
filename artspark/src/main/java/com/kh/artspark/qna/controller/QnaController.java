package com.kh.artspark.qna.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.artspark.common.model.vo.PageInfo;
import com.kh.artspark.common.template.PageTemplate;
import com.kh.artspark.qna.model.service.QnaService;
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
		
		List<Qna> qnaList = qnaService.qnaFindAll(map);
		
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("pageInfo", pageInfo);
		log.info("{}", qnaList);
		log.info("{}", listCount);
		return "qna/qnaList";
	}
	
	@GetMapping("qnaSearchCount")
	public String qnaSearchCount(String condition, @RequestParam(value="page", defaultValue = "1") int page, String keyword, Model model) {
		
		log.info(" 검색 조건 : {}", condition);
		log.info(" 검색 키워드 : {}", keyword);
		

		//map에 담기
		Map<String, String> map = new HashMap();
		map.put("condition", condition);	
		map.put("keyword", keyword);
		// service로
		
		int searchCount = qnaService.qnaSearchCount(map);
		// log.info("검색 조건에 부합하는 행의 수 : {}", searchCount);
		int currentPage = page;
		int pageLimit = 5;
		int boardLimit = 10;
		
		//pageTemplate클래스에서 가져와서(get) pageInfo에 담아줌
		PageInfo pageInfo = PageTemplate.getPageInfo(searchCount, currentPage, pageLimit, boardLimit);
		
		// offset(몇번 건너뛰고 가져갈 것인지 엑셀에서의 offset을 생각x ex. offset 4 => 50개를 조회하고 앞에 40를 제외하고 나머지를 들고간다.)
		RowBounds rowBounds = new RowBounds((currentPage - 1) * boardLimit, boardLimit);

		
		List<Qna> qnaList = qnaService.qnaFindConditionAndKeyword(map, rowBounds);
		log.info("{}", qnaList);
		log.info("{}", searchCount);
		
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("keyword", keyword);
		model.addAttribute("condition", condition);
		
		return "qna/qnaList";
	}
}
