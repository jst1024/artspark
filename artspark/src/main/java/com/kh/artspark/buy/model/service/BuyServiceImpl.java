package com.kh.artspark.buy.model.service;

import org.springframework.stereotype.Service;

import com.kh.artspark.buy.model.dao.BuyMapper;
import com.kh.artspark.product.model.vo.ProductDetail;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BuyServiceImpl implements BuyService {
	
	private final BuyMapper buyMapper;	

	@Override
	public ProductDetail getProductDetail(int productNo) {
		return buyMapper.getProductDetail(productNo);
	}

}
