package com.kh.artspark.report.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.artspark.report.model.vo.Report;

@Mapper
public interface ReportMapper {

	public int insertReport(Report report);

}
