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
	            	<a href="${path2 }/product/productInsertForm">
	                	<button class="btn btn-primary">작품 등록</button>
	                </a>
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
	                                <span class="badge badge-warning">★★★★★(${ product.avgStar })</span>
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