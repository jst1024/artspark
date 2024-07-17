package com.kh.artspark.chat.model.service;

import java.util.List;
import java.util.Map;

import com.kh.artspark.chat.model.vo.Chat;

public interface ChatService {

	List<Map<String, Object>> findByIdChatroom(String loginUserId);

	List<Chat> findChatings(int chatroomNo);

	int insertChat(Map<String, Object> map);

}
