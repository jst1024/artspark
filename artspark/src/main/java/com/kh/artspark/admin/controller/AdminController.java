package com.kh.artspark.admin.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.artspark.common.model.vo.PageInfo;
import com.kh.artspark.member.model.service.MemberService;
import com.kh.artspark.member.model.vo.Member;
import com.kh.artspark.notice.model.service.NoticeService;
import com.kh.artspark.notice.model.vo.Notice;
import com.kh.artspark.product.model.service.ProductService;
import com.kh.artspark.product.model.vo.Product;
import com.kh.artspark.qna.model.service.QnaService;
import com.kh.artspark.qna.model.vo.Qna;
import com.kh.artspark.request.model.service.RequestService;
import com.kh.artspark.request.model.vo.Request;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

	private final ProductService productService;
    private final NoticeService noticeService;
    private final MemberService memberService;
    private final RequestService requestService;
    private final QnaService qnaService;
    private final BCryptPasswordEncoder bcryptPasswordEncoder;

    @GetMapping
    public String adminPage() {
        return "admin/adminPage";
    }

    @GetMapping("/memberManagement")
    public String memberManagement() {
        return "admin/memberManagement";
    }

    @GetMapping("/boardManagement")
    public String boardManagement() {
        return "admin/boardManagement";
    }

    @GetMapping("/bannerSettings")
    public String bannerSettings() {
        return "admin/bannerSettings";
    }

    @ResponseBody
    @GetMapping("/ajaxNoticeManagement")
    public Map<String, Object> getNoticeListAjax(@RequestParam(value = "page", defaultValue = "1") int page) {
        int listCount = noticeService.noticeCount();
        int currentPage = page;
        int pageLimit = 5;
        int boardLimit = 5;

        int maxPage = (int) Math.ceil((double) listCount / boardLimit);
        int startPage = ((currentPage - 1) / pageLimit) * pageLimit + 1;
        int endPage = startPage + pageLimit - 1;

        if (endPage > maxPage) {
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

        Map<String, Integer> map = new HashMap<>();

        int startValue = (currentPage - 1) * boardLimit + 1;
        int endValue = startValue + boardLimit - 1;

        map.put("startValue", startValue);
        map.put("endValue", endValue);

        List<Notice> noticeList = noticeService.noticeFindAll(map);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Map<String, Object>> formattedNoticeList = new ArrayList<>();
        
        for (Notice notice : noticeList) {
            Map<String, Object> formattedNotice = new HashMap<>();
            formattedNotice.put("noticeNo", notice.getNoticeNo());
            formattedNotice.put("noticeTitle", notice.getNoticeTitle());
            formattedNotice.put("noticeDate", sdf.format(notice.getNoticeDate()));
            formattedNotice.put("memId", notice.getMemId() != null ? notice.getMemId() : "admin");
            formattedNoticeList.add(formattedNotice);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("noticeList", formattedNoticeList);
        result.put("pageInfo", pageInfo);

        return result;
    }

    @ResponseBody
    @GetMapping("/ajaxRequestManagement")
    public Map<String, Object> getRequestListAjax(@RequestParam(value = "page", defaultValue = "1") int page) {
        int listCount = requestService.requestCount();
        int currentPage = page;
        int pageLimit = 5;
        int boardLimit = 5;

        int maxPage = (int) Math.ceil((double)listCount / boardLimit);
        int startPage = ((currentPage - 1) / pageLimit) * pageLimit + 1;
        int endPage = startPage + pageLimit - 1;

        if (endPage > maxPage) {
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

        Map<String, Integer> map = new HashMap<>();
        int startValue = (currentPage - 1) * boardLimit + 1;
        int endValue = startValue + boardLimit - 1;

        if (endValue > listCount) {
            endValue = listCount;
        }

        map.put("startValue", startValue);
        map.put("endValue", endValue);

        List<Request> requestList = requestService.requestFindAll(map);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Map<String, Object>> formattedRequestList = new ArrayList<>();

        for (Request request : requestList) {
            Map<String, Object> formattedRequest = new HashMap<>();
            formattedRequest.put("reqNo", request.getReqNo());
            formattedRequest.put("reqTitle", request.getReqTitle());
            formattedRequest.put("reqDate", sdf.format(request.getReqDate()));
            formattedRequest.put("memId", request.getMemId() != null ? request.getMemId() : "admin");
            formattedRequestList.add(formattedRequest);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("requestList", formattedRequestList);
        result.put("pageInfo", pageInfo);

        return result;
    }


    
    @ResponseBody
    @GetMapping("/ajaxProductManagement")
    public Map<String, Object> getProductListAjax(@RequestParam(value = "page", defaultValue = "1") int page) {
    	int listCount = productService.productAllCount();
    	int currentPage = page;
    	int pageLimit = 5;
    	int boardLimit = 5;
    	
    	int maxPage = (int) Math.ceil((double) listCount / boardLimit);
    	int startPage = ((currentPage - 1) / pageLimit) * pageLimit + 1;
    	int endPage = startPage + pageLimit - 1;
    	
    	if (endPage > maxPage) {
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
    	
    	Map<String, Integer> map = new HashMap<>();
    	
    	int startValue = (currentPage - 1) * boardLimit + 1;
    	int endValue = startValue + boardLimit - 1;
    	
    	map.put("startValue", startValue);
    	map.put("endValue", endValue);
    	
    	List<Product> productList = productService.productFindAll(map);
    	
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	List<Map<String, Object>> formattedProductList = new ArrayList<>();
    	
    	for (Product product : productList) {
    		Map<String, Object> formattedProduct = new HashMap<>();
    		formattedProduct.put("productNo", product.getProductNo());
    		formattedProduct.put("productTitle", product.getProductTitle());
    		formattedProduct.put("productDate", sdf.format(product.getProductDate()));
    		formattedProduct.put("memId", product.getMemId());
    		formattedProductList.add(formattedProduct);
    	}
    	
    	Map<String, Object> result = new HashMap<>();
    	result.put("productList", formattedProductList);
    	result.put("pageInfo", pageInfo);
    	
    	return result;
    }

    @ResponseBody
    @GetMapping("/ajaxQnaManagement")
    public Map<String, Object> getQnaListAjax(@RequestParam(value = "page", defaultValue = "1") int page) {

        int listCount = qnaService.qnaCount(); 
        int currentPage = page; // 현재페이지(사용자가 요청한 페이지)
        int pageLimit = 5; // 페이지 하단에 보여질 페이징바의 최대 개수 => 5개로 고정 
        int boardLimit = 5; // 한 페이지에 보여질 게시글의 최대 개수 => 5개로 고정

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

        Map<String, Integer> map = new HashMap<>();

        int startValue = (currentPage - 1) * boardLimit + 1;
        int endValue = startValue + boardLimit - 1;

        map.put("startValue", startValue);
        map.put("endValue", endValue);

        List<Qna> qnaList = qnaService.qnaFindAllWithAnswers(map);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Map<String, Object>> formattedQnaList = new ArrayList<>();

        for (Qna qna : qnaList) {
            Map<String, Object> formattedQna = new HashMap<>();
            formattedQna.put("qnaNo", qna.getQnaNo());
            formattedQna.put("qnaTitle", qna.getQnaTitle());
            formattedQna.put("qnaDate", sdf.format(qna.getQnaDate()));
            formattedQna.put("memId", qna.getMemId());
            formattedQnaList.add(formattedQna);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("qnaList", formattedQnaList);
        result.put("pageInfo", pageInfo);

        return result;
    }

}
