package com.kh.artspark.banner.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

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
                                            @RequestParam("banImage") MultipartFile banImage,
                                            HttpSession session) {
        if (banImage.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        String changeName = saveFile(banImage, session);

        Banner banner = new Banner();
        banner.setBanName(banName);
        banner.setBanComent(banComent);
        banner.setBanUrl(banUrl);
        banner.setBanImage("resources/uploadFiles/" + changeName);

        int result = bannerService.addBanner(banner);
        if (result > 0) {
            return new ResponseEntity<>(banner, HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/deleteBanner")
    @ResponseBody
    public ResponseEntity<Integer> deleteBanner(@RequestParam("banNo") int banNo) {
        int result = bannerService.deleteBanner(banNo);
        if (result > 0) {
            return new ResponseEntity<>(result, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/editBanner")
    @ResponseBody
    public ResponseEntity<Banner> editBanner(@RequestParam("banNo") int banNo) {
        Banner banner = bannerService.selectBannerByNo(banNo);
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
                                               @RequestParam(value = "banImage", required = false) MultipartFile banImage,
                                               HttpSession session) {
        Banner banner = new Banner();
        banner.setBanNo(banNo);
        banner.setBanName(banName);
        banner.setBanComent(banComent);
        banner.setBanUrl(banUrl);

        if (banImage != null && !banImage.isEmpty()) {
            String changeName = saveFile(banImage, session);
            banner.setBanImage("resources/uploadFiles/" + changeName);
        } else {
            banner.setBanImage(bannerService.selectBannerByNo(banNo).getBanImage());
        }

        int result = bannerService.updateBanner(banner);
        if (result > 0) {
            return new ResponseEntity<>(banner, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private String saveFile(MultipartFile file, HttpSession session) {
        String originName = file.getOriginalFilename();
        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        int randomNum = (int)(Math.random() * 90000) + 10000;
        String extension = originName.substring(originName.lastIndexOf("."));
        String changeName = currentTime + "_" + randomNum + extension;

        String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");

        try {
            file.transferTo(new File(savePath + changeName));
        } catch (IllegalStateException | IOException e) {
            e.printStackTrace();
            throw new RuntimeException("파일 저장 실패");
        }

        return changeName;
    }
}
