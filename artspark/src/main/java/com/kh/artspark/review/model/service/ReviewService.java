package com.kh.artspark.review.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.kh.artspark.review.model.vo.Review;

public interface ReviewService {

	int buyRecord(Map<String, Object> map);

	int insertReview(Review review);

	int reviewCount(int productNo);

	List<Review> findReviewList(int productNo, RowBounds rowBounds);

}
