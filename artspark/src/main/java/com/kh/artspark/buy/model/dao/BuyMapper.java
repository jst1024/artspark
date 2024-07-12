package com.kh.artspark.buy.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.artspark.product.model.vo.ProductDetail;

@Mapper
public interface BuyMapper {

	ProductDetail getProductDetail(int productNo);

}
