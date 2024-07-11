package com.kh.artspark.product.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductController {

	// ㅋㅋ내가낙서하고감
	@GetMapping("productList")
	public String productList() {
		return "product/productList";
	}
	
	@GetMapping("productInsertForm")
	public String productInsertForward() {
		return "product/productInsert";
	}
	
	@GetMapping("productDetail")
	public String productDetail() {
		return "product/productDetail";
	}
	
	@GetMapping("productQna")
	public String productQna() {
		return "product/productQna";
	}
	
	@GetMapping("productBuy")
	public String productBuy() {
		return "product/productBuy";
	}
	
	@GetMapping("productComplete")
	public String productComplete() {
		return "product/productComplete";
	}
	
}
