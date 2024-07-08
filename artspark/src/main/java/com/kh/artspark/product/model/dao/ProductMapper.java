package com.kh.artspark.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.artspark.product.model.vo.Product;
import com.kh.artspark.product.model.vo.ProductDetail;
import com.kh.artspark.product.model.vo.ProductForm;

@Mapper
public interface ProductMapper {
	
	List<Map<String, Object>> findAllProductList(String loginUserId);

	int insertJjim(Map<String, Object> map);

	int deleteJjim(Map<String, Object> map);

	Map<String, Object> findById(Map<String, Object> map);

	void insertProduct(Product product);

	void insertProductDetail(ProductDetail productDetail);

	int tagCheck(String tagName);

	void insertTag(int tagNo);

	void insertTagCheck(String tagName);

	void insertPayOption(List<String> changeList);

	void insertDetailOption(ProductForm productForm);

}
