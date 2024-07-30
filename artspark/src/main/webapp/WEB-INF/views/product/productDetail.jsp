<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path1" value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작품 상세보기</title>
    <jsp:include page="../common/head.jsp"></jsp:include>
    <style>
    	body {
	    	background-color: #f8f9fa;
		}
    	#profileImg {
    		width:110px;
    		height:110px;
    		object-fit: cover;
    	}
    	.img-preview {
            width: 100%;
            margin-bottom: 20px;
        }
        .product-options {
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .price-option-select {
        	width: 150px;
        }
        .product-details p {
            margin-bottom: 5px;
            text-align: center;
        }
        .product-options {
        	margin-bottom: 10px;
        }
        .product-options select, .product-options input {
            margin-bottom: 10px;
        }
        .product-options .form-group {
            margin-bottom: 15px;
        }
        .btn-custom {
            margin-top: 15px;
        }
        .product-bottom-line {
        	border-bottom: 1px solid #333;
        }
        .big-btn {
        	width: 308px;
        	height: 60px;
        	margin-bottom: 20px;
        	border: none;
        	color: white;
        }
        .small-btn {
        	width: 160px;
        	height: 34px;
        	margin-bottom: 20px;
        	border: none;
        	color: white;
        }
        #artist-qna-btn {
        	background-color: #14213d;
        }
        #artist-qna-btn:hover {
        	background-image: linear-gradient(rgba(255,255,255,0.2),rgba(255,255,255,0.2));	
        }
        #buy-btn {
        	background-color: #fca311;
        }
        #buy-btn:hover {
        	background-image: linear-gradient(rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.2));	
        }
        #review-btn {
        	background-color: #14213d;
        }
        #review-btn:hover {
        	background-image: linear-gradient(rgba(255,255,255,0.2),rgba(255,255,255,0.2));	
        }
        
        .table-head {
        	border-top: 1px solid #e6e6e6; 
        	background-color:#868e96; 
        	color:white; 
        	padding-top:14px;
        }
        .table-body {
        	border-top: 1px solid #e6e6e6; 
        	padding-top:14px;
        	border-bottom: 1px solid #e6e6e6;
        }
        
        .table-body p {
        	text-align: center;
        }
        
        .pagination .page-link {
		    color: #007bff;
		    cursor: pointer;
		}
		
		.pagination .page-item.active .page-link {
		    background-color: #007bff;
		    border-color: #007bff;
		    cursor: pointer;
		}
		
		.plusoption {
			border-bottom: 1px solid #333;
			padding: 20px 0;
		}
		
		.option-counting {
			width:50px;
			height:36px;
			line-height:36px;
			border:1px solid #333;
			margin: 0 10px;
		}
		.number-and-remove {
		    display: flex;
		    align-items: center;
		}
		.number-and-remove span {
		    margin-right: 10px; /* 숫자와 x 버튼 사이의 간격 조정 */
		}
		#option-pick {
			margin-bottom: 16px;
		}
		#total-price {
			text-weight:bold;
		}
		.heart-icon {
		    cursor: pointer;
		    color: red;
		    font-size: 1.5rem;
		}
        .rating-container {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 50px; 
            width: 310px; 
        }
		.star-rating {
            display: inline-block;
            font-size: 0;
            position: relative;
            width: 100px;
            height: 20px;
            background: url('${path1}/resources/images/star-empty.png') repeat-x;
        }
        .star-rating::before {
            content: '';
            display: block;
            width: 0;
            height: 100%;
            background: url('${path1}/resources/images/star-full.png') repeat-x;
            position: absolute;
            top: 0;
            left: 0;
        }
        .star-rating[data-rating="0"]::before { width: 0%; }
        .star-rating[data-rating="0.1"]::before { width: 2%; }
        .star-rating[data-rating="0.2"]::before { width: 4%; }
        .star-rating[data-rating="0.3"]::before { width: 6%; }
        .star-rating[data-rating="0.4"]::before { width: 8%; }
        .star-rating[data-rating="0.5"]::before { width: 10%; }
        .star-rating[data-rating="0.6"]::before { width: 12%; }
        .star-rating[data-rating="0.7"]::before { width: 14%; }
        .star-rating[data-rating="0.8"]::before { width: 16%; }
        .star-rating[data-rating="0.9"]::before { width: 18%; }
        .star-rating[data-rating="1"]::before { width: 20%; }
        .star-rating[data-rating="1.1"]::before { width: 22%; }
        .star-rating[data-rating="1.2"]::before { width: 24%; }
        .star-rating[data-rating="1.3"]::before { width: 26%; }
        .star-rating[data-rating="1.4"]::before { width: 28%; }
        .star-rating[data-rating="1.5"]::before { width: 30%; }
        .star-rating[data-rating="1.6"]::before { width: 32%; }
        .star-rating[data-rating="1.7"]::before { width: 34%; }
        .star-rating[data-rating="1.8"]::before { width: 36%; }
        .star-rating[data-rating="1.9"]::before { width: 38%; }
        .star-rating[data-rating="2"]::before { width: 40%; }
        .star-rating[data-rating="2.1"]::before { width: 42%; }
        .star-rating[data-rating="2.2"]::before { width: 44%; }
        .star-rating[data-rating="2.3"]::before { width: 46%; }
        .star-rating[data-rating="2.4"]::before { width: 48%; }
        .star-rating[data-rating="2.5"]::before { width: 50%; }
        .star-rating[data-rating="2.6"]::before { width: 52%; }
        .star-rating[data-rating="2.7"]::before { width: 54%; }
        .star-rating[data-rating="2.8"]::before { width: 56%; }
        .star-rating[data-rating="2.9"]::before { width: 58%; }
        .star-rating[data-rating="3"]::before { width: 60%; }
        .star-rating[data-rating="3.1"]::before { width: 62%; }
        .star-rating[data-rating="3.2"]::before { width: 64%; }
        .star-rating[data-rating="3.3"]::before { width: 66%; }
        .star-rating[data-rating="3.4"]::before { width: 68%; }
        .star-rating[data-rating="3.5"]::before { width: 70%; }
        .star-rating[data-rating="3.6"]::before { width: 72%; }
        .star-rating[data-rating="3.7"]::before { width: 74%; }
        .star-rating[data-rating="3.8"]::before { width: 76%; }
        .star-rating[data-rating="3.9"]::before { width: 78%; }
        .star-rating[data-rating="4"]::before { width: 80%; }
        .star-rating[data-rating="4.1"]::before { width: 82%; }
        .star-rating[data-rating="4.2"]::before { width: 84%; }
        .star-rating[data-rating="4.3"]::before { width: 86%; }
        .star-rating[data-rating="4.4"]::before { width: 88%; }
        .star-rating[data-rating="4.5"]::before { width: 90%; }
        .star-rating[data-rating="4.6"]::before { width: 92%; }
        .star-rating[data-rating="4.7"]::before { width: 94%; }
        .star-rating[data-rating="4.8"]::before { width: 96%; }
        .star-rating[data-rating="4.9"]::before { width: 98%; }
        .star-rating[data-rating="5"]::before { width: 100%; }
    </style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
    <div class="container container-custom mt-5">
    	<span>${ product.productPurpose } 제작 </span>&nbsp;&nbsp;&nbsp;
    	<small style="color: #999;">${ product.productCategory } / 작품번호 : ${ product.productNo }</small>
    	<p class="d-flex justify-content-between" style="margin-top: 10px;">
	        <span style="font-size:28px;">${ product.memNickname } 작가 · ${ product.productTitle }</span>
	        <span>
	        	<c:if test="${ sessionScope.loginUser.memId.equals(product.memId) }">
		        	<a href="${path1 }/product/productUpdateForward?pno=${product.productNo}">
		        		<button type="button" class="btn btn-primary">작품수정</button>&nbsp;&nbsp;
		        	</a>
		        	<button type="button" id="deleteBtn" class="btn btn-danger">작품삭제</button>&nbsp;&nbsp;
	        	</c:if>
	        	<a href="${path1 }/product">
	        		<button type="button" class="btn btn-secondary">목록</button>
	        	</a>
	        </span>
	    </p><br>
        
	    <div class="row" style="margin-bottom:150px;">
	        <!-- 이미지 섹션 -->
	        <div class="col-md-8">
	        	<c:forEach items="${ productFiles }" var="productFile">
	            	<img src="${path1 }/${ productFile.filePath }" class="img-preview">
	            </c:forEach>
	        </div>
	
	        <!-- 설명 및 옵션 섹션 -->
	        <div class="col-md-4">
	            <div class="product-options">
	                <div class="product-details">
	                	<div style="margin-bottom: 15px; text-align: right;">
	                		<c:if test="${ sessionScope.loginUser eq null }">
                        		<span class="heart-icon" onclick="loginAlert();">
				                    <i class="far fa-heart"></i>
				                </span>
                        	</c:if>
	                		<c:if test="${ sessionScope.loginUser != null }">
                        		<c:if test="${ product.isLiked eq 1 }">
		                        	<span class="heart-icon" onclick="clickHeart(this)">
		                        		<input type="hidden" name="productNo" value="${ product.productNo }">
					                    <i class="fas fa-heart"></i>
					                </span>
				                </c:if>
				                <c:if test="${ product.isLiked eq 0 }">
		                        	<span class="heart-icon" onclick="clickHeart(this)">
		                        		<input type="hidden" name="productNo" value="${ product.productNo }">
					                    <i class="far fa-heart"></i>
					                </span>
				                </c:if>
			                </c:if>
	                	</div>
	                	<p><img id="profileImg" src="${path1 }/resources/images/profile.png" alt=""></p><br>
	                    <p>${ product.memNickname } 작가</p>
	                    <p><small>${ product.artistIntro }</small><p><br><br>
	                    <div class="rating-container">
	                    	<div class="star-rating" data-rating="${ product.avgStar }"></div>
	                    	<p style="margin-top:5px; margin-left: 10px; font-size:14px;">평점 (${ product.avgStar })</p>
	                    </div>
	                    <br><br>
	                    <p><small style="color:red;"><i class="fas fa-exclamation-circle"></i> 채팅</small></p>
	                    <p><small>채팅은 결제 후에 이용하실 수 있습니다.<br>결제 전에는 작가 문의 및 답변을 이용해주세요.</small></p>
	                </div>
	            </div>
	            
	            <!-- 상세 옵션 -->
	            <div class="product-options" style="background-color: #999; text-align:center; color:white; font-size:20px; margin-bottom:0px;">
	            	<p style="margin-bottom: 0px;">상세 옵션</p>
	            </div>
	            
	            <div class="product-options">
	                <div class="product-details" >
	                    <p class="d-flex justify-content-between" style="margin-top: 20px;">
					        <span>제출 파일 유형</span>
					        <span>${ product.detailType }</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span>해상도</span>
					        <span>${ product.detailPixel }</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span>기본 사이즈</span>
					        <span>${ product.detailSize }</span>
					    </p>
					    <p class="d-flex justify-content-between">
					        <span>수정 횟수</span>
					        <span>${ product.updateCount }회</span>
					    </p>
					    <p class="d-flex justify-content-between" style="margin-bottom: 20px;">
					        <span>작업 기간</span>
					        <span>${ product.detailWorkdate }</span>
					    </p>
	                </div>
	            </div>
	            
	            <!-- 가격 옵션 -->
	            <div class="product-options" style="background-color: #999; text-align:center; color:white; font-size:20px; margin-bottom:0px;">
	            	<p style="margin-bottom: 0px;">가격 옵션</p>
	            </div>
	            
	            <div class="product-options">
	                <div class="product-details product-bottom-line">
	                	<c:forEach items="${ product.payOptionList }" var="payOption">
		                    <p class="d-flex justify-content-between" style="margin-top: 20px;">
						        <span class="option-name">${ payOption.optionName }</span>
						        <select class="price-option-select" id="price-option-select1">
						        	<option value="" selected disabled>선택하세요.</option>
						        	<c:forEach items="${ payOption.detailOptionList }" var="detailOption">
							        	<option value="${ detailOption.detailOptionPrice }">${ detailOption.detailOptionName } [ ${ detailOption.detailOptionPrice }원 ]</option>
						        	</c:forEach>
						        </select>
						    </p>
					    </c:forEach>
	                </div>
	                
	                <!-- 
	                	가격 옵션 선택 시 선택한 옵션 보여주는 div
	                	option text : 옵션 상세 목록 
	                	option value : 가격
	                -->
	                <form action="${ path1 }/buy" id="buy-form" method="post">
		                <div id="select-options"></div>
		                
		                <!--
		                	총 결제 금액
		                	옵션 선택할 때마다 바뀌도록 함
		                -->
		                <div class="product-details">
		                	<p class="d-flex justify-content-between" style="margin-top: 40px; font-size: 24px;">
						        <span>결제 금액</span>
						        <span id="total-price">0원</span>
						        <input type="hidden" name="productNo" value="${ product.productNo }">
						        <input type="hidden" name="productTitle" value="${ product.productTitle }">
						        <input type="hidden" name="memNickname" value="${ product.memNickname }">
						        <input type="hidden" name="memId" value="${ product.memId }">
						        <c:if test="${ not empty loginUser }">
						        	<input type="hidden" id="loginUser" name="loginUser" value="${ sessionScope.loginUser }">	
						        </c:if>
						        <c:if test="${ empty loginUser }">
						        	<input type="hidden" id="loginUser" name="loginUser" value="">	
						        </c:if>
						        <input type="hidden" id="totalPrice" name="totalPrice" value="0">
						    </p>
		                </div>
		                
		                
		                <!-- 선택한 옵션에 대한 가격을 동적으로 추가해주는 구문 -->
		                <script>
		                	$(() => {
		                		let total = 0; // 총 가격
		                		let i = 1; // 추가된 옵션을 넘버링하기 위한 변수
		                		const selectedOptions = new Set(); // 선택된 옵션을 추적하기 위한 set
		                		
		                		$('.price-option-select').on('change', function() {
		                			const selectPrice = parseInt($(this).val()).toLocaleString();
		                			let selectDetailOption = $(this).find('option:selected').text();
		                			selectDetailOption = selectDetailOption.replace(/\s*\[.*?\]\s*/g, "");
		                			const selectOption = $(this).closest('p').find('.option-name').text();
		                			const optionKey = selectOption + ' / ' + selectDetailOption;
		                			// console.log(optionKey);
		                			
		                			// 이미 선택된 옵션인지 확인
		                			if(selectedOptions.has(optionKey)) {
		                				alertify.alert('ㅇ? 이미선택한거임').setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
		                				// 다시 드롭다운 옵션을 '선택하세요'로 바꿔주기
			                			$('.price-option-select option[value=""]').prop('selected', true);
										return;	                				
		                			}
		                			
		                			selectedOptions.add(optionKey);
		                			
		                			let resultStr = '';
		                			
		                			resultStr += '<div class="product-details plusoption" id="plus-option' + i + '">'
		                					   + '<p class="d-flex justify-content-between" id="option-pick">'
		                					   + '<span>' + selectOption + ' / ' + selectDetailOption + '</span>'
		                					   + '</p>'
		                					   + '<div class="d-flex justify-content-between align-items-center" id="option-group">'
		                					   + '<div class="btn-group" role="group">'
		                					   + '<button type="button" class="btn btn-outline-secondary" id="minusbtn' + i + '">-</button>'
		                					   + '<p class="option-counting" id="option-count' + i + '">1</p>'
		                					   + '<button type="button" class="btn btn-outline-secondary" id="plusbtn' + i + '">+</button>'
		                					   + '</div>'
		                					   + '<div class="number-and-remove">'
		                					   + '<span id="option-price' + i + '">' + selectPrice + '원</span>'
		                					   + '<input hidden="text" id="selectedOption' + i + '" name="buyOptionName" value="' + selectOption +'">'
		                					   + '<input hidden="text" id="selectedDetailOption' + i + '" name="buyDetailOptionName" value="' + selectDetailOption +'">'
		                					   + '<input hidden="text" id="selectedPrice' + i + '" name="buyOptionPrice" value="' + parseInt($(this).val()) +'">'
		                					   + '<input hidden="text" id="selectedCount' + i + '" name="buyOptionAmount" value="' + 1 + '">'
		                					   + '<button type="button" class="btn btn-outline-secondary" id="deletebtn' + i + '">×</button>'
		                					   + '</div></div></div>';
		                			
		                			i += 1;
		                			total += parseInt($(this).val());
		                			const totalText = parseInt(total).toLocaleString() + '원';
		                			$('#total-price').text(totalText);
		                			$('#select-options').append(resultStr);
		                			$('#totalPrice').val(total);
		                			
		                			// 다시 드롭다운 옵션을 '선택하세요'로 바꿔주기
		                			$('.price-option-select option[value=""]').prop('selected', true);
		                		});
		                		
		                		// '+' 버튼 누르면 수량과 가격 증가
		                		// id^=x 는 아이디가 x로 시작하는 요소를 선택함. ex) xa, xb, xc ...
		                		$('#select-options').on('click', '[id^=plusbtn]', function(e) {
		                			const buttonId = $(this).attr('id');
		                	        const optionId = buttonId.replace('plusbtn', '');
		                	        
		                			// 수량 증가
		                			const countElem = $('#option-count' + optionId);
	        						countElem.text(parseInt(countElem.text()) + 1);
	        						$('#selectedCount' + optionId).val(parseInt(countElem.text()));
		                			
		                			// 가격의 구분기호 제거
		                			const optionPriceElem = $('#option-price' + optionId);
	        						const optionPrice = optionPriceElem.text().replace(/,/g, '');
									
		                			// 옵션 가격 추가 후 locale 형식으로 바꿔줌
		                			const changeOptionPrice = (parseInt(optionPrice) + parseInt($('#selectedPrice' + optionId).val())).toLocaleString() + '원';
	        						optionPriceElem.text(changeOptionPrice);
		                			
		                			// 총 가격 추가
		                			const totalPrice = $('#total-price').text().replace(/,/g, '');
		                			total += parseInt($('#selectedPrice' + optionId).val());
		                			const changeTotalPrice = total.toLocaleString() + '원';
		                			$('#total-price').text(changeTotalPrice);
		                			$('#totalPrice').val(total);
		                		});
		                		
		                		// '-' 버튼 누르면 수량과 가격 감소
		                		$('#select-options').on('click', '[id^=minusbtn]', function(e) {
		                			const buttonId = $(this).attr('id');
		                			const optionId = buttonId.replace('minusbtn', '');
		                			
		                			// 수량이 1일때는 더 이상 내려가지 못하도록 함 
		                			const countElem = $('#option-count' + optionId);
		                			
		                			if(countElem.text() === '1') {
		                				return;
		                			}
		                			countElem.text(parseInt(countElem.text()) - 1);
		                			$('#selectedCount' + optionId).val(parseInt(countElem.text()));
		                			
		                			// 가격의 구분기호 제거
		                			const optionPriceElem = $('#option-price' + optionId);
	        						const optionPrice = optionPriceElem.text().replace(/,/g, '');
	        						
	        						// 옵션 가격 뺀 후 locale 형식으로 바꿔줌
		                			const changeOptionPrice = (parseInt(optionPrice) - parseInt($('#selectedPrice' + optionId).val())).toLocaleString() + '원';
	        						optionPriceElem.text(changeOptionPrice);
	        						
	        						// 총 가격 빼기
		                			const totalPrice = $('#total-price').text().replace(/,/g, '');
		                			total -= parseInt($('#selectedPrice' + optionId).val());
		                			const changeTotalPrice = total.toLocaleString() + '원';
		                			$('#total-price').text(changeTotalPrice);
		                			$('#totalPrice').val(total);
		                		});
		                		
		                		// 'x' 버튼 누르면 해당 옵션 삭제 후 총가격 감소
		                		$('#select-options').on('click', '[id^=deletebtn]', function(e){
		                			const buttonId = $(this).attr('id');
		                			const optionId = buttonId.replace('deletebtn', '');
		                			
		                			const optionPriceElem = $('#option-price' + optionId);
		                			const optionPrice = optionPriceElem.text().replace(/,/g, '');
		                			
		                			// 총 가격 계산
		                			const totalPrice = $('#total-price').text().replace(/,/g, '');
		                			total -= parseInt(optionPrice);
		                			const changeTotalPrice = total.toLocaleString() + '원';
		                			$('#total-price').text(changeTotalPrice);
		                			$('#totalPrice').val(total);
		                			
		                			// set에서 제거
		                			const optionKey = $('#selectedOption' + optionId).val() + ' / '
		                							+ $('#selectedDetailOption' + optionId).val();
		                			selectedOptions.delete(optionKey);
		                			// console.log(optionKey);
		                			// 현재 div요소 삭제
		                			$('#plus-option' + optionId).remove();
		                		});
		                		
		                		// 로그인 안했을때 / 선택한 가격옵션이 없으면 alert 띄워주기
			                	$('.product-details').on('click', '#buy-btn', function(e) {
			                		
									if($('#loginUser').val() === '') {
										alertify.alert('로그인 하셈').setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
										return;
									}			                		
			                		
									// console.log($('#select-options').html());
			                		if($('#select-options').html() === '') {
			                	 		alertify.alert('옵션 하나이상 넣으셈').setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
			                			return;
			                		}
			                		
			                		// console.log("하잉");
			                		$('#buy-form').submit();
			                	})
		                	});
		                	
		                	// 빈 하트 클릭 시 : 빨간 하트로 토글 및 로그인유저의 찜 목록에 상품 추가
		        			// 빨간 하트 클릭 시 : 빈 하트로 토글 및 로그인유저의 찜 목록에서 상품 삭제
		                	function clickHeart(event) {
		                		
		                		const productNo = $(event).children().eq(0).val();
		                		const icon = $(event).children().eq(1).attr('class');
		                		
		                		if (icon === 'far fa-heart') { // 찜이 안되어있는 경우
		        			        $(event).children().eq(1).attr('class', 'fas fa-heart')
		        			        
		        			        // 찜테이블에 등록
		        			        $.ajax({
		        	        			url : '${path1}/product/jjim/' + productNo,
		        	        			type : 'post',
		        	        			success : result => {
		        	        				alertify.alert(result.message).setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
		        	        			}
		        	        		});
		        			    } else { // 찜이 되어있는 경우
		        			    	$(event).children().eq(1).attr('class', 'far fa-heart')
		        			    	
		        			        // 찜테이블에서 삭제
		        			        $.ajax({
		        	        			url : '${path1}/product/jjim/' + productNo,
		        	        			type : 'delete',
		        	        			success : result => {
		        	        				alertify.alert(result.message).setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
		        	        			}
		        	        		});
		        			    }
		                	}
		                	
		                	// 로그인 안하고 하트 누를 시 경고메세지 alert
		                	function loginAlert() {
		                		alertify.alert('로그인이 필요합니다.').setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
		                	}
		                	
		                	// 작가 문의 페이지로 이동
		                	function productQnaForward() {
		                		location.href = '${path1}/productQna';
		                	}
		                	
		                	// 작품삭제 버튼 클릭 시
		                	$('#deleteBtn').on('click', function(e) {
		                		// const deleteCheck = confirm('진짜 삭제할거임?;');
		                		const deleteCheck = alertify.confirm('ArtSpark', 
		                											'진짜 삭제할거임?', 
		                											function() { location.href='${path1}/product/productDelete?productNo=' + ${product.productNo}; },
		                											function() {})
		                											.set({'movable':true, 'moveBounded': true});
		                	});
		                	
		                </script>
		                
		                <div class="product-details">
		                	<p style="margin-top: 40px; margin-bottom: 30px;">
						        <small style="color:red;"><i class="fas fa-exclamation-circle"></i> 작가에게 견적 확인 후 주문해 주세요</small>
						    </p>
		                </div>
		                
		                <div class="product-details">
		                	<button type="button" class="big-btn" id="artist-qna-btn" onclick="productQnaForward();">작가에게 문의하기</button>
		                	<button type="button" class="big-btn" id="buy-btn">주문 / 결제하기</button>
		                </div>
	                </form>
	            </div>
	        </div>
	    </div>
	    
	    <!-- 본문 들어갈 자리 -->
	    <div class="row" style="margin-bottom: 70px;">
	    	<div class="col-md-12">
	            ${ product.productContent }
	        </div>
	        
	    </div>
	    
	    <!-- 태그 -->
	    <div class="tags" style="margin-bottom: 150px; text-align:center; background-color:#f1f3f5">
	    	<span><i class="fas fa-tag"></i> </span>
	    	<span style="font-size: 20px;">
	    		<c:forEach items="${ productTags }" var="tag">
	    			&nbsp;#${ tag.tagName }&nbsp;&nbsp;
	    		</c:forEach>
	    	</span>
	    </div>
	    
	    <!-- 문의 및 답변 -->
	    <div class="row" style="margin-bottom: 50px;">
	    	<div class="col-md-2">
	            <h3>문의 및 답변</h3>
	        </div>
	        <div class="col-md-10">
	            <small style="color:red;"><i class="fas fa-exclamation-circle"></i> 글을 작성하시면 실시간으로 알림 메시지가 발송됩니다.</small>
	        </div>
	        
			<div class="col-md-12">
				<p class="d-flex justify-content-between">
			        <span></span>
			        <button type="button" class="small-btn" id="artist-qna-btn" onclick="productQnaForward();">작가에게 문의하기</button>
			    </p>
	        </div>
	        
	        <div class="row col-md-12" id="productQna-div" style="margin:0;">
            </div>
	        
       		<div class="col-md-2 table-head">
           		<p style="text-align: center;">닉네임</p>
            </div>
            <div class="col-md-8 table-head">
           		<p style="text-align: center;">문의 내용</p>
            </div>
            <div class="col-md-2 table-head">
           		<p style="text-align: center;">작성 시간</p>
            </div>
     
     		<c:forEach begin="1" end="5">
	            <div class="col-md-2 table-body" style="border-bottom: 1px solid #e6e6e6;">
	           		<p style="text-align: center;"><i class="fas fa-lock"></i>****a</p>
	            </div>
	            <div class="col-md-8 table-body" style="border-bottom: 1px solid #e6e6e6;">
	           		<p>비밀글입니다. 작성자와 해당 작가만 볼 수 있습니다.</p>
	            </div>
	            <div class="col-md-2 table-body" style="border-bottom: 1px solid #e6e6e6;">
	           		<p style="text-align: center;">24-06-20</p>
	            </div>
            </c:forEach>
	    </div>
	    
	    <!-- 문의 페이징 -->
	    <nav aria-label="Page navigation" id="productQna-paging">
            <ul class="pagination justify-content-center">
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item active"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">4</a></li>
            </ul>
        </nav>      
	    
	    <!-- 이용 후기 -->
	    <div class="row" style="margin-bottom: 50px; margin-top:150px;">
	    	<div class="col-md-2">
	            <h3>이용 후기</h3>
	        </div>
	        <div class="col-md-10">
	        	<p></p>
	        </div>
	        
			<div class="col-md-12">
				<p class="d-flex justify-content-between">
			        <span></span>
			        <button type="button" class="small-btn" id="review-btn">후기 작성</button>
			    </p>
	        </div>
	        
	        <form action="${path1}/review/insert-form" method="post" id="review-form">
	        	<input type="hidden" name="productNo" value="${product.productNo}">
	        	<input type="hidden" name="productTitle" value="${product.productTitle}">
	        </form>
	        
	        <script>
	        	$('#review-btn').on('click', function() {
	        		const loginUserId = '${sessionScope.loginUser.memId}';
	        		const sellerId = '${product.memId}';
	        		const productNo = parseInt('${product.productNo}');
	        		
	        		if(loginUserId === sellerId) {
	        			alertify.alert('내가 등록한 상품입니다.').setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
	        			return;
	        		}
	        		
	        		if(loginUserId !== '') {
	        			$.ajax({
	        				url : '${path1}/review/buy-product',
	        				type : 'get',
	        				data : {
	        					loginUserId : loginUserId,
	        					productNo : productNo
	        				},
							success : result => {
								if(result.data === 'N') {
									alertify.alert('리뷰는 상품 구매 후 작성 가능합니다.').setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
									return;
								}
								
								else {
									$('#review-form').submit();
								}
							}	        			
	        			});
	        		}
	        		else {
	        			alertify.alert('로그인이 필요합니다.').setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
	        		}
	        	});
	        </script>
	        
	        <!-- 후기 테이블 -->
	        <div class="row col-md-12" id="review-div" style="margin:0;">
            </div>
	    </div>
	    
	    <!-- 후기 페이징 -->
	    <nav aria-label="Page navigation" id="review-paging" style="margin-bottom: 200px;">
        </nav>
	    
	    <script>
	    	const productNo = parseInt('${product.productNo}');
	    
	    	// 문의, 리뷰 로딩
	    	$(() => {
	    		loadReview(1);
	    	});
	    	
	    	// 문의 테이블 / 페이지
	    	function loadProductQna(page) {
	    		$.ajax({
	    			url : '${path1}/productQna',
	    			type : 'get',
	    			data : {
	    				productNo : productNo,
	    				page : page
	    			},
	    			success : result => {
	    				console.log(result);
	    			}
	    		});
	    	}
	    	
	    	// 문의 페이징 처리
	    	
	    	// 리뷰 테이블 / 페이지
	    	function loadReview(page) {
	    		$.ajax({
	    			url : '${path1}/review',
	    			type : 'get',
	    			data : {
	    				productNo : productNo,
	    				page : page
	    			},
	    			success : result => {
	    				const reviewList = result.data.reviewList;
	    				const pageInfo = result.data.pageInfo;
	    				
		            	$('#review-div').append('<div class="col-md-1 table-head"><p style="text-align: center;">번호</p></div>'
		            						   +'<div class="col-md-2 table-head"><p>평점</p></div>'
		            						   +'<div class="col-md-6 table-head"><p>내용</p></div>'
		            						   +'<div class="col-md-1 table-head"><p style="text-align: center;">작성자</p></div>'
		            						   +'<div class="col-md-2 table-head"><p style="text-align: center;">작성일</p></div>');
	    				
	    				if(reviewList.length !== 0) {
		    				reviewList.map((review, i) => {
		    					let str = '';
		    					str += '<div class="col-md-1 table-body">'
		    						 + '<p>' + review.reviewNo + '</p>'
		    						 + '</div>'
		    						 + '<div class="col-md-2 table-body">'
		    						 + '<div class="star-rating" data-rating="' + review.reviewStar + '"></div>'
		    						 + '</div>'
		    						 + '<div class="col-md-6 table-body">'
		    						 + '<p style="text-align:left;">' + review.reviewContent + '</p>'
		    						 + '</div>'
		    						 + '<div class="col-md-1 table-body">'
		    						 + '<p>' + review.memId + '</p>'
		    						 + '</div>'
		    						 + '<div class="col-md-2 table-body">'
		    						 + '<p>' + review.reviewDate + '</p>'
		    						 + '</div>';
		    					
		    					$('#review-div').append(str);
		    				});
		    				
		    				let pagingStr = '';
		    				pagingStr += '<ul class="pagination justify-content-center"';
		    				
							if(pageInfo.currentPage === 1) {
								pagingStr += '<li class="page-item"><a class="page-link">이전</a></li>';
							} else {
								pagingStr += '<li class="page-item"><a class="page-link" onclick="moveReviewPage(' + (pageInfo.currentPage - 1) + ');">이전</a></li>'
							}
							
							for(let i=pageInfo.startPage; i<=pageInfo.endPage; i++) {
								if(pageInfo.currentPage === i) {
									pagingStr += '<li class="page-item active"><a class="page-link">' + i + '</a></li>';
								} else {
									pagingStr += '<li class="page-item"><a class="page-link" onclick="moveReviewPage(' + i + ');">' + i + '</a></li>';
								}
							}
							
							if(pageInfo.currentPage === pageInfo.endPage) {
								pagingStr += '<li class="page-item"><a class="page-link">다음</a></li>';
							} else {
								pagingStr += '<li class="page-item"><a class="page-link" onclick="moveReviewPage(' + (pageInfo.currentPage + 1) + ');">다음</a></li>'
							}
							
							pagingStr += '</ul>';
							
							$('#review-paging').append(pagingStr);
	    				}
	    				else {
	    					$('#review-div').append('<div class="col-md-12 table-body"><p>등록된 후기가 없습니다.</p></div>');
	    				}
	    			}
	    		});
	    	}
	    	
	    	// 리뷰 페이징 처리
	    	function moveReviewPage(page) {
	    		$('#review-div').empty();
	    		$('#review-paging').empty();
	    		
	    		loadReview(page);
	    	}
	    </script>
	    
	</div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>