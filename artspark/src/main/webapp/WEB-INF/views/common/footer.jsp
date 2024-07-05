<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <style>
        /* div{border:1px solid red;} */
        #footer {
            width:80%;
            height:200px; 
            margin:auto;
            margin-top:50px;
        }
        #footer-1 {
            width:100%;
            height:20%;
            border-top:1px solid lightgray;
            border-bottom:1px solid lightgray;
        }
        #footer-2 {width:100%; height:80%;}
        #footer-1, #footer-2 {padding-left:50px;}
        #footer-1>a {
            text-decoration:none;
            font-weight:600;
            margin:10px;
            line-height:40px;
            color:black;
        }
        #footer-2>p {
            margin:0;
            padding:10px;
            font-size:13px;
        }
        #p2 {text-align:center;}
    </style>
</head>
<body>
    <div id="footer">
        <div id="footer-1">
            <a href="#">이용약관</a> | 
            <a href="#">개인정보취급방침</a> | 
            <a href="#">공지사항</a> | 
            <a href="#">문의사항</a>
        </div>

        <div id="footer-2">
            <p id="p1">
               주소 : 서울시 서초구 사임당로8길13 4층 / 대표전화 : xx-xxx-xxxx / E-mail : artspark@artspark.kr<br>
               회사명 : artspark  사업자등록번호 : xxx-xx-xxxxx<br>
               artspark는 통신판매 플랫폼 제공자이며, 통신판매의 당사자가 아닙니다. 상품, 상품정보, 거래에 관한 의무와 책임은 판매회원에게 있습니다.<br>
            </p> 
            <p id="p2">Copyright © 1998-2024 승철 Educational Institute All Right Reserved</p>
        </div>
    </div>
</body>
</html>