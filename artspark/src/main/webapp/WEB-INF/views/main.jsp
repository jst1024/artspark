<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<jsp:include page="common/head.jsp" />

<style>
    .carousel-item {
        height: 300px;
        background-color: lightgray;
    }
    .category-icon {
        display: inline-block;
        width: 100px;
        height: 120px;
        margin: 10px;
        margin-top: 40px;
        text-align: center;
        text-decoration: none;
        color: black;
    }
    .category-icon img {
        width: 75px;
        height: 75px;
        object-fit: cover;
        border-radius: 10px;
    }
    .category-name {
        margin-top: 5px;
        font-size: 14px;
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
        flex-direction: column;
        align-items: center;
        justify-content: flex-end;
        text-align: center;
        position: relative;
    }
    .popular-writer img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 10px;
        position: absolute;
        top: 0;
        left: 0;
    }
    .default-image {
        width: 100%;
        height: 100%;
        background-color: lightgray;
        display: flex;
        align-items: center;
        justify-content: center;
        position: absolute;
        top: 0;
        left: 0;
    }
    .popular-writer-details {
        background-color: rgba(0, 0, 0, 0.5);
        color: white;
        width: 100%;
        padding: 10px;
        border-radius: 0 0 10px 10px;
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
                        <img src="${path2}/${banner.banImage}" class="d-block w-100" alt="${banner.banName}">
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
                <a href="${path2}/product?category=일러스트" class="category-icon">
                    <img src="https://artmug.kr/image/cate/MT_100000000000_on.png?ver=6" alt="일러스트">
                    <div class="category-name">일러스트</div>
                </a>
                <a href="${path2}/product?category=디자인" class="category-icon">
                    <img src="https://artmug.kr/image/cate/MT_104000000000_on.png?ver=6" alt="디자인">
                    <div class="category-name">디자인</div>
                </a>
                <a href="${path2}/product?category=영상%20·%20음향" class="category-icon">
                    <img src="https://artmug.kr/image/cate/MT_108000000000_on.png?ver=6" alt="영상·음향">
                    <div class="category-name">영상·음향</div>
                </a>
                <a href="${path2}/product?category=웹툰%20·%20만화" class="category-icon">
                    <img src="https://artmug.kr/image/cate/MT_103000000000_on.png?ver=6" alt="웹툰·만화">
                    <div class="category-name">웹툰·만화</div>
                </a>
            </div>
        </div>

        <div class="container mt-4">
            <div class="section-title">인기 작가</div>
            <div class="popular-writer-container">
                <c:forEach var="writer" items="${popularWriters}">
                    <a href="${path2 }/product/${writer.productNo}" class="popular-writer">
                        <c:choose>
                            <c:when test="${not empty writer.filePath}">
                                <img src="${path2}/${writer.filePath}" alt="${writer.memNickname}">
                            </c:when>
                            <c:otherwise>
                                <div class="default-image">No Image</div>
                            </c:otherwise>
                        </c:choose>
                        <div class="popular-writer-details">
                            <div>${writer.memNickname}</div>
                            <div>구매수: ${writer.buyCount}</div>
                        </div>
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
                        <c:forEach var="notice" items="${noticeList}">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <a href="${path2}/noticeDetail?noticeNo=${notice.noticeNo}" 
                                    style="color: black; text-decoration: none;">
                                    ${notice.noticeTitle}</a>
                                <fmt:formatDate value="${notice.noticeDate}" 
                                    pattern="yyyy-MM-dd"/>
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
                        <c:forEach var="request" items="${requestList}">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <a href="${path2}/requestDetail?reqNo=${request.reqNo}" style="color: black; text-decoration: none;">${request.reqTitle}</a>
                                <fmt:formatDate value="${request.reqDate}" pattern="yyyy-MM-dd"/>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <br>
        <br>
    </div>
    
    <jsp:include page="common/footer.jsp"/>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
