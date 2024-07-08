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
public class PayOption {
	
	private int payOptionNo;
	private String optionName;
	private int productNo;
	private List<DetailOption> detailOptionList;
	
}
