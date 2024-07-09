package com.kh.artspark.product.model.service;

import java.util.List;
import java.util.Map;

import com.kh.artspark.product.model.vo.Product;
import com.kh.artspark.product.model.vo.ProductDetail;
import com.kh.artspark.product.model.vo.ProductForm;

public interface ProductService {
	
	// 모든 상품 정보 조회
	List<Map<String, Object>> findAllProductList(String loginUserId);

	// 찜 등록
	int insertJjim(Map<String, Object> map);

	// 찜 삭제
	int deleteJjim(Map<String, Object> map);

	// 상품 상세보기
	Map<String, Object> findById(Map<String, Object> map);

	// 상품 등록
	int insertProduct(Product product, ProductDetail productDetail, ProductForm productForm,
			List<String> tagList);

}
