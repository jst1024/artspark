package com.kh.artspark.review.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.artspark.buy.model.vo.Buy;
import com.kh.artspark.review.model.dao.ReviewMapper;
import com.kh.artspark.review.model.vo.Review;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService {

	private final ReviewMapper reviewMapper;

	@Override
	public int buyRecord(Map<String, Object> map) {
		
		List<Buy> buyRecord = reviewMapper.buyRecord(map);

		if(!buyRecord.isEmpty()) {
			return 1;
		}
		
		return 0;
	}

	@Override
	public int insertReview(Review review) {
		return reviewMapper.insertReview(review);
	}
	
}
