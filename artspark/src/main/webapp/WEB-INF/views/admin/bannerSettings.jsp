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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                            <tr id="banner-${banner.BAN_NO}">
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
        function deleteBanner(bannerNo) {
            if (confirm('정말 삭제하시겠습니까?')) {
                $.ajax({
                    url: '${path2}/deleteBanner',
                    type: 'GET',
                    data: { bannerNo: bannerNo },
                    success: function(result) {
                        if (result > 0) {
                            $('#banner-' + bannerNo).remove();
                            console.log('배너 삭제 성공: 배너 번호 ' + bannerNo);
                        } else {
                            console.error('배너 삭제 실패: 배너 번호 ' + bannerNo);
                        }
                    }
                });
            }
        }

        function editBanner(bannerNo) {
            window.location.href = '${path2}/editBanner?bannerNo=' + bannerNo;
        }

        function toggleBannerStatus(bannerNo, status) {
            $.ajax({
                url: '${path2}/toggleBannerStatus',
                type: 'GET',
                data: { bannerNo: bannerNo, status: status },
                success: function(result) {
                    if (result > 0) {
                        $('#banner-' + bannerNo + ' td:nth-child(4)').text(status);
                        console.log('배너 상태 업데이트 성공: 배너 번호 ' + bannerNo);
                    } else {
                        console.error('배너 상태 업데이트 실패: 배너 번호 ' + bannerNo);
                    }
                }
            });
        }
    </script>
</body>
</html>
