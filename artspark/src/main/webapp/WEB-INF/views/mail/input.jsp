<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 재설정 - 이메일 입력</title>
</head>
<body>
    <h2>비밀번호 재설정 - 이메일 입력</h2>
    <form action="auth-mail" method="post">
        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required><br>
        <input type="submit" value="인증번호 받기">
    </form>
</body>
</html>