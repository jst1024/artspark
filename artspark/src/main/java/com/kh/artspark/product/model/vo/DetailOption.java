package com.kh.artspark.product.model.vo;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class DetailOption {
	
	private int detailOptionNo;
	private String detailOptionName;
	private int detailOptionPrice;
	private int payOptionNo;
	
}
