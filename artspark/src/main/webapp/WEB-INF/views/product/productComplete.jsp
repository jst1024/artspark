<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작품 구매</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
    	#profileImg {
    		width:160px;
    		height:auto;
    		object-fit: cover;
    	}
    	.form-group label {
            font-weight: bold;
        }
        .form-text {
            font-size: 0.875rem;
        }
        .email-group {
            display: flex;
        }
        .email-group select {
            margin-left: 10px;
            width: 120px;
        }
        .form-inline .form-check {
            margin-left: 0;
        }
        .container-custom {
            max-width: 1200px;
            padding: 30px 50px;
            margin: 40px auto;
            border: 1px solid #ddd;
        }
        .help-text {
            margin-top: 5px;
        }
        .payment-methods {
            display: flex;
            align-items: center;
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
        #cancle-btn {
        	background-color: #ff5e26;
        }
        #cancle-btn:hover {
        	background-image: linear-gradient(rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.2));
        }
        #buy-btn {
        	background-color: skyblue;
        }
        #buy-btn:hover {
        	background-image: linear-gradient(rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.2));	
        }
    </style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	
	<!-- 결제 정보 -->
    <div class="container-custom">
    	<h2 style="margin-top:10px;">결제 완료</h2><br>
	    <div class="card" style="border:none;">
	        <div class="card-body">
                
                <div class="form-group row">
                    <div class="col-sm-2">
                        <p><strong>결제 방법</strong></p>
                    </div>
                    <div class="col-sm-10">
                        <p>[결제 방법]</p>
                    </div>
                </div>
                
                <div class="form-group row">
                    <div class="col-sm-2">
                        <p><strong>입금자명</strong></p>
                    </div>
                    <div class="col-sm-10">
                        <p>[입금자명]</p>
                    </div>
                </div>
                
                <div class="form-group row">
                    <div class="col-sm-2">
                        <p><strong>연락처</strong></p>
                    </div>
                    <div class="col-sm-10">
                        <p>010-1234-5678</p>
                    </div>
                </div>
                
                <div class="form-group row">
                    <div class="col-sm-2">
                        <p><strong>이메일</strong></p>
                    </div>
                    <div class="col-sm-10">
                        <p>email@email.com</p>
                    </div>
                </div>
                
                <div class="form-group row">
                    <div class="col-sm-2">
                        <p><strong>주문자</strong></p>
                    </div>
                    <div class="col-sm-10">
                        <p>[주문자명]</p>
                    </div>
                </div>
                
                <div class="form-group row">
                    <div class="col-sm-2">
                        <p style="color:red;"><strong>입금 계좌</strong></p>
                    </div>
                    <div class="col-sm-10">
                        <p style="color:red;">xx 은행 : 1111-11-1111 &nbsp;&nbsp;&nbsp;&nbsp; 예금주 : artSpark</p>
                    </div>
                </div>
                
                <div class="form-group row">
                    <div class="col-sm-2">
                        <p><strong>입금 기한</strong></p>
                    </div>
                    <div class="col-sm-10">
                        <p>2일 이내 입금이 안될 경우 자동 취소됩니다.</p>
                    </div>
                </div>
	        </div>
	    </div>
	</div>
	
	<!-- 상세 옵션 -->
	<div class="container-custom">
	    <div class="card" style="border:none;">
	        <div class="card-body">
                <div class="form-group row">
                	<div class="col-sm-5">
	                    <p class="d-flex justify-content-between" style="margin-top: 20px;">
					        <span><strong>제출 파일 유형</strong></span>
					        <span>png</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span><strong>해상도</strong></span>
					        <span>300dpi</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span><strong>기본 사이즈</strong></span>
					        <span>2000이상</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span><strong>수정 횟수</strong></span>
					        <span>2회</span>
					    </p>
					    <p class="d-flex justify-content-between" style="margin-bottom: 20px;">
					        <span><strong>작업 기간</strong></span>
					        <span>결제일로부터 7일</span>
					    </p>
					</div>
                </div>
	        </div>
	    </div>
	</div>
	
	<!-- 상품 정보 및 선택한 가격 옵션 -->
	<div class="container-custom">
	    <div class="card" style="border:none;">
	        <div class="card-body">
                <div class="form-group row">
                	<div class="col-sm-3">
	                    <p style="padding-left:20px;"><img id="profileImg" src="resources/images/test04.png" alt=""></p>
					</div>
                	
                	<div class="col-sm-7">
                		<p style="font-size:28px;">[작가 이름]</p>
                		<p>[작품 제목]</p><br>
	                    <p class="d-flex justify-content-between" style="margin-top: 20px;">
					        <span><strong>[옵션명1] / [옵션선택항목1] / n개</strong></span>
					        <span>25,000원</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span><strong>[옵션명2] / [옵션선택항목2] / n개</strong></span>
					        <span>110,000원</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span><strong>[옵션명3] / [옵션선택항목3] / n개</strong></span>
					        <span>5,000원</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span style="font-size:28px;"><strong>총 결제 금액</strong></span>
					        <span style="color: red; font-size:28px; font-weight:bold;">115,000</span>
					    </p>
					</div>
                </div>
	        </div>
	    </div>
	</div>
	
	<div class="btn-group">
        <button type="submit" class="big-btn" id="buy-btn" onclick="productCompleteForward();">확인</button>
        <button type="button" class="big-btn" id="cancle-btn" onclick="backpage();">취소</button>
	</div>
	
	<script>
		function productCompleteForward() {
			location.href = "productList";
		}
	
		function backpage() {
			location.href = "productList";
		}
	</script>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>