<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세보기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .container-main {
            max-width: 1200px;
            margin: 0 auto;
        }
        .notice-content {
            margin: 20px 0;
        }
        .notice-file {
            margin-top: 10px;
        }
        .admin-actions {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .btn {
            width: 100%;
            max-width: 200px;
        }
        .img-fixed {
            width: 500px;
            height: 500px;
            object-fit: cover;
        }
        @media (max-width: 1200px) {
            .container-main {
                padding: 0 15px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    <div class="container-fluid" style="max-width: 1920px;">
        <div class="container-main">
            <h2 class="mt-5">공지사항 상세보기</h2>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th scope="row">글 번호</th>
                        <td>${notice.noticeNo}</td>
                        <th scope="row">작성일</th>
                        <td>${notice.noticeDate}</td>
                    </tr>
                    <tr>
                        <th scope="row">제목</th>
                        <td colspan="3">${notice.noticeTitle}</td>
                    </tr>
                    <tr>
                        <td colspan="4" class="notice-content">
                            <div class="mb-3 text-center">
                                <c:if test="${imgFile != null}">
                                    <img src="${imgFile.imgFilePath}" alt="첨부 이미지" class="img-fluid img-fixed">
                                </c:if>
                                <c:if test="${imgFile == null}">
                                    <span></span>
                                </c:if>
                            </div>
                            <p>${notice.noticeContent}</p>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">첨부파일</th>
                        <td colspan="3">
                            <c:if test="${imgFile != null}">
                                <strong>첨부파일: </strong><a href="${imgFile.imgFilePath}" target="_blank">${imgFile.originName}</a>
                            </c:if>
                            <c:if test="${imgFile == null}">
                                <span>첨부파일 없음</span>
                            </c:if>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="admin-actions">
                <c:choose>
                    <c:when test="${sessionScope.loginUser.memId == 'admin'}">
                        <button type="button" class="btn btn-secondary" onclick="location.href='managePage'">관리자페이지</button>
                        <button type="button" class="btn btn-primary" onclick="location.href='updateNotice?noticeNo=${notice.noticeNo}'">수정하기</button>
                            <form action="deleteNotice" method="post" style="display:inline;">
                                <input type="hidden" name="noticeNo" value="${notice.noticeNo}">
                                <input type="hidden" name="filePath" value="${imgFile.imgFilePath}">
                                <button type="submit" class="btn btn-danger">삭제하기</button>
                            </form>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="btn btn-secondary" onclick="history.back()">뒤로가기</button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp" />

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>