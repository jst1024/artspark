<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 재설정 - 인증번호 확인</title>
</head>
<body>
    <h2>비밀번호 재설정 - 인증번호 확인</h2>
    <form action="reset-password" method="post">
        <input type="hidden" name="email" value="${param.email}">
        <label for="code">인증번호:</label>
        <input type="text" id="code" name="code" required><br>
        <label for="newPassword">새 비밀번호:</label>
        <input type="password" id="newPassword" name="newPassword" required><br>
        <label for="confirmPassword">새 비밀번호 확인:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required><br>
        <input type="submit" value="비밀번호 재설정">
    </form>
</body>
</html>