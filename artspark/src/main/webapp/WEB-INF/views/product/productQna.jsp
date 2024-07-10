<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작가 문의</title>
    <jsp:include page="../common/head.jsp"></jsp:include>
    <style>
        #white-board {
        	width: 100%;
        	height: 600px;
        	padding: 30px;
        	border: 1px solid #333;
        	margin-bottom: 100px;
        }
        
        #editor {
        	width: 100%;
        	height: 600px;
        	padding: 30px;
        	border: 1px solid #333;
        	margin-bottom: 50px;
        }
        
        .btn-group {
        	width: 100%;
        	margin:auto;
        	margin-bottom: 100px;
        	display: flex;
    		justify-content: center; /* 가로 가운데 정렬 */
        }
        
        .btn-group button{
        	margin: 0 10px;
        }
        
        .big-btn {
        	width: 308px;
        	height: 60px;
        	margin-bottom: 20px;
        	border: none;
        	color: white;
        }
        
        #send-btn {
        	background-color: #14213d;
        }
        #send-btn:hover {
        	background-image: linear-gradient(rgba(255,255,255,0.2),rgba(255,255,255,0.2));	
        }
        
        #cancle-btn {
        	background-color: #ff5e26;
        }
        #cancle-btn:hover {
        	background-image: linear-gradient(rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.2));
        }
    </style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
    <div class="container container-custom mt-5">
    	<div class="row">
    		<div class="col-md-4"></div>
    		<div class="col-md-4" style="text-align:center;">
        		<h2 style="margin-top:10px;">초안 그리기</h2><br>
        	</div>
        	<div class="col-md-4"></div>
        </div>
        
	    <!-- 본문 들어갈 자리 -->
	    <div class="row" style="margin-bottom: 150px;">
			<div class="col-md-12">
	            <div id="white-board">
	            	<h2>화이트보드 들어갈 자리</h2>
	            </div>
	        </div>
	        
	        <div class="col-md-4"></div>
    		<div class="col-md-4" style="text-align:center;">
        		<h2 style="margin-top:10px;">문의 내용 작성</h2><br>
        	</div>
        	<div class="col-md-4"></div>
	        
	        <div class="col-md-12">
	            <div id="editor">
	            	<h2>네이버에디터 들어갈 자리</h2>
	            </div>
	        </div>
	        
	        <div class="col-md-4"></div>
	        <div class="col-md-4" style="text-align:center;">
	        	<p><small style="color: red;"><i class="fas fa-exclamation-circle"></i>글을 작성하면 판매자에게 알람이 전송됩니다.</small></p>
	        </div>
	        <div class="col-md-4"></div>
	        
	        <div class="btn-group">
		        <button type="submit" class="big-btn" id="send-btn">보내기</button>
		        <button type="button" class="big-btn" id="cancle-btn" onclick="backpage();">취소</button>
			</div>
			
			<script>
				function backpage() {
					location.href = "productDetail";
				}
			</script>
	    </div>
	</div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>