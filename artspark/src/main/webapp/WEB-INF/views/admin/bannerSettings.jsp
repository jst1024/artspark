<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="dashboard-item">
    <h5>배너 설정</h5>
    <div class="table-container">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>배너 ID</th>
                    <th>이미지</th>
                    <th>링크</th>
                    <th>상태</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>banner01</td>
                    <td><img src="${path2}/resources/images/banner1.jpg" alt="배너1" width="50"></td>
                    <td><a href="#">링크1</a></td>
                    <td>활성</td>
                    <td>
                        <button class="btn btn-danger btn-sm">삭제</button>
                        <button class="btn btn-warning btn-sm">수정</button>
                    </td>
                </tr>
                <tr>
                    <td>banner02</td>
                    <td><img src="${path2}/resources/images/banner2.jpg" alt="배너2" width="50"></td>
                    <td><a href="#">링크2</a></td>
                    <td>비활성</td>
                    <td>
                        <button class="btn btn-success btn-sm">활성화</button>
                        <button class="btn btn-warning btn-sm">수정</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
