<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쇼핑몰</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<<<<<<< Updated upstream
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
=======
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
     <!-- alertify JS -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>

     <style>
>>>>>>> Stashed changes
        .header {
            position: -webkit-sticky; /* Safari */
            position: sticky;
            top: 0;
            z-index: 1000;
            background-color: white;
        }
        
        a {
			text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container-fluid header">
        <div class="row align-items-center">
            <div class="col">
<<<<<<< Updated upstream
                <img src="path/to/logo.png" alt="Logo" width="100">
=======
                <a href="${path2 }/index.jsp">
                	<img src="${path2 }/resources/images/logo.png" alt="Logo" width="100">
                </a>
>>>>>>> Stashed changes
            </div>
            <div class="col">
                <nav class="navbar navbar-expand-lg navbar-light">
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item"><a class="nav-link" href="productList">일러스트</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">디자인</a></li>
                            <li class="nav-item"><a class="nav-link" href="memberList">영상·음향</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">웹툰·만화</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">의뢰게시판</a></li>
                        </ul>
                        <form class="form-inline my-2 my-lg-0">
                            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                        </form>
<<<<<<< Updated upstream
                        <a class="nav-link" href="#">로그인</a>
                        <a class="nav-link" href="#">회원가입</a>
=======
                        <c:choose>
                        	<c:when test="${ sessionScope.loginUser.memId eq 'admin' }">
                                    <li class="nav-item"><a class="nav-link" href="logout">로그아웃</a></li>
                                    <li class="nav-item"><a class="nav-link" href="">관리자게시판</a></li>
                                </c:when>
                            <c:when test="${ sessionScope.loginUser eq null }">
                                <a class="nav-link" href="join">회원가입</a>
                                <a class="nav-link" href="#" data-toggle="modal" data-target="#loginModal">로그인</a>
                            </c:when>
                            <c:otherwise>
                                <label>${ sessionScope.loginUser.memNickname }님 환영합니다.</label>&nbsp;&nbsp;
                                <a href="#">마이페이지</a>
                                <a href="logout">로그아웃</a>
                            </c:otherwise>
                        </c:choose>    
>>>>>>> Stashed changes
                    </div>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>