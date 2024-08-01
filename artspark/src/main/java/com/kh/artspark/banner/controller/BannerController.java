package com.kh.artspark.banner.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.artspark.banner.model.service.BannerService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class BannerController {

	private final BannerService bannerService;
	
	@GetMapping("/bannerList")
    public String bannerList(Model model) {
        List<Map<String, Object>> bannerList = bannerService.getAllBanners();
        model.addAttribute("bannerList", bannerList);
        return "bannerList";
    }

    @GetMapping("/deleteBanner")
    public String deleteBanner(@RequestParam("bannerNo") int bannerNo) {
        bannerService.deleteBanner(bannerNo);
        return "redirect:/bannerList";
    }

    @GetMapping("/editBanner")
    public String editBanner(@RequestParam("bannerNo") int bannerNo, Model model) {
        Map<String, Object> banner = bannerService.getBannerByNo(bannerNo);
        model.addAttribute("banner", banner);
        return "editBanner";
    }

    @GetMapping("/toggleBannerStatus")
    public String toggleBannerStatus(@RequestParam("bannerNo") int bannerNo, @RequestParam("status") String status) {
        bannerService.updateBannerStatus(bannerNo, status);
        return "redirect:/bannerList";
    }
}
