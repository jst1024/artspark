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
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
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
        .star-rating {
            color: gold;
            margin-bottom: 10px;
            text-aligh: right;
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
        }
        .pagination .page-link {
		    color: #007bff;
		}
		
		.pagination .page-item.active .page-link {
		    background-color: #007bff;
		    border-color: #007bff;
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
    </style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
    <div class="container container-custom mt-5">
    	<span>${ product.productPurpose } 제작 </span>&nbsp;&nbsp;&nbsp;
    	<small style="color: #999;">${ product.productCategory } / 작품번호 : ${ product.productNo }</small><br>
        <h2 style="margin-top:10px;">${ product.memId } 작가 · ${ product.productTitle }</h2><br>
        
	    <div class="row" style="margin-bottom:150px;">
	        <!-- 이미지 섹션 -->
	        <div class="col-md-8">
	            <img src="${path1 }/resources/images/cat1.jpg" class="img-preview">
	            <img src="${path1 }/resources/images/cat2.jpg" class="img-preview">
	            <img src="${path1 }/resources/images/cat3.jpg" class="img-preview">
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
	                    <p>${ product.memId } 작가</p>
	                    <p><small>${ product.artistIntro }</small><p><br><br>
	                    <div class="star-rating"><p>★★★★★ <span style="color:black;"> 별점 ${ product.avgStar }</span></p></div>
	                    <p>문의 답변율 n%</p><br><br>
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
							        	<option value="${ detailOption.detailOptionPrice }">${ detailOption.detailOptionName } ( ${ detailOption.detailOptionPrice }원 )</option>
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
	                <div id="select-options">
	                </div>
	                <!-- 
	                <div class="product-details" id="plus-option">
	                	<p class="d-flex justify-content-between" id="option-pick">
					        <span>[옵션명] / [옵션 상세 목록]</span>
					    </p>
					    <div class="d-flex justify-content-between align-items-center" id="option-group">
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-outline-secondary"><strong>-</strong></button>
								<p id="option-count">1</p>
								<button type="button" class="btn btn-outline-secondary">+</button>
							</div>
							<div class="number-and-remove">
								<span>33,000원</span>
								<button type="button" class="btn btn-outline-secondary">×</button>
							</div>
						</div>
	                </div>
	                -->
	                
	                <!--
	                	총 결제 금액
	                	옵션 선택할 때마다 바뀌도록 함
	                -->
	                <div class="product-details">
	                	<p class="d-flex justify-content-between" style="margin-top: 40px; font-size: 24px;">
					        <span>결제 금액</span>
					        <span id="total-price">0원</span>
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
	                			const selectDetailOption = $(this).find('option:selected').text();
	                			const selectOption = $(this).closest('p').find('.option-name').text();
	                			const optionKey = selectOption + ' / ' + selectDetailOption;
	                			console.log(optionKey);
	                			
	                			// 이미 선택된 옵션인지 확인
	                			if(selectedOptions.has(optionKey)) {
	                				alert('이미 선택된 옵션입니다.');
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
	                					   + '<input type="hidden" id="selectedOption' + i + '" name="selectedOption' + i + '" value="' + selectOption +'">'
	                					   + '<input type="hidden" id="selectedDetailOption' + i + '" name="selectedDetailOption' + i + '" value="' + selectDetailOption +'">'
	                					   + '<input type="hidden" id="selectedPrice' + i + '" name="selectedPrice' + i + '" value="' + parseInt($(this).val()) +'">'
	                					   + '<button type="button" class="btn btn-outline-secondary" id="deletebtn' + i + '">×</button>'
	                					   + '</div></div></div>';
	                			
	                			i += 1;
	                			total += parseInt($(this).val());
	                			const totalText = parseInt(total).toLocaleString() + '원';
	                			$('#total-price').text(totalText);
	                			$('#select-options').append(resultStr);
	                		});
	                		
	                		// '+' 버튼 누르면 수량과 가격 증가
	                		// id^=x 는 아이디가 x로 시작하는 요소를 선택함. ex) xa, xb, xc ...
	                		$('#select-options').on('click', '[id^=plusbtn]', function(e) {
	                			const buttonId = $(this).attr('id');
	                	        const optionId = buttonId.replace('plusbtn', '');
	                	        
	                			// 수량 증가
	                			const countElem = $('#option-count' + optionId);
        						countElem.text(parseInt(countElem.text()) + 1);
	                			
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
	                			
	                			// set에서 제거
	                			const optionKey = $('#selectedOption' + optionId).val() + ' / '
	                							+ $('#selectedDetailOption' + optionId).val();
	                			selectedOptions.delete(optionKey);
	                			// console.log(optionKey);
	                			// 현재 div요소 삭제
	                			$('#plus-option' + optionId).remove();
	                		});
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
	        	        			url : 'jjim/' + productNo,
	        	        			type : 'post',
	        	        			success : result => {
	        	        				alertify.alert(result.message).setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
	        	        			}
	        	        		});
	        			    } else { // 찜이 되어있는 경우
	        			    	$(event).children().eq(1).attr('class', 'far fa-heart')
	        			    	
	        			        // 찜테이블에서 삭제
	        			        $.ajax({
	        	        			url : 'jjim/' + productNo,
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
	                </script>
	                
	                <div class="product-details">
	                	<p style="margin-top: 40px; margin-bottom: 30px;">
					        <small style="color:red;"><i class="fas fa-exclamation-circle"></i> 작가에게 견적 확인 후 주문해 주세요</small>
					    </p>
	                </div>
	                
	                <div class="product-details">
	                	<button type="button" class="big-btn" id="artist-qna-btn" onclick="productQnaForward();">작가에게 문의하기</button>
	                	<button type="submit" class="big-btn" id="buy-btn" onclick="productBuyForward();">주문 / 결제하기</button>
	                </div>
	            </div>
	        </div>
	    </div>
	    
	    <!-- 본문 들어갈 자리 -->
	    <div class="row" style="margin-bottom: 150px;">
	    	<div class="col-md-12">
	            <h3>여기엔 본문 내용이랑 사진 들어갈거임 ㅇㅇ</h3>
	            <p>ㅎㅇㅋㅋ</p>
	        </div>
	        
			<div class="col-md-12">
	            <img src="${path1 }/resources/images/test04.png" class="img-preview">
	            <img src="${path1 }/resources/images/test05.png" class="img-preview">
	        </div>
	        
	        <div class="col-md-12">
	            <p>본문 끝 ㅋㅋ</p>
	        </div>
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
	    <nav aria-label="Page navigation">
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
	        
       		<div class="col-md-1 table-head">
           		<p style="text-align: center;">번호</p>
            </div>
            <div class="col-md-2 table-head">
           		<p>평점</p>
            </div>
            <div class="col-md-6 table-head">
           		<p>내용</p>
            </div>
            <div class="col-md-1 table-head">
           		<p style="text-align: center;">작성자</p>
            </div>
            <div class="col-md-2 table-head">
           		<p style="text-align: center;">작성일</p>
            </div>
     
     		<c:forEach begin="1" end="5">
	            <div class="col-md-1 table-body" style="border-bottom: 1px solid #e6e6e6;">
	           		<p style="text-align: center;">5</p>
	            </div>
	            <div class="col-md-2 table-body" style="border-bottom: 1px solid #e6e6e6;">
	           		<p>★★★★★</p>
	            </div>
	            <div class="col-md-6 table-body" style="border-bottom: 1px solid #e6e6e6;">
	           		<p>본문 테스트용 임다 ㅋㅋㅋㅋㅋㅋㅋㅋ큐ㅠㅠㅠㅠㅠㅠㅠ</p>
	            </div>
	            <div class="col-md-1 table-body" style="border-bottom: 1px solid #e6e6e6;">
	           		<p style="text-align: center;">********a</p>
	            </div>
	            <div class="col-md-2 table-body" style="border-bottom: 1px solid #e6e6e6;">
	           		<p style="text-align: center;">24-06-20</p>
	            </div>
            </c:forEach>
	    </div>
	    
	    <script>
        	function productQnaForward() {
        		location.href = 'productQna';
        	}
        	
        	function productBuyForward() {
        		location.href = 'productBuy';
        	}
        </script>
	    
	    <!-- 후기 페이징 -->
	    <nav aria-label="Page navigation" style="margin-bottom: 200px;">
            <ul class="pagination justify-content-center">
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item active"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">4</a></li>
            </ul>
        </nav>  
	</div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>