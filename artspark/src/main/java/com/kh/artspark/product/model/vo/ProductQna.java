package com.kh.artspark.product.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class ProductQna {

	private int qnaNo;
	private int productNo;
	private String qnaTitle;
	private String qnaContent;
	private Date qnaDate;
	private String memId;
	private String status;
	private Date qnaDeldate;
	private String qnaCategory;
	
}
