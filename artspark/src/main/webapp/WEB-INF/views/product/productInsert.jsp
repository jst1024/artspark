<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작품 등록</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
    	.container-custom {
            max-width: 1200px;
        }
        .form-group {
            margin-bottom: 2rem !important;
        }
        .col-form-label {
            padding-right: 10px;
        }
        .custom-table td, .custom-table th {
            padding: 0.5rem;
        }
        .custom-file-input {
            display: inline-block;
            margin-right: 10px;
        }
        .pre-image {
        	display: none;
        }
   		.preImage {
   			width:255px;
   			height: 192px;
   			object-fit: cover;
   		}     
   		.plbtn {
   			background-color: white;
   			border: 0px;
   		}
   		.plbtn:hover {
   			text-decoration: underline; 
   		}
   
    </style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
    <div class="container container-custom mt-5">
        <h2>작품 등록</h2><br>
        <p style="font-size: 14px;">✪ 스타일 또는 분야별로 나누어 등록해주세요.<br>
        ✪ 샘플 이미지는 최소 세장 이상 올려주시기 바랍니다.</p><br><br>
        <form action="">
            <div class="form-group row">
                <label for="category" class="col-sm-2 col-form-label">카테고리</label>
                <div class="col-sm-3">
                    <select class="form-control" id="category">
                        <option>일러스트</option>
                        <!-- Add more options here -->
                    </select>
                </div>
            </div>
            
            <div class="form-group row" style="margin-bottom: 60px !important;">
                <label for="title" class="col-sm-2 col-form-label">제목</label>
                <div class="col-sm-5">
                    <input type="text" class="form-control" id="title" placeholder="제목을 입력해주세요.">
                    <small class="form-text text-danger" style="margin-top:10px;">* 특수문자 등으로 제목을 강조, 장식하는 경우 예고 없이 삭제됩니다</small>
                </div>
            </div>
            
            <div class="form-group row" style="margin-bottom: 80px !important;">
                <label for="mainImage" class="col-sm-2 col-form-label">대표 이미지</label>
                <div class="col-sm-3">
                    <input type="file" class="form-control-file" id="mainImage1" onchange="loadImg(this)">
                </div>
                <div class="col-sm-3">
                    <input type="file" class="form-control-file" id="mainImage2" onchange="loadImg(this)">
                </div>
                <div class="col-sm-3">
                    <input type="file" class="form-control-file" id="mainImage3" onchange="loadImg(this)">
                </div>
                
                <!-- 업로드 파일 미리보기 -->
                <script>
	                function loadImg(inputFile) {
	            		const inputId = inputFile.id; 
	            		const idNum = inputId.substring(inputId.length - 1);
	            		const showId = 'preImage' + idNum;  
	            		
	            		if(inputFile.files.length > 0) {
	            			const reader = new FileReader();
	            			reader.readAsDataURL(inputFile.files[0]);
	            			
	            			reader.onload = e => {
	            				document.getElementById(showId).src = e.target.result;
	            			}
	            			
	            			$('.pre-image').show();
	            			console.log($('#preImage1').attr('src'));
	            		} else {
	            			// 파일을 선택안하면 미리보기를 없앰
	            			$('#'+showId).attr('src', ''); 
	            			
	            			if($('#preImage1').attr('src') ==='' && $('#preImage2').attr('src') ==='' && $('#preImage3').attr('src') ==='') {
	            				$('.pre-image').hide();
	            			}
	            		}
	            	}
                </script>
                
                <label for="" class="col-sm-2 col-form-label pre-image"></label>
                <div class="col-sm-3 pre-image">
                    <img id="preImage1" class="preImage" src="">
                </div>
                <div class="col-sm-3 pre-image">
                    <img id="preImage2" class="preImage" src="">
                </div>
                <div class="col-sm-3 pre-image">
                    <img id="preImage3" class="preImage" src="">
                </div>
                
                <label for="" class="col-sm-2 col-form-label"></label>
                <div class="col-sm-9">
                    <small class="form-text text-muted" style="margin-top:10px;">
                        * 권장 사이즈: 가로 세로 4:3 비율 (732px x 549px) / 1개당 최대 용량 12MB<br>
                        * <span style="color:red;">jpg, png, gif</span> 파일만 가능. 애니메트드 등의 메가타 파일불가. 여러장일 경우 이미지 사이즈를 맞춰주세요.<br>
                        * 썸네일 이미지는 첫번째 대표 이미지만 보여집니다.
                    </small>
                </div>
            </div>
            
            <div class="form-group row" style="margin-bottom: 80px !important;">
                <label for="detailedOptions" class="col-sm-2 col-form-label">상세 옵션</label>
                <div class="col-sm-2" style="border-top: 1px solid #e6e6e6; line-height: 80px; margin-bottom:0px !important;">
                	제작 범위
                </div>
                
                <div class="col-sm-3" style="border-top: 1px solid #e6e6e6">
                    <div class="form-group" style="line-height: 80px; margin-bottom:0px !important;">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="broadcast" value="option1">
                            <label class="form-check-label" for="broadcast">상업용</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="nonProfit" value="option2">
                            <label class="form-check-label" for="nonProfit">비상업용</label>
                        </div>
                    </div>
                </div>
                <div class="col-sm-5" style="border-top: 1px solid #e6e6e6; line-height: 70px; margin-bottom:0px !important;">
                	<small class="form-text text-danger">* 두 개 모두 체크하신 경우, 제작금액을 두가지로 나누어 기입하세요</small>
                </div>
                
                <label for="" class="col-sm-2 col-form-label"></label>
                <div class="col-sm-2" style="border-top: 1px solid #e6e6e6; line-height: 80px; margin-bottom:0px !important;">
                	<label for="fileType">제출 파일 유형</label>
                </div>
                <div class="col-sm-2" style="border-top: 1px solid #e6e6e6; line-height: 80px; margin-bottom:0px !important;">
                    <input type="text" class="form-control" id="fileType" style="display: inline;">
                </div>
                <div class="col-sm-6" style="border-top: 1px solid #e6e6e6; line-height: 70px; margin-bottom:0px !important;">
                    <small class="form-text text-muted">예) png, jpg, ai ...</small>
                </div>
                
                <label for="" class="col-sm-2 col-form-label"></label>
                <div class="col-sm-2" style="border-top: 1px solid #e6e6e6; line-height: 80px; margin-bottom:0px !important;">
                	<label for="baseSize">기본 사이즈</label>
                </div>
                <div class="col-sm-2" style="border-top: 1px solid #e6e6e6; line-height: 80px; margin-bottom:0px !important;">
                    <input type="text" class="form-control" id="baseSize" style="display: inline;" placeholder="0000px">
                </div>
                <div class="col-sm-6" style="border-top: 1px solid #e6e6e6; line-height: 70px; margin-bottom:0px !important;">
                    <small class="form-text text-muted">예) 가로 3000px 이상, A4</small>
                </div>
                
                <label for="" class="col-sm-2 col-form-label"></label>
                <div class="col-sm-2" style="border-top: 1px solid #e6e6e6; line-height: 80px; margin-bottom:0px !important;">
                	<label for="resolution">작업 해상도</label>
                </div>
                <div class="col-sm-8" style="border-top: 1px solid #e6e6e6; line-height: 80px; margin-bottom:0px !important;">
                    <input type="text" class="form-control" id="resolution" style="display: inline; width:160px;" placeholder="0000px"> dpi
                </div>
                
                <label for="" class="col-sm-2 col-form-label"></label>
                <div class="col-sm-2" style="border-top: 1px solid #e6e6e6; line-height: 80px; margin-bottom:0px !important;">
                	<label for="revisions">수정 횟수</label>
                </div>
                <div class="col-sm-8" style="border-top: 1px solid #e6e6e6; line-height: 80px; margin-bottom:0px !important;">
                    <input type="number" class="form-control" min="0" value=0 id="revisions" style="display: inline; width:160px;"> 회
                </div>
                
                <label for="" class="col-sm-2 col-form-label"></label>
                <div class="col-sm-2" style="border-top: 1px solid #e6e6e6; border-bottom: 1px solid #e6e6e6; line-height: 80px; margin-bottom:0px !important;">
                	<label for="workPeriod">작업 기간</label>
                </div>
                <div class="col-sm-8" style="border-top: 1px solid #e6e6e6; border-bottom: 1px solid #e6e6e6; line-height: 80px; margin-bottom:0px !important;">
                    <input type="number" class="form-control" min="0" value=0 id="workPeriod" style="display: inline; width:160px;"> 일
                </div>
            </div>
            
            <div class="form-group row" style="margin-bottom: 10px !important;">
                <label for="" class="col-sm-2 col-form-label"></label>
                <div class="col-sm-10">
                    <small class="form-text" style="margin-top:10px;">
                    	<button type="button" class="plbtn" id="plusbtn">
                    		<i class="fas fa-plus"></i> 옵션 추가
                    	</button>&nbsp;&nbsp;&nbsp;
                    	<button type="button" class="plbtn" id="deletebtn">
                    		<span style="color:red;"><i class="fas fa-minus"></i> 삭제</span>
                    	</button>&nbsp;&nbsp;&nbsp;&nbsp;
                    	* 최저 금액이 대표 금액으로 썸네일에 노출됩니다.
                    </small>
                </div>
            </div>
            
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">제작 금액</label>
                <div class="col-sm-10">
                    <table class="table table-bordered custom-table" >
                        <thead>
                            <tr style="text-align:center; height:26px; background-color: #f3f3f3;">
                                <th scope="col" style="width: 5%"><i class="fas fa-check-square"></i></th>
                                <th scope="col" style="width: 25%">옵션명</th>
                                <th scope="col">옵션 선택 항목</th>
                                <th scope="col" style="width: 20%">제작 금액</th>
                            </tr>
                        </thead>
                        <tbody id="optionList">
                        
                        	<!-- 자바스크립트로 옵션추가 버튼 클릭 시 테이블 한 행 추가, 삭제버튼 클릭시 체크박스 체크된 행 삭제 --> 
                            <tr id="optionList1">
                                <td id="optionList_num1" style="text-align:center; line-height:40px;"><input type="checkbox" name="optionCheck" value="1" style="display: inline;"></td>
                                <td><input type="text" class="form-control" name="optionName1" placeholder="옵션명"></td>
                                <td><input type="text" class="form-control" name="optionSelect1" placeholder="옵션 선택 항목"></td>
                                <td><input type="text" class="form-control option-price" name="optionPrice1" placeholder="0" style="text-align:right;"></td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
            </div>
            
            <script>
            	
            	$(() => {
            		
            		let i = 1;
            		
            		// 옵션 추가 버튼 클릭 시 테이블 한 행 추가
            		$('#plusbtn').on('click', function() {
            			i += 1;
            			let line = '';
                		
                		line += '<tr id="optionList'+ i +'">'
                				  + '<td id="optionList_num' + i +'" style="text-align:center; line-height:40px;"><input type="checkbox" name="optionCheck" value="'
                				  + i + '" style="display: inline;"></td>'
                				  + '<td><input type="text" class="form-control" name="optionName' + i + '" placeholder="옵션명"></td>'
                				  + '<td><input type="text" class="form-control" name="optionSelect' + i + '" placeholder="옵션 선택 항목"></td>'
                				  + '<td><input type="text" class="form-control option-price" name="optionPrice' + i + '" placeholder="0" style="text-align:right;"></td>'
                				  + '</tr>';
                				  
                		$('#optionList').append(line);
            		});
            		
            		
					// 옵션 삭제 버튼 클릭 시 체크된 행을 모두 삭제
					$('#deletebtn').on('click', function() {
						
						// name이 optionCheck이고 체크된 체크박스를 가져옴
						$('input:checkbox[name=optionCheck]:checked').each(function(index) {
							
							/*
								- jQuery의 부모를 찾을 수 있는 메서드 세가지
								closest : 선택한 요소부터 시작해서 지정한 선택자에 가장 가까운 조상 요소를 찾음
								반환값 : 선택한 요소부터 시작해서, 일치하는 첫 번째 조상 요소 반환
										  
								parents : 선택한 요소부터 모든 조상 요소들을 선택
								반환값 : 선택한 요소의 모든 조상 요소들을 jQuery객체로 반환
								
								parent : 선택한 요소의 바로 위의 부모 요소를 찾음
								반환값 : 선택한 요소의 바로 위의 부모 요소를 반환
							*/
							
							$(this).closest('tr').remove();							
						});
						
					});
            		
					
            		// 제작금액이 문자면 '숫자만 입력가능 합니다.'라는 문구를 띄워줌.
            		// 제작금액이 4자리 이상일 때 3자리마다 ','을 찍어줌
            		$(document).on('keyup', '.option-price', function(event) {
            			
            			// 문자열에서 쉼표를 찾아서 제거
						let value = ($(this).val()).replace(/,/g, '');
						
						// 백스페이스(8), Tab(9), Enter(13), Escape(27), Ctrl(17), Alt(18) 키는 허용
						if (event.keyCode === 8 || event.keyCode === 9 || event.keyCode === 13 || event.keyCode === 27 || event.ctrlKey || event.altKey) {
				            return;
				        }
						
						// 숫자 여부 체크
						if(!(/^\d+$/.test(value))) {
							alert('숫자만 입력할 수 있습니다.');
							$(this).val('');
							return;
						}
						
						// toLocaleString() : 숫자를 지역화된 형식으로 바꿔줌
						let formatNumber = parseInt(value).toLocaleString();
						
						$(this).val(formatNumber);
            		})
            		
            	});
            	
            </script>
            
            <div class="form-group row">
                <label for="searchTags" class="col-sm-2 col-form-label">검색 태그</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="searchTags" placeholder="#팬아트#삽화...10개까지 입력 가능. 단어 앞에 # 문자를 넣어주세요">
                </div>
            </div>
            
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
				<button type="submit" class="btn-lg btn-primary me-md-2" type="button">작품 등록</button>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="productList" class="btn-lg btn-danger" type="button">취소</a>
			</div>
        </form>
    </div>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>