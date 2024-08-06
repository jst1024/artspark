<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>리뷰 등록</title>
    <style>
        .container-custom {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        body {
            width: 1920px;
            margin: 0 auto;
        }
        .form-group {
            position: relative;
        }
        .form-group .btn-primary {
            position: absolute;
            right: 0;
            bottom: 0;
        }
        .rating {
	    float: none;
	    width: 200px;
	    display: flex;
		}
		
		.rating__input {
		    display: none;
		}
		
		.rating__label {
		    width: 20px;
		    overflow: hidden;
		    cursor: pointer;
		}
		
		.rating__label .star-icon {
		    width: 20px;
		    height: 40px;
		    display: block;
		    position: relative;
		    left: 0;
		    background-image: url('https://velog.velcdn.com/images/jellykelly/post/9957327f-f358-4c25-9989-5bb3dd5755d6/image.svg');
		    background-repeat: no-repeat;
		    background-size: 40px;
		}
		
		.rating__label .star-icon.filled {
		    background-image: url('https://velog.velcdn.com/images/jellykelly/post/10caf033-b0ef-4d58-804b-6e33395e4ea5/image.svg');
		}
		
		.rating__label--full .star-icon {
		    background-position: right;
		}
		
		.rating__label--half .star-icon {
		    background-position: left;
		}
		
		.rating.readonly .star-icon {
		    opacity: 0.7;
		    cursor: default;
		}
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="container-custom">
        <h2>리뷰 등록</h2>
        <form action="review-insert" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this)">
        	<div class="form-group">
                <label for="productTitle">상품 제목</label>
                <input type="hidden" value="${productNo }" name="productNo">
                <input type="text" class="form-control" id="productTitle" name="productTitle" value="${productTitle }" readonly>
            </div>
            <div class="form-group">
                <label for="title">제목</label>
                <input type="hidden" value="${sessionScope.loginUser.memId}" name="memId">
                <input type="text" class="form-control" id="title" name="reviewTitle" placeholder="제목을 입력해주세요">
            </div>
            <div class="form-group">
                <label for="rating">별점</label>
                <div class="rating">
			        <label class="rating__label rating__label--half" for="starhalf">
			            <input type="radio" id="starhalf" class="rating__input" name="reviewStar" value="0.5">
			            <span class="star-icon"></span>
			        </label>
			        <label class="rating__label rating__label--full" for="star1">
			            <input type="radio" id="star1" class="rating__input" name="reviewStar" value="1">
			            <span class="star-icon"></span>
			        </label>
			        <label class="rating__label rating__label--half" for="star1half">
			            <input type="radio" id="star1half" class="rating__input" name="reviewStar" value="1.5">
			            <span class="star-icon"></span>
			        </label>
			        <label class="rating__label rating__label--full" for="star2">
			            <input type="radio" id="star2" class="rating__input" name="reviewStar" value="2">
			            <span class="star-icon"></span>
			        </label>
			        <label class="rating__label rating__label--half" for="star2half">
			            <input type="radio" id="star2half" class="rating__input" name="reviewStar" value="2.5">
			            <span class="star-icon"></span>
			        </label>
			        <label class="rating__label rating__label--full" for="star3">
			            <input type="radio" id="star3" class="rating__input" name="reviewStar" value="3">
			            <span class="star-icon"></span>
			        </label>
			        <label class="rating__label rating__label--half" for="star3half">
			            <input type="radio" id="star3half" class="rating__input" name="reviewStar" value="3.5">
			            <span class="star-icon"></span>
			        </label>
			        <label class="rating__label rating__label--full" for="star4">
			            <input type="radio" id="star4" class="rating__input" name="reviewStar" value="4">
			            <span class="star-icon"></span>
			        </label>
			        <label class="rating__label rating__label--half" for="star4half">
			            <input type="radio" id="star4half" class="rating__input" name="reviewStar" value="4.5">
			            <span class="star-icon"></span>
			        </label>
			        <label class="rating__label rating__label--full" for="star5">
			            <input type="radio" id="star5" class="rating__input" name="reviewStar" value="5">
			            <span class="star-icon"></span>
			        </label>
			    </div>
            </div>
            <div class="form-group">
                <label for="editorTxt">내용</label>
                <textarea class="form-control" id="editorTxt" name="reviewContent" rows="10" placeholder="내용을 입력해주세요"></textarea>
            </div>
            <button type="submit" class="btn btn-primary" style="float: right;">등록하기</button>
        </form>
    </div>
    
    <script>
		const rateWrap = document.querySelectorAll('.rating'),
	    label = document.querySelectorAll('.rating .rating__label'),
	    input = document.querySelectorAll('.rating .rating__input'),
	    labelLength = label.length,
	    opacityHover = '0.5';

		let stars = document.querySelectorAll('.rating .star-icon');
	
		checkedRate();
	
		rateWrap.forEach(wrap => {
		    wrap.addEventListener('mouseenter', () => {
		        stars = wrap.querySelectorAll('.star-icon');
	
		        stars.forEach((starIcon, idx) => {
		            starIcon.addEventListener('mouseenter', () => {
		                initStars(); 
		                filledRate(idx, labelLength); 
	
		                for (let i = 0; i < stars.length; i++) {
		                    if (stars[i].classList.contains('filled')) {
		                        stars[i].style.opacity = opacityHover;
		                    }
		                }
		            });
	
		            starIcon.addEventListener('mouseleave', () => {
		                starIcon.style.opacity = '1';
		                checkedRate(); 
		            });
	
		            wrap.addEventListener('mouseleave', () => {
		                starIcon.style.opacity = '1';
		            });
		        });
		    });
		});
	
		// 주어진 index 까지의 별을 채우는 함수
		function filledRate(index, length) {
		    if (index <= length) {
		        for (let i = 0; i <= index; i++) {
		            stars[i].classList.add('filled');
		        }
		    }
		}
	
		// 체크된 라디오 버튼에 따라 해당하는 별과 그 이전의 별을 채우는 함수
		function checkedRate() {
		    let checkedRadio = document.querySelectorAll('.rating input[type="radio"]:checked');
	
	
		    initStars();
		    checkedRadio.forEach(radio => {
		        let previousSiblings = prevAll(radio);
	
		        for (let i = 0; i < previousSiblings.length; i++) {
		            previousSiblings[i].querySelector('.star-icon').classList.add('filled');
		        }
	
		        radio.nextElementSibling.classList.add('filled');
	
		        // 현재 라디오 버튼의 이전 형제 요소들을 반환하는 함수
		        function prevAll() {
		            let radioSiblings = [],
		                prevSibling = radio.parentElement.previousElementSibling;
	
		            while (prevSibling) {
		                radioSiblings.push(prevSibling);
		                prevSibling = prevSibling.previousElementSibling;
		            }
		            return radioSiblings;
		        }
		    });
		}
	
		// 모든 별에서 'filled' 클래스를 제거하여 초기화하는 함수
		function initStars() {
		    for (let i = 0; i < stars.length; i++) {
		        stars[i].classList.remove('filled');
		    }
		}
	</script>
					
    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>
