package com.kh.artspark.product.model.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.artspark.product.model.dao.ProductMapper;
import com.kh.artspark.product.model.vo.Product;
import com.kh.artspark.product.model.vo.ProductDetail;
import com.kh.artspark.product.model.vo.ProductForm;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

	private final ProductMapper productMapper;
	
	@Override
	public List<Map<String, Object>> findAllProductList(String loginUserId) {
		return productMapper.findAllProductList(loginUserId);
	}

	@Override
	public int insertJjim(Map<String, Object> map) {
		return productMapper.insertJjim(map);
	}

	@Override
	public int deleteJjim(Map<String, Object> map) {
		return productMapper.deleteJjim(map);
	}

	@Override
	public Map<String, Object> findById(Map<String, Object> map) {
		return productMapper.findById(map);
	}

	@Transactional
	@Override
	public int insertProduct(Product product, ProductDetail productDetail,
			ProductForm productForm, List<String> tagList) {
		
		// product 테이블 insert
		productMapper.insertProduct(product);
		
		// productDetail 테이블 insert
		productMapper.insertProductDetail(productDetail);
		
		// 태그 테이블에 테그이름이 있는지 조회 후, 없으면 두 테이블에 모두 insert
		// 있으면 tagCheck 테이블에만 insert
		for(String tagName : tagList) {
			int tagNo = productMapper.tagCheck(tagName);
			
			if(tagName.isEmpty()) {
				productMapper.insertTagCheck(tagName);
			}
			productMapper.insertTag(tagNo);
		}
		
		// 중복 제거를 위해 HashSet에 리스트를 넣어 중복을 제거한 뒤 다시 ArrayList로 변환
		List<String> optionNameList = productForm.getOptionName();
		List<String> changeList = new ArrayList<String>(new HashSet<String>(optionNameList));
		
		productMapper.insertPayOption(changeList);

		productMapper.insertDetailOption(productForm);
		
		return 1;
	}

}















