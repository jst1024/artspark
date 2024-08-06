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
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
        	background-color: #fca311;
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
    	<h2 style="margin-top:10px;">주문 / 결제하기</h2><br>
	    <div class="card" style="border:none;">
	        <div class="card-body">
                <div class="form-group row payment-methods">
                	<label for="payerName" class="col-sm-2 col-form-label">결제방법</label>&nbsp;&nbsp;&nbsp;&nbsp;
                    <div class="form-check form-check-inline col-sm-2">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="domesticPayment" value="card" checked>
                        <label class="form-check-label" for="domesticPayment">카드결제</label>
                    </div>
                    <div class="form-check form-check-inline col-sm-2">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="internationalPayment" value="vbank">
                        <label class="form-check-label" for="internationalPayment">가상계좌</label>
                    </div>
                </div>
                
                <div class="form-group row">
                    <label for="payerName" class="col-sm-2 col-form-label">입금자명</label>
                    <div class="col-sm-4">
	                    <form action="${ path1 }/buyComplete" id="buy-complete" method="post">
	                    	<input type="hidden" name="productNo" value="${ productDetail.productNo }">
	                    	<input type="hidden" name="merchant_uid" value="${ merchant_uid }">
	                    	<input type="hidden" name="memNickname" value="${ memNickname }">
	                    	<input type="hidden" name="productTitle" value="${ productTitle }">
	                    	<input type="hidden" name="totalPrice" value="${ totalPrice }">
	                        <input type="text" class="form-control" id="buyerName" name="buyerName" style="width:300px;" placeholder="입금자명">
	                    </form>
                    </div>
                    <div class="col-sm-6">
                        <small class="form-text text-danger">* 작가에게 공개되지 않습니다.<br></small>
                    </div>
                </div>
                
                <div class="form-group row">
                    <label for="contact" class="col-sm-2 col-form-label">연락처</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="buyerPhone" name="buyerPhone" style="width:350px;" placeholder="연락처 입력">
                    </div>
                </div>
                
                <div class="form-group row">
                    <label for="email" class="col-sm-2 col-form-label" >이메일</label>
                    <div class="col-sm-10">
                    	<input type="text" class="form-control" id="buyerEmail" name="buyerEmail" style="width:350px;" placeholder="이메일 입력">
                    </div>
                </div>
                
                <div class="form-group row">
                    <label for="requests" class="col-sm-2 col-form-label">요청사항</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" id="buyerRequest" name="buyerRequest" placeholder="요청사항 입력"></textarea>
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
					        <span>${ productDetail.detailType }</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span><strong>해상도</strong></span>
					        <span>${ productDetail.detailPixel }dpi</span>
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
                		<c:forEach items="${ buyOption.buyOptionName }" varStatus="i">
		                    <p class="d-flex justify-content-between buy-option" style="margin-top: 20px;">
		                    	<input type="hidden" id="buyOptionPrice${i.index + 1}" name="buyOptionPrice" value="${ buyOption.buyOptionPrice[i.index] }">
		                    	<input type="hidden" id="buyOptionAmount${i.index + 1}" name="buyOptionAmount" value="${ buyOption.buyOptionAmount[i.index] }">
		                    	<input type="hidden" id="buyOptionName${i.index + 1}" name="buyOptionName" value="${ buyOption.buyOptionName[i.index] }">
			                    <input type="hidden" id="buyDetailOptionName${i.index + 1}" name="buyDetailOptionName" value="${ buyOption.buyDetailOptionName[i.index] }">
						        <span><strong>${ buyOption.buyOptionName[i.index] } / ${ buyOption.buyDetailOptionName[i.index] } / ${ buyOption.buyOptionAmount[i.index] }개</strong></span>
						        <span>${ buyOption.buyOptionPrice[i.index] }원</span>
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
        <button type="button" class="big-btn" id="buy-btn">주문 / 결제하기</button>
        <button type="button" class="big-btn" id="cancle-btn" onclick="backpage();">취소</button>
	</div>

	<!-- 
		결제 API 사용
		
		결제 동작 과정
		1. 유저가 브라우저에서 결제
		2. 브라우저에서 백엔드로 결제를 확인하는 함수를 트리거
		3. 백엔드에서 포드원으로부터 엑세스토큰을 받음
		4. 방금 발생한 결제에 대한 정보를 요청
		5. 해당 정보를 통해 유저가 결제한 금액이 정확한지 여부 확인
	 -->	
	<script>
		$('#buy-btn').on('click', function() {
			const merchant_uid = $('input[name="merchant_uid"]').val();
			const productNo = $('input[name="productNo"]').val();
			const payMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
			const productTitle = '${productTitle}';
			const price = parseInt('${totalPrice}');
			const buyerName = $('input[name="buyerName"]').val();
			const buyerPhone = $('input[name="buyerPhone"]').val();
			const buyerEmail = $('input[name="buyerEmail"]').val();
			const buyerRequest = $('#buyerRequest').val();
			
			const buyOptionNames = document.querySelectorAll('input[name="buyOptionName"]');
			var buyOptionName = [];
			buyOptionNames.forEach(function(input) {
				buyOptionName.push(input.value);
			});
			
			const buyDetailOptionNames = document.querySelectorAll('input[name="buyDetailOptionName"]');
			var buyDetailOptionName = [];
			buyDetailOptionNames.forEach(function(input) {
				buyDetailOptionName.push(input.value);
			});
			
			const buyOptionAmounts = document.querySelectorAll('input[name="buyOptionAmount"]');
			var buyOptionAmount = [];
			buyOptionAmounts.forEach(function(input) {
				buyOptionAmount.push(parseInt(input.value));
			});
			
			const buyOptionPrices = document.querySelectorAll('input[name="buyOptionPrice"]');
			var buyOptionPrice = [];
			buyOptionPrices.forEach(function(input) {
				buyOptionPrice.push(parseInt(input.value));
			});
			
			IMP.init("imp60481580");
			console.log("결제 모듈이 초기화되었습니다.");
			
			IMP.request_pay({
				pg: "tosspayments", // 결제 대행사를 토스페이먼츠로 지정
			    merchant_uid: merchant_uid, // 고유 주문번호 생성
			    name: productTitle, // 상품명 설정
			    pay_method: payMethod, // 결제 수단 지정
			    escrow: false, // 에스크로 사용 여부 (기본값은 false)
			    amount: price, // 결제 금액 설정
			    buyer_name: buyerName, // 구매자 이름
			    buyer_email: buyerEmail, // 구매자 이메일
			    buyer_tel: buyerPhone, // 구매자 전화번호
			    currency: "KRW", // 통화 설정 (기본값은 KRW)
			    locale: "ko", // 언어 설정 (기본값은 ko, 한국어)
			    custom_data: { buyerRequest: buyerRequest }, // 결제 고유 데이터 설정
			    appCard: false // 앱카드 사용 여부 (기본값은 false)
			    
			}, function(rsp) {
				if(rsp.error_code === 'F400') {
					alertify.alert("결제가 취소되었습니다.").setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
				} else {
			    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
			    	$.ajax({
			    		url: "${path1}/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
			    		type: 'POST',
			    		dataType: 'json',
			    		data: {
				    		imp_uid : rsp.imp_uid,
				    		merchant_uid : rsp.merchant_uid,
							productNo : productNo,
							paymentRequest : buyerRequest,
							buyOptionName : buyOptionName,
							buyDetailOptionName : buyDetailOptionName,
							buyOptionPrice : buyOptionPrice,
							buyOptionAmount : buyOptionAmount
			    		},
			    		success: response => {
			    			// console.log(response.message);
			    			$('#buy-complete').submit();
			    		},
			    		error: e => {
			    			console.log(e);
			    			alertify.alert(e).setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
			    		}
			    	});
				}
			});
		});
	</script>
	
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
		
		// 이전 페이지 포워딩
		function backpage() {
			const pno = parseInt('${productDetail.productNo}');
			location.href = "${path1}/product/" + pno;
		}
	</script>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>