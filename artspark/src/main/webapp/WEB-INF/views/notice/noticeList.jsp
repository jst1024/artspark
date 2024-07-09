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
            width: 1920px;
            margin: 0 auto;
        }
        .content {
            width: 1200px;
            margin: 0 auto;
        }
        .pagination-custom {
            justify-content: center;
        }
        .write-btn {
            float: right;
        }
    </style>
</head>
<body>

    <div id="header">
      <jsp:include page="../common/header.jsp" />
    </div>
    
    <div class="container-main">
            <form class="form-inline mb-3">
                <select class="custom-select" name="condition">
                	<option selected value="title">제목</option>
                	<option value="content">내용</option>
                    <option value="writer">작성자</option>
                    
                </select>
                <input class="form-control mr-2" type="text" placeholder="검색" name="keyword" value="${keyword }">
                <button class="btn btn-primary" type="submit">검색</button>
            </form>
            
            <script>
            $(() => {
            	$('#searchForm option[value="${condition}"]').attr('selected', true);
            });
            </script>
            
            
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>내용</th>
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
                		<c:otherwise> <!-- otherwise를 썼기 때문에 else같은 성격 -->
	                		<c:forEach var="notice" items="${noticeList }" varStatus="status">
			                    <tr class="notice-detail">
			                        <td>${notice.noticeNo }</td>
			                        <td>${notice.noticeTitle }</td>
			                        <td>${notice.noticeContent }</td>
			                        <td>${notice.noticeDate }</td>
			                        <td><c:out value="${notice.memId}" default="admin"/></td>
			                    </tr>
	                    	</c:forEach>
                    	</c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            
<!-- 페이징 -->
            <div id="pagingArea">
                <ul class="pagination">
                
                <!-- 이전 -->
				<c:choose>
				    <c:when test="${ pageInfo.startPage eq pageInfo.currentPage }">
				        <li class="page-item disabled">
				            <a class="page-link" href="#">이전</a>
				        </li>
				    </c:when>
				    <c:when test="${ empty condition }">
				        <li>
				        	<a class="page-link" href="noticelist?page=${ pageInfo.currentPage - 1 }">이전</a>
			        	</li>
				    </c:when>
				    <c:otherwise>
				        <li>
				        	<a class="page-link" href="search?page=${ pageInfo.currentPage - 1 }&condition=${condition}&keyword=${keyword }">이전</a>
			        	</li>
				    </c:otherwise>
				</c:choose>
                    
                    <c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" var="p" >
	                    <c:choose>
	                    	<c:when test="${ empty condition }"> 
		                    	<li class="page-item">
		                    		<a class="page-link" href="noticelist?page=${ p }">${ p }</a>
		                    		<!-- 몇번 페이지로 요청하는지 -->
		                    	</li>
	                    	</c:when>
	                    	<c:otherwise>
	                    	 	<li class="page-item">
		                    		<a class="page-link" href="search?page=${ p }&condition=${condition}&keyword=${keyword }">${ p }</a>
		                    	</li>
	                    	</c:otherwise>
	                    </c:choose>
                    </c:forEach>
                    
                    
                    <c:choose>
                    <c:when test="${ pageInfo.maxPage eq pageInfo.currentPage }">
                    	<li class="page-item disabled">
                    		<a class="page-link" href="#">다음</a>
                    	</li>
                    </c:when>
                    <c:when test="${ empty condition }">
                    <li class="page-item">
                    	<a class="page-link" href="noticelist?page=${ pageInfo.currentPage + 1 }">다음</a>
                    </li>
                    </c:when>
                    <c:otherwise>
                    	 <li>
				        	<a class="page-link" href="search?page=${ pageInfo.currentPage + 1 }&condition=${condition}&keyword=${keyword }">다음</a>
			        	</li>
                    </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            
            <c:if test="${sessionScope.loginUser.userId eq 'admin'}">
                <a class="btn btn-secondary write-btn" href="insertNoticeForm">글쓰기</a>
            </c:if>
        </div>
    
    <div id="footer">
      <jsp:include page="../common/footer.jsp" />
    </div>
    

</body>
</html>