package com.kh.artspark.buy.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.kh.artspark.buy.model.service.BuyService;
import com.kh.artspark.buy.model.service.PortoneService;
import com.kh.artspark.buy.model.vo.Buy;
import com.kh.artspark.buy.model.vo.BuyOption;
import com.kh.artspark.buy.model.vo.Payment;
import com.kh.artspark.common.model.vo.Message;
import com.kh.artspark.member.model.vo.Member;
import com.kh.artspark.product.model.vo.Product;
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
							 Model model) throws IOException, InterruptedException {
		
//		log.info("상품번호 : {}", productNo);
//		log.info("상품제목 : {}", productTitle);
//		log.info("닉네임 : {}", memNickname);
//		log.info("아이디 : {}", memId);
//		log.info("구매옵션 : {}", buyOption);
//		log.info("총가격 : {}", totalPrice);
		
		ProductDetail productDetail = buyService.getProductDetail(productNo);
//		log.info("상세옵션 : {}", productDetail);
		
		String merchant_uid = "as-" + new Date().getTime();
		log.info("{}",merchant_uid);
		
		JsonObject preparePayment = portoneService.setPreparePayment(merchant_uid, totalPrice);
		log.info("{}",preparePayment);
		
		merchant_uid = preparePayment.get("merchant_uid").getAsString();
		int amount = preparePayment.get("amount").getAsInt();
		
		log.info("{}",merchant_uid);
		log.info("{}",amount);
		
		model.addAttribute("merchant_uid", merchant_uid);
		model.addAttribute("productDetail", productDetail);
		model.addAttribute("productTitle", productTitle);
		model.addAttribute("memId", memId);
		model.addAttribute("memNickname", memNickname);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("buyOption", buyOption);
		
		return "product/productBuy";
	}
	
	// 상품 구매 확인 및 저장
	@ResponseBody
	@PostMapping(value = "payments/complete", produces="application/json; charset=UTF-8")
	public ResponseEntity<Message> paymentInform(String imp_uid, String merchant_uid, 
				int productNo, String paymentRequest, 
				@RequestParam(value="buyOptionName[]") String[] buyOptionName, 
				@RequestParam(value="buyDetailOptionName[]") String[] buyDetailOptionName, 
				@RequestParam(value="buyOptionPrice[]") int[] buyOptionPrice, 
				@RequestParam(value="buyOptionAmount[]") int[] buyOptionAmount, 
				HttpSession session) throws IOException, InterruptedException {
		
		// 결제내역 단건 조회 결과
		JsonObject buyResult = portoneService.getPaymentInfo(imp_uid);
		
		// 결제 가격 조작 판별
		if(buyResult == null) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
																			 .message("결제 금액 조작")
																			 .build());
		}
		
//		log.info("{}",buyOptionName[0]);
//		log.info("{}",buyOptionName[1]);
//		log.info("{}",buyDetailOptionName);
//		log.info("{}",buyOptionPrice);
//		log.info("{}",buyOptionAmount);
//		log.info("{}",paymentRequest);
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		// 결제 성공 후 결제정보 db 저장
		Map<String, Object> map = new HashMap<String, Object>();
		
		Buy buy = Buy.builder().buyNo(merchant_uid)
							   .memId(loginUser.getMemId())
							   .productNo(productNo)
							   .build();
		
		Payment payment = Payment.builder().buyNo(merchant_uid)
										   .paymentMethod(buyResult.get("pay_method").getAsString())
										   .paymentName(buyResult.get("buyer_name").getAsString())
										   .paymentPhone(buyResult.get("buyer_tel").getAsString())
										   .paymentEmail(buyResult.get("buyer_email").getAsString())
										   .paymentRequest(paymentRequest)
										   .build();
		
		List<Map<String, Object>> buyOptionList = new ArrayList<Map<String, Object>>();

		for(int i=0; i<buyOptionName.length; i++) {
			Map<String, Object> buyOption = new HashMap<String, Object>();
			buyOption.put("buyOptionName", buyOptionName[i]);
			buyOption.put("buyDetailOptionName", buyDetailOptionName[i]);
			buyOption.put("buyOptionPrice", buyOptionPrice[i]);
			buyOption.put("buyOptionAmount", buyOptionAmount[i]);
			buyOption.put("buyNo", merchant_uid);
			
			buyOptionList.add(buyOption);
		}
		
		
		int result = buyService.insertBuyInfo(buy, payment, buyOptionList);
		
		if(result <= 2) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
																			 .message("결제 정보 등록 실패")
																			 .build());
		}
		
		Message responseMsg = Message.builder().message("결제 성공!!")
											   .build();
		
		return ResponseEntity.status(HttpStatus.OK).body(responseMsg);
	}
	
	
	// 결제 완료 페이지
	// payment, product_detail, artist, 
	@PostMapping("buyComplete")
	public String buyComplete(int productNo, String merchant_uid, String productTitle, 
							String memNickname, int totalPrice, Model model, HttpSession session) {

		ProductDetail productDetail = buyService.getProductDetail(productNo);
		
		Payment payment = buyService.getPayment(merchant_uid);
		
		List<Map<String, Object>> buyOptionList = buyService.getBuyOption(merchant_uid);
//		log.info("{}", buyOptionList);
		
		// 상품 구매 완료 시 구매자와 판매자의 채팅방 생성
		Member member = (Member) session.getAttribute("loginUser");
		String loginUserId = member.getMemId();
		String seller = buyService.getSeller(productNo);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("loginUserId", loginUserId);
		map.put("seller", seller);
		map.put("chatroomActive", "Y");
		map.put("workStatus", "시작");
		map.put("myReadStatus", "N");
		map.put("yourReadStatus", "N");
		
		int result = buyService.createChatroom(map);
		if(result == 0) {
			model.addAttribute("errorMsg", "채팅방 생성 실패");
			return "error/errorPage";
		}
		
		session.setAttribute("alertMsg", "결제 완료 및 채팅방 생성");
		model.addAttribute("productNo", productNo);
		model.addAttribute("productTitle", productTitle);
		model.addAttribute("memNickname", memNickname);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("productDetail", productDetail);
		model.addAttribute("payment", payment);
		model.addAttribute("buyOptionList", buyOptionList);
		
		return "product/productComplete";
	}
	
}


















