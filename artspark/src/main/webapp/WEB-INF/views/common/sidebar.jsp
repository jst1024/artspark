<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .sidebar {
            height: 100vh;
            position: fixed;
            top: 90px;
            left: 0;
            background-color: #f8f9fa;
            padding-top: 20px;
            z-index: 10;
            width: 200px;
        }
        .sidebar a {
            display: block;
            color: black;
            padding: 16px;
            text-decoration: none;
        }
        .sidebar a:hover {
            background-color: #ddd;
        }
        .profile-img-container {
            text-align: center;
            margin-bottom: 10px;
        }
        .profile-img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .profile-img-container a:hover {
            background-color: transparent; /* 호버 시 배경색 변경 방지 */
        }
        .profile-img:hover {
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }
        .profile-details {
            text-align: center;
        }
        .menu-items {
            margin-top: 150px; /* 메뉴 항목들을 아래로 내림 */
        }
        .menu-items a {
            border-bottom: black;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="profile-img-container">
            <a href="프로필설정페이지">
                <img src="${path2}/resources/images/profile.png" alt="Profile Image" class="profile-img">
                <div class="profile-details">
                    <br>
                    <div>닉네임</div>
                    <div>프로필</div>
                </div>
            </a>
        </div>
        <div class="menu-items">
            <a href="#">상품관리</a>
            <a href="#">판매관리</a>
            <a href="#">문의/리뷰관리</a>
            <a href="#">회원관리</a>
            <a href="#">게시판관리</a>
            <a href="#">배너설정</a>
        </div>
    </div>
</body>
</html>
