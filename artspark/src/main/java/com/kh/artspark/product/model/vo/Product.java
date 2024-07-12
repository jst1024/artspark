package com.kh.artspark.product.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class Product {
	
	private int productNo;
	private String productCategory;
	private String productTitle;
	private String productContent;
	private Date productDate;
	private Date productDeldate;
	private String memId;
	
}
