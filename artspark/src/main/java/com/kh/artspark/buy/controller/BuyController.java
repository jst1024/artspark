package com.kh.artspark.buy.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.artspark.buy.model.service.BuyService;
import com.kh.artspark.buy.model.vo.BuyOption;
import com.kh.artspark.product.model.vo.ProductDetail;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("buy")
public class BuyController {
	
	private final BuyService buyService;
	
	@PostMapping
	public String productBuy(int productNo,
							 String productTitle,
							 String memNickname, 
							 String memId, 
							 int totalPrice, 
							 BuyOption buyOption,
							 Model model) {
		
		log.info("상품번호 : {}", productNo);
		log.info("상품제목 : {}", productTitle);
		log.info("닉네임 : {}", memNickname);
		log.info("아이디 : {}", memId);
		log.info("구매옵션 : {}", buyOption);
		log.info("총가격 : {}", totalPrice);
		
		ProductDetail productDetail = buyService.getProductDetail(productNo);
		log.info("상세옵션 : {}", productDetail);
		
		model.addAttribute("productDetail", productDetail);
		model.addAttribute("memId", memId);
		model.addAttribute("memNickname", memNickname);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("buyOption", buyOption);
		
		return "product/productBuy";
	}
	
}


















