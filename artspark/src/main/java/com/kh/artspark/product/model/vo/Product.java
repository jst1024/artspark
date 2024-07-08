package com.kh.artspark.product.model.vo;

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
	private String productDate;
	private String memId;
	
}
