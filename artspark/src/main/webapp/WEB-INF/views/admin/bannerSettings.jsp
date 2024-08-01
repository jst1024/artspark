<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />

<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../common/head.jsp"/>
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
        <div class="dashboard-item" style="width:100%;">
            <h5>배너 설정</h5>
            <div class="table-container">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>배너번호</th>
                            <th>배너이름</th>
                            <th>링크</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody id="bannerTableBody">
                        <c:forEach var="banner" items="${bannerList}">
                            <tr id="bannerRow-${banner.banNo}">
                                <td>${banner.banNo}</td>
                                <td>${banner.banName}</td>
                                <td><a href="${banner.banUrl}">링크</a></td>
                                <td>
                                    <button class="btn btn-danger btn-sm" onclick="deleteBanner(${banner.banNo})">삭제</button>
                                    <button class="btn btn-warning btn-sm" onclick="editBanner(${banner.banNo})">수정</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <button class="btn btn-primary" data-toggle="modal" data-target="#addBannerModal">배너 추가</button>
    </div>

    <!-- 배너 추가 모달 -->
    <div class="modal fade" id="addBannerModal" tabindex="-1" role="dialog" aria-labelledby="addBannerModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addBannerModalLabel">배너 추가</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="addBannerForm" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="addBanName">배너 이름</label>
                            <input type="text" class="form-control" id="addBanName" name="banName" required>
                        </div>
                        <div class="form-group">
                            <label for="addBanComent">배너 설명</label>
                            <input type="text" class="form-control" id="addBanComent" name="banComent">
                        </div>
                        <div class="form-group">
                            <label for="addBanUrl">배너 URL</label>
                            <input type="text" class="form-control" id="addBanUrl" name="banUrl" required>
                        </div>
                        <div class="form-group">
                            <label for="addBanImage">배너 이미지</label>
                            <input type="file" class="form-control" id="addBanImage" name="banImage" required>
                        </div>
                        <button type="submit" class="btn btn-primary">저장하기</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- 배너 수정 모달 -->
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
	                <form id="editBannerForm" enctype="multipart/form-data">
	                    <input type="hidden" id="editBanNo" name="banNo">
	                    <div class="form-group">
	                        <label for="editBanName">배너 이름</label>
	                        <input type="text" class="form-control" id="editBanName" name="banName" required>
	                    </div>
	                    <div class="form-group">
	                        <label for="editBanComent">배너 설명</label>
	                        <input type="text" class="form-control" id="editBanComent" name="banComent">
	                    </div>
	                    <div class="form-group">
	                        <label for="editBanUrl">배너 URL</label>
	                        <input type="text" class="form-control" id="editBanUrl" name="banUrl" required>
	                    </div>
	                    <div class="form-group">
	                        <label for="editBanImage">배너 이미지</label>
	                        <input type="file" class="form-control" id="editBanImage" name="banImage">
	                    </div>
	                    <button type="submit" class="btn btn-primary">수정하기</button>
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
                    url: '${path2}/deleteBanner',
                    type: 'GET',
                    data: { banNo: banNo },
                    success: function(response) {
                        alert('배너가 삭제되었습니다.');
                        $('#bannerRow-' + banNo).remove();
                    },
                    error: function(xhr, status, error) {
                        alert('배너 삭제에 실패했습니다.');
                    }
                });
            }
        }

        function editBanner(banNo) {
            $.ajax({
                url: '${path2}/editBanner',
                type: 'GET',
                data: { banNo: banNo },
                success: function(response) {
                    $('#editBanNo').val(response.banNo);
                    $('#editBanName').val(response.banName);
                    $('#editBanComent').val(response.banComent);
                    $('#editBanUrl').val(response.banUrl);
                    $('#editBanImage').val('');
                    $('#editBannerModal').modal('show');
                },
                error: function(xhr, status, error) {
                    alert('배너 정보를 불러오는데 실패했습니다.');
                }
            });
        }

        $('#editBannerForm').on('submit', function(event) {
            event.preventDefault();
            var formData = new FormData(this);

            $.ajax({
                url: '${path2}/updateBanner',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    alert('배너가 수정되었습니다.');
                    $('#editBannerModal').modal('hide');
                    $('.modal-backdrop').remove(); // 검은색 배경 제거
                    $('body').removeClass('modal-open'); // 모달 오픈 클래스 제거
                    updateBannerRow(response);
                },
                error: function(xhr, status, error) {
                    alert('배너 수정에 실패했습니다.');
                }
            });
        });

        $('#addBannerForm').on('submit', function(event) {
            event.preventDefault();
            var formData = new FormData(this);

            $.ajax({
                url: '${path2}/addBanner',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    alert('배너가 추가되었습니다.');
                    $('#addBannerModal').modal('hide'); // 모달 닫기
                    $('.modal-backdrop').remove(); // 검은색 배경 제거
                    $('body').removeClass('modal-open'); // 모달 오픈 클래스 제거
                    updateBannerRow(response);
                },
                error: function(xhr, status, error) {
                    alert('배너 추가에 실패했습니다.');
                }
            });
        });

        function updateBannerRow(banner) {
            var row = $('#bannerRow-' + banner.banNo);
            if (row.length === 0) {
                // 새로운 배너 행 추가
                var newRow = '<tr id="bannerRow-' + banner.banNo + '">'
                    + '<td>' + banner.banNo + '</td>'
                    + '<td>' + banner.banName + '</td>'
                    + '<td><a href="' + banner.banUrl + '">링크</a></td>'
                    + '<td>'
                    + '<button class="btn btn-danger btn-sm" onclick="deleteBanner(' + banner.banNo + ')">삭제</button>'
                    + '<button class="btn btn-warning btn-sm" onclick="editBanner(' + banner.banNo + ')">수정</button>'
                    + '</td>'
                    + '</tr>';
                $('#bannerTableBody').append(newRow);
            } else {
                // 기존 배너 행 업데이트
                row.find('td:eq(1)').text(banner.banName);
                row.find('td:eq(2) a').attr('href', banner.banUrl).text('링크');
            }
        }
    </script>
</body>
</html>
