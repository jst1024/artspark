package com.kh.artspark.chat.model.service;

import java.util.List;
import java.util.Map;

public interface ChatService {

	List<Map<String, Object>> findByIdChatroom(String loginUserId);

}
