package com.kh.artspark.product.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.artspark.common.model.vo.Message;
import com.kh.artspark.common.model.vo.PageInfo;
import com.kh.artspark.common.template.PageTemplate;
import com.kh.artspark.member.model.vo.Member;
import com.kh.artspark.product.model.service.ProductService;
import com.kh.artspark.product.model.vo.Product;
import com.kh.artspark.product.model.vo.ProductDetail;
import com.kh.artspark.product.model.vo.ProductFile;
import com.kh.artspark.product.model.vo.ProductForm;
import com.kh.artspark.product.model.vo.Tag;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/product")
public class ProductController {
	
	private final ProductService productService;
	
	// 상품 목록 전체 조회
	@GetMapping
	public String findAllProductList(@RequestParam(value="page", defaultValue = "1") int page,
									HttpSession session, Model model) {
		
		int listCount = productService.productAllCount();
		int currentPage = page;
		int pageLimit = 5;
		int boardLimit = 4;
		
		PageInfo pageInfo = PageTemplate.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		RowBounds rowBounds = new RowBounds((currentPage - 1) * boardLimit, boardLimit);

		List<Map<String, Object>> productList = new ArrayList<Map<String,Object>>();
		
		// 찜테이블에 있는 멤버아이디와 로그인유저의 아이디를 비교하기위함 
		if(session.getAttribute("loginUser") != null) {
			Member loginUser = (Member) session.getAttribute("loginUser");
			productList = productService.findAllProductList(loginUser.getMemId(), rowBounds);
		} else {
			productList = productService.findAllProductList("", rowBounds);
		}
		
		// 태그 목록 30개 불러오기
		List<Tag> tags = productService.getTags();
		
		model.addAttribute("tags", tags);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("productList", productList);
		
		return "product/productList";
	}
	
	// 카테고리별 상품 목록 조회
	@GetMapping("category")
	public String findCategoryList(@RequestParam(value="page", defaultValue = "1") int page,
									@RequestParam(value="category") String category,
									HttpSession session, Model model) {
		
		int listCount = productService.productCategoryCount(category);
		int currentPage = page;
		int pageLimit = 5;
		int boardLimit = 1;
		
		PageInfo pageInfo = PageTemplate.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		RowBounds rowBounds = new RowBounds((currentPage - 1) * boardLimit, boardLimit);

		List<Map<String, Object>> productList = new ArrayList<Map<String,Object>>();
		
		Map<String, String> map = new HashMap<String, String>();
		
		// 찜테이블에 있는 멤버아이디와 로그인유저의 아이디를 비교하기위함 
		if(session.getAttribute("loginUser") != null) {
			Member loginUser = (Member) session.getAttribute("loginUser");
			map.put("loginUserId", loginUser.getMemId());
			map.put("category", category);
			productList = productService.findAllCategoryList(map, rowBounds);
		} else {
			map.put("loginUserId", "");
			map.put("category", category);
			productList = productService.findAllCategoryList(map, rowBounds);
		}
		
		// 태그 목록 30개 불러오기
		List<Tag> tags = productService.getTags();
		
		model.addAttribute("tags", tags);
		model.addAttribute("category", category);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("productList", productList);
		
		return "product/productList";
	}
	
	// keyword 검색(작가명, 작품제목, 태그) 기능
	@GetMapping("search")
	public String searchProduct(String keyword,
								@RequestParam(value="page", defaultValue = "1") int page,
								HttpSession session,
								Model model) {
		log.info("키워드 : {}", keyword);
		int searchCount = productService.productSearchCount(keyword);
		log.info("검색 수 : {}개", searchCount);
		int currentPage = page;
		int pageLimit = 5;
		int boardLimit = 1;
		
		PageInfo pageInfo = PageTemplate.getPageInfo(searchCount, currentPage, pageLimit, boardLimit);
		
		RowBounds rowBounds = new RowBounds((currentPage - 1) * boardLimit, boardLimit);
		
		List<Map<String, Object>> productList = new ArrayList<Map<String,Object>>();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		
		if(session.getAttribute("loginUser") != null) {
			Member loginUser = (Member) session.getAttribute("loginUser");
			map.put("loginUserId", loginUser.getMemId());
		} else {
			map.put("loginUserId", "");
		}
		
		productList = productService.productSearchList(map, rowBounds);
		
		// 태그 목록 30개 불러오기
		List<Tag> tags = productService.getTags();
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("tags", tags);
		model.addAttribute("productList", productList);
		model.addAttribute("keyword", keyword);
		
		return "product/productList";
	}

