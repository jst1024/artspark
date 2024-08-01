<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />

<!DOCTYPE html>
<html>
<head>
    <title>배너 설정</title>
    <link rel="stylesheet" href="${path2}/resources/css/bootstrap.min.css">
    <style>
        .table-container {
            margin-top: 20px;
        }
        .table img {
            width: 50px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="dashboard-item">
            <h5>배너 설정</h5>
            <div class="table-container">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>배너 ID</th>
                            <th>이미지</th>
                            <th>링크</th>
                            <th>상태</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="banner" items="${bannerList}">
                            <tr>
                                <td>${banner.BAN_NO}</td>
                                <td><img src="${path2}/resources/images/${banner.BAN_IMAGE}" alt="배너 이미지"></td>
                                <td><a href="${banner.BAN_URL}">링크</a></td>
                                <td>${banner.BAN_STATUS}</td>
                                <td>
                                    <button class="btn btn-danger btn-sm" onclick="deleteBanner(${banner.BAN_NO})">삭제</button>
                                    <button class="btn btn-warning btn-sm" onclick="editBanner(${banner.BAN_NO})">수정</button>
                                    <c:choose>
                                        <c:when test="${banner.BAN_STATUS == '활성'}">
                                            <button class="btn btn-success btn-sm" onclick="toggleBannerStatus(${banner.BAN_NO}, '비활성')">비활성화</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-success btn-sm" onclick="toggleBannerStatus(${banner.BAN_NO}, '활성')">활성화</button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        function deleteBanner(bannerId) {
            if (confirm('정말 삭제하시겠습니까?')) {
                window.location.href = '${path2}/deleteBanner?bannerId=' + bannerId;
            }
        }

        function editBanner(bannerId) {
            window.location.href = '${path2}/editBanner?bannerId=' + bannerId;
        }

        function toggleBannerStatus(bannerId, status) {
            window.location.href = '${path2}/toggleBannerStatus?bannerId=' + bannerId + '&status=' + status;
        }
    </script>
</body>
</html>
