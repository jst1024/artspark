<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 리스트</title>
    <jsp:include page="../common/head.jsp"></jsp:include>
    <style>
	    body {
	    background-color: #f8f9fa;
		}
		
		.tagbtn {
			border: none;
			background-color: white;
		}
		
		.tagbtn:hover {
			text-decoration: underline;
		}
		
		.container {
			min-height: 1000px;
		}
		
		#hashtags {
			border: 1px solid #ced4da; 
			padding: 20px;
		}
		
		.card {
		    cursor: pointer;
		}
		
		.card {
		    border: none;
		    position: relative;
		    overflow: hidden;
		    transition: transform 0.3s ease, box-shadow 0.3s ease;
		    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		}
		
		.card:hover {
		    transform: scale(1.05); /* 카드 확대 및 약간 회전 */
		    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* 그림자 효과임 */
		}
		
		.card-img-top {
		    width: 270px;
		    height: 192px;
		    object-fit: cover;
		    transition: all 0.3s ease;
		}
		
		.card-title {
		    font-size: 1rem;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		}
		
		.card-text {
		    font-size: 0.9rem;
		}
		
		.card-title .heart-icon {
		    cursor: pointer;
		    color: red;
		    font-size: 1.5rem;
		}
		
		.card::before {
		    content: '';
		    position: absolute;
		    top: -50%;
		    left: -50%;
		    width: 200%;
		    height: 200%;
		    background: radial-gradient(circle, rgba(255,255,255,0.1), rgba(0,0,0,0.2));
		    transition: opacity 0.3s ease;
		    opacity: 0;
		    z-index: 0;
		    pointer-events: none; /* 클릭 방지 */
		}
		
		.card:hover::before {
		    opacity: 1;
		}
		
		#pagingArea {width:fit-content; margin:auto;}
		
		.pagination .page-link {
		    color: #007bff;
		}
		
		.pagination .page-item.active .page-link {
		    background-color: #007bff;
		    border-color: #007bff;
		}
		
		.star-rating {
            display: inline-block;
            font-size: 0;
            position: relative;
            width: 100px;
            height: 20px; 
            background: url('${path2}/resources/images/star-empty.png') repeat-x;
        }
        .star-rating::before {
            content: '';
            display: block;
            width: 0;
            height: 100%;
            background: url('${path2}/resources/images/star-full.png') repeat-x;
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
    <div class="container" style="max-width: 1200px;">
        <div class="row my-4">
            <div class="col-md-2">
                <select class="form-control">
                    <option>최신순</option>
                    <option>인기순</option>
                    <!-- Add other options here -->
                </select>
            </div>
            <div class="col-md-4">
	            <form action="${path2 }/product/search" method="get">
	                <div class="input-group">
	                		<c:if test="${ empty keyword }">
		                    	<input type="text" class="form-control" name="keyword" placeholder="검색어 입력">
		                    </c:if>
		                    <c:if test="${ not empty keyword }">
		                    	<input type="text" class="form-control" name="keyword" value="${ keyword }" placeholder="검색어 입력">
		                    </c:if>
		                    <div class="input-group-append">
		                        <button class="btn btn-primary" type="submit">검색</button>
		                    </div>
	                </div>
                </form>
            </div>
            <div class="col-md-6 text-right">
            	<c:if test="${ sessionScope.loginUser != null }">
            		<c:if test="${ artist != null }">
		            	<a href="${path2 }/product/productInsertForm">
		                	<button class="btn btn-primary">작품 등록</button>
		                </a>
	                </c:if>
	                <c:if test="${ artist == null }">
	                	<button class="btn btn-primary" onclick="artistAlert();">작품 등록</button>
	                </c:if>
                </c:if>
                <c:if test="${ sessionScope.loginUser eq null }">
                	<button class="btn btn-primary" onclick="loginAlert();">작품 등록</button>
                </c:if>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col">
                <div id="hashtags">
                	<c:forEach items="${ tags }" var="tag">
                		<a href="${path2 }/product/search?keyword=${ tag.tagName }">
                    		<button class="tagbtn" style="margin-bottom: 10px;">#${ tag.tagName }</button>
                    	</a>
                    </c:forEach>
                    <!-- Add other tags here -->
                </div>
            </div>
        </div>
        <div class="row">
            <!-- Product Cards -->
            <c:if test="${ empty productList }">
            	<div style="margin: 20px;">
            		<h3>상품이 존재하지 않습니다.</h3>
            	</div>
            </c:if>
            <c:forEach items="${ productList }" var="product">
	            <div class="col-md-3 mb-4 product-card">
	                <div class="card">
	                    <img class="card-img-top" src="${path2 }/${ product.filePath }" alt="Card image cap">
	                    <div class="card-body">
	                        <h5 class="card-title">${ product.memNickname } / ${ product.productTitle }
	                        <input type="hidden" name="productNo" value="${ product.productNo }">
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
	                        </h5>
	                        <div class="d-flex justify-content-between">
	                            <div>
	                                <div class="star-rating" data-rating="${ product.avgStar }"></div>
	                            </div>
	                            <div>${ product.minPrice }원 ~</div>
	                        </div>
	                        <p class="card-text">${ product.productPurpose }</p>
	                    </div>
	                </div>
	            </div>
            </c:forEach>
        </div>
        
        <script>
        	
        	$('.card').click(e => {
    		    if (!$(e.target).closest('.heart-icon').length) {
    		    	const productNo = $(e.currentTarget).find('input[name="productNo"]').val();
    		    	console.log(productNo);
    		        location.href = '${path2 }/product/' + productNo;
    		    }
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
	        			url : '${path2}/product/jjim/' + productNo,
	        			type : 'post',
	        			success : result => {
	        				alertify.alert(result.message).setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
	        			}
	        		});
			    } else { // 찜이 되어있는 경우
			    	$(event).children().eq(1).attr('class', 'far fa-heart')
			    	
			        // 찜테이블에서 삭제
			        $.ajax({
	        			url : '${path2}/product/jjim/' + productNo,
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
        	
        	// 작가가 아닌 상태로 작품등록 버튼 누를시 alert
        	function artistAlert() {
        		alertify.alert('작가회원만 작품 등록이 가능합니다.').setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
        	}
        </script>
        
        <!-- 페이징 처리 -->
        <div id="pagingArea">
	        <ul class="pagination">
	        
	        	<c:if test="${ category eq null }"> 
	        		<c:choose>
		        		<c:when test="${ pageInfo.currentPage eq 1 }">
			            	<li class="page-item"><a class="page-link" href="#">이전</a></li>
		            	</c:when>
		            	<c:otherwise>
		            		<c:if test="${ empty keyword }">
		            			<li class="page-item"><a class="page-link" href="${path2 }/product?page=${ pageInfo.currentPage - 1 }">이전</a></li>
		            		</c:if>
		            		<c:if test="${ not empty keyword }">
		            			<li class="page-item"><a class="page-link" href="${path2 }/product/search/?page=${ pageInfo.currentPage - 1 }&keyword=${keyword}">이전</a></li>
		            		</c:if>
		            	</c:otherwise>
		            </c:choose>
		            <c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="p">
		            	<c:choose>
			            	<c:when test="${ pageInfo.currentPage == p }">
			            		<li class="page-item active">
			            			<a class="page-link" href="#">${ p }</a>
			            		</li>
			            	</c:when>
			            	<c:otherwise>
			            		<c:if test="${ empty keyword }">
				            		<li class="page-item">
				            			<a class="page-link" href="${path2 }/product?page=${ p }">${ p }</a>
				            		</li>
			            		</c:if>
			            		<c:if test="${ not empty keyword }">
				            		<li class="page-item">
				            			<a class="page-link" href="${path2 }/product/search?page=${ p }&keyword=${keyword}">${ p }</a>
				            		</li>
			            		</c:if>
			            	</c:otherwise>
		            	</c:choose>
		            </c:forEach>
		            
		            <c:choose>
			            <c:when test="${ pageInfo.maxPage eq pageInfo.currentPage }">
			            	<li class="page-item">
			            		<a class="page-link" href="#">다음</a>
			            	</li>
			            </c:when>
			            <c:otherwise>
			            	<c:if test="${ empty keyword }">
				            	<li class="page-item">
				            		<a class="page-link" href="${path2 }/product?page=${ pageInfo.currentPage + 1 }">다음</a>
				            	</li>
			            	</c:if>
			            	<c:if test="${ not empty keyword }">
				            	<li class="page-item">
				            		<a class="page-link" href="${path2 }/product/search?page=${ pageInfo.currentPage + 1 }&keyword=${keyword}">다음</a>
				            	</li>
			            	</c:if>
			            </c:otherwise>
		            </c:choose>
	            </c:if>
	            
	            <c:if test="${ category != null }">
	            	<c:choose>
		        		<c:when test="${ pageInfo.currentPage eq 1 }">
			            	<li class="page-item">
			            		<a class="page-link" href="#">이전</a>
			            	</li>
		            	</c:when>
		            	<c:otherwise>
		            		<li class="page-item">
		            			<a class="page-link" href="category?page=${ pageInfo.currentPage - 1 }&category=${ category }">이전</a>
		            		</li>
		            	</c:otherwise>
		            </c:choose>
		            <c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="p">
		            	<c:choose>
			            	<c:when test="${ pageInfo.currentPage == p }">
			            		<li class="page-item active">
			            			<a class="page-link" href="#">${ p }</a>
			            		</li>
			            	</c:when>
			            	<c:otherwise>
			            		<li class="page-item">
			            			<a class="page-link" href="category?page=${ p }&category=${ category }">${ p }</a>
			            		</li>
			            	</c:otherwise>
		            	</c:choose>
		            </c:forEach>
		            
		            <c:choose>
			            <c:when test="${ pageInfo.maxPage eq pageInfo.currentPage }">
			            	<li class="page-item">
			            		<a class="page-link" href="#">다음</a>
			            	</li>
			            </c:when>
			            <c:otherwise>
			            	<li class="page-item">
			            		<a class="page-link" href="category?page=${ pageInfo.currentPage + 1 }&category=${ category }">다음</a>
			            	</li>
			            </c:otherwise>
		            </c:choose>
	            </c:if>
	        </ul>
	    </div>
    </div>
    <jsp:include page="../common/footer.jsp" />
</body>
</html>