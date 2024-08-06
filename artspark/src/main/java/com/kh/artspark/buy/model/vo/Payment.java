package com.kh.artspark.buy.model.vo;

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
public class Payment {

	private String buyNo;
	private String paymentMethod;
	private String paymentName;
	private String paymentPhone;
	private String paymentEmail;
	private String paymentRequest;
	
}
