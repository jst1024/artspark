package com.kh.artspark.buy.controller;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.artspark.buy.model.service.BuyService;
import com.kh.artspark.buy.model.service.PortoneService;
import com.kh.artspark.buy.model.vo.BuyOption;
import com.kh.artspark.product.model.vo.ProductDetail;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class BuyController {
	
	private final BuyService buyService;
	private final PortoneService portoneService;
	
	// 상품 구매 페이지 포워딩
	@PostMapping("buy")
	public String productBuyForward(int productNo,
							 String productTitle,
							 String memNickname, 
							 String memId, 
							 int totalPrice, 
							 BuyOption buyOption,
							 Model model) {
		
//		log.info("상품번호 : {}", productNo);
//		log.info("상품제목 : {}", productTitle);
//		log.info("닉네임 : {}", memNickname);
//		log.info("아이디 : {}", memId);
//		log.info("구매옵션 : {}", buyOption);
//		log.info("총가격 : {}", totalPrice);
		
		ProductDetail productDetail = buyService.getProductDetail(productNo);
//		log.info("상세옵션 : {}", productDetail);
		
		model.addAttribute("productDetail", productDetail);
		model.addAttribute("productTitle", productTitle);
		model.addAttribute("memId", memId);
		model.addAttribute("memNickname", memNickname);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("buyOption", buyOption);
		
		return "product/productBuy";
	}
	
	// 상품 구매 확인
	@ResponseBody
	@PostMapping(value = "payments/complete", produces="application/json; charset=UTF-8")
	public String paymentInform(String imp_uid, String merchant_uid) throws IOException, InterruptedException {
		
//		HttpRequest request = HttpRequest.newBuilder()
//		    .uri(URI.create("https://api.iamport.kr/payments/"+ imp_uid))
//		    .header("Content-Type", "application/json")
//		    .header("Authorization", accessToken)
//		    .method("GET", HttpRequest.BodyPublishers.ofString("{}"))
//		    .build();
//		HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
//		System.out.println(response.body());
		
		String result = portoneService.getPaymentInfo(imp_uid);
		
//		log.info("토큰 : {}", accessToken);
		log.info("result : {}", result);
		log.info("{}",imp_uid);
		log.info("{}",merchant_uid);
		
		return "";
	}
	
}


















