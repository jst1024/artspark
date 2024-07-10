package com.kh.artspark.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.artspark.product.model.vo.DetailOption;
import com.kh.artspark.product.model.vo.PayOption;
import com.kh.artspark.product.model.vo.Product;
import com.kh.artspark.product.model.vo.ProductDetail;
import com.kh.artspark.product.model.vo.ProductFile;
import com.kh.artspark.product.model.vo.Tag;
import com.kh.artspark.product.model.vo.TagCheck;

@Mapper
public interface ProductMapper {
	
	int productAllCount();

	int productCategoryCount(String category);
	
	int productSearchCount();

	int categorySearchCount();
	
	List<Map<String, Object>> findAllProductList(String loginUserId, RowBounds rowBounds);
	
	List<Map<String, Object>> findAllCategoryList(Map<String, String> map, RowBounds rowBounds);

	int insertJjim(Map<String, Object> map);

	int deleteJjim(Map<String, Object> map);

	Map<String, Object> findById(Map<String, Object> map);

	int insertProduct(Product product);

	int insertProductDetail(ProductDetail productDetail);

	Integer tagCheck(Tag tag);

	int insertTag(TagCheck tagCheck);

	int insertTagCheck(Tag tag);
	
	int insertProductFile(ProductFile productFile);

	int insertPayOption(PayOption payOption);

	int insertDetailOption(DetailOption detailOption);

	List<ProductFile> findByIdFile(int productNo);

	List<Tag> findByIdTag(int productNo);

	List<Tag> getTags();

}
