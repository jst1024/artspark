package com.kh.artspark.banner.model.service;

import java.util.List;
import java.util.Map;

public interface BannerService {

	// 배너리스트
	List<Map<String, Object>> getAllBanners();

	// 배너삭제
	int deleteBanner(int bannerNo);

	// 배너상세
	Map<String, Object> getBannerByNo(int bannerNo);

	// 배너수정
	int updateBannerStatus(int bannerNo, String status);

}
