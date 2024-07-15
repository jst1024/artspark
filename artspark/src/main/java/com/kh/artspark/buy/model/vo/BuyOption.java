package com.kh.artspark.buy.model.vo;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class BuyOption {
	
	private int buyOptionNo;
	private List<String> buyOptionName;
	private List<String> buyDetailOptionName;
	private List<Integer> buyOptionPrice;
	private List<Integer> buyOptionAmount;
	private String buyNo;
	
}
