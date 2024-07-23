<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="../common/head.jsp" />
    <style>
        .content {
            margin-left: 220px; 
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
        .sidebar a {
            cursor: pointer;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.sidebar a').on('click', function(e) {
                e.preventDefault();
                var page = $(this).data('page');
                $.ajax({
                    url: page,
                    method: 'GET',
                    success: function(data) {
                        $('.content').html(data);
                    },
                    error: function() {
                        alert('로딩에 실패했어요');
                    }
                });
            });
        });
    </script>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <jsp:include page="../common/sidebar.jsp"/>
    <div class="content">
        <div class="dashboard-container">
            <div class="dashboard-item">
                <h5>정지 회원</h5>
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
                <h5>삭제된 상품</h5>
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
