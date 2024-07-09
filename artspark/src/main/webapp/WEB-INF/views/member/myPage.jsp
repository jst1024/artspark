<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .artist-card {
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .artist-info {
            flex-grow: 1;
            margin-left: 20px;
        }
        .artist-name {
            font-size: 24px;
            font-weight: bold;
        }
        .rating {
            color: gold;
            font-size: 18px;
        }
        .image-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-left: 10px;
        }
        .image-placeholder-wrapper {
            display: flex;
            justify-content: space-between;
            width: 500px;
        }
        .image-placeholder {
            width: 200px;
            height: 150px;
            background-color: #f8f8f8;
            border: 1px solid #ddd;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .image-caption {
            font-size: 12px;
            padding-right: 350px;
        }
        .remove-button {
            font-size: 24px;
            color: red;
            cursor: pointer;
            align-self: flex-start;
        }
        .profile-image {
            width: 60px;
            height: 60px;
            background-color: #ddd;
            border-radius: 50%;
        }
        .form-group.text-end {
            margin-bottom: 20px;
        }
        .form-group.text-end .form-control {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <div class="container my-5">
        <h1 class="mb-4">마이페이지</h1>
        
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="inquiry-tab" data-bs-toggle="tab" data-bs-target="#inquiry" type="button" role="tab">문의 및 답변</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="order-tab" data-bs-toggle="tab" data-bs-target="#order" type="button" role="tab">주문 관리</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="favorite-tab" data-bs-toggle="tab" data-bs-target="#favorite" type="button" role="tab">관심 작가</button>
            </li>
        </ul>
        
        <div class="tab-content mt-3" id="myTabContent">
            <div class="tab-pane fade show active my-4" id="inquiry" role="tabpanel">
                <h2>문의 및 답변</h2>
                <div class="mt-3 d-flex justify-content-end">
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="showDeleted">
                            <label class="form-check-label" for="showDeleted">삭제된 문의 보기</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="showAnswered">
                            <label class="form-check-label" for="showAnswered">내용검색</label>
                        </div>
                        <div class="input-group w-auto d-inline-flex align-middle">
                            <input type="text" class="form-control" placeholder="작성자/제목">
                            <button class="btn btn-primary" type="button">검색</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade my-4" id="order" role="tabpanel">
                <h2 class="mb-4">주문 관리</h2>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>의뢰번호</th>
                                <th>이미지</th>
                                <th>작가명</th>
                                <th>주문 내용</th>
                                <th>결제 금액</th>
                                <th>주문 상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>2406-306212</td>
                                <td><img src="path_to_image.jpg" alt="캐릭터 이미지" style="width: 50px; height: 50px;"></td>
                                <td>삼냥</td>
                                <td>6월이벤트 / SD캐릭터 / 선물상자 / 고정틀 주가 / 장신구(소품) / 1 컷 선물상자 / 방송용 6월이벤트 / 방송용(전통서비스) / 1 개</td>
                                <td>63,000원</td>
                                <td>
                                    <button class="btn btn-sm btn-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#detailsCollapse" aria-expanded="false" aria-controls="detailsCollapse">
                                        자세히
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="collapse mt-3" id="detailsCollapse">
                    <div class="card card-body bg-light">
                        <p><strong>작가 연락처 : </strong>결제 후 공개됩니다.</p>
                        <p><strong>입금은행 : </strong>우리은행</p>
                        <p><strong>예금주 : </strong>(주)위고헬스</p>
                        <p><strong>입금계좌 : </strong>1005-703-139393</p>
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>결제일 : </strong></p>
                                <p><strong>원본제작일 : </strong></p>
                                <p><strong>제출 파일 유형 : </strong>png & gif</p>
                                <p><strong>해상도 : </strong>300dpi</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>기본 사이즈 : </strong>1000 이상</p>
                                <p><strong>수정 횟수 : </strong>3회</p>
                                <p><strong>작업 기간 : </strong>시작일로부터 7일</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade my-4" id="favorite" role="tabpanel">
                <h2 class="mb-4">관심 작가</h2>
                <div class="form-group text-end">
                    <input type="text" class="form-control d-inline-block" placeholder="작가명" style="width: 200px;">
                    <button type="button" class="btn btn-primary ml-2">검색</button>
                </div>

                <div class="artist-card">
                    <div class="d-flex">
                        <div class="profile-image"></div>
                        <div class="artist-info ml-3">
                            <div class="artist-name">작가 이름</div>
                            <div class="rating">평점 ★★★★★</div>
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center">
                        <div class="image-placeholder-wrapper">
                            <div class="image-placeholder">이미지 1</div>
                            <div class="image-placeholder">이미지 2</div>
                            <div class="image-placeholder">이미지 3</div>
                        </div>
                        <div class="image-caption">제목 1 / 카테고리</div>
                    </div>
                    <div class="remove-button ml-3">X</div>
                </div>

                <div class="artist-card">
                    <div class="d-flex">
                        <div class="profile-image"></div>
                        <div class="artist-info ml-3">
                            <div class="artist-name">작가 이름</div>
                            <div class="rating">평점 ★★★★★</div>
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center">
                        <div class="image-placeholder-wrapper">
                            <div class="image-placeholder">이미지 1</div>
                            <div class="image-placeholder">이미지 2</div>
                            <div class="image-placeholder">이미지 3</div>
                        </div>
                        <div class="image-caption">제목 2 / 카테고리</div>
                    </div>
                    <div class="remove-button ml-3">X</div>
                </div>

                <div class="artist-card">
                    <div class="d-flex">
                        <div class="profile-image"></div>
                        <div class="artist-info ml-3">
                            <div class="artist-name">작가 이름</div>
                            <div class="rating">평점 ★★★★★</div>
                        </div>
                    </div>
                    <div class="d-flex flex-column align-items-center">
                        <div class="image-placeholder-wrapper">
                            <div class="image-placeholder">이미지 1</div>
                            <div class="image-placeholder">이미지 2</div>
                            <div class="image-placeholder">이미지 3</div>
                        </div>
                        <div class="image-caption">제목 3 / 카테고리</div>
                    </div>
                    <div class="remove-button ml-3">X</div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>