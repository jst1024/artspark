package com.kh.artspark.member.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class Report {

	private int reportNo;
	private String reportCategory;
	private String reportContent;
	private String reportDate;
	private String memId;
	private String memId2;
}
