package com.kh.artspark.buy.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.artspark.buy.model.dao.BuyMapper;
import com.kh.artspark.buy.model.vo.Buy;
import com.kh.artspark.buy.model.vo.Payment;
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

	@Transactional
	@Override
	public int insertBuyInfo(Buy buy, Payment payment, List<Map<String, Object>> buyOptionList) {
		
		int result1 = buyMapper.insertBuy(buy);
		
		int result2 = buyMapper.insertPayment(payment);
		
		int result3 = 0;
		for(int i=0; i<buyOptionList.size(); i++) {
			result3 += buyMapper.insertBuyOption(buyOptionList.get(i));
		}
		
		return result1 + result2 + result3;
	}

	@Override
	public Payment getPayment(String merchant_uid) {
		return buyMapper.getPayment(merchant_uid);
	}

	@Override
	public List<Map<String, Object>> getBuyOption(String merchant_uid) {
		return buyMapper.getBuyOption(merchant_uid);
	}

	@Override
	public String getSeller(int productNo) {
		return buyMapper.getSeller(productNo);
	}

	@Override
	public int createChatroom(Map<String, String> map) {
		return buyMapper.createChatroom(map);
	}

}
