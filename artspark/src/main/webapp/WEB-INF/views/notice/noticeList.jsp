<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 목록(Notice)</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .container-main {
            max-width: 1920px;
            margin: 0 auto;
            padding: 15px;
        }
        .pagination-custom {
            justify-content: center;
        }
        .write-btn {
            float: right;
        }
        .table-wrapper {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            overflow-x: auto;
        }
        .search-form {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 15px;
            margin-right : 15px;
        }
        #noticeList {text-align:center;}
        #noticeList>tbody>tr:hover {cursor:pointer;}

        #pagingArea {width:fit-content; margin:auto;}
        
        #searchForm {
            width:80%;
            margin:auto;
        }
        .select {width:20%;}
        .text {width:53%;}
        .searchBtn {width:20%;}
        @media (max-width: 768px) {
            .search-form {
                flex-direction: column;
                align-items: flex-start;
            }
            .search-form select, .search-form input, .search-form button {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
    <div id="header">
      <jsp:include page="../common/header.jsp" />
    </div>
    
    <div class="container-main">
        <div class="search-form">
            <form class="form-inline" action="noticeSearchCount" method="get">
                <select class="custom-select mr-2" name="condition">
                    <option selected value="title">제목</option>
                    <option value="content">내용</option>
                </select>
                	<input class="form-control mr-2" type="text" placeholder="검색" name="keyword" value="${keyword}">
                <button class="btn btn-primary" type="submit">검색</button>
            </form>
        </div>
        
        <script>
        $(() => {
            $('#searchForm option[value="${condition}"]').attr('selected', true);
        });
        </script>
        
        <div class="table-wrapper">
            <table class="table table-hover" id="noticeList">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성일</th>
                        <th>작성자</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty noticeList}"> 
                            <tr>
                                <td colspan="5">조회된 결과가 존재하지 않습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="notice" items="${noticeList}" varStatus="status">
                                <tr class="notice-Detail">
                                    <td>${notice.noticeNo}</td>
                                    <td>${notice.noticeTitle}</td>
                                    <td>${notice.noticeDate}</td>
                                    <td><c:out value="${notice.memId}" default="admin"/></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        
        <script>
               $(() => {
            	   console.dir('pagingArea');
            	   
            	   $('.notice-Detail').click(e => {
            		   location.href = 'noticeDetail?noticeNo=' + $(e.currentTarget).children().eq(0).text();
            	   });
               });
        </script>
        
        <!-- 페이징 -->
        <div id="pagingArea">
            <ul class="pagination pagination-custom">
                <!-- 이전 -->
                <c:choose>
                    <c:when test="${pageInfo.startPage eq pageInfo.currentPage || empty noticeList }">
                        <li class="page-item disabled">
                            <a class="page-link" href="#">이전</a>
                        </li>
                    </c:when>
                    <c:when test="${empty condition}">
                        <li>
                            <a class="page-link" href="noticelist?page=${pageInfo.currentPage - 1}">이전</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a class="page-link" href="noticeSearch?page=${pageInfo.currentPage - 1}&condition=${condition}&keyword=${keyword}">이전</a>
                        </li>
                    </c:otherwise>
                </c:choose>
                
                <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="p">
                    <c:choose>
                        <c:when test="${empty condition}">
                            <li class="page-item">
                                <a class="page-link" href="noticelist?page=${p}">${p}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link" href="noticeSearch?page=${p}&condition=${condition}&keyword=${keyword}">${p}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <!-- 다음 -->
                <c:choose>
                    <c:when test="${pageInfo.maxPage eq pageInfo.currentPage || empty noticeList }">
                        <li class="page-item disabled">
                            <a class="page-link" href="#">다음</a>
                        </li>
                    </c:when>
                    <c:when test="${empty condition}">
                        <li class="page-item">
                            <a class="page-link" href="noticelist?page=${pageInfo.currentPage + 1}">다음</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a class="page-link" href="noticeSearch?page=${pageInfo.currentPage + 1}&condition=${condition}&keyword=${keyword}">다음</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
        
        <c:if test="${sessionScope.loginUser.memId eq 'admin'}">
            <a class="btn btn-secondary write-btn" href="noticeInsert">글쓰기</a>
            <button type="button" class="btn btn-secondary" onclick="location.href='managePage'">관리자페이지</button>
        </c:if>
    </div>
    
    <div id="footer">
      <jsp:include page="../common/footer.jsp" />
    </div>
    
</body>
</html>