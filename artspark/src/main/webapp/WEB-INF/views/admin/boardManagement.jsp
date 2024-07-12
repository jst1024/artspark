<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<div class="board-management-container">
    <div class="dashboard-item">
        <h5>상품 게시판 관리</h5>
        <div class="table-container">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>상품 ID</th>
                        <th>상품명</th>
                        <th>작성자</th>
                        <th>작성 날짜</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>product01</td>
                        <td>상품 1</td>
                        <td>user01</td>
                        <td>2024-07-10</td>
                        <td><button class="btn btn-danger">삭제</button></td>
                    </tr>
                    <tr>
                        <td>product02</td>
                        <td>상품 2</td>
                        <td>user02</td>
                        <td>2024-07-11</td>
                        <td><button class="btn btn-danger">삭제</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="dashboard-item">
        <h5>의뢰 게시판 관리</h5>
        <div class="table-container">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>의뢰 ID</th>
                        <th>의뢰 제목</th>
                        <th>작성자</th>
                        <th>작성 날짜</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>request01</td>
                        <td>의뢰 1</td>
                        <td>user01</td>
                        <td>2024-07-10</td>
                        <td><button class="btn btn-danger">삭제</button></td>
                    </tr>
                    <tr>
                        <td>request02</td>
                        <td>의뢰 2</td>
                        <td>user02</td>
                        <td>2024-07-11</td>
                        <td><button class="btn btn-danger">삭제</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="dashboard-item">
        <h5>문의 게시판 관리</h5>
        <div class="table-container">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>문의 ID</th>
                        <th>문의 제목</th>
                        <th>작성자</th>
                        <th>작성 날짜</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>inquiry01</td>
                        <td>문의 1</td>
                        <td>user01</td>
                        <td>2024-07-10</td>
                        <td><button class="btn btn-danger">삭제</button></td>
                    </tr>
                    <tr>
                        <td>inquiry02</td>
                        <td>문의 2</td>
                        <td>user02</td>
                        <td>2024-07-11</td>
                        <td><button class="btn btn-danger">삭제</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="dashboard-item">
        <h5>공지사항</h5>
        <table class="table table-hover" id="noticeList">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>작성자</th>
                </tr>
            </thead>
            <tbody id="noticeTableBody">
                <!-- AJAX로 데이터를 채울 예정 -->
            </tbody>
        </table>
        <!-- 페이징 -->
        <div id="pagingArea">
            <ul class="pagination pagination-custom">
                <!-- AJAX로 페이징을 동적으로 업데이트 -->
            </ul>
        </div>
        <a class="btn btn-secondary write-btn" href="noticeInsert">글쓰기</a>
    </div>
</div>

<script>
$(document).ready(function() {
    function loadNotices(page) {
        $.ajax({
            url: "${path2}/admin/ajaxBoardManagement",
            type: "GET",
            data: { page: page },
            success: function(data) {
                var noticeList = data.noticeList;
                var pageInfo = data.pageInfo;

                // 테이블 갱신
                var noticeTableBody = $("#noticeTableBody");
                noticeTableBody.empty();
                $.each(noticeList, function(index, notice) {
                    var row = "<tr class='notice-Detail'>" +
                              "<td>" + notice.noticeNo + "</td>" +
                              "<td>" + notice.noticeTitle + "</td>" +
                              "<td>" + notice.noticeDate + "</td>" +
                              "<td>" + notice.memId + "</td>" +
                              "</tr>";
                    noticeTableBody.append(row);
                });

                // 페이지네이션 갱신
                var pagingArea = $(".pagination-custom");
                pagingArea.empty();

                if (pageInfo.startPage > 1) {
                    pagingArea.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (pageInfo.currentPage - 1) + '">이전</a></li>');
                }

                for (var i = pageInfo.startPage; i <= pageInfo.endPage; i++) {
                    var activeClass = (i === pageInfo.currentPage) ? 'active' : '';
                    pagingArea.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>');
                }

                if (pageInfo.endPage < pageInfo.maxPage) {
                    pagingArea.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (pageInfo.currentPage + 1) + '">다음</a></li>');
                }
            }
        });
    }

    // 초기 로딩
    loadNotices(1);

    // 페이지네이션 클릭 이벤트
    $(document).on('click', '.pagination-custom a', function(e) {
        e.preventDefault();
        var page = $(this).data('page');
        loadNotices(page);
    });

    // 공지사항 상세보기 클릭 이벤트
    $(document).on('click', '.notice-Detail', function(e) {
        var noticeNo = $(this).children().eq(0).text();
        location.href = 'noticeDetail?noticeNo=' + noticeNo;
    });
});
</script>

<style>
.board-management-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}
.dashboard-item {
    background-color: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    flex: 1 1 calc(50% - 20px); /* 50% 너비를 차지하며, 간격 20px */
    box-sizing: border-box;
}
.table-container {
    overflow-y: auto;
}
.table>tbody>tr:hover {cursor:pointer;}
</style>
