<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 리스트</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
		
		.product-card {
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
		    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* 그림자 효과 */
		}
		
		.card-img-top {
		    width: 255px;
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
                    <option>작가</option>
                    <!-- Add other options here -->
                </select>
            </div>
            <div class="col-md-4">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="검색어 입력">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button">검색</button>
                    </div>
                </div>
            </div>
            <div class="col-md-6 text-right">
            	<a href="productInsertForm">
                	<button class="btn btn-primary">작품 등록 / 수정</button>
                </a>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col">
                <div id="hashtags">
                	<c:forEach begin="1" end="36">
                    	<button class="tagbtn">#태그입력</button>
                    </c:forEach>
                    <!-- Add other tags here -->
                </div>
            </div>
        </div>
        <div class="row">
            <!-- Product Cards -->
            <c:forEach begin="1" end="12">
	            <div class="col-md-3 mb-4 product-card" v-for="item in items" :key="item.id">
	                <div class="card">
	                    <img class="card-img-top" src="resources/images/cat1.jpg" alt="Card image cap">
	                    <div class="card-body">
	                        <h5 class="card-title">작가이름 / 제목
	                        	<span class="heart-icon" onclick="toggleHeart(event, this)">
				                    <i class="far fa-heart"></i>
				                </span>
	                        </h5>
	                        <div class="d-flex justify-content-between">
	                            <div>
	                                <span class="badge badge-warning">★★★★★</span>
	                            </div>
	                            <div>50000원 ~</div>
	                        </div>
	                        <p class="card-text">용도(상업용)</p>
	                    </div>
	                </div>
	            </div>
            </c:forEach>
        </div>
        
        <script>
        	$(() => {
        		
        		$('.product-card').click(e => {
        		    if (!$(e.target).closest('.heart-icon').length) {
        		        location.href = 'productDetail';
        		    }
        		});
        	});
        	
        	// 하트 클릭시 토글
        	function toggleHeart(event, element) {
			    event.stopPropagation(); // 이벤트 전파 방지
			    const icon = element.querySelector('i');
			    if (icon.classList.contains('far')) {
			        icon.classList.remove('far');
			        icon.classList.add('fas');
			    } else {
			        icon.classList.remove('fas');
			        icon.classList.add('far');
			    }
			}
        </script>
        
        <!-- 페이징 처리 -->
        <nav aria-label="Page navigation">
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