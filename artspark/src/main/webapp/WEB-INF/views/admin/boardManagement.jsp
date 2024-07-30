<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />
<div class="board-management-container">
    <!-- 상품 게시판 관리 -->
    <div class="dashboard-item">
        <h5>상품게시판 관리</h5>
        <div class="table-container">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>상품번호</th>
                        <th>제목</th>
                        <th>작성일</th>
                        <th>작성자</th>
                    </tr>
                </thead>
                <tbody id="productTableBody">
                    <!-- AJAX로 데이터를 채울 예정 -->
                </tbody>
            </table>
            <!-- 페이징 -->
            <div id="productPagingArea">
                <ul class="pagination pagination-custom">
                    <!-- AJAX로 페이징을 동적으로 업데이트 -->
                </ul>
            </div>
        </div>
    </div>

    <!-- 의뢰 게시판 관리 -->
    <div class="dashboard-item">
        <h5>의뢰 게시판 관리</h5>
        <div class="table-container">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>의뢰 번호</th>
                        <th>의뢰 제목</th>
                        <th>작성일</th>
                        <th>작성자</th>
                    </tr>
                </thead>
                <tbody id="requestTableBody">
                    <!-- AJAX로 데이터를 채울 예정 -->
                </tbody>
            </table>
            <!-- 페이징 -->
            <div id="requestPagingArea">
                <ul class="pagination pagination-custom">
                    <!-- AJAX로 페이징을 동적으로 업데이트 -->
                </ul>
            </div>
        </div>
    </div>

    <!-- 문의 게시판 관리 -->
    <div class="dashboard-item">
        <h5>문의 게시판 관리</h5>
        <div class="table-container">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>문의 번호</th>
                        <th>문의 제목</th>
                        <th>작성자</th>
                        <th>작성 날짜</th>
                    </tr>
                </thead>
                <tbody id="qnaTableBody">
                    <!-- AJAX로 데이터를 채울 예정 -->
                </tbody>
            </table>
            <!-- 페이징 -->
            <div id="qnaPagingArea">
                <ul class="pagination pagination-custom">
                    <!-- AJAX로 페이징을 동적으로 업데이트 -->
                </ul>
            </div>
        </div>
    </div>

    <!-- 공지사항 -->
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
        <div id="noticePagingArea">
            <ul class="pagination pagination-custom">
                <!-- AJAX로 페이징을 동적으로 업데이트 -->
            </ul>
        </div>
        <a class="btn btn-secondary write-btn" href="${path2 }/noticeInsert">글쓰기</a>
    </div>
</div>

