package com.kh.artspark.banner.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BannerMapper {

	List<Map<String, Object>> getAllBanners();

	int deleteBanner(int bannerNo);

	Map<String, Object> getBannerByNo(int bannerNo);

	int updateBannerStatus(int bannerNo, String status);

}
