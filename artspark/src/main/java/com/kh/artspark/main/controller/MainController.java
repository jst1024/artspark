package com.kh.artspark.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
public class MainController {

    private final NoticeService noticeService;
    private final RequestService requestService;
    private final MemberService memberService;
    
    @GetMapping("/")
    public String mainPage(@RequestParam(value="page", defaultValue="1") int page, Model model) {
        // 공지사항 설정
        int noticeListCount = noticeService.noticeCount();
        PageInfo noticePageInfo = getPageInfo(noticeListCount, page, 5, 3);
        Map<String, Integer> noticeMap = getPageMap(noticePageInfo);
        List<Notice> noticeList = noticeService.noticeFindAll(noticeMap);

        // 의뢰 설정
        int requestListCount = requestService.requestCount();
        PageInfo requestPageInfo = getPageInfo(requestListCount, page, 5, 3);
        Map<String, Integer> requestMap = getPageMap(requestPageInfo);
        List<Request> requestList = requestService.requestFindAll(requestMap);

        // 인기 작가 설정
        List<Map<String, Object>> popularWriters = memberService.getPopularWriters();

        // 모델에 데이터 추가
        model.addAttribute("noticeList", noticeList);
        model.addAttribute("noticePageInfo", noticePageInfo);
        model.addAttribute("requestList", requestList);
        model.addAttribute("requestPageInfo", requestPageInfo);
        model.addAttribute("popularWriters", popularWriters);

        return "main"; // main.jsp로 포워딩
    }


    private PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
        int maxPage = (int)Math.ceil((double)listCount / boardLimit);
        int startPage = ((currentPage - 1) / pageLimit) * pageLimit + 1;
        int endPage = startPage + pageLimit - 1;

        if (endPage > maxPage) {
            endPage = maxPage;
        }

        return PageInfo.builder()
                .listCount(listCount)
                .currentPage(currentPage)
                .pageLimit(pageLimit)
                .boardLimit(boardLimit)
                .maxPage(maxPage)
                .startPage(startPage)
                .endPage(endPage)
                .build();
    }

    private Map<String, Integer> getPageMap(PageInfo pageInfo) {
        Map<String, Integer> map = new HashMap<>();
        int startValue = (pageInfo.getCurrentPage() - 1) * pageInfo.getBoardLimit() + 1;
        int endValue = startValue + pageInfo.getBoardLimit() - 1;

        map.put("startValue", startValue);
        map.put("endValue", endValue);

        return map;
    }
}
