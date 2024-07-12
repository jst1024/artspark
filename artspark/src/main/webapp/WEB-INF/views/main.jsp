<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>artspark</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
    	a {
    		
    	}
        .carousel-item {
            height: 300px;
            background-color: lightgray;
        }
        .category-icon {
            width: 80px;
            height: 80px;
            background-color: lightblue;
            border-radius: 10px;
            margin: 10px;
        }
        .popular-writer, .announcement, .inquiry-board {
            height: 150px;
            background-color: lightgray;
            border-radius: 10px;
            margin: 20px;
        }
        .section-title {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin-top: 20px;
        }
        .board-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>
	<jsp:include page="common/header.jsp"/>
	
	<div id="content">
		<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="${path2}/resources/images/image1.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="${path2}/resources/images/image2.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="${path2}/resources/images/image3.jpg" class="d-block w-100" alt="...">
            </div>
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
            <div class="category-icon"></div>
            <div class="category-icon"></div>
            <div class="category-icon"></div>
            <div class="category-icon"></div>
        </div>
    </div>

    <div class="container mt-4">
        <div class="section-title">인기 작가</div>
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="popular-writer"></div>
            </div>
            <div class="col-md-4">
                <div class="popular-writer"></div>
            </div>
            <div class="col-md-4">
                <div class="popular-writer"></div>
            </div>
            <div class="col-md-4">
                <div class="popular-writer"></div>
            </div>
            <div class="col-md-4">
                <div class="popular-writer"></div>
            </div>
            <div class="col-md-4">
                <div class="popular-writer"></div>
            </div>
        </div>
    </div>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6">
                <div class="section-title">공지사항</div>
                <div class="board-title">
                    <h5>공지사항</h5>
                    <a href="#">more</a>
                </div>
                <ul class="list-group">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Text - Double click to edit
                        <span>24.06.19</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Text - Double click to edit
                        <span>24.06.19</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Text - Double click to edit
                        <span>24.06.19</span>
                    </li>
                </ul>
            </div>
            <div class="col-md-6">
                <div class="section-title">의뢰게시판</div>
                <div class="board-title">
                    <h5>의뢰게시판</h5>
                    <a href="#">more</a>
                </div>
                <ul class="list-group">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Text - Double click to edit
                        <span>24.06.19</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Text - Double click to edit
                        <span>24.06.19</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Text - Double click to edit
                        <span>24.06.19</span>
                    </li>
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