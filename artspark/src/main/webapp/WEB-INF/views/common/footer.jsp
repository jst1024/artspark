<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <style>
        /* div{border:1px solid red;} */
        #footer {
            width: 100%;
            height: 200px;
            margin: auto;
            margin-top: 50px;
        }
        #footer-1 {
            width: 100%;
            height: 20%;
            border-top: 1px solid lightgray;
            border-bottom: 1px solid lightgray;
        }
        #footer-2 {
            width: 100%;
            height: 80%;
        }
        #footer-1, #footer-2 {
            padding-left: 50px;
        }
        #footer-1 a {
            text-decoration: none;
            font-weight: 600;
            margin: 10px;
            line-height: 40px;
            color: black;
        }
        #footer-1 a:first-child {
        	margin-left: 210px;
        }
        #footer-2 p {
            margin: 0;
            margin-left: 200px;
            padding: 10px;
            font-size: 13px;
        }
        #p2 {
            text-align: center;
        }
        .sticky-button {
		    position: fixed;
		    bottom: 60px;
		    right: 40px;
		    width: 70px;
		    height: 70px;
		    background-color: #ff6e40;
		    border-radius: 50%;
		    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    cursor: pointer;
		    z-index: 1000;
		}
		
		.sticky-button p {
		    margin: 0;
		    line-height: 1;
		}
    </style>
</head>
<body>
    <div id="footer">
        <div id="footer-1">
            <a href="#">이용약관</a> | 
            <a href="#">개인정보취급방침</a> | 
            <a href="noticelist">공지사항</a> | 
            <a href="qnalist">문의사항</a>
        </div>
        <br>
        <br>
        <div id="footer-2">
            <p id="p1">
               주소 : 서울시 중구 남대문로1가 48-6 2층 / 대표전화 : xx-xxx-xxxx / E-mail : artspark@artspark.kr<br>
               회사명 : artspark  사업자등록번호 : xxx-xx-xxxxx<br>
               artspark는 통신판매 플랫폼 제공자이며, 통신판매의 당사자가 아닙니다. 상품, 상품정보, 거래에 관한 의무와 책임은 판매회원에게 있습니다.<br>
            </p>
            <br> 
            <p id="p2">Copyright © 2024 All Right Reserved</p>
        </div>
    </div>
    
    <div class="sticky-button">
	    <p style="color:white;">채팅</p>
	    <div class="badge"></div>
	</div>
    
    <script>
		const loginUser = '${sessionScope.loginUser.memId}';
		
		$('.sticky-button').on('click', function() {
			if(loginUser === '') {
				alertify.alert("로그인 후 이용 가능합니다.").setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
			} else {
				location.href = "${path2}/private-chat";
			}
		});
	</script>
</body>
</html>
