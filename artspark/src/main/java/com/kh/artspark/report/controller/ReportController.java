package com.kh.artspark.report.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.artspark.report.model.service.ReportService;
import com.kh.artspark.report.model.vo.Report;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("report")
public class ReportController {

	private final ReportService reportService;
	
	@PostMapping
	public String insertReport(Report report, int reqNo, HttpSession session, Model model) {
		
		int result = reportService.insertReport(report);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "신고가 정상적으로 처리되었습니다.");
			return "redirect:/requestDetail?reqNo=" + reqNo;
		}
		
		model.addAttribute("errorMsg", "신고가 실패하였습니다.");
		return "error/errorPage";
	}
	
}
