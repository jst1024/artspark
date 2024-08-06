package com.kh.artspark.review.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.artspark.buy.model.vo.Buy;
import com.kh.artspark.review.model.vo.Review;

@Mapper
public interface ReviewMapper {

	List<Buy> buyRecord(Map<String, Object> map);

	int insertReview(Review review);

	int reviewCount(int productNo);

	List<Review> findReviewList(int productNo, RowBounds rowBounds);

	int deleteReview(int reviewNo);

}
