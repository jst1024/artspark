package com.kh.artspark.review.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.artspark.buy.model.vo.Buy;
import com.kh.artspark.review.model.vo.Review;

@Mapper
public interface ReviewMapper {

	List<Buy> buyRecord(Map<String, Object> map);

	int insertReview(Review review);

}