	// 찜 등록
	@ResponseBody
	@PostMapping(value="jjim/{pno}", produces = "application/json; charset=UTF-8")
	public ResponseEntity<Message> insertHeart(@PathVariable String pno, HttpSession session) {
		
		int productNo = Integer.parseInt(pno);
		Member loginUser = (Member) session.getAttribute("loginUser");
		String loginId = loginUser.getMemId();
		
		Map<String, Object> map = new HashMap<>();
		map.put("loginId", loginId);
		map.put("productNo", productNo);
		
		if(productService.insertJjim(map) == 0) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
																			 .message("찜 등록 요청 실패")
																			 .build()); 
		}
		
		Message responseMsg = Message.builder().message("찜 목록에 추가되었습니다.")
											   .build();
		
		return ResponseEntity.status(HttpStatus.OK).body(responseMsg);
	}
	
	// 찜 삭제
	@ResponseBody
	@DeleteMapping(value="jjim/{pno}", produces = "application/json; charset=UTF-8")
	public ResponseEntity<Message> deleteHeart(@PathVariable String pno, HttpSession session) {
		
		int productNo = Integer.parseInt(pno);
		Member loginUser = (Member) session.getAttribute("loginUser");
		String loginId = loginUser.getMemId();
		
		Map<String, Object> map = new HashMap<>();
		map.put("loginId", loginId);
		map.put("productNo", productNo);
		
		if(productService.deleteJjim(map) == 0) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
																			 .message("찜 삭제 요청 실패")
																			 .build()); 
		}
		
		Message responseMsg = Message.builder().message("찜 목록에서 삭제되었습니다.")
											   .build();
		
		return ResponseEntity.status(HttpStatus.OK).body(responseMsg);
	}
	
	// 상품 상세 페이지
	@GetMapping("/{pno}")
	public ModelAndView detail(@PathVariable String pno, HttpSession session , ModelAndView mv) {
		
		int productNo = Integer.parseInt(pno);
		
		Map<String, Object> map = new HashMap<>();
		
		if(session.getAttribute("loginUser") != null) {
			Member member = (Member) session.getAttribute("loginUser");
			String loginId = member.getMemId();
			map.put("loginId", loginId);
			map.put("productNo", productNo);
		} else {
			map.put("loginId", "");
			map.put("productNo", productNo);
		}
		
		Map<String, Object> product = productService.findById(map);
		List<ProductFile> productFiles = productService.findByIdFile(productNo);
		List<Tag> productTags = productService.findByIdTag(productNo);
		
//		log.info("PayOption: {}", product.get("payOptionList"));
		
		mv.addObject("productFiles", productFiles);
		mv.addObject("productTags", productTags);
		mv.addObject("product", product).setViewName("product/productDetail");
		
		return mv;
	}
	
	@GetMapping("productInsertForm")
	public String productInsertForward() {
		return "product/productInsert";
	}
	
	// 상품 등록
	@PostMapping
	public String insertProduct(Product product,
								ProductDetail productDetail,
								ProductForm productForm,
								String productPurpose1,
								String productPurpose2,
								String tags,
								MultipartFile[] mainImage,
								HttpSession session,
								Model model) {
		
//		log.info("입력 정보 : {}", product);
//		log.info("입력 정보 : {}", productDetail);
//		log.info("입력 정보 : {}", productForm);
//		log.info("입력 정보 : {}", tags);
//		log.info("입력 정보 : {}", productPurpose1);
//		log.info("입력 정보 : {}", productPurpose2);
//		log.info("사진들 : {}", mainImage[0]);
//		log.info("사진들 : {}", mainImage[1]);
//		log.info("사진들 : {}", mainImage[2]);
		
		String productPurpose = "";
		if(productPurpose1 != null && productPurpose2 != null) {
			productPurpose = productPurpose1 + " / " + productPurpose2;
		} else if(productPurpose1 != null && productPurpose2 == null) {
			productPurpose = productPurpose1;
		} else {
			productPurpose = productPurpose2;
		}
		
		productDetail.setProductPurpose(productPurpose);
		
		String[] tagArray = tags.split("#");
		List<Tag> tagList = new ArrayList<>();
		
		for(String s : tagArray) {
			if(!s.trim().isEmpty()) {
				Tag tag = new Tag();
				tag.setTagName(s.trim());
				tagList.add(tag);
			}
		}
		
//		log.info("태그 : {}", tagList);
		
		// 파일 처리
		List<ProductFile> productFiles = new ArrayList<>();
		
		for(int i=0; i<mainImage.length; i++) {
			if(!mainImage[i].getOriginalFilename().equals("")) {
				ProductFile productFile = new ProductFile();
				String changeName = saveFile(mainImage[i], session);
				
				productFile.setOriginName(mainImage[i].getOriginalFilename());
				productFile.setChangeName(changeName);
				productFile.setFilePath("resources/uploadFiles/" + changeName);
				
				productFiles.add(productFile);
			}
		}
		
		int result = productService.insertProduct(product, productDetail,productForm, 
												tagList, productFiles);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "상품 등록 성공!");
			return "redirect:/product";
		}
		
		model.addAttribute("errorMsg", "상품 등록 실패..ㅠ");
		return "error/errorPage";
	}
	
	// 파일 이름 바꾸고 저장하는 메서드
	public String saveFile(MultipartFile upfile, HttpSession session) {
		
		String originName = upfile.getOriginalFilename();
		String ext = originName.substring(originName.lastIndexOf('.')+1, originName.length());
		
		int num = (int) (Math.random() * 900) + 100;
		// 곱하는 값 : 값의 범위
		// 더하는 값 : 시작값
		// ex) 100 ~ 999
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		
		String changeName = "ARTSPARK_" + currentTime + "_" + num + "." + ext;
		
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}
	
	
	// 상품 삭제
	@GetMapping("productDelete")
	public String productDelete(int productNo, HttpSession session, Model model) {
		// product 테이블의 status를 N으로 바꾸고, product_deldate를 현재시간으로 업데이트
		// 찜 테이블에서 해당 상품번호를 가진 레코드 제거
		
		int result = productService.deleteProduct(productNo);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "상품이 삭제되었습니다.");
			return "redirect:/product";
		}
		
		session.setAttribute("alertMsg", "상품 삭제에 실패했습니다.");
		return "redirect:/product/" + productNo;
	}
	
	// 상품 업데이트페이지 포워딩
	@GetMapping("productUpdateForward")
	public String productUpdateForward(String pno, Model model) {
		int productNo = Integer.parseInt(pno);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("loginId", "");
		map.put("productNo", productNo);
		
		Map<String, Object> product = productService.findById(map);
		List<ProductFile> productFiles = productService.findByIdFile(productNo);
		List<Tag> productTags = productService.findByIdTag(productNo);
		StringBuilder sb = new StringBuilder();
		
		for(Tag t : productTags) {
			sb.append("#" + t.getTagName());
		}
		
		log.info(sb.toString());
		log.info("PayOption: {}", product.get("payOptionList"));
		log.info("파일 정보 : {}", productFiles);
		
		model.addAttribute("productFiles", productFiles);
		model.addAttribute("productTags", sb.toString());
		model.addAttribute("product", product);
		
		return "product/productUpdate";
	}
	
	// 상품 업데이트
	@PostMapping("update")
	public String updateProduct(Product product,
								ProductDetail productDetail,
								ProductForm productForm,
								String productPurpose1,
								String productPurpose2,
								String tags,
								MultipartFile upImage1,
								MultipartFile upImage2,
								MultipartFile upImage3,
								HttpSession session,
								Model model) {
		
		log.info("입력 정보 : {}", product);
		log.info("입력 정보 : {}", productDetail);
		log.info("입력 정보 : {}", productForm);
		log.info("입력 정보 : {}", tags);
		log.info("입력 정보 : {}", productPurpose1);
		log.info("입력 정보 : {}", productPurpose2);
		log.info("사진들 : {}", upImage1);
		log.info("사진들 : {}", upImage2);
		log.info("사진들 : {}", upImage3);
		
		String productPurpose = "";
		if(productPurpose1 != null && productPurpose2 != null) {
			productPurpose = productPurpose1 + " / " + productPurpose2;
		} else if(productPurpose1 != null && productPurpose2 == null) {
			productPurpose = productPurpose1;
		} else {
			productPurpose = productPurpose2;
		}
		
		productDetail.setProductPurpose(productPurpose);
		
		String[] tagArray = tags.split("#");
		List<Tag> tagList = new ArrayList<>();
		
		for(String s : tagArray) {
			if(!s.trim().isEmpty()) {
				Tag tag = new Tag();
				tag.setTagName(s.trim());
				tagList.add(tag);
			}
		}
		
//		log.info("태그 : {}", tagList);
		
		// 파일 처리
		MultipartFile[] changeFiles = new MultipartFile[3];
		changeFiles[0] = upImage1;
		changeFiles[1] = upImage2;
		changeFiles[2] = upImage3;
		List<ProductFile> originFiles = productService.findByIdFile(product.getProductNo());
		List<ProductFile> productFiles = new ArrayList<>();
		
		for(int i=0; i<changeFiles.length; i++) {
			if(!changeFiles[i].getOriginalFilename().equals("")) {
				ProductFile productFile = new ProductFile();
				String changeName = saveFile(changeFiles[i], session);
				productFile.setOriginName(changeFiles[i].getOriginalFilename());
				productFile.setChangeName(changeName);
				productFile.setFilePath("resources/uploadFiles/" + changeName);
				
				// 새 파일을 넣으면 기존파일삭제
				if(originFiles.size() > i && !originFiles.get(i).getOriginName().equals("")) {
					new File(session.getServletContext().getRealPath(originFiles.get(i).getFilePath())).delete();
					productService.deleteOriginFile(originFiles.get(i).getChangeName());
				}
				
				productFiles.add(productFile);
			}
		}
		
		log.info("파일들 : {}", productFiles);
		
		int result = productService.updateProduct(product, productDetail, productForm, 
												tagList, productFiles);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "상품 수정 성공!");
			return "redirect:/product/" + product.getProductNo();
		}
		
		model.addAttribute("errorMsg", "상품 수정 실패..ㅠ");
		return "error/errorPage";
		
	}
}

















