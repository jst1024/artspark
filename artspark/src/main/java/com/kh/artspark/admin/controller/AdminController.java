package com.kh.artspark.admin.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.artspark.common.model.vo.PageInfo;
import com.kh.artspark.member.model.service.MemberService;
import com.kh.artspark.notice.model.service.NoticeService;
import com.kh.artspark.notice.model.vo.Notice;
import com.kh.artspark.request.model.service.RequestService;
import com.kh.artspark.request.model.vo.Request;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

    private final NoticeService noticeService;
    private final MemberService memberService;
    private final RequestService requestService;
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

}
