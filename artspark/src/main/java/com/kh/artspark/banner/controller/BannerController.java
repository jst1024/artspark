package com.kh.artspark.banner.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.artspark.banner.model.service.BannerService;
import com.kh.artspark.banner.model.vo.Banner;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class BannerController {

    private final BannerService bannerService;

    @PostMapping("/addBanner")
    @ResponseBody
    public ResponseEntity<Banner> addBanner(@RequestParam("banName") String banName,
                                            @RequestParam("banComent") String banComent,
                                            @RequestParam("banUrl") String banUrl,
                                            @RequestParam("banImage") MultipartFile banImageFile) {
        String banImage = "";
        if (!banImageFile.isEmpty()) {
            try {
                String originalFilename = banImageFile.getOriginalFilename();
                String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
                String savedFilename = UUID.randomUUID().toString() + fileExtension;

                String uploadDir = "C:/uploads"; // 실제 업로드 경로
                File uploadPath = new File(uploadDir);
                if (!uploadPath.exists()) {
                    uploadPath.mkdirs();
                }

                File dest = new File(uploadDir, savedFilename);
                banImageFile.transferTo(dest);

                banImage = "resources/images/" + savedFilename;
            } catch (IOException e) {
                log.error("배너 이미지 업로드 실패", e);
                return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }

        Banner banner = new Banner();
        banner.setBanName(banName);
        banner.setBanComent(banComent);
        banner.setBanUrl(banUrl);
        banner.setBanImage(banImage);

        int result = bannerService.addBanner(banner);
        if (result > 0) {
            log.info("배너 추가 성공");
            return new ResponseEntity<>(banner, HttpStatus.OK);
        } else {
            log.error("배너 추가 실패");
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

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
