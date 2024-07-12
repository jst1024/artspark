package com.kh.artspark.buy.model.service;

import com.kh.artspark.product.model.vo.ProductDetail;

public interface BuyService {

	// 상품 상세옵션 가져오기
	ProductDetail getProductDetail(int productNo);

}
