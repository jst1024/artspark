package com.kh.artspark.product.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class ProductDetail {
	
	private int productNo;
	private String productPurpose;
	private String detailType;
	private String detailSize;
	private String detailPixel;
	private int updateCount;
	private String detailWorkdate;
	
}
