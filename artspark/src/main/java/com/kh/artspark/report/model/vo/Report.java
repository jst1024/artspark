package com.kh.artspark.report.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class Report {

	private int reportNo;
	private String memId;
	private String memId2;
	private String reportContent;
	private Date reportDate;
	private String reportCategory;
	
}
