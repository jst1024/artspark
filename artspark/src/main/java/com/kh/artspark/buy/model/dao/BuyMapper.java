package com.kh.artspark.buy.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.artspark.buy.model.vo.Buy;
import com.kh.artspark.buy.model.vo.Payment;
import com.kh.artspark.product.model.vo.ProductDetail;

@Mapper
public interface BuyMapper {

	ProductDetail getProductDetail(int productNo);

	int insertBuy(Buy buy);

	int insertPayment(Payment payment);

	int insertBuyOption(Map<String, Object> map);

	Payment getPayment(String merchant_uid);

	List<Map<String, Object>> getBuyOption(String merchant_uid);

}
