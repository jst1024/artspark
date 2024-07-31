<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path2" value="${pageContext.servletContext.contextPath}"/>
<div class="dashboard-item">
    <h5>회원 관리</h5>
    <div class="table-container">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>회원 ID</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>상태</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody id="memberTableBody">
                <!-- AJAX로 데이터를 채울 예정 -->
            </tbody>
        </table>
        <div id="memberPagingArea">
            <ul class="pagination pagination-custom">
                <!-- AJAX로 페이징을 동적으로 업데이트 -->
            </ul>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        function loadMembers(page) {
            $.ajax({
                url: "${path2}/admin/ajaxMemberList",
                type: "GET",
                data: { page: page },
                success: function (data) {
                    var memberList = data.memberList;
                    var pageInfo = data.pageInfo;

                    // 테이블 갱신
                    var memberTableBody = $("#memberTableBody");
                    memberTableBody.empty();
                    $.each(memberList, function (index, member) {
                        var row = "<tr>" +
                            "<td>" + member.memId + "</td>" +
                            "<td>" + member.memNickname + "</td>" +
                            "<td>" + member.memEmail + "</td>" +
                            "<td>" + (member.status === 'Y' ? '정상' : '정지') + "</td>" +
                            "<td>" +
                            "<button class='btn " + (member.status === 'Y' ? 'btn-danger' : 'btn-success') + " btn-sm toggle-status' data-id='" + member.memId + "'>" +
                            (member.status === 'Y' ? '정지' : '복구') +
                            "</button>" +
                            "</td>" +
                            "</tr>";
                        memberTableBody.append(row);
                    });

                    // 페이지네이션 갱신
                    var pagingArea = $("#memberPagingArea .pagination-custom");
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
                },
                error: function (xhr, status, error) {
                    console.error("회원 목록을 불러오는 중 오류 발생: ", error);
                }
            });
        }

        // 초기 로딩
        loadMembers(1);

        // 페이지네이션 클릭 이벤트
        $(document).on('click', '.pagination-custom a', function (e) {
            e.preventDefault();
            var page = $(this).data('page');
            loadMembers(page);
        });

        // 정지/복구 버튼 클릭 이벤트
        $(document).on('click', '.toggle-status', function () {
            var memberId = $(this).data('id');
            var newStatus = $(this).hasClass('btn-danger') ? 'N' : 'Y';

            $.ajax({
                url: "${path2}/admin/updateMemberStatus",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({ memberId: memberId, status: newStatus }),
                success: function (response) {
                    alert(response.message); // 서버에서 반환한 메시지를 사용자에게 알림
                    loadMembers(1); // 리스트 갱신
                },
                error: function (xhr, status, error) {
                    console.error("상태 변경 중 오류 발생: ", error);
                    alert("상태 변경 중 오류가 발생했습니다.");
                }
            });
        });
    });
</script>
