package com.kh.artspark.banner.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.artspark.banner.model.service.BannerService;
import com.kh.artspark.banner.model.vo.Banner;

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
        int result = bannerService.deleteBanner(bannerNo);
        if (result > 0) {
            log.info("배너 삭제 성공: 배너 번호 " + bannerNo);
        } else {
            log.error("배너 삭제 실패: 배너 번호 " + bannerNo);
        }
        return "redirect:/bannerList";
    }

    @GetMapping("/editBanner")
    public String editBanner(@RequestParam("bannerNo") int bannerNo, Model model) {
        Map<String, Object> banner = bannerService.getBannerByNo(bannerNo);
        model.addAttribute("banner", banner);
        return "editBanner";
    }

    @PostMapping("/updateBanner")
    public String updateBanner(@RequestParam("bannerNo") int bannerNo,
                               @RequestParam("bannerName") String bannerName,
                               @RequestParam("bannerComent") String bannerComent,
                               @RequestParam("bannerUrl") String bannerUrl,
                               @RequestParam("bannerImage") String bannerImage) {
        Banner banner = new Banner();
        banner.setBanNo(bannerNo);
        banner.setBanName(bannerName);
        banner.setBanComent(bannerComent);
        banner.setBanUrl(bannerUrl);
        banner.setBanImage(bannerImage);

        int result = bannerService.updateBanner(banner);
        if (result > 0) {
            log.info("배너 업데이트 성공: 배너 번호 " + bannerNo);
        } else {
            log.error("배너 업데이트 실패: 배너 번호 " + bannerNo);
        }
        return "redirect:/bannerList";
    }

}
