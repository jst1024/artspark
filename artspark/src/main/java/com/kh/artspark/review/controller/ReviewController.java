package com.kh.artspark.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.artspark.common.model.vo.Message;
import com.kh.artspark.common.model.vo.PageInfo;
import com.kh.artspark.common.template.PageTemplate;
import com.kh.artspark.review.model.service.ReviewService;
import com.kh.artspark.review.model.vo.Review;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("review")
public class ReviewController {

	private final ReviewService reviewService;
	
	@ResponseBody
	@GetMapping("buy-product")
	public ResponseEntity<Message> buyProduct(Model model, String loginUserId, int productNo) {
		
//		log.info("{}", loginUserId);
//		log.info("{}", productNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("loginUserId",loginUserId);
		map.put("productNo", productNo);
		
		// 구매기록이 있으면 1, 없으면 0 반환
		int result = reviewService.buyRecord(map);
		
		Message responseMsg = null;
		
		if(result > 0) {
			responseMsg = Message.builder().message("구매 기록 있음")
										   .data("Y")
										   .build();
		} else {
			responseMsg = Message.builder().message("구매 기록 없음")
					   .data("N")
					   .build();
		}
		
		return ResponseEntity.ok(responseMsg);
	}
	
	@PostMapping("insert-form")
	public String insertForm(int productNo, String productTitle, Model model) {
		
//		log.info("{}",loginUserId);
//		log.info("{}", productNo);
		
		model.addAttribute("productNo", productNo);
		model.addAttribute("productTitle", productTitle);
		
		return "review/reviewInsert";
	}
	
	@PostMapping("review-insert")
	public String reviewInsert(Review review, HttpSession session, Model model) {
		
//		log.info("review : {}", review);
		
		int result = reviewService.insertReview(review);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "리뷰 등록 성공");
		}
		else {
			session.setAttribute("alertMsg", "리뷰 등록 실패");
		}
		
		return "redirect:../product/" + review.getProductNo();
	}
	
	@ResponseBody
	@GetMapping
	public ResponseEntity<Message> reviewList(int productNo, 
											  @RequestParam(value = "page", defaultValue = "1") int page) {
		int listCount = reviewService.reviewCount(productNo);
		int currentPage = page;
		int pageLimit = 5;
		int boardLimit = 5;
		
		PageInfo pageInfo = PageTemplate.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		RowBounds rowBounds = new RowBounds((currentPage - 1) * boardLimit, boardLimit);

		List<Review> reviewList = reviewService.findReviewList(productNo, rowBounds);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reviewList", reviewList);
		map.put("pageInfo", pageInfo);
		
		Message responseMsg = Message.builder().message("리뷰 리스트")
											   .data(map)
											   .build();
		
		return ResponseEntity.ok(responseMsg);
	}
	
	@ResponseBody
	@DeleteMapping("/{reviewNo}")
	public ResponseEntity<Message> deleteReview(@PathVariable("reviewNo") int reviewNo) {
		
		int result = reviewService.deleteReview(reviewNo);

		Message responseMsg = null;
		if(result > 0) {
			responseMsg = Message.builder().message("리뷰가 삭제되었습니다.")
										   .data(result)
										   .build();
		} else {
			responseMsg = Message.builder().message("리뷰 삭제에 실패하였습니다.")
										   .data(result)
										   .build();
		}
		
		return ResponseEntity.ok(responseMsg);
	}
}

















