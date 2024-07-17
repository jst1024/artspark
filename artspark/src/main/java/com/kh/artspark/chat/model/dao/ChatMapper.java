package com.kh.artspark.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatMapper {

	List<Map<String, Object>> findByIdChatroom(String loginUserId);

}
