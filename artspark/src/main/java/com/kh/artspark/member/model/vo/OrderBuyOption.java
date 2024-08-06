package com.kh.artspark.member.model.vo;

import java.sql.Date;
import java.util.List;

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
public class OrderBuyOption {
	
	private String buyNo;
	private int productNo;
	private String paymentName;
	private String paymentEmail;
	private String paymentPhone;
	private String paymentRequest;
	private Date paymentDate;
	private String productPurpose;
	private String detailType;
	private String detailSize;
	private String detailPixel;
	private int updateCount;
	private String detailWorkdate;
	private String memNickname;
	private String artistPath;
	private String productTitle;
	private int totalAmount;
	private List<BuyOption> buyOptionList; 
}