<script>
$(document).ready(function() {
    function loadNotices(page) {
        $.ajax({
            url: "${path2}/admin/ajaxNoticeManagement",
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
                var pagingArea = $("#noticePagingArea .pagination-custom");
                pagingArea.empty();

                if (pageInfo.startPage > 1) {
                    pagingArea.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (pageInfo.currentPage - 1) + '">이전</a></li>');
                }

                for (var i = pageInfo.startPage; i <= Math.min(pageInfo.endPage, pageInfo.maxPage); i++) {
                    var activeClass = (i === pageInfo.currentPage) ? 'active' : '';
                    pagingArea.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>');
                }

                if (pageInfo.endPage < pageInfo.maxPage) {
                    pagingArea.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (pageInfo.currentPage + 1) + '">다음</a></li>');
                }
            }
        });
    }

    function loadRequests(page) {
        $.ajax({
            url: "${path2}/admin/ajaxRequestManagement",
            type: "GET",
            data: { page: page },
            success: function(data) {
                var requestList = data.requestList;
                var pageInfo = data.pageInfo;

                // 테이블 갱신
                var requestTableBody = $("#requestTableBody");
                requestTableBody.empty();
                $.each(requestList, function(index, request) {
                    var row = "<tr class='request-Detail'>" +
                              "<td>" + request.reqNo + "</td>" +
                              "<td>" + request.reqTitle + "</td>" +
                              "<td>" + request.reqDate + "</td>" +
                              "<td>" + request.memId + "</td>" +
                              "</tr>";
                    requestTableBody.append(row);
                });

                // 페이지네이션 갱신
                var pagingArea = $("#requestPagingArea .pagination-custom");
                pagingArea.empty();
                

                if (pageInfo.startPage > 1) {
                    pagingArea.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (pageInfo.currentPage - 1) + '">이전</a></li>');
                }

                for (var i = pageInfo.startPage; i <= Math.min(pageInfo.endPage, pageInfo.maxPage); i++) {
                    var activeClass = (i === pageInfo.currentPage) ? 'active' : '';
                    pagingArea.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>');
                }

                if (pageInfo.endPage < pageInfo.maxPage) {
                    pagingArea.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (pageInfo.currentPage + 1) + '">다음</a></li>');
                }
            }
        });
    }

    function loadProducts(page) {
        $.ajax({
            url: "${path2}/admin/ajaxProductManagement",
            type: "GET",
            data: { page: page },
            success: function(data) {
                var productList = data.productList;
                var pageInfo = data.pageInfo;

                // 테이블 갱신
                var productTableBody = $("#productTableBody");
                productTableBody.empty();
                $.each(productList, function(index, product) {
                    var row = "<tr class='product-Detail'>" +
                              "<td>" + product.productNo + "</td>" +
                              "<td>" + product.productTitle + "</td>" +
                              "<td>" + product.productDate + "</td>" +
                              "<td>" + product.memId + "</td>" +
                              "</tr>";
                    productTableBody.append(row);
                });

                // 페이지네이션 갱신
                var pagingArea = $("#productPagingArea .pagination-custom");
                pagingArea.empty();

                if (pageInfo.startPage > 1) {
                    pagingArea.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (pageInfo.currentPage - 1) + '">이전</a></li>');
                }

                for (var i = pageInfo.startPage; i <= Math.min(pageInfo.endPage, pageInfo.maxPage); i++) {
                    var activeClass = (i === pageInfo.currentPage) ? 'active' : '';
                    pagingArea.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>');
                }

                if (pageInfo.endPage < pageInfo.maxPage) {
                    pagingArea.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (pageInfo.currentPage + 1) + '">다음</a></li>');
                }
            }
        });
    }

    function loadQnas(page) {
        $.ajax({
            url: "${path2}/admin/ajaxQnaManagement",
            type: "GET",
            data: { page: page },
            success: function(data) {
                var qnaList = data.qnaList;
                var pageInfo = data.pageInfo;

                // 테이블 갱신
                var qnaTableBody = $("#qnaTableBody");
                qnaTableBody.empty();
                $.each(qnaList, function(index, qna) {
                    var row = "<tr class='qna-Detail'>" +
                              "<td>" + qna.qnaNo + "</td>" +
                              "<td>" + qna.qnaTitle  + "</td>" +
                              "<td>" + qna.memId + "</td>" +
                              "<td>" + qna.qnaDate + "</td>" +
                              "</tr>";
                    qnaTableBody.append(row);
                });

                // 페이지네이션 갱신
                var pagingArea = $("#qnaPagingArea .pagination-custom");
                pagingArea.empty();

                if (pageInfo.startPage > 1) {
                    pagingArea.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (pageInfo.currentPage - 1) + '">이전</a></li>');
                }

                for (var i = pageInfo.startPage; i <= Math.min(pageInfo.endPage, pageInfo.maxPage); i++) {
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
    loadRequests(1);
    loadProducts(1);
    loadQnas(1);

    // 페이지네이션 클릭 이벤트
    $(document).on('click', '.pagination-custom a', function(e) {
        e.preventDefault();
        var page = $(this).data('page');
        var containerId = $(this).closest('.pagination-custom').parent().attr('id');
        
        if(containerId === 'noticePagingArea') {
            loadNotices(page);
        } else if(containerId === 'requestPagingArea') {
            loadRequests(page);
        } else if(containerId === 'productPagingArea') {
            loadProducts(page);
        } else if(containerId === 'qnaPagingArea') {
            loadQnas(page);
        }
    });

    // 공지사항 상세보기 클릭 이벤트
    $(document).on('click', '.notice-Detail', function(e) {
        var noticeNo = $(this).children().eq(0).text();
        location.href = 'noticeDetail?noticeNo=' + noticeNo;
    });

    // 의뢰 상세보기 클릭 이벤트
    $(document).on('click', '.request-Detail', function(e) {
        var requestNo = $(this).children().eq(0).text();
        location.href = 'requestDetail?reqNo=' + requestNo;
    });

    // 상품 상세보기 클릭 이벤트
    $(document).on('click', '.product-Detail', function(e) {
        var productNo = $(this).children().eq(0).text();
        location.href = 'productDetail?pno=' + productNo;
    });

    // 문의 상세보기 클릭 이벤트
    $(document).on('click', '.qna-Detail', function(e) {
        var qnaNo = $(this).children().eq(0).text();
        location.href = 'qnaDetail?qnaNo=' + qnaNo;
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

.pagination {
    justify-content : center;
}
</style>
