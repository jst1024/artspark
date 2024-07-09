<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        a {
            text-decoration: none !important;
            color: black !important;
        }
        .header {
            position: -webkit-sticky; 
            position: sticky;
            top: 0;
            z-index: 1000;
            background-color: white;
            width: 100%;
            padding: 10px 0;
        }
        .sidebar {
            height: calc(100vh - 60px); /* 헤더 높이를 제외한 전체 높이 */
            position: fixed;
            top: 60px; /* 헤더 높이만큼 아래에 위치 */
            left: 0;
            background-color: #f8f9fa;
            padding-top: 20px;
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
        }
        .profile-details {
            text-align: center;
        }
        .content {
            margin-left: 220px; /* 사이드바의 너비보다 조금 더 넓게 설정합니다 */
            padding: 20px;
        }
        .dashboard-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .dashboard-item {
            width: 48%;
            background-color: lightgray;
            margin-bottom: 20px;
            padding: 20px;
            border-radius: 10px;
        }
        .table-container {
            width: 100%;
            height: 300px;
            overflow-y: auto;
        }
        table {
            width: 100%;
            text-align: center;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <jsp:include page="../common/sidebar.jsp"/>
    <div class="content">
        <div class="dashboard-container">
            <div class="dashboard-item">
                <h5>신고된 회원</h5>
                <div class="table-container">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>회원 ID</th>
                                <th>신고 사유</th>
                                <th>신고 날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>user01</td>
                                <td>욕설</td>
                                <td>2024-07-10</td>
                            </tr>
                            <tr>
                                <td>user02</td>
                                <td>부적절한 내용</td>
                                <td>2024-07-11</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="dashboard-item">
                <h5>신고된 게시글</h5>
                <div class="table-container">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>게시글 ID</th>
                                <th>신고 사유</th>
                                <th>신고 날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>post01</td>
                                <td>스팸</td>
                                <td>2024-07-09</td>
                            </tr>
                            <tr>
                                <td>post02</td>
                                <td>부적절한 이미지</td>
                                <td>2024-07-10</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="dashboard-item">
                <h5>트래픽 통계</h5>
                <!-- 트래픽 통계 관련 내용 추가 -->
            </div>
            <div class="dashboard-item">
                <h5>고객 문의</h5>
                <div class="table-container">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>문의 ID</th>
                                <th>내용</th>
                                <th>문의 날짜</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>inquiry01</td>
                                <td>배송 문의</td>
                                <td>2024-07-08</td>
                            </tr>
                            <tr>
                                <td>inquiry02</td>
                                <td>상품 문의</td>
                                <td>2024-07-09</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
</body>
</html>
