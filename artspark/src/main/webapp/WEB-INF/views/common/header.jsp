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
                            <li class="nav-item"><a class="nav-link" href="${path2 }/product">일러스트</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path2 }/product">디자인</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path2 }/product">영상·음향</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path2 }/product">웹툰·만화</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">의뢰게시판</a></li>
                        </ul>
                        <form class="form-inline my-2 my-lg-0">
                            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                        </form>

                        <ul class="navbar-nav auth-links">
                            <c:choose>
                                <c:when test="${ sessionScope.loginUser.memId eq 'admin' }">
                                    <li class="nav-item"><a class="nav-link" href="logout">로그아웃</a></li>
                                    <li class="nav-item"><a class="nav-link" href="">관리자게시판</a></li>
                                </c:when>
                                <c:when test="${ sessionScope.loginUser eq null }">
                                    <li class="nav-item"><a class="nav-link" href="#" data-toggle="modal" data-target="#loginModal">로그인</a></li>
                                    <li class="nav-item"><a class="nav-link" href="join">회원가입</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item"><a class="nav-link" href="logout">로그아웃</a></li>
                                    <li class="nav-item"><a class="nav-link" href="">회원정보</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
    </div>
    <div class="modal fade" id="loginModal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Login</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;"></button>
                </div>
        
                <form action="login" method="post">
                    <!-- Modal body -->
                    <div class="modal-body">
                        <label for="memId" class="mr-sm-2">ID : </label>
                        <input type="text" class="form-control mb-2 mr-sm-2" placeholder="아이디 입력" id="memId" name="memId"> <br>
                        <label for="memPwd" class="mr-sm-2">Password : </label>
                        <input type="password" class="form-control mb-2 mr-sm-2" placeholder="비밀번호 입력" id="memPwd" name="memPwd">
                    </div>
                           
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">로그인</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
