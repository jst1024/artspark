<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <tbody>
                <tr>
                    <td>user01</td>
                    <td>홍길동</td>
                    <td>hong@example.com</td>
                    <td>정상</td>
                    <td>
                        <button class="btn btn-danger btn-sm">정지</button>
                        <button class="btn btn-warning btn-sm">수정</button>
                    </td>
                </tr>
                <tr>
                    <td>user02</td>
                    <td>김철수</td>
                    <td>kim@example.com</td>
                    <td>정지</td>
                    <td>
                        <button class="btn btn-success btn-sm">복구</button>
                        <button class="btn btn-warning btn-sm">수정</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
