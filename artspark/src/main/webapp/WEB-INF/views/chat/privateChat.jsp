<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1대1 채팅</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
        }

        .container {
            display: flex;
            flex-direction: row;
            width: 90%;
            max-width: 1000px;
            min-height: 700px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            flex: 1;
            margin-top: 50px;
        }

        .chat-list {
            width: 30%;
            background-color: #f2f2f2;
            padding: 20px;
            border-right: 1px solid #e0e0e0;
            overflow-y: auto;
        }

        .chat-list-item {
            display: flex;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #e0e0e0;
            cursor: pointer;
        }

        .chat-list-item img {
            border-radius: 50%;
            margin-right: 10px;
        }

        .chat-list-item .user-info {
            display: flex;
            flex-direction: column;
        }

        .chat-list-item .user-info .username {
            font-weight: bold;
        }

        .chat-list-item .user-info .last-message {
            font-size: 12px;
            color: #777;
        }

        .chat-content {
            display: flex;
            flex-direction: column;
            width: 70%;
            height: 100%;
        }

        .chat-header {
            display: flex;
            align-items: center;
            padding: 10px;
            background-color: #fff;
            border-bottom: 1px solid #e0e0e0;
        }

        .chat-header img {
            border-radius: 50%;
            margin-right: 10px;
        }

        .chat-header .user-info {
            display: flex;
            flex-direction: column;
        }

        .chat-header .user-info span {
            font-size: 14px;
        }

        .chat-header .user-info .username {
            font-weight: bold;
        }

        .chat-container {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
        }

        .message-row {
            display: flex;
            margin-bottom: 10px;
            align-items: flex-end;
        }

        .message-row.you {
            justify-content: flex-start;
        }

        .message-row.me {
            justify-content: flex-end;
        }

        .message {
            max-width: 60%;
            padding: 10px;
            margin: 0 10px;
            border-radius: 15px;
            position: relative;
            font-size: 14px;
        }

        .message-content {
            margin-bottom: 5px;
        }

        .message-row.you .message {
            background-color: #d1e7dd;
            color: #0f5132;
            margin-right: auto;
        }

        .message-row.me .message {
            background-color: #0d6efd;
            color: white;
            margin-left: auto;
        }

        .message-info {
            font-size: 12px;
            display: flex;
            justify-content: space-between;
        }

        .message-info .time {
            margin-right: 10px;
        }

        .message-info .read-status {
            font-weight: bold;
        }

        .read-status {
            display: inline-block;
            color: #333;
            width: 20px;
            height: 20px;
            text-align: center;
            line-height: 20px;
            font-size: 12px;
            position: absolute;
            bottom: 0px;
            right: 0px;
        }

        .message-row.me .read-status {
            left: 20px;
            padding-right: 20px;
            right: auto;
        }

        .message-row.you .read-status {
            right: -10px;
            padding-left: 15px;
        }

        .message-row.me .read-status {
            left: -10px;
        }

        .input-area {
            display: flex;
            align-items: center;
            padding: 10px;
            background-color: #fff;
            border-top: 1px solid #e0e0e0;
        }

        .input-area input[type="text"] {
            flex: 1;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-right: 10px;
        }

        .input-area button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="container">
        <div class="chat-list">
        	<!--  
            <div class="chat-list-item">
                <img src="https://via.placeholder.com/40" alt="User Image">
                <div class="user-info">
                    <span class="username">신범드</span>
                    <span class="last-message">조이조타님이 이모티콘을 보냈어요.</span>
                </div>
            </div>
            <div class="chat-list-item">
                <img src="https://via.placeholder.com/40" alt="User Image">
                <div class="user-info">
                    <span class="username">레모네이드주세요</span>
                    <span class="last-message">만나서 반가워요</span>
                </div>
            </div>
            -->
            <c:forEach items="${ chatrooms }" var="chatroom">
            	<div class="chat-list-item">
                	<img src="https://via.placeholder.com/40" alt="User Image">
	                <div class="user-info">
	                	<c:if test="${ chatroom.memId == sessionScope.loginUser.memId }">
	                    	<span class="username">${ chatroom.memId2 }</span>
	                    </c:if>
	                    <c:if test="${ chatroom.memId2 == sessionScope.loginUser.memId }">
	                    	<span class="username">${ chatroom.memId }</span>
	                    </c:if>
	                    <span class="last-message">${ chatroom.lastChat }</span>
	                </div>
	            </div>
            </c:forEach>
            
            <!-- 추가적인 채팅방 아이템들 -->
        </div>
        
        <!-- 채팅방 -->
        <div class="chat-content">
        
        	<!-- 채팅방 목록 -->
            <div class="chat-header">
                <img src="https://via.placeholder.com/40" alt="User Image">
                <div class="user-info">
                    <span class="username">신범드</span>
                    <span class="user-status">보통 1시간 이내 응답</span>
                </div>
            </div>
            
            <!-- 상세 채팅 내용 -->
            <div class="chat-container">
            
                <div class="message-row you">
                    <div class="message">
                        <div class="message-content">
                            안녕하세요!
                        </div>
                        <div class="message-info">
                            <span class="time">3:42 PM</span>
                        </div>
                        <div class="read-status">1</div>
                    </div>
                </div>
                
                <div class="message-row me">
                    <div class="message">
                        <div class="message-content">
                            안녕하세요! 반갑습니다.
                        </div>
                        <div class="message-info">
                            <span class="time">3:44 PM</span>
                        </div>
                        <div class="read-status">1</div>
                    </div>
                </div>
                
            </div>
            
            <!-- 채팅 전송 -->
            <div class="input-area">
                <input type="text" id="message" placeholder="메시지를 입력하세요...">
                <button onclick="send();">전송</button>
            </div>
        </div>
    </div>
    
    <script>
    	var chat;
    	
    	$('#chat-start').on('click', function() {
    		const uri = 'ws://localhost/artspark/chat';
    		chat = new WebSocket(uri);
    		
    		chat.onopen = () => {	// 소켓 연결 시 수행되는 핸들러
    			console.log("서버 접속 성공");
    		};
    		
    		chat.onclose = () => {
    			console.log("서버 접속 실패");    			
    		};
    		
    		chat.onerror = e => {
    			console.log(e);
    			console.log('서버 연결 과정에서 문제 생김');
    		};
    		
    		chat.onmessage = e => {
				const message = e.data;
				const msgData = JSON.parse(message);
				const loginUserId = '${sessionScope.loginUser.memId}';
				let wrap = '';
				
				// console.log(msgData);
				// console.log(message);
				
				if(loginUserId === msgData.memId) {
					wrap += '<div class="message-row me">'
				} else {
					wrap += '<div class="message-row you">'
				}
				wrap += '<div class="message">'
					    + '<div class="message-content">'
					    + msgData.chatContent
					    + '</div>'
					    + '<div class="message-info">'
					    + '<span class="time">'
					    + msgData.chatTime
					    + '</span>'
					    + '</div>'
					    + '<div class="read-status">1</div>'
					    + '</div>'
					    + '</div>';
				
				$('.chat-container').append(wrap);
				scrollToBottom();
			}
    	});
    	
    	// 새로운 채팅이 올라오면 채팅방스크롤을 맨아래로 하게 함
    	function scrollToBottom() {
    	    var chatContainer = document.querySelector('.chat-container');
    	    chatContainer.scrollTop = chatContainer.scrollHeight;
    	}
    	
    	function disconnect() {
			group.close();
		}
		
		function send() {
			let message = document.getElementById('message').value;
			
			chat.send(message);
			message = '';
		}
    </script>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>







