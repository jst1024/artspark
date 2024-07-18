<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List, java.util.ArrayList, java.util.Map, java.util.HashMap, java.util.Date" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
        <%-- 더미 데이터 설정 --%>
        <%
            // 배너 이미지
            List<String> banners = new ArrayList<>();
            banners.add("image1.jpg");
            banners.add("image2.jpg");
            banners.add("image3.jpg");
            request.setAttribute("banners", banners);

            // 카테고리
            List<Map<String, Object>> categories = new ArrayList<>();
            for (int i = 1; i <= 4; i++) {
                Map<String, Object> category = new HashMap<>();
                category.put("id", i);
                category.put("name", "Category" + i);
                categories.add(category);
            }
            request.setAttribute("categories", categories);

            // 인기 작가
            List<Map<String, Object>> popularWriters = new ArrayList<>();
            for (int i = 1; i <= 6; i++) {
                Map<String, Object> writer = new HashMap<>();
                writer.put("id", i);
                writer.put("image", "/cat3.jpg"); 
                popularWriters.add(writer);
            }
            request.setAttribute("popularWriters", popularWriters);

            // 공지사항
            List<Map<String, Object>> notices = new ArrayList<>();
            for (int i = 1; i <= 3; i++) {
                Map<String, Object> notice = new HashMap<>();
                notice.put("id", i);
                notice.put("title", "Notice Title" + i);
                notice.put("date", new Date());
                notices.add(notice);
            }
            request.setAttribute("notices", notices);

            // 의뢰게시판
            List<Map<String, Object>> requests = new ArrayList<>();
            for (int i = 1; i <= 3; i++) {
                Map<String, Object> requestItem = new HashMap<>();
                requestItem.put("id", i);
                requestItem.put("title", "Request Title" + i);
                requestItem.put("date", new Date());
                requests.add(requestItem);
            }
            request.setAttribute("requests", requests);
        %>
<jsp:include page="common/head.jsp" />
<style>
    .carousel-item {
        height: 300px;
        background-color: lightgray;
    }
    .category-icon {
        display: inline-block;
        width: 80px;
        height: 80px;
        background-color: lightblue;
        border-radius: 10px;
        margin: 10px;
        margin-top : 40px;
        line-height: 80px; 
        text-align: center; 
    }
    .popular-writer-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
    }
    .popular-writer {
        width: calc((100% / 3) - 20px); /* 한 줄에 3개씩 배치하고, 간격 20px */
        height: 300px; 
        background-color: lightgray;
        border-radius: 10px;
        margin: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .popular-writer img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 10px;
    }
    .default-image {
        width: 100%;
        height: 100%;
        background-color: lightgray;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .section-title {
        font-size: 24px;
        font-weight: bold;
        text-align: center;
        margin-top: 40px;
        margin-bottom: 20px;
    }
    .board-title {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .board-title a {
        margin-left: auto;
        margin-right: 8px; 
        text-decoration: none;
        color: black;
    }
    .sticky-button {
        position: fixed;
        bottom: 60px;
        right: 60px;
        width: 70px;
        height: 70px;
        background-color: #ff6e40;
        border-radius: 50%;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        display: flex;
        justify-content: center;
        align-items: center;
        cursor: pointer;
        z-index: 1000;
    }

    .badge {
        position: absolute;
        top: 5px;
        right: 5px;
        width: 20px;
        height: 20px;
        background-color: red;
        color: white;
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 12px;
    }
</style>
</head>
<body>
    <jsp:include page="common/header.jsp"/>

    <div id="content">

        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <c:forEach var="banner" items="${banners}" varStatus="status">
                    <li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="${status.first ? 'active' : ''}"></li>
                </c:forEach>
            </ol>
            <div class="carousel-inner">
                <c:forEach var="banner" items="${banners}" varStatus="status">
                    <div class="carousel-item ${status.first ? 'active' : ''}">
                        <img src="${path2}/resources/images/${banner}" class="d-block w-100" alt="...">
                    </div>
                </c:forEach>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <div class="container text-center mt-4">
            <div class="row justify-content-center">
                <c:forEach var="category" items="${categories}">
                    <a href="${path2}/category/${category.id}" class="category-icon">${category.name}</a>
                </c:forEach>
            </div>
        </div>

        <div class="container mt-4">
		    <div class="section-title">인기 작가</div>
		    <div class="popular-writer-container">
		        <c:forEach var="writer" items="${popularWriters}">
		            <a href="${path2}/writer/${writer.id}" class="popular-writer">
		                <c:choose>
		                    <c:when test="${not empty writer.image}">
		                        <img src="${path2}/resources/images/${writer.image}" alt="${writer.name}">
		                    </c:when>
		                    <c:otherwise>
		                        <div class="default-image">No Image</div>
		                    </c:otherwise>
		                </c:choose>
		            </a>
		        </c:forEach>
		    </div>
		</div>



        <div class="container mt-4">
		    <div class="row">
		        <div class="col-md-6">
		            <div class="section-title">공지사항</div>
		            <div class="board-title">
		                <a href="${path2}/noticelist">more</a>
		            </div>
		            <ul class="list-group">
		                <c:forEach var="notice" items="${notices}">
		                    <li class="list-group-item d-flex justify-content-between align-items-center">
		                        <a href="${path2}/notice/${notice.id}" style="color: black; text-decoration: none;">${notice.title}</a>
		                        <fmt:formatDate value="${notice.date}" pattern="yyyy-MM-dd"/>
		                    </li>
		                </c:forEach>
		            </ul>
		        </div>
		        <div class="col-md-6">
		            <div class="section-title">의뢰게시판</div>
		            <div class="board-title">
		                <a href="${path2}/requestlist">more</a>
		            </div>
		            <ul class="list-group">
		                <c:forEach var="request" items="${requests}">
		                    <li class="list-group-item d-flex justify-content-between align-items-center">
		                        <a href="${path2}/request/${request.id}" style="color: black; text-decoration: none;">${request.title}</a>
		                        <fmt:formatDate value="${request.date}" pattern="yyyy-MM-dd"/>
		                    </li>
		                </c:forEach>
		            </ul>
		        </div>
		    </div>
		</div>
        <br>
        <br>
    </div>
    
    <div class="sticky-button">
	    <p style="color:white;">채팅</p>
	    <div class="badge"></div>
	</div>
	
	<script>
		const loginUser = '${sessionScope.loginUser.memId}';
		
		$('.sticky-button').on('click', function() {
			if(loginUser === '') {
				alertify.alert("로그인 후 이용 가능합니다.").setHeader('ArtSpark').set({'movable':true, 'moveBounded': true});
			} else {
				location.href = "${path2}/private-chat";
			}
		});
	</script>
    
    <jsp:include page="common/footer.jsp"/>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
