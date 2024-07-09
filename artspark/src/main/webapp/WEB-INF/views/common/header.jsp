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

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>

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

        .header {
            position: sticky;
            top: 0;
            z-index: 1000;
            background-color: white;
        }
        
        a {
            text-decoration: none !important;
            color: black !important;
        }

        .navbar-nav {
            white-space: nowrap;
        }

        .navbar-nav li {
            margin-left: 10px; 
        }

        .navbar-nav .nav-item a,
        .auth-links .nav-item a {
            font-size: 14px; 
            white-space: nowrap; 
        }

        .form-inline .form-control {
            width: 200px; 
        }

        @media (max-width: 992px) {
            .navbar-nav li,
            .auth-links .nav-item a {
                margin-left: 5px; 
            }
            .navbar-nav .nav-item a,
            .auth-links .nav-item a {
                font-size: 12px; 
            }
            .form-inline .form-control {
                width: 100px; 
            }
        }

        @media (max-width: 1737px) {
            .navbar-nav li,
            .auth-links .nav-item a {
                margin-left: 5px; 
            }
            .navbar-nav .nav-item a,
            .auth-links .nav-item a {
                font-size: 12px; 
            }
            .form-inline .form-control {
                width: 150px; 
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid header">
        <div class="row align-items-center">
            <div class="col">
                <img src="path/to/logo.png" alt="Logo" width="100">

                <a href="${path2 }/index.jsp">
                	<img src="${path2 }/resources/images/logo.png" alt="Logo" width="100">
                </a>

        <div class="d-flex justify-content-between align-items-center">
            <div class="p-2">
                <a href="${path2 }/index.jsp">
                    <img src="${path2 }/resources/images/logo.png" alt="Logo" width="100">
                </a>
            </div>
            <div class="p-2 flex-grow-1">
                <nav class="navbar navbar-expand navbar-light">
                    <div class="navbar-collapse collapse">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item"><a class="nav-link" href="${path2 }/product">일러스트</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path2 }/product">디자인</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path2 }/product">영상·음향</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path2 }/product">웹툰·만화</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">의뢰게시판</a></li>
                        </ul>
                        <form class="form-inline my-2 my-lg-0">
                            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                        </form>

                        <a class="nav-link" href="#">로그인</a>
                        <a class="nav-link" href="#">회원가입</a>
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

                        <ul class="navbar-nav auth-links">
                            <c:choose>
                                <c:when test="${ sessionScope.loginUser.memId eq 'admin' }">
                                    <li class="nav-item"><a class="nav-link" href="">로그아웃</a></li>
                                    <li class="nav-item"><a class="nav-link" href="">관리자게시판</a></li>
                                </c:when>
                                <c:when test="${ sessionScope.loginUser eq null }">
                                    <li class="nav-item"><a class="nav-link" href="">로그인</a></li>
                                    <li class="nav-item"><a class="nav-link" href="">회원가입</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item"><a class="nav-link" href="">로그아웃</a></li>
                                    <li class="nav-item"><a class="nav-link" href="">회원정보</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
    </div>
    <div class="modal fade" id="loginModal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Login</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
        
                <form action="login" method="post">
                    <!-- Modal body -->
                    <div class="modal-body">
                        <label for="memId" class="mr-sm-2">ID : </label>
                        <input type="text" class="form-control mb-2 mr-sm-2" placeholder="아이디 입력" id="memId" name="memId"> <br>
                        <label for="memPwd" class="mr-sm-2">Password : </label>
                        <input type="password" class="form-control mb-2 mr-sm-2" placeholder="비밀번호 입력" id="memPwd" name="memPwd">
                    </div>
                           
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">로그인</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>