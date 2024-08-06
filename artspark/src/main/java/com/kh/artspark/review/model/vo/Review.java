package com.kh.artspark.review.model.vo;

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
public class Review {

	private int reviewNo;
	private String reviewTitle;
	private String reviewContent;
	private Date reviewDate;
	private double reviewStar;
	private String memId;
	private int productNo;
	
}
