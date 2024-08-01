<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path2" value="${pageContext.servletContext.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../common/head.jsp"/>
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
            height: 450px; /* 고정 높이 설정 */
        }
        .table-container {
            width: 100%;
            height: calc(100% - 40px); /* height를 적절히 계산하여 스크롤을 피함 */
            overflow-y: auto;
        }
        table {
            width: 100%;
            text-align: center;
        }
        .sidebar a {
            cursor: pointer;
        }
        .pagination {
            justify-content: center;
        }
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
            flex: 1 1 calc(50% - 20px);
            box-sizing: border-box;
        }
        .table-container {
            overflow-y: auto;
        }
        .table > tbody > tr:hover {
            cursor: pointer;
        }
        .notice-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .notice-pagination {
            flex-grow: 1;
            display: flex;
            justify-content: center;
        }
        .write-btn {
            flex-shrink: 0;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
$(document).ready(function () {
    // 메뉴 항목 클릭 이벤트 핸들러 추가
    $('.menu-items a').click(function (e) {
        e.preventDefault();
        var pageUrl = $(this).data('page');
        $('.content').load(pageUrl);
    });

    function loadNotices(page) {
        $.ajax({
            url: "${path2}/admin/ajaxNoticeManagement",
            type: "GET",
            data: {page: page},
            success: function (data) {
                var noticeList = data.noticeList;
                var pageInfo = data.pageInfo;

                // 테이블 갱신
                var noticeTableBody = $("#noticeTableBody");
                noticeTableBody.empty();
                $.each(noticeList, function (index, notice) {
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

    function loadSuspendedMembers(page) {
        $.ajax({
            url: "${path2}/admin/ajaxSuspendedMemberList",
            type: "GET",
            data: {page: page},
            success: function (data) {
                var suspendedMemberList = data.suspendedMemberList;
                var pageInfo = data.pageInfo;
                console.log(suspendedMemberList); // 확인용 콘솔 로그

                // 테이블 갱신
                var memberTableBody = $("#suspendedMembersTableBody");
                memberTableBody.empty();
                $.each(suspendedMemberList, function (index, member) {
                    var row = "<tr class='member-Detail' data-id='" + member.memId + "'>" +
                        "<td>" + member.memId + "</td>" + 
                        "<td>" + member.memSuspension + "</td>" + 
                        "<td>" + member.reportCategory + "</td>" + 
                        "<td>" + member.memReportcount + "</td>" + 
                        "</tr>";
                    memberTableBody.append(row);
                });

                // 페이지네이션 갱신
                var pagingArea = $("#suspendedMembersPagingArea .pagination-custom");
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

    function loadDeletedProducts(page) {
        $.ajax({
            url: "${path2}/admin/ajaxDeletedProducts",
            type: "GET",
            data: {page: page},
            success: function (data) {
                var deletedProductList = data.deletedProductList;
                var pageInfo = data.pageInfo;
                console.log(deletedProductList);

                var productTableBody = $("#deletedProductsTableBody");
                productTableBody.empty();
                $.each(deletedProductList, function (index, product) {
                    var row = "<tr class='product-Detail' data-id='" + product.productNo + "'>" +
                        "<td>" + product.productNo + "</td>" +
                        "<td>" + product.productTitle + "</td>" +
                        "<td>" + product.memId + "</td>" +
                        "<td>" + product.productDate + "</td>" +
                        "</tr>";
                    productTableBody.append(row);
                });

                var pagingArea = $("#deletedProductsPagingArea .pagination-custom");
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

    function loadTrafficStats(page) {
        $.ajax({
            url: "${path2}/admin/ajaxTrafficStats",
            type: "GET",
            data: {page: page},
            success: function (data) {
                var statsList = data.statsList;
                var pageInfo = data.pageInfo;

                // 테이블 갱신
                var statsTableBody = $("#trafficStatsTableBody");
                statsTableBody.empty();
                $.each(statsList, function (index, stat) {
                    var row = "<tr class='stat-Detail'>" +
                        "<td>" + stat.date + "</td>" +
                        "<td>" + stat.visits + "</td>" +
                        "<td>" + stat.pageViews + "</td>" +
                        "<td>" + stat.uniqueVisitors + "</td>" +
                        "</tr>";
                    statsTableBody.append(row);
                });

                // 페이지네이션 갱신
                var pagingArea = $("#trafficStatsPagingArea .pagination-custom");
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
            data: {page: page},
            success: function (data) {
                var qnaList = data.qnaList;
                var pageInfo = data.pageInfo;

                // 테이블 갱신
                var qnaTableBody = $("#qnaTableBody");
                qnaTableBody.empty();
                $.each(qnaList, function (index, qna) {
                    var row = "<tr class='qna-Detail'>" +
                        "<td>" + qna.qnaNo + "</td>" +
                        "<td>" + qna.qnaTitle + "</td>" +
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
    loadSuspendedMembers(1);
    loadDeletedProducts(1);
    loadTrafficStats(1);
    loadQnas(1);

    // 페이지네이션 클릭 이벤트
    $(document).on('click', '.pagination-custom a', function (e) {
        e.preventDefault();
        var page = $(this).data('page');
        var containerId = $(this).closest('.pagination-custom').parent().attr('id');

        if (containerId === 'noticePagingArea') {
            loadNotices(page);
        } else if (containerId === 'suspendedMembersPagingArea') {
            loadSuspendedMembers(page);
        } else if (containerId === 'deletedProductsPagingArea') {
            loadDeletedProducts(page);
        } else if (containerId === 'trafficStatsPagingArea') {
            loadTrafficStats(page);
        } else if (containerId === 'qnaPagingArea') {
            loadQnas(page);
        }
    });

    // 공지사항 상세보기 클릭 이벤트
    $(document).on('click', '.notice-Detail', function (e) {
        var noticeNo = $(this).children().eq(0).text();
        location.href = 'noticeDetail?noticeNo=' + noticeNo;
    });

    // 정지 회원 상세보기 클릭 이벤트
    $(document).on('click', '.member-Detail', function (e) {
        var memberId = $(this).data('id');
        $('#memberId').val(memberId);
        $('#suspendedMemberModal').modal('show');
    });

    // 삭제된 상품 상세보기 클릭 이벤트
    $(document).on('click', '.product-Detail', function (e) {
        var productNo = $(this).data('id');
        $('#productNo').val(productNo);
        $('#deletedProductModal').modal('show');
    });

    // 상태 저장 버튼 클릭 이벤트 (정지 회원)
    $('#saveStatusButton').click(function () {
        var memberId = $('#memberId').val();
        var newStatus = $('#newStatus').val();

        $.ajax({
            url: "${path2}/admin/updateMemberStatus",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ memberId: memberId, status: newStatus }),
            success: function (response) {
                alert(response.message);  // 서버에서 반환한 메시지를 사용자에게 알림
                $('#suspendedMemberModal').modal('hide');
                loadSuspendedMembers(1); // 리스트 갱신
            },
            error: function (xhr, status, error) {
                console.error("상태 변경 중 오류 발생: ", error);
                alert("상태 변경 중 오류가 발생했습니다.");
            }
        });
    });

    // 상태 저장 버튼 클릭 이벤트 (삭제된 상품)
    $('#saveProductStatusButton').click(function () {
        var productNo = $('#productNo').val();
        var newStatus = $('#productStatus').val();

        $.ajax({
            url: "${path2}/admin/updateProductStatus",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ productNo: productNo, status: newStatus }),
            success: function (response) {
                alert(response.message);  // 서버에서 반환한 메시지를 사용자에게 알림
                $('#deletedProductModal').modal('hide');
                loadDeletedProducts(1); // 리스트 갱신
            },
            error: function (xhr, status, error) {
                console.error("상태 변경 중 오류 발생: ", error);
                alert("상태 변경 중 오류가 발생했습니다.");
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
            <h5>신고 회원</h5>
            <div class="table-container">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>회원 ID</th>
                        <th>정지 날짜</th>
                        <th>정지 사유</th>
                        <th>신고수</th>
                    </tr>
                    </thead>
                    <tbody id="suspendedMembersTableBody">
                    <!-- AJAX로 데이터를 채울 예정 -->
                    </tbody>
                </table>
                <div id="suspendedMembersPagingArea">
                    <ul class="pagination pagination-custom">
                        <!-- AJAX로 페이징을 동적으로 업데이트 -->
                    </ul>
                </div>
            </div>
        </div>
        <div class="dashboard-item">
            <h5>삭제된 상품</h5>
            <div class="table-container">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>상품 번호</th>
                        <th>삭제 이유</th>
                        <th>회원명</th>
                        <th>삭제 날짜</th>
                    </tr>
                    </thead>
                    <tbody id="deletedProductsTableBody">
                    <!-- AJAX로 데이터를 채울 예정 -->
                    </tbody>
                </table>
                <div id="deletedProductsPagingArea">
                    <ul class="pagination pagination-custom">
                        <!-- AJAX로 페이징을 동적으로 업데이트 -->
                    </ul>
                </div>
            </div>
        </div>
        <div class="dashboard-item">
            <h5>공지사항</h5>
            <div class="table-container">
                <table class="table table-hover">
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
                <div class="notice-container">
                    <div class="notice-pagination" id="noticePagingArea">
                        <ul class="pagination pagination-custom">
                            <!-- AJAX로 페이징을 동적으로 업데이트 -->
                        </ul>
                    </div>
                    <a class="btn btn-secondary write-btn" href="${path2}/noticeInsert">글쓰기</a>
                </div>
            </div>
        </div>
        <div class="dashboard-item">
            <h5>문의 게시판</h5>
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
                <div id="qnaPagingArea">
                    <ul class="pagination pagination-custom">
                        <!-- AJAX로 페이징을 동적으로 업데이트 -->
                    </ul>
                </div>
            </div>
        </div>
        <div class="dashboard-item">
            <h5>트래픽 통계</h5>
            <div class="table-container">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>날짜</th>
                        <th>방문자 수</th>
                        <th>페이지 뷰</th>
                        <th>고유 방문자</th>
                    </tr>
                    </thead>
                    <tbody id="trafficStatsTableBody">
                    <!-- AJAX로 데이터를 채울 예정 -->
                    </tbody>
                </table>
                <div id="trafficStatsPagingArea">
                    <ul class="pagination pagination-custom">
                        <!-- AJAX로 페이징을 동적으로 업데이트 -->
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 정지 회원 모달 창 -->
<div class="modal fade" id="suspendedMemberModal" tabindex="-1" role="dialog" aria-labelledby="suspendedMemberModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="suspendedMemberModalLabel">정지 상태 변경</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="suspendedMemberForm">
                    <div class="form-group">
                        <label for="memberId">회원 ID</label>
                        <input type="text" class="form-control" id="memberId" readonly>
                    </div>
                    <div class="form-group">
                        <label for="newStatus">정지상태</label>
                        <select class="form-control" id="newStatus">
                            <option value="Y">활성</option>
                            <option value="N">정지</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="saveStatusButton">저장</button>
            </div>
        </div>
    </div>
</div>

<!-- 삭제된 상품 모달 창 -->
<div class="modal fade" id="deletedProductModal" tabindex="-1" role="dialog" aria-labelledby="deletedProductModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deletedProductModalLabel">상품 상태 변경</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="deletedProductForm">
                    <div class="form-group">
                        <label for="productNo">상품 번호</label>
                        <input type="text" class="form-control" id="productNo" readonly>
                    </div>
                    <div class="form-group">
                        <label for="productStatus">상품 상태</label>
                        <select class="form-control" id="productStatus">
                            <option value="Y">활성</option>
                            <option value="N">정지</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="saveProductStatusButton">저장</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>
