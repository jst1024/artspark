<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        .dashboard-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            padding: 20px;
        }
        .dashboard-item {
            width: 48%;
            height: 200px;
            background-color: lightgray;
            margin-bottom: 20px;
        }
        .full-width {
            width: 100%;
            height: 200px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
    	<jsp:include page="../common/sidebar.jsp"/>
            <div class="col-md-10">
                <div class="dashboard-container">
                    <div class="dashboard-item">
                        <h5>신고된 의견</h5>
                    </div>
                    <div class="dashboard-item">
                        <h5>신고된 게시글</h5>
                    </div>
                    <div class="dashboard-item full-width">
                        <h5>트래픽 통계</h5>
                    </div>
                    <div class="dashboard-item full-width">
                        <h5>고객 문의</h5>
                    </div>
                </div>
            </div>
        </div>
</body>
</html>
