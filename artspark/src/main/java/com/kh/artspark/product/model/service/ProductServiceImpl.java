package com.kh.artspark.product.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.artspark.member.model.vo.Member;
import com.kh.artspark.product.model.dao.ProductMapper;
import com.kh.artspark.product.model.vo.DetailOption;
import com.kh.artspark.product.model.vo.PayOption;
import com.kh.artspark.product.model.vo.Product;
import com.kh.artspark.product.model.vo.ProductDetail;
import com.kh.artspark.product.model.vo.ProductFile;
import com.kh.artspark.product.model.vo.ProductForm;
import com.kh.artspark.product.model.vo.ProductQna;
import com.kh.artspark.product.model.vo.Tag;
import com.kh.artspark.product.model.vo.TagCheck;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

private final ProductMapper productMapper;

	@Override
	public int productAllCount() {
		return productMapper.productAllCount();
	}
	
	@Override
	public int productCategoryCount(String category) {
		return productMapper.productCategoryCount(category);
	}
	
	@Override
	public int productSearchCount(String keyword) {
		return productMapper.productSearchCount(keyword);
	}

	@Override
	public List<Map<String, Object>> findAllProductList(Map<String, String> map, RowBounds rowBounds) {
		return productMapper.findAllProductList(map, rowBounds);
	}
	
	@Override
	public List<Map<String, Object>> findAllCategoryList(Map<String, String> map, RowBounds rowBounds) {
		return productMapper.findAllCategoryList(map, rowBounds);
	}
	
	@Override
	public List<Map<String, Object>> productSearchList(Map<String, String> map, RowBounds rowBounds) {
		return productMapper.productSearchList(map, rowBounds);
	}
	
	@Override
	public List<Tag> getTags() {
		return productMapper.getTags();
	}

	@Override
	public int insertJjim(Map<String, Object> map) {
		return productMapper.insertJjim(map);
	}

	@Override
	public int deleteJjim(Map<String, Object> map) {
		return productMapper.deleteJjim(map);
	}

	@Override
	public Map<String, Object> findById(Map<String, Object> map) {
		return productMapper.findById(map);
	}
	
	@Override
	public List<ProductFile> findByIdFile(int productNo) {
		return productMapper.findByIdFile(productNo);
	}
	
	@Override
	public List<Tag> findByIdTag(int productNo) {
		return productMapper.findByIdTag(productNo);
	}
	
	@Transactional
	@Override
	public int insertProduct(Product product, ProductDetail productDetail,
			ProductForm productForm, List<Tag> tagList, List<ProductFile> productFiles) {
		
		// product 테이블 insert
		productMapper.insertProduct(product);
		int productNo = product.getProductNo();
		
		// productDetail 테이블 insert
		productDetail.setProductNo(productNo);
		productMapper.insertProductDetail(productDetail);
		
		// 태그 테이블에 테그이름이 있는지 조회 후, 없으면 두 테이블에 모두 insert
		// 있으면 tagCheck 테이블에만 insert
		for(Tag tag : tagList) {
//			System.out.println(tag);
			Integer tagNo = productMapper.tagCheck(tag);
			
			if(tagNo == null || tagNo == 0) {
				productMapper.insertTagCheck(tag);
				tagNo = tag.getTagNo();
			}
			TagCheck tagCheck = new TagCheck();
			tagCheck.setProductNo(productNo);
			tagCheck.setTagNo(tagNo);
			
			productMapper.insertTag(tagCheck);
		}
		
		// 상품 파일 insert
		for(ProductFile productFile : productFiles) {
			productFile.setProductNo(productNo);
			productMapper.insertProductFile(productFile);
		}
		
		// payOption 이름 중복 비교를 위한 map 생성
		Map<String, PayOption> payOptionMap = new HashMap<>();
		
		//옵션과 상세옵션을 처리
		for(int i=0; i<productForm.getOptionName().size(); i++) {
			
			String optionName = productForm.getOptionName().get(i);
			String detailOptionName = productForm.getDetailOptionName().get(i);
			int detailOptionPrice = productForm.getDetailOptionPrice().get(i);
			
			PayOption payOption = payOptionMap.get(optionName);
			if(payOption == null) {
				payOption = new PayOption();
				payOption.setOptionName(optionName);
				payOption.setProductNo(productNo);
				productMapper.insertPayOption(payOption);
				payOptionMap.put(optionName, payOption);
			}
			
			DetailOption detailOption = new DetailOption();
			detailOption.setDetailOptionName(detailOptionName);
			detailOption.setDetailOptionPrice(detailOptionPrice);
			detailOption.setPayOptionNo(payOption.getPayOptionNo());
			productMapper.insertDetailOption(detailOption);
		}
		
		return 1;
	}

	@Transactional
	@Override
	public int deleteProduct(int productNo) {
		
		// 상품 삭제(status 'N'으로 업데이트)
		int result = productMapper.deleteProduct(productNo);
		
		// 찜 테이블에서 삭제
		productMapper.deleteProductJjim(productNo);
		
		return result;
	}

	@Override
	public int deleteOriginFile(String changeName) {
		return productMapper.deleteOriginFile(changeName);
	}

	@Transactional
	@Override
	public int updateProduct(Product product, ProductDetail productDetail,
			ProductForm productForm, List<Tag> tagList, List<ProductFile> productFiles) {
		
		// product 테이블 update
		productMapper.updateProduct(product);
		int productNo = product.getProductNo();
		
		// productDetail 테이블 update
		productDetail.setProductNo(productNo);
		productMapper.updateProductDetail(productDetail);
		
		// 기존 태그 삭제
		productMapper.deleteTag(productNo);
		
		// 태그 테이블에 테그이름이 있는지 조회 후, 없으면 두 테이블에 모두 insert
		// 있으면 tagCheck 테이블에만 insert
		for(Tag tag : tagList) {
//			System.out.println(tag);
			Integer tagNo = productMapper.tagCheck(tag);
			
			if(tagNo == null || tagNo == 0) {
				productMapper.insertTagCheck(tag);
				tagNo = tag.getTagNo();
			}
			TagCheck tagCheck = new TagCheck();
			tagCheck.setProductNo(productNo);
			tagCheck.setTagNo(tagNo);
			
			productMapper.insertTag(tagCheck);
		}
		
		// 상품 파일 insert
		for(ProductFile productFile : productFiles) {
			productFile.setProductNo(productNo);
			productMapper.insertProductFile(productFile);
		}
		
		// 기존 가격 옵션 제거
		productMapper.deleteOptions(productNo);
		
		// payOption 이름 중복 비교를 위한 map 생성
		Map<String, PayOption> payOptionMap = new HashMap<>();
		
		//옵션과 상세옵션을 처리
		for(int i=0; i<productForm.getOptionName().size(); i++) {
			
			String optionName = productForm.getOptionName().get(i);
			String detailOptionName = productForm.getDetailOptionName().get(i);
			int detailOptionPrice = productForm.getDetailOptionPrice().get(i);
			
			PayOption payOption = payOptionMap.get(optionName);
			if(payOption == null) {
				payOption = new PayOption();
				payOption.setOptionName(optionName);
				payOption.setProductNo(productNo);
				productMapper.insertPayOption(payOption);
				payOptionMap.put(optionName, payOption);
			}
			
			DetailOption detailOption = new DetailOption();
			detailOption.setDetailOptionName(detailOptionName);
			detailOption.setDetailOptionPrice(detailOptionPrice);
			detailOption.setPayOptionNo(payOption.getPayOptionNo());
			productMapper.insertDetailOption(detailOption);
		}
		
		return 1;
	}

	// 어드민에 쓸 리스트야
	@Override
	public List<Product> productFindAll(Map<String, Integer> map) {
		return productMapper.productFindAll(map);
	}

	@Override

	public int updateProductStatus(String productNo, String newStatus) {
		return productMapper.updateProductStatus(productNo, newStatus);
	}

	@Override
	public int deletedProductCount() {
		return productMapper.deletedProductCount();
	}

	@Override
	public List<Product> deletedProductFindAll(Map<String, Integer> map) {
		return productMapper.deletedProductFindAll(map);
	}
	
	public int productQnaCount(int productNo) {
		return productMapper.productQnaCount(productNo);
	}

	@Override
	public List<ProductQna> findProductQnaList(int productNo, RowBounds rowBounds) {
		return productMapper.findProductQnaList(productNo, rowBounds);

	}
	
}















