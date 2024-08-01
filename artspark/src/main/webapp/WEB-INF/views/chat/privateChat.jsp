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
		    word-wrap: break-word; 
        }

        .message-content {
            margin-bottom: 5px;
        }

        .message-row.you .message {
            background-color: #dee2e6;
            color: #0f5132;
            margin-right: auto;
        }

        .message-row.me .message {
            background-color: #fd6901;
            color: white;
            margin-left: auto;
        }
        
        .message-row.me .message:after {
		    content: '';
		    position: absolute;
		    top: 10px;
		    right: -10px;
		    border-width: 10px;
		    border-style: solid;
		    border-color: #fd6901 transparent transparent transparent;
		}
		
		.message-row.you .message:after {
		    content: '';
		    position: absolute;
		    top: 10px;
		    left: -10px;
		    border-width: 10px;
		    border-style: solid;
		    border-color: #dee2e6 transparent transparent transparent;
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
        	
        	<!-- 채팅방 목록 -->
        	<c:choose>
	        	<c:when test="${ not empty chatrooms }">
		            <c:forEach items="${ chatrooms }" var="chatroom">
		            	<div class="chat-list-item">
		            		<input type="hidden" id="chatroom-no" value="${ chatroom.chatroomNo }">
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
	            </c:when>
	            <c:otherwise>
	            	<p style="font-size : 20px;">채팅방이 존재하지 않습니다.</p>
	            </c:otherwise>
	        </c:choose>
            
            <!-- 추가적인 채팅방 아이템들 -->
        </div>
        
        <!-- 채팅방 -->
        <div class="chat-content">
        
            <!-- 상세 채팅 내용 -->
            <div class="chat-container">
            
                <h2 style="text-align : center;">선택된 채팅방이 없습니다.</h2>
                
            </div>
            
        </div>
    </div>
    
    <script>
    	let chat;
    	let chatPartner;
    	let chatroomNo;
    	
    	// 채팅방 클릭 이벤트
		$('.chat-list-item').on('click',  function(e) {
			chatroomNo = $(e.currentTarget).children().eq(0).val();
			chatPartner = $(e.currentTarget).find('.username').text();
			const loginUserId = '${sessionScope.loginUser.memId}';
			let chatHead = '';
			let chatContent = '<div class="chat-container">';
			let chatInput = '';
			
			chatInput += '<div class="input-area">'
				   + '<input type="text" id="message" placeholder="메시지를 입력하세요...">'
				   + '<button onclick="send(' + chatroomNo + ');">전송</button>'
				   + '</div>';
				   
			$('.chat-content').html('');
			
			// 소켓 연결된 상태라면, 소켓 연결을 끊음
			if(chat !== undefined) {
				disconnect();
			} 
			
			$.ajax({
				url : 'chat-info',
				type : 'get',
				data : {
					chatroomNo : chatroomNo
				},
				success : result => {
					// 채팅창 띄워주는 로직
					const chatList = result.data;
					
					chatHead += '<div class="chat-header">'
								  +	'<img src="https://via.placeholder.com/40" alt="User Image">'
								  +	'<div class="user-info">'
								  + '<span class="username">' + chatPartner + '</span>'
								  +	'</div></div>';
					
					chatList.map((chat, i) => {
						if(chat.memId === loginUserId) {
							chatContent += '<div class="message-row me">';
						} else {
							chatContent += '<div class="message-row you">'
						}
						console.log(chat.chatContent);
						chatContent += '<div class="message">'
									 + '<div class="message-content">'
									 + chat.chatContent
									 + '</div>'
									 + '<div class="message-info">'
									 + '<span class="time">' + chat.chatTime + '</span>'
									 + '</div>'
									 // + '<div class="read-status">1</div>'
									 + '</div></div>';
					});
					chatContent += '</div>';
					
					$('.chat-content').html(chatHead + chatContent + chatInput);
					scrollToBottom();
				},
				error : e => {
					$('.chat-content').html('');
					
					chatHead += '<div class="chat-header">'
						  +	'<img src="https://via.placeholder.com/40" alt="User Image">'
						  +	'<div class="user-info">'
						  + '<span class="username">' + chatPartner + '</span>'
						  +	'</div></div>';
					$('.chat-content').html(chatHead);
					
					chatContent += '</div>';
					
					$('.chat-content').html(chatHead + chatContent + chatInput);	 
				}
			});
			
			// 소켓 연결
			const uri = 'ws://192.168.20.222//artspark/chat';
    		chat = new WebSocket(uri);
    		
    		chat.onopen = () => {	// 소켓 연결 시 수행되는 핸들러
    			console.log("서버 접속 성공");
    		};
    		
    		chat.onclose = () => {
    			console.log("서버 종료");    			
    		};
    		
    		chat.onerror = e => {
    			console.log(e);
    			console.log('서버 연결 과정에서 문제 생김');
    		};
    		
    		// 서버로부터 온 메세지 수신
    		chat.onmessage = e => {
				const message = e.data;
				const msgData = JSON.parse(message);
				let newChat = '';
				
				if(msgData.chatroomNo != chatroomNo) {
					return;
				} 
				
				if(loginUserId === msgData.memId) {
					newChat += '<div class="message-row me">'
				} else {
					newChat += '<div class="message-row you">'
				}
				
				newChat += '<div class="message">'
							 + '<div class="message-content">'
							 + msgData.chatContent
							 + '</div>'
							 + '<div class="message-info">'
							 + '<span class="time">' + msgData.chatTime + '</span>'
							 + '</div>'
							 // + '<div class="read-status">1</div>'
							 + '</div></div>';
				
				$('.chat-container').append(newChat);
				scrollToBottom();
			};
		});
    	
    	// 새로운 채팅이 올라오면 채팅방스크롤을 맨아래로 하게 함
    	function scrollToBottom() {
    	    var chatContainer = document.querySelector('.chat-container');
    	    chatContainer.scrollTop = chatContainer.scrollHeight;
    	}
    	
    	// 소켓 연결 종료
    	function disconnect() {
			chat.close();
		}
		
    	// 소켓 메세지 전송
    	// ajax로 메세지를 먼저 컨트롤러로 보내서 db에 저장한 후 send()로 웹소켓 서버로 보내줄거임
		function send(roomNo) {
			let message = document.getElementById('message').value;
			console.log(roomNo);
			if(message !== '') {
				$.ajax({
					url : 'insert-chat',
					type : 'post',
					data : {
						message : message,
						chatroomNo : roomNo
					},
					success : result => {
						console.log(result);
						const msgData = {
							content : message,
							chatPartner : chatPartner,
							chatroomNo : roomNo
						};
						
						chat.send(JSON.stringify(msgData));
						document.getElementById('message').value = '';
					},
					error : e => {
						console.log(e);
						alert('채팅 등록 실패');
					}
				});
			}
		}
    	
		// input 요소에 keydown 이벤트 리스너 추가
		$(document).on('keydown', '#message', function(event) {
		    if (event.key === 'Enter') {
		        send(chatroomNo);
		    }
		});
    	
    </script>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>







