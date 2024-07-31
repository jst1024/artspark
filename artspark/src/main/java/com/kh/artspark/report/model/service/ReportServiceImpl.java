package com.kh.artspark.report.model.service;

import org.springframework.stereotype.Service;

import com.kh.artspark.report.model.dao.ReportMapper;
import com.kh.artspark.report.model.vo.Report;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {

	private final ReportMapper reportMapper;

	@Override
	public int insertReport(Report report) {
		return reportMapper.insertReport(report);
	}
	
}
