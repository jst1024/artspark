package com.kh.artspark.admin.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.artspark.banner.model.service.BannerService;
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
    private final BannerService bannerService;
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
    public String bannerList(Model model) {
        List<Map<String, Object>> bannerList = bannerService.getAllBanners();
        model.addAttribute("bannerList", bannerList);
        log.info("배너리스트 {}", bannerList);
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

    @ResponseBody
    @GetMapping("/ajaxSuspendedMemberList")
    public Map<String, Object> suspendedMemberList(@RequestParam(value = "page", defaultValue = "1") int page) {

        int listCount = memberService.suspendedMemberCount();
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

        List<Map<String, Object>> suspendedMemberList = memberService.suspendedMemberList(map);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Map<String, Object>> formattedSuspendedMemberList = new ArrayList<>();

        for (Map<String, Object> member : suspendedMemberList) {
            Map<String, Object> formattedMember = new HashMap<>();
            formattedMember.put("memId", member.get("memId"));
            
            if (member.get("memSuspension") != null) {
                formattedMember.put("memSuspension", sdf.format(member.get("memSuspension")));
            } else {
                formattedMember.put("memSuspension", "N/A");
            }
            
            formattedMember.put("reportCategory", member.get("reportCategory"));
            formattedMember.put("memReportcount", member.get("memReportcount"));
            formattedSuspendedMemberList.add(formattedMember);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("suspendedMemberList", formattedSuspendedMemberList);
        result.put("pageInfo", pageInfo);

        return result;
    }

    @ResponseBody
    @PostMapping("/updateMemberStatus")
    public Map<String, Object> updateMemberStatus(@RequestBody Map<String, String> request) {
        String memberId = request.get("memberId");
        String newStatus = request.get("status");
        
        Map<String, Object> response = new HashMap<>();
        try {
            int result = memberService.updateMemberStatus(memberId, newStatus);
            if (result > 0) {
                response.put("message", "정지상태가 성공적으로 변경되었습니다.");
            } else {
                response.put("message", "정지상태 변경에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("message", "정지상태 변경 중 오류가 발생했습니다.");
        }
        return response;
    }

    @ResponseBody
    @GetMapping("/ajaxMemberList")
    public Map<String, Object> getMemberListAjax(@RequestParam(value = "page", defaultValue = "1") int page) {
        int listCount = memberService.memberCount();
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

        List<Member> memberList = memberService.memberList(map);

        Map<String, Object> result = new HashMap<>();
        result.put("memberList", memberList);
        result.put("pageInfo", pageInfo);

        return result;
    }

    @ResponseBody
    @GetMapping("/ajaxDeletedProducts")
    public Map<String, Object> getDeletedProducts(@RequestParam(value = "page", defaultValue = "1") int page) {
        int listCount = productService.deletedProductCount();
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

        log.info("Fetching deleted products for page: {}, endValue: {}", page, endValue);
        List<Product> deletedProductList = productService.deletedProductFindAll(map);
        log.info("Fetched deleted products: {}", deletedProductList);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Map<String, Object>> formattedDeletedProductList = new ArrayList<>();

        for (Product product : deletedProductList) {
            if (product != null) {
                Map<String, Object> formattedProduct = new HashMap<>();
                formattedProduct.put("productNo", product.getProductNo());
                formattedProduct.put("productTitle", product.getProductTitle());
                formattedProduct.put("productDate", sdf.format(product.getProductDate()));
                formattedProduct.put("memId", product.getMemId());
                formattedDeletedProductList.add(formattedProduct);
            }
        }

        Map<String, Object> result = new HashMap<>();
        result.put("deletedProductList", formattedDeletedProductList);
        result.put("pageInfo", pageInfo);

        return result;
    }

    @ResponseBody
    @PostMapping("/updateProductStatus")
    public Map<String, Object> updateProductStatus(@RequestBody Map<String, String> request) {
        String productNo = request.get("productNo");
        String newStatus = request.get("status");

        Map<String, Object> response = new HashMap<>();
        try {
            int result = productService.updateProductStatus(productNo, newStatus);
            if (result > 0) {
                response.put("message", "상품 상태가 성공적으로 변경되었습니다.");
            } else {
                response.put("message", "상품 상태 변경에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("message", "상품 상태 변경 중 오류가 발생했습니다.");
        }
        return response;
    }
    
}
