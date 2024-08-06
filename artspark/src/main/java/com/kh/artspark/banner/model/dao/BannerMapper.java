package com.kh.artspark.banner.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.artspark.banner.model.vo.Banner;

@Mapper
public interface BannerMapper {

	List<Map<String, Object>> getAllBanners();
	
	int addBanner(Banner banner);

	int deleteBanner(int bannerNo);

	Banner selectBannerByNo(int bannerNo);

	int updateBanner(Banner banner);




}
