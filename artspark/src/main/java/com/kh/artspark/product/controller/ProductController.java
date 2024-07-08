package com.kh.artspark.product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.artspark.common.model.vo.Message;
import com.kh.artspark.member.model.vo.Member;
import com.kh.artspark.product.model.service.ProductService;
import com.kh.artspark.product.model.vo.Product;
import com.kh.artspark.product.model.vo.ProductDetail;
import com.kh.artspark.product.model.vo.ProductForm;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/product")
public class ProductController {
	
	private final ProductService productService;
	
	// 상품 목록 전체 조회
	@GetMapping
	public String findAllProductList(HttpSession session, Model model) {
		
		// 찜테이블에 있는 멤버아이디와 로그인유저의 아이디를 비교하기위함 
//		if(session.getAttribute("loginUser") != null) {
//			Member loginUser = (Member) session.getAttribute("loginUser");
//			List<Map<String, Object>> productList = productService.findAllProductList(loginUser.getMemId());
//			model.addAttribute("productList", productList);
//			return "product/productList";
//		}
		
		List<Map<String, Object>> productList = productService.findAllProductList("");
		model.addAttribute("productList", productList);
		
		return "product/productList";
	}

	// 찜 등록
	@ResponseBody
	@PostMapping(value="jjim/{pno}", produces = "application/json; charset=UTF-8")
	public ResponseEntity<Message> insertHeart(@PathVariable String pno, HttpSession session) {
		
		int productNo = Integer.parseInt(pno);
		Member loginUser = (Member) session.getAttribute("loginUser");
		String loginId = loginUser.getMemId();
		
		Map<String, Object> map = new HashMap<>();
		map.put("loginId", loginId);
		map.put("productNo", productNo);
		
		if(productService.insertJjim(map) == 0) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
																			 .message("찜 등록 요청 실패")
																			 .build()); 
		}
		
		Message responseMsg = Message.builder().message("찜 목록에 추가되었습니다.")
											   .build();
		
		return ResponseEntity.status(HttpStatus.OK).body(responseMsg);
	}
	
	// 찜 삭제
	@ResponseBody
	@DeleteMapping(value="jjim/{pno}", produces = "application/json; charset=UTF-8")
	public ResponseEntity<Message> deleteHeart(@PathVariable String pno, HttpSession session) {
		
		int productNo = Integer.parseInt(pno);
		Member loginUser = (Member) session.getAttribute("loginUser");
		String loginId = loginUser.getMemId();
		
		Map<String, Object> map = new HashMap<>();
		map.put("loginId", loginId);
		map.put("productNo", productNo);
		
		if(productService.deleteJjim(map) == 0) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
																			 .message("찜 삭제 요청 실패")
																			 .build()); 
		}
		
		Message responseMsg = Message.builder().message("찜 목록에서 삭제되었습니다.")
											   .build();
		
		return ResponseEntity.status(HttpStatus.OK).body(responseMsg);
	}
	
	// 상품 상세 페이지
	@GetMapping("/{pno}")
	public ModelAndView detail(@PathVariable String pno, HttpSession session , ModelAndView mv) {
		
		int productNo = Integer.parseInt(pno);
		
		Map<String, Object> map = new HashMap<>();
		
		if(session.getAttribute("loginUser") != null) {
			Member member = (Member) session.getAttribute("loginUser");
			String loginId = member.getMemId();
			map.put("loginId", loginId);
			map.put("productNo", productNo);
		} else {
			map.put("loginId", "");
			map.put("productNo", productNo);
		}
		
		Map<String, Object> product = productService.findById(map);
		
//		log.info("PayOption: {}", product.get("payOptionList"));
		
		mv.addObject("product", product).setViewName("product/productDetail");
		
		return mv;
	}
	
	
	// 상품 등록
	@PostMapping
	public String insertProduct(Product product,
								ProductDetail productDetail,
								ProductForm productForm,
								String productPurpose1,
								String productPurpose2,
								String tags,
								MultipartFile mainImage1,
								MultipartFile mainImage2,
								MultipartFile mainImage3,
								Model model) {
		
		log.info("입력 정보 : {}", product);
		log.info("입력 정보 : {}", productDetail);
		log.info("입력 정보 : {}", productForm);
		log.info("입력 정보 : {}", tags);
		log.info("입력 정보 : {}", productPurpose1);
		log.info("입력 정보 : {}", productPurpose2);
//		log.info("사진1 : {}", mainImage1);
//		log.info("사진2 : {}", mainImage2);
//		log.info("사진3 : {}", mainImage3);
		
		String productPurpose = "";
		if(productPurpose1 != null && productPurpose2 != null) {
			productPurpose = productPurpose1 + " / " + productPurpose2;
		} else if(productPurpose1 != null && productPurpose2 == null) {
			productPurpose = productPurpose1;
		} else {
			productPurpose = productPurpose2;
		}
		
		productDetail.setProductPurpose(productPurpose);
		
		String[] tagArray = tags.split("#");
		List<String> tagList = new ArrayList<>();
		
		for(String s : tagArray) {
			if(!s.trim().isEmpty()) {
				tagList.add(s);
			}
		}
		
		int result = productService.insertProduct(product, productDetail, productForm, tagList);
		
		return "";
	}
	
}

















