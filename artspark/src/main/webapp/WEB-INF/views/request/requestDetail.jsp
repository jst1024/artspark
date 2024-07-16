<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>의뢰게시판 상세보기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .container-main {
            max-width: 1200px;
            margin: 0 auto;
        }
        .req-content {
            margin: 20px 0;
        }
        .req-file {
            margin-top: 10px;
        }
        .memId-actions {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .btn {
            width: 100%;
            max-width: 200px;
        }
        .img-fixed {
            width: 100%;
            max-width: 500px;
            height: auto;
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
    <div class="container-fluid" style="max-width: 1200px; margin: 0 auto;">
        <div class="container-main">
            <h2 class="mt-5">의뢰글 상세보기</h2>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th scope="row">글 번호</th>
                        <td>${request.reqNo}</td>
                        <th scope="row">작성일</th>
                        <td>${request.reqDate}</td>
                        <th scope="row">작성자</th>
                        <td>${request.memId}</td>
                        <th scope="row">조회수</th>
                        <td>${request.reqCount}</td>
                    </tr>
                    <tr>
                        <th scope="row">제목</th>
                        <td colspan="7">${request.reqTitle}</td>
                    </tr>
                    <tr>
                        <td colspan="8" class="req-content">
                            <div class="mb-7 text-center">
                                <c:if test="${imgFile != null}">
                                    <img src="${imgFile.imgFilePath}" alt="첨부 이미지" class="img-fluid img-fixed">
                                </c:if>
                                <c:if test="${imgFile == null}">
                                    <span></span>
                                </c:if>
                            </div>
                            <p>${request.reqContent}</p>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">첨부파일</th>
                        <td colspan="7">
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
            <div class="memId-actions">
                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
                <c:if test="${ sessionScope.loginUser.memId eq requestScope.request.memId }">
                    <a class="btn btn-primary" onclick="postSubmit(this.innerHTML);">수정하기</a>
                    <a class="btn btn-danger" onclick="postSubmit(this.innerHTML);">삭제하기</a>
                </c:if>
                <form method="post" action="" id="postForm">
                    <input type="hidden" name="reqNo" value="${request.reqNo }" />
                    <input type="hidden" name="filePath" value="${imgFile.imgFilePath}">
                </form>
                <button type="button" class="btn btn-secondary" onclick="history.back()">뒤로가기</button>
                <script>
                    function postSubmit(el) {
                        const attrValue = '수정하기' === el ? 'updateRequest' : 'deleteRequest';
                        $('#postForm').attr('action', attrValue).submit();
                    }
                </script>
            </div>
            <table id="replyArea" class="replyTable" align="center">
                <thead>
                    <c:choose>
                        <c:when test="${empty sessionScope.loginUser }">
                            <tr> <!-- 댓글작성 영역, 로그인이 되어있지 않으면 로그인하라고 표시 -->
                                <th colspan="2">
                                    <textarea class="form-control" name="" id="replyContent" cols="55" rows="2" style="resize:none; width:100%;" readonly>로그인 후 이용가능합니다.</textarea>
                                </th>
                                <th style="vertical-align:middle"><button class="btn btn-secondary" disabled>등록하기</button></th> 
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <tr> <!-- 댓글작성 영역 -->
                                <th colspan="5">
                                    <textarea class="form-control" name="" id="replyContent" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
                                </th>
                                <th style="vertical-align:middle"><button onclick="insertReply();" class="btn btn-secondary">등록하기</button></th> 
                            </tr>
                            <tr>
                                <td colspan="3">댓글(<span id="replyCount"></span>)</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <script>
	    	$(() => {
	    		selectReply();
	    	})
	    
	    	function selectReply() {
	    		$.ajax({
	    			url : 'reply',
	    			type : 'get',
	    			data : {
	    				reqNo : ${ request.reqNo }
	    			},
	    			success : result => {
	    				
	    				let resultStr = '';
	    				
	    				for(let i in result) {
	    					resultStr += '<tr>'
	    							+ '<td>' + result[i].memId + '</td>'
	    							+ '<td>' + result[i].replyContent + '</td>'
	    							+ '<td>' + result[i].replyDate + '</td>'
	    							+ '</tr>';
	    				}
	    				$('#replyArea tbody').html(resultStr);
	    				$('#replyCount').text(result.length);
	
	    			}
	    		});
	    	}
        
        
        	function insertReply() {
        		
        		
        		 if($('#replyContent').val().trim() != ''){
        			$.ajax({
        				url : 'reply',
        				data : {
        					reqNo : ${ request.reqNo }, 
        					replyContent : $('#replyContent').val(), 
        					memId : '${ sessionScope.loginUser.memId }'
        				},
        				type : 'post',
        				success : result => {
        					
        					console.log(result);
        					if(result == 'success') {
        						selectReply();
        						$('#replyContent').val('');
        					}
        				}
        			});	
        		}
        		else {
        			alertify.alert('올브르즈 은습느드..');
        		}
        	}
        



        </script>
    </div>
    <jsp:include page="../common/footer.jsp" />

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
