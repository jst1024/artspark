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
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="editBannerModal" tabindex="-1" role="dialog" aria-labelledby="editBannerModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editBannerModalLabel">배너 수정</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="editBannerForm">
                        <input type="hidden" id="banNo" name="banNo">
                        <div class="form-group">
                            <label for="banName">배너 이름</label>
                            <input type="text" class="form-control" id="banName" name="banName" required>
                        </div>
                        <div class="form-group">
                            <label for="banComent">배너 설명</label>
                            <input type="text" class="form-control" id="banComent" name="banComent">
                        </div>
                        <div class="form-group">
                            <label for="banUrl">배너 URL</label>
                            <input type="text" class="form-control" id="banUrl" name="banUrl" required>
                        </div>
                        <div class="form-group">
                            <label for="banImage">배너 이미지</label>
                            <input type="text" class="form-control" id="banImage" name="banImage" required>
                        </div>
                        <button type="submit" class="btn btn-primary">저장하기</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="${path2}/resources/js/jquery.min.js"></script>
    <script src="${path2}/resources/js/bootstrap.min.js"></script>
    <script>
        function deleteBanner(banNo) {
            if (confirm('정말 삭제하시겠습니까?')) {
                $.ajax({
                    url: '${path2}/admin/deleteBanner',
                    type: 'GET',
                    data: { banNo: banNo },
                    success: function(response) {
                        alert('배너가 삭제되었습니다.');
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        alert('배너 삭제에 실패했습니다.');
                    }
                });
            }
        }

        function editBanner(banNo) {
            $.ajax({
                url: '${path2}/admin/editBanner',
                type: 'GET',
                data: { banNo: banNo },
                success: function(response) {
                    $('#banNo').val(response.BAN_NO);
                    $('#banName').val(response.BAN_NAME);
                    $('#banComent').val(response.BAN_COMENT);
                    $('#banUrl').val(response.BAN_URL);
                    $('#banImage').val(response.BAN_IMAGE);
                    $('#editBannerModal').modal('show');
                },
                error: function(xhr, status, error) {
                    alert('배너 정보를 불러오는데 실패했습니다.');
                }
            });
        }

        $('#editBannerForm').on('submit', function(event) {
            event.preventDefault();
            $.ajax({
                url: '${path2}/admin/updateBanner',
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    alert('배너가 수정되었습니다.');
                    $('#editBannerModal').modal('hide');
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert('배너 수정에 실패했습니다.');
                }
            });
        });
    </script>
</body>
</html>
