package com.kh.artspark.banner.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.artspark.banner.model.dao.BannerMapper;
import com.kh.artspark.banner.model.vo.Banner;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BannerServiceImpl implements BannerService {

	private final BannerMapper bannerMapper;

	@Override
	public List<Map<String, Object>> getAllBanners() {
		return bannerMapper.getAllBanners();
	}
	
	@Override
	public int addBanner(Banner banner) {
		return bannerMapper.addBanner(banner);
	}
	
	@Override
	public int deleteBanner(int bannerNo) {
		return bannerMapper.deleteBanner(bannerNo);
	}

	@Override
	public Map<String, Object> getBannerByNo(int bannerNo) {
		return bannerMapper.getBannerByNo(bannerNo);
	}

	@Override
	public int updateBanner(Banner banner) {
		return bannerMapper.updateBanner(banner);
	}

	


}
