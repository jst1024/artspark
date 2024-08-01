package com.kh.artspark.banner.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.artspark.banner.model.service.BannerService;
import com.kh.artspark.banner.model.vo.Banner;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class BannerController {

    private final BannerService bannerService;

    

    @GetMapping("/deleteBanner")
    @ResponseBody
    public ResponseEntity<Integer> deleteBanner(@RequestParam("banNo") int banNo) {
        int result = bannerService.deleteBanner(banNo);
        if (result > 0) {
            log.info("배너 삭제 성공: 배너 번호 " + banNo);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } else {
            log.error("배너 삭제 실패: 배너 번호 " + banNo);
            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/editBanner")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> editBanner(@RequestParam("banNo") int banNo) {
        Map<String, Object> banner = bannerService.getBannerByNo(banNo);
        if (banner != null) {
            return new ResponseEntity<>(banner, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/updateBanner")
    @ResponseBody
    public ResponseEntity<Banner> updateBanner(@RequestParam("banNo") int banNo,
                                               @RequestParam("banName") String banName,
                                               @RequestParam("banComent") String banComent,
                                               @RequestParam("banUrl") String banUrl,
                                               @RequestParam("banImage") String banImage) {
        Banner banner = new Banner();
        banner.setBanNo(banNo);
        banner.setBanName(banName);
        banner.setBanComent(banComent);
        banner.setBanUrl(banUrl);
        banner.setBanImage(banImage);

        int result = bannerService.updateBanner(banner);
        if (result > 0) {
            log.info("배너 업데이트 성공: 배너 번호 " + banNo);
            return new ResponseEntity<>(banner, HttpStatus.OK);
        } else {
            log.error("배너 업데이트 실패: 배너 번호 " + banNo);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
