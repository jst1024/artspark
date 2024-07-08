<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            top: 0;
            left: 0;
            background-color: #f8f9fa;
            padding-top: 20px;
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
        }

        .profile-details {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="profile-img-container">
            <a href="프로필설정페이지">
                <img src="/profile.png" alt="Profile Image" class="profile-img">
            </a>
        </div>
        <div class="profile-details">
            <div>닉네임</div>
            <div>프로필</div>
        </div>
        <a href="#">상품관리</a>
        <a href="#">판매관리</a>
        <a href="#">문의/리뷰관리</a>
    </div>
</body>
</html>
