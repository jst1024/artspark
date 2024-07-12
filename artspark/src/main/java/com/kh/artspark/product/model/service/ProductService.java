package com.kh.artspark.product.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.kh.artspark.product.model.vo.Product;
import com.kh.artspark.product.model.vo.ProductDetail;
import com.kh.artspark.product.model.vo.ProductFile;
import com.kh.artspark.product.model.vo.ProductForm;
import com.kh.artspark.product.model.vo.Tag;

public interface ProductService {

	// 상품 전체 개수
	int productAllCount();

	// 카테고리별 상품 전체 개수
	int productCategoryCount(String category);
	
	// 검색 상품 개수 조회
	int productSearchCount(String keyword);

	// 모든 상품 목록 조회
	List<Map<String, Object>> findAllProductList(String loginUserId, RowBounds rowBounds);
	
	// 카테고리별 상품 목록 조회
	List<Map<String, Object>> findAllCategoryList(Map<String, String> map, RowBounds rowBounds);
	
	// 검색 상품목록 조회
	List<Map<String, Object>> productSearchList(Map<String, String> map, RowBounds rowBounds);
	
	// 태그 30개 조회
	List<Tag> getTags();

	// 찜 등록
	int insertJjim(Map<String, Object> map);

	// 찜 삭제
	int deleteJjim(Map<String, Object> map);

	// 상품 상세보기
	Map<String, Object> findById(Map<String, Object> map);
	
	// 상품 상세보기(이미지)
	List<ProductFile> findByIdFile(int productNo);
	
	// 상품 태그 조회
	List<Tag> findByIdTag(int productNo);

	// 상품 등록
	int insertProduct(Product product, ProductDetail productDetail, List<String> changeList, ProductForm productForm,
			List<Tag> tagList, List<ProductFile> productFiles);

}