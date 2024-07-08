package com.kh.artspark.product.model.vo;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ProductForm {
	
	private List<String> optionName;
    private List<String> detailOptionName;
    private List<Integer> detailOptionPrice;
	
}
