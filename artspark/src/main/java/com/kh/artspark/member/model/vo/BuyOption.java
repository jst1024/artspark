package com.kh.artspark.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BuyOption {
	
	private String buyNo;
	private String buyOptionName;
	private int buyOptionPrice;
	private int buyOptionAmount;
	private String buyDetailOptionName;
	
}
