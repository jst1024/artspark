package com.kh.artspark.review.model.service;

import java.util.Map;

import com.kh.artspark.review.model.vo.Review;

public interface ReviewService {

	int buyRecord(Map<String, Object> map);

	int insertReview(Review review);

}
