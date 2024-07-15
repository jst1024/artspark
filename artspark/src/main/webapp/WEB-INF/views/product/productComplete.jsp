<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path1" value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작품 구매</title>
    <jsp:include page="../common/head.jsp"></jsp:include>
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
                        <p>${ payment.paymentMethod }</p>
                    </div>
                </div>
                
                <div class="form-group row">
                    <div class="col-sm-2">
                        <p><strong>입금자명</strong></p>
                    </div>
                    <div class="col-sm-10">
                        <p>${ payment.paymentName }</p>
                    </div>
                </div>
                
                <div class="form-group row">
                    <div class="col-sm-2">
                        <p><strong>연락처</strong></p>
                    </div>
                    <div class="col-sm-10">
                        <p>${ payment.paymentPhone }</p>
                    </div>
                </div>
                
                <div class="form-group row">
                    <div class="col-sm-2">
                        <p><strong>이메일</strong></p>
                    </div>
                    <div class="col-sm-10">
                        <p>${ payment.paymentEmail }</p>
                    </div>
                </div>
                
                <div class="form-group row">
                    <div class="col-sm-2">
                        <p><strong>요청사항</strong></p>
                    </div>
                    <div class="col-sm-10">
                        <p>${ payment.paymentRequest }</p>
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
					        <span>${ productDetail.productPurpose }</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span><strong>해상도</strong></span>
					        <span>${ productDetail.detailPixel }</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span><strong>기본 사이즈</strong></span>
					        <span>${ productDetail.detailSize }</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span><strong>수정 횟수</strong></span>
					        <span>${ productDetail.updateCount }회</span>
					    </p>
					    <p class="d-flex justify-content-between" style="margin-bottom: 20px;">
					        <span><strong>작업 기간</strong></span>
					        <span>${ productDetail.detailWorkdate }</span>
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
                		<p style="font-size:28px;">${ memNickname }</p>
                		<p>${ productTitle }</p><br>
                		<c:forEach items="${ buyOptionList }" var="buyOption" varStatus="i">
		                    <p class="d-flex justify-content-between buy-option" style="margin-top: 20px;">
		                    	<input type="hidden" id="buyOptionPrice${i.index + 1}" name="buyOptionPrice" value="${ buyOption.buyOptionPrice }">
		                    	<input type="hidden" id="buyOptionAmount${i.index + 1}" name="buyOptionAmount" value="${ buyOption.buyOptionAmount }">
		                    	<input type="hidden" id="buyOptionName${i.index + 1}" name="buyOptionName" value="${ buyOption.buyOptionName }">
			                    <input type="hidden" id="buyDetailOptionName${i.index + 1}" name="buyDetailOptionName" value="${ buyOption.buyDetailOptionName }">
						        <span><strong>${ buyOption.buyOptionName } / ${ buyOption.buyDetailOptionName } / ${ buyOption.buyOptionAmount }개</strong></span>
						        <span>${ buyOption.buyOptionPrice }원</span>
						    </p>
					    </c:forEach>
					    <p class="d-flex justify-content-between">
					        <span style="font-size:28px;"><strong>총 결제 금액</strong></span>
					        <span id="total-price" style="color: #ff5200; font-size:28px; font-weight:bold;">${ totalPrice }원</span>
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
		$(() => {
			// 구매 옵션별 가격과 수량 곱하고 localeString으로 바꾸기
			$('.buy-option').each(function() {
				const buyOptionPrice = $(this).find('input').eq(0).val();
				const buyOptionAmount = $(this).find('input').eq(1).val();
				
				const price = buyOptionPrice * buyOptionAmount;
				
				const localePrice = price.toLocaleString() + '원';
				
				$(this).find('span').eq(1).text(localePrice);
			});
			
			// 총 가격 localeString으로 바꾸기
			let totalPrice = $('#total-price').text().replace('원', '');
			totalPrice = (parseInt(totalPrice)).toLocaleString();
			$('#total-price').text(totalPrice + '원');
		});
	
		function productCompleteForward() {
			const pno = parseInt('${productDetail.productNo}');
			location.href = "${path1}/product/" + pno;
		}
	
		function backpage() {
			location.href = "${path1}/product";
		}
	</script>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>