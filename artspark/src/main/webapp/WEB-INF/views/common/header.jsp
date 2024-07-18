<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path2" value="${pageContext.servletContext.contextPath }" />

<jsp:include page="head.jsp" />

<body>

	<!-- 포워딩 된 상황에서 sessionScope에 alertMsg가 존재할 때 -->
	<c:if test="${ not empty alertMsg }">
		<script>
			// 서버에 alertMsg가 존재할 때
			alertify.alert('${alertMsg}').setHeader('ArtSpark').set({'movable':true, 'moveBounded': true}); 
		</script>
		<c:remove var="alertMsg" scope="session"/>
	</c:if>

    <div class="container-fluid header">
        <div class="d-flex justify-content-between align-items-center">
            <div class="p-2">
                <a href="${path2 }/index.jsp">
                    <img src="${path2 }/resources/images/logo.png" alt="Logo" width="100">
                </a>
            </div>
            <div class="p-2 flex-grow-1 d-flex justify-content-end">
                <nav class="navbar navbar-expand navbar-light">
                    <div class="navbar-collapse collapse">
                        <ul class="navbar-nav mr-auto">
                        	<li class="nav-item"><a class="nav-link" href="${path2 }/product">전체</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path2 }/product/category?category=일러스트">일러스트</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path2 }/product/category?category=디자인">디자인</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path2 }/product/category?category=영상 · 음향">영상·음향</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path2 }/product/category?category=웹툰 · 만화">웹툰·만화</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path2 }/requestlist">의뢰게시판</a></li>
                        </ul>
                        <form class="form-inline my-2 my-lg-0">
                            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                        </form>

                        <ul class="navbar-nav auth-links">
                            <c:choose>
                                <c:when test="${ sessionScope.loginUser.memId eq 'admin' }">
                                    <li class="nav-item"><a class="nav-link" href="${path2 }/logout">로그아웃</a></li>
                                    <li class="nav-item"><a class="nav-link" href="${path2 }/admin">관리자게시판</a></li>
                                </c:when>
                                <c:when test="${ sessionScope.loginUser eq null }">
                                    <li class="nav-item"><a class="nav-link" href="${ path2 }/loginPage" >로그인</a></li>
                                    <li class="nav-item"><a class="nav-link" href="${ path2 }/joinPage">회원가입</a></li>
                                </c:when>
                                <c:when test="${ sessionScope.loginUser.memCategory eq 'B' }">
                                    <li class="nav-item"><a class="nav-link" href="${path2 }/logout">로그아웃</a></li>
                                    <li class="nav-item"><a class="nav-link" href="${path2 }/updateProduct">회원정보</a></li>
                                    <li class="nav-item"><a class="nav-link" href="${path2 }/myPage">마이페이지</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item"><a class="nav-link" href="${ path2 }/logout">로그아웃</a></li>
                                    <li class="nav-item"><a class="nav-link" href="${ path2 }/updatePage">회원정보</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
