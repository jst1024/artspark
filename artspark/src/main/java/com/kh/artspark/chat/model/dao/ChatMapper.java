package com.kh.artspark.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.artspark.chat.model.vo.Chat;

@Mapper
public interface ChatMapper {

	List<Map<String, Object>> findByIdChatroom(String loginUserId);

	List<Chat> findChatings(int loginUserId);

	int insertChat(Map<String, Object> map);

}
