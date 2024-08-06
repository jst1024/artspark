package com.kh.artspark.buy.model.service;

import java.util.List;
import java.util.Map;

import com.kh.artspark.buy.model.vo.Buy;
import com.kh.artspark.buy.model.vo.Payment;
import com.kh.artspark.product.model.vo.Product;
import com.kh.artspark.product.model.vo.ProductDetail;

public interface BuyService {

	// 상품 상세옵션 가져오기
	ProductDetail getProductDetail(int productNo);

	// 상품 결제 정보 저장
	int insertBuyInfo(Buy buy, Payment payment, List<Map<String, Object>> buyOptionList);

	// 결제 정보 조회
	Payment getPayment(String merchant_uid);

	// 구매 옵션 조회
	List<Map<String, Object>> getBuyOption(String merchant_uid);

	// 상품 올린사람 조회
	String getSeller(int productNo);

	// 채팅방 생성
	int createChatroom(Map<String, String> map);

}
