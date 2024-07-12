-- 드랍 테이블 목록
DROP TABLE MEMBER;
DROP TABLE REQUEST CASCADE CONSTRAINTS;
DROP TABLE REPLY;
DROP TABLE QNA;
DROP TABLE IMG_FILE;
DROP TABLE NOTICE;
DROP TABLE REVIEW;
DROP TABLE PAYMENT;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE PRODUCT_DETAIL;
DROP TABLE BUY CASCADE CONSTRAINTS;
DROP TABLE JJIM;
DROP TABLE ALRAM;
DROP TABLE CHATROOM;
DROP TABLE CHAT;
DROP TABLE PAY_OPTION;
DROP TABLE BUY_OPTION;
DROP TABLE DETAIL_OPTION;
DROP TABLE TAG_CHECK;
DROP TABLE REPORT;
DROP TABLE ANSWER;
DROP TABLE PRODUCTFILE;
DROP TABLE TAG;
DROP TABLE ALRAM_TYPE;
DROP TABLE ARTIST;



-- 테이블 별 SEQUENCE
CREATE SEQUENCE MEMBER_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PRODUCT_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE BUY_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PAYMENT_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE REQUEST_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE REPLY_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE QNA_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE ANSWER_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE IMG_FILE_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE NOTICE_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE REVIEW_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PRODUCT_DETAIL_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE JJIM_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE ALRAM_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE CHATROOM_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE CHAT_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PAY_OPTION_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE BUY_OPTION_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE DETAIL_OPTION_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE TAG_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE TAG_CHECK_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE REPORT_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PRODUCTFILE_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE ALRAM_TYPE_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE ARTIST_SEQ START WITH 1 INCREMENT BY 1;



-- MEMBER 테이블 생성
CREATE TABLE MEMBER (
   MEM_ID VARCHAR2(50) NOT NULL,
   MEM_PWD VARCHAR2(100) NOT NULL,
   MEM_NICKNAME VARCHAR2(50),
   STATUS VARCHAR2(10) DEFAULT 'Y' NOT NULL,
   MEM_EMAIL VARCHAR2(100) NOT NULL,
   MEM_ENROLL DATE DEFAULT SYSDATE NOT NULL,
   MEM_CATEGORY VARCHAR2(10) DEFAULT 'A' NOT NULL,
   PRIMARY KEY (MEM_ID)
);

COMMENT ON COLUMN MEMBER.STATUS IS 'Y 와 N 으로 탈퇴 여부확인';
COMMENT ON COLUMN MEMBER.MEM_CATEGORY IS 'A : 일반회원 B : 판매자 C : 관리자 D : 블랙리스트';

-- MEMBER 더미 데이터
INSERT INTO MEMBER (MEM_ID, MEM_PWD, MEM_NICKNAME, STATUS, MEM_EMAIL, MEM_ENROLL, MEM_CATEGORY)
VALUES ('admin', '1234', '관리자', 'Y', 'admin@example.com', SYSDATE, 'C');
INSERT INTO MEMBER (MEM_ID, MEM_PWD, MEM_NICKNAME, STATUS, MEM_EMAIL, MEM_ENROLL, MEM_CATEGORY)
VALUES ('user1', 'pwd1', 'nick1', 'Y', 'user1@example.com', SYSDATE, 'A');
INSERT INTO MEMBER (MEM_ID, MEM_PWD, MEM_NICKNAME, STATUS, MEM_EMAIL, MEM_ENROLL, MEM_CATEGORY)
VALUES ('user2', 'pwd2', 'nick2', 'Y', 'user2@example.com', SYSDATE, 'B');
INSERT INTO MEMBER (MEM_ID, MEM_PWD, MEM_NICKNAME, STATUS, MEM_EMAIL, MEM_ENROLL, MEM_CATEGORY)
VALUES ('user3', 'pwd3', 'nick3', 'Y', 'user3@example.com', SYSDATE, 'D');




-- ARTIST 테이블 생성
CREATE TABLE ARTIST (
   MEM_ID VARCHAR2(50) NOT NULL,
   ARTIST_INTRO VARCHAR2(400) NOT NULL,
   ARTIST_PHONE VARCHAR2(50) NOT NULL,
   PRIMARY KEY (MEM_ID),
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
);

-- ARTIST 더미 데이터
INSERT INTO ARTIST (MEM_ID, ARTIST_INTRO, ARTIST_PHONE)
VALUES ('admin', '아티스트 소개1', '010-3333-3333');
INSERT INTO ARTIST (MEM_ID, ARTIST_INTRO, ARTIST_PHONE)
VALUES ('user1', '아티스트 소개2', '010-1111-1111');
INSERT INTO ARTIST (MEM_ID, ARTIST_INTRO, ARTIST_PHONE)
VALUES ('user2', '아티스트 소개3', '010-2222-2222');




-- PRODUCT 테이블 생성
CREATE TABLE PRODUCT (
   PRODUCT_NO NUMBER NOT NULL,
   PRODUCT_CATEGORY VARCHAR2(100) NOT NULL,
   PRODUCT_TITLE VARCHAR2(400) NOT NULL,
   PRODUCT_CONTENT VARCHAR2(4000) NOT NULL,
   PRODUCT_DATE DATE DEFAULT SYSDATE NOT NULL,
   MEM_ID VARCHAR2(50) NOT NULL,
   PRIMARY KEY (PRODUCT_NO),
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
);

COMMENT ON COLUMN PRODUCT.PRODUCT_NO IS '시퀀스 사용';

INSERT INTO PRODUCT (PRODUCT_NO, PRODUCT_CATEGORY, PRODUCT_TITLE, PRODUCT_CONTENT, PRODUCT_DATE, MEM_ID)
VALUES (PRODUCT_SEQ.NEXTVAL, '일러스트', '일러스트 제목1', '일러스트 내용1', SYSDATE, 'user1');
INSERT INTO PRODUCT (PRODUCT_NO, PRODUCT_CATEGORY, PRODUCT_TITLE, PRODUCT_CONTENT, PRODUCT_DATE, MEM_ID)
VALUES (PRODUCT_SEQ.NEXTVAL, '디자인', '디자인 제목2', '디자인 내용2', SYSDATE, 'user2');
INSERT INTO PRODUCT (PRODUCT_NO, PRODUCT_CATEGORY, PRODUCT_TITLE, PRODUCT_CONTENT, PRODUCT_DATE, MEM_ID)
VALUES (PRODUCT_SEQ.NEXTVAL, '영상', '영상 제목3', '영상 내용3', SYSDATE, 'user3');




-- BUY 테이블 생성
CREATE TABLE BUY (
   BUY_NO NUMBER NOT NULL,
   MEM_ID VARCHAR2(50) NOT NULL,
   PRODUCT_NO NUMBER NOT NULL,
   PRIMARY KEY (BUY_NO),
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE,
   FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT(PRODUCT_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN BUY.BUY_NO IS '시퀀스 사용';

-- BUY 더미 데이터
INSERT INTO BUY (BUY_NO, MEM_ID, PRODUCT_NO)
VALUES (BUY_SEQ.NEXTVAL, 'user1', 1);
INSERT INTO BUY (BUY_NO, MEM_ID, PRODUCT_NO)
VALUES (BUY_SEQ.NEXTVAL, 'user2', 2);
INSERT INTO BUY (BUY_NO, MEM_ID, PRODUCT_NO)
VALUES (BUY_SEQ.NEXTVAL, 'user3', 3);




-- PAYMENT 테이블 생성
CREATE TABLE PAYMENT (
   BUY_NO NUMBER NOT NULL,
   PAYMENT_METHOD VARCHAR2(50) NOT NULL,
   PAYMENT_NAME VARCHAR2(100) NOT NULL,
   PAYMENT_PHONE VARCHAR2(50) NOT NULL,
   PAYMENT_EMAIL VARCHAR2(50),
   PRIMARY KEY (BUY_NO),
   FOREIGN KEY (BUY_NO) REFERENCES BUY(BUY_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN PAYMENT.BUY_NO IS '시퀀스 사용';
COMMENT ON COLUMN PAYMENT.PAYMENT_NAME IS '디폴트 : 세션 유저이름';
COMMENT ON COLUMN PAYMENT.PAYMENT_EMAIL IS '디폴트 : 세션 유저 이메일';

-- PAYMENT 더미 데이터
INSERT INTO PAYMENT (BUY_NO, PAYMENT_METHOD, PAYMENT_NAME, PAYMENT_PHONE, PAYMENT_EMAIL)
VALUES (1, '신용카드', '사용자1', '010-1234-5678', 'user1@example.com');
INSERT INTO PAYMENT (BUY_NO, PAYMENT_METHOD, PAYMENT_NAME, PAYMENT_PHONE, PAYMENT_EMAIL)
VALUES (2, '무통장입금', '사용자2', '010-2345-6789', 'user2@example.com');
INSERT INTO PAYMENT (BUY_NO, PAYMENT_METHOD, PAYMENT_NAME, PAYMENT_PHONE, PAYMENT_EMAIL)
VALUES (3, '휴대폰결제', '사용자3', '010-3456-7890', 'user3@example.com');




-- REQUEST 테이블 생성
CREATE TABLE REQUEST (
   REQ_NO NUMBER NOT NULL,
   REQ_PURPOSE VARCHAR2(100) NOT NULL,
   REQ_TITLE VARCHAR2(100) NOT NULL,
   REQ_CATEGORY VARCHAR2(20) NOT NULL,
   REQ_CONTENT VARCHAR2(2000) NOT NULL,
   REQ_DATE DATE DEFAULT SYSDATE NOT NULL,
   REQ_COUNT NUMBER DEFAULT 0 NOT NULL,
   MEM_ID VARCHAR2(50) NOT NULL,
   PRIMARY KEY (REQ_NO),
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
);

COMMENT ON COLUMN REQUEST.REQ_NO IS '시퀀스 사용';
COMMENT ON COLUMN REQUEST.REQ_PURPOSE IS '상업용, 비상업용';
COMMENT ON COLUMN REQUEST.REQ_CATEGORY IS '일러스트, 디자인, 영상, 웹툰';
COMMENT ON COLUMN REQUEST.REQ_COUNT IS '조회시 +1';

-- REQUEST 더미 데이터
INSERT INTO REQUEST (REQ_NO, REQ_PURPOSE, REQ_TITLE, REQ_CATEGORY, REQ_CONTENT, REQ_DATE, REQ_COUNT, MEM_ID)
VALUES (REQUEST_SEQ.NEXTVAL, '상업용', '의뢰 제목1', '일러스트', '의뢰 내용1', SYSDATE, 0, 'user1');
INSERT INTO REQUEST (REQ_NO, REQ_PURPOSE, REQ_TITLE, REQ_CATEGORY, REQ_CONTENT, REQ_DATE, REQ_COUNT, MEM_ID)
VALUES (REQUEST_SEQ.NEXTVAL, '비상업용', '의뢰 제목2', '디자인', '의뢰 내용2', SYSDATE, 0, 'user2');
INSERT INTO REQUEST (REQ_NO, REQ_PURPOSE, REQ_TITLE, REQ_CATEGORY, REQ_CONTENT, REQ_DATE, REQ_COUNT, MEM_ID)
VALUES (REQUEST_SEQ.NEXTVAL, '상업용', '의뢰 제목3', '영상', '의뢰 내용3', SYSDATE, 0, 'user3');




-- REPLY 테이블 생성
CREATE TABLE REPLY (
   REPLY_NO NUMBER NOT NULL,
   REPLY_CONTENT VARCHAR2(100) NOT NULL,
   REPLY_DATE DATE DEFAULT SYSDATE NOT NULL,
   REQ_NO NUMBER NOT NULL,
   MEM_ID VARCHAR2(50) NOT NULL,
   PRIMARY KEY (REPLY_NO),
   FOREIGN KEY (REQ_NO) REFERENCES REQUEST(REQ_NO) ON DELETE CASCADE,
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
);

COMMENT ON COLUMN REPLY.REPLY_NO IS '시퀀스 사용';

-- REPLY 더미 데이터
INSERT INTO REPLY (REPLY_NO, REPLY_CONTENT, REPLY_DATE, REQ_NO, MEM_ID)
VALUES (REPLY_SEQ.NEXTVAL, '답변 내용1', SYSDATE, 1, 'user1');
INSERT INTO REPLY (REPLY_NO, REPLY_CONTENT, REPLY_DATE, REQ_NO, MEM_ID)
VALUES (REPLY_SEQ.NEXTVAL, '답변 내용2', SYSDATE, 2, 'user2');
INSERT INTO REPLY (REPLY_NO, REPLY_CONTENT, REPLY_DATE, REQ_NO, MEM_ID)
VALUES (REPLY_SEQ.NEXTVAL, '답변 내용3', SYSDATE, 3, 'user3');




-- QNA 테이블 생성
CREATE TABLE QNA (
   QNA_NO NUMBER NOT NULL,
   QNA_TITLE VARCHAR2(400) NOT NULL,
   QNA_CONTENT VARCHAR2(4000) NOT NULL,
   QNA_DATE DATE DEFAULT SYSDATE NOT NULL,
   MEM_ID VARCHAR2(50) NOT NULL,
   SECRET VARCHAR2(5) NOT NULL,
   PRIMARY KEY (QNA_NO),
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
);

COMMENT ON COLUMN QNA.QNA_NO IS '시퀀스 사용';
COMMENT ON COLUMN QNA.SECRET IS 'Y = 비밀, N = 공개';

-- QNA 더미 데이터
INSERT INTO QNA (QNA_NO, QNA_TITLE, QNA_CONTENT, QNA_DATE, MEM_ID, SECRET)
VALUES (QNA_SEQ.NEXTVAL, '질문 제목1', '질문 내용1', SYSDATE, 'user1', 'N');
INSERT INTO QNA (QNA_NO, QNA_TITLE, QNA_CONTENT, QNA_DATE, MEM_ID, SECRET)
VALUES (QNA_SEQ.NEXTVAL, '질문 제목2', '질문 내용2', SYSDATE, 'user2', 'Y');
INSERT INTO QNA (QNA_NO, QNA_TITLE, QNA_CONTENT, QNA_DATE, MEM_ID, SECRET)
VALUES (QNA_SEQ.NEXTVAL, '질문 제목3', '질문 내용3', SYSDATE, 'user3', 'N');




-- ANSWER 테이블 생성
CREATE TABLE ANSWER (
   ANSWER_NO NUMBER NOT NULL,
   ANSWER_TITLE VARCHAR2(400) NOT NULL,
   ANSWER_CONTENT VARCHAR2(4000) NOT NULL,
   ANSWER_DATE DATE DEFAULT SYSDATE NOT NULL,
   MEM_ID VARCHAR2(50) DEFAULT 'admin',
   QNA_NO NUMBER NOT NULL,
   PRIMARY KEY (ANSWER_NO),
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE,
   FOREIGN KEY (QNA_NO) REFERENCES QNA(QNA_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN ANSWER.ANSWER_NO IS '시퀀스 사용';

-- ANSWER 더미 데이터
INSERT INTO ANSWER (ANSWER_NO, ANSWER_TITLE, ANSWER_CONTENT, ANSWER_DATE, MEM_ID, QNA_NO)
VALUES (ANSWER_SEQ.NEXTVAL, '답변 제목1', '답변 내용1', SYSDATE, DEFAULT, 1);
INSERT INTO ANSWER (ANSWER_NO, ANSWER_TITLE, ANSWER_CONTENT, ANSWER_DATE, MEM_ID, QNA_NO)
VALUES (ANSWER_SEQ.NEXTVAL, '답변 제목2', '답변 내용2', SYSDATE, DEFAULT, 2);
INSERT INTO ANSWER (ANSWER_NO, ANSWER_TITLE, ANSWER_CONTENT, ANSWER_DATE, MEM_ID, QNA_NO)
VALUES (ANSWER_SEQ.NEXTVAL, '답변 제목3', '답변 내용3', SYSDATE, DEFAULT, 3);




-- IMG_FILE 테이블 생성
CREATE TABLE IMG_FILE (
   FILE_NO NUMBER NOT NULL,
   BOARD_TYPE VARCHAR2(20) NOT NULL,
   BOARD_NO NUMBER NOT NULL,
   ORIGIN_NAME VARCHAR2(50) NOT NULL,
   CHANGE_NAME VARCHAR2(50) NOT NULL,
   FILE_PATH VARCHAR2(200) NOT NULL,
   FILE_DATE DATE DEFAULT SYSDATE NOT NULL,
   PRIMARY KEY (FILE_NO)
);
COMMENT ON COLUMN IMG_FILE.FILE_NO IS '시퀀스 사용';
COMMENT ON COLUMN IMG_FILE.BOARD_TYPE IS '의뢰, 공지, 문의, 답변, 작가';

-- IMG_FILE 더미 데이터
INSERT INTO IMG_FILE (FILE_NO, BOARD_TYPE, BOARD_NO, ORIGIN_NAME, CHANGE_NAME, FILE_PATH, FILE_DATE)
VALUES (IMG_FILE_SEQ.NEXTVAL, '공지', 1, '원본명1.jpg', '변경명1.jpg', '/path/to/file1', SYSDATE);
INSERT INTO IMG_FILE (FILE_NO, BOARD_TYPE, BOARD_NO, ORIGIN_NAME, CHANGE_NAME, FILE_PATH, FILE_DATE)
VALUES (IMG_FILE_SEQ.NEXTVAL, '의뢰', 2, '원본명2.jpg', '변경명2.jpg', '/path/to/file2', SYSDATE);
INSERT INTO IMG_FILE (FILE_NO, BOARD_TYPE, BOARD_NO, ORIGIN_NAME, CHANGE_NAME, FILE_PATH, FILE_DATE)
VALUES (IMG_FILE_SEQ.NEXTVAL, '문의', 3, '원본명3.jpg', '변경명3.jpg', '/path/to/file3', SYSDATE);
INSERT INTO IMG_FILE (FILE_NO, BOARD_TYPE, BOARD_NO, ORIGIN_NAME, CHANGE_NAME, FILE_PATH, FILE_DATE)
VALUES (IMG_FILE_SEQ.NEXTVAL, '작가', 4, '원본명4.jpg', '변경명4.jpg', '/path/to/file4', SYSDATE);
INSERT INTO IMG_FILE (FILE_NO, BOARD_TYPE, BOARD_NO, ORIGIN_NAME, CHANGE_NAME, FILE_PATH, FILE_DATE)
VALUES (IMG_FILE_SEQ.NEXTVAL, '답변', 5, '원본명5.jpg', '변경명5.jpg', '/path/to/file5', SYSDATE);




-- NOTICE 테이블 생성
CREATE TABLE NOTICE (
   NOTICE_NO NUMBER NOT NULL,
   NOTICE_TITLE VARCHAR2(400) NOT NULL,
   NOTICE_CONTENT VARCHAR2(4000) NOT NULL,
   NOTICE_DATE DATE DEFAULT SYSDATE NOT NULL,
   MEM_ID VARCHAR2(50) DEFAULT 'admin' NOT NULL,
   PRIMARY KEY (NOTICE_NO),
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
);

COMMENT ON COLUMN NOTICE.NOTICE_NO IS '시퀀스 사용';

-- NOTICE 더미 데이터
INSERT INTO NOTICE (NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE, MEM_ID)
VALUES (NOTICE_SEQ.NEXTVAL, '공지 제목1', '공지 내용1', SYSDATE, DEFAULT);
INSERT INTO NOTICE (NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE, MEM_ID)
VALUES (NOTICE_SEQ.NEXTVAL, '공지 제목2', '공지 내용2', SYSDATE, DEFAULT);
INSERT INTO NOTICE (NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_DATE, MEM_ID)
VALUES (NOTICE_SEQ.NEXTVAL, '공지 제목3', '공지 내용3', SYSDATE, DEFAULT);




-- REVIEW 테이블 생성
CREATE TABLE REVIEW (
   REVIEW_NO NUMBER NOT NULL,
   REVIEW_TITLE VARCHAR2(400) NOT NULL,
   REVIEW_CONTENT VARCHAR2(4000) NOT NULL,
   REVIEW_DATE DATE DEFAULT SYSDATE NOT NULL,
   REVIEW_STAR NUMBER(2,1) NOT NULL,
   MEM_ID VARCHAR2(50) NOT NULL,
   PRODUCT_NO NUMBER NOT NULL,
   PRIMARY KEY (REVIEW_NO),
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE,
   FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT(PRODUCT_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN REVIEW.REVIEW_NO IS '시퀀스 사용';
COMMENT ON COLUMN REVIEW.REVIEW_STAR IS '0.5단위';
COMMENT ON COLUMN REVIEW.PRODUCT_NO IS '시퀀스 사용';

-- REVIEW 더미 데이터
INSERT INTO REVIEW (REVIEW_NO, REVIEW_TITLE, REVIEW_CONTENT, REVIEW_DATE, REVIEW_STAR, MEM_ID, PRODUCT_NO)
VALUES (REVIEW_SEQ.NEXTVAL, '리뷰 제목1', '리뷰 내용1', SYSDATE, 4.5, 'user1', 1);
INSERT INTO REVIEW (REVIEW_NO, REVIEW_TITLE, REVIEW_CONTENT, REVIEW_DATE, REVIEW_STAR, MEM_ID, PRODUCT_NO)
VALUES (REVIEW_SEQ.NEXTVAL, '리뷰 제목2', '리뷰 내용2', SYSDATE, 5.0, 'user2', 2);
INSERT INTO REVIEW (REVIEW_NO, REVIEW_TITLE, REVIEW_CONTENT, REVIEW_DATE, REVIEW_STAR, MEM_ID, PRODUCT_NO)
VALUES (REVIEW_SEQ.NEXTVAL, '리뷰 제목3', '리뷰 내용3', SYSDATE, 4.0, 'user3', 3);




-- PRODUCT_DETAIL 테이블 생성
CREATE TABLE PRODUCT_DETAIL (
   PRODUCT_NO NUMBER NOT NULL,
   PRODUCT_PURPOSE VARCHAR2(20) NOT NULL,
   DETAIL_TYPE VARCHAR2(100) NOT NULL,
   DETAIL_SIZE VARCHAR2(50) NOT NULL,
   DETAIL_PIXEL VARCHAR2(50) NOT NULL,
   UPDATE_COUNT NUMBER DEFAULT 0 NOT NULL,
   DETAIL_WORKDATE VARCHAR2(50) NOT NULL,
   PRIMARY KEY (PRODUCT_NO),
   FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT(PRODUCT_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN PRODUCT_DETAIL.PRODUCT_NO IS '시퀀스 사용';

-- PRODUCT_DETAIL 더미 데이터
INSERT INTO PRODUCT_DETAIL (PRODUCT_NO, PRODUCT_PURPOSE, DETAIL_TYPE, DETAIL_SIZE, DETAIL_PIXEL, UPDATE_COUNT, DETAIL_WORKDATE)
VALUES (PRODUCT_DETAIL_SEQ.NEXTVAL, '상업용', '타입1', '사이즈1', '1000x1000', 6, '2024-06-08');
INSERT INTO PRODUCT_DETAIL (PRODUCT_NO, PRODUCT_PURPOSE, DETAIL_TYPE, DETAIL_SIZE, DETAIL_PIXEL, UPDATE_COUNT, DETAIL_WORKDATE)
VALUES (PRODUCT_DETAIL_SEQ.NEXTVAL, '비상업용', '타입2', '사이즈2', '2000x2000', 8, '2024-06-09');
INSERT INTO PRODUCT_DETAIL (PRODUCT_NO, PRODUCT_PURPOSE, DETAIL_TYPE, DETAIL_SIZE, DETAIL_PIXEL, UPDATE_COUNT, DETAIL_WORKDATE)
VALUES (PRODUCT_DETAIL_SEQ.NEXTVAL, '상업용', '타입3', '사이즈3', '3000x3000', 3, '2024-06-18');




-- JJIM 테이블 생성
CREATE TABLE JJIM (
   MEM_ID VARCHAR2(50) NOT NULL,
   PRODUCT_NO NUMBER NOT NULL,
   JJIM_DATE DATE DEFAULT SYSDATE NOT NULL,
   PRIMARY KEY (MEM_ID, PRODUCT_NO),
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE,
   FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT(PRODUCT_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN JJIM.PRODUCT_NO IS '시퀀스 사용';

-- JJIM 더미 데이터
INSERT INTO JJIM (MEM_ID, PRODUCT_NO, JJIM_DATE)
VALUES ('user1', 1, SYSDATE);
INSERT INTO JJIM (MEM_ID, PRODUCT_NO, JJIM_DATE)
VALUES ('user2', 2, DEFAULT);
INSERT INTO JJIM (MEM_ID, PRODUCT_NO, JJIM_DATE)
VALUES ('user3', 3, DEFAULT);




-- ALRAM 테이블 생성
CREATE TABLE ALRAM (
   ALRAM_NO NUMBER NOT NULL,
   ALRAM_TIME DATE DEFAULT SYSDATE NOT NULL,
   ALRAM_CONTENT VARCHAR2(4000) NOT NULL,
   MEM_ID VARCHAR2(50) NOT NULL,
   PRIMARY KEY (ALRAM_NO),
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
);

COMMENT ON COLUMN ALRAM.ALRAM_NO IS '시퀀스 사용';

-- ALRAM 더미 데이터
INSERT INTO ALRAM (ALRAM_NO, ALRAM_TIME, ALRAM_CONTENT, MEM_ID)
VALUES (ALRAM_SEQ.NEXTVAL, SYSDATE, '알림 내용1', 'user1');
INSERT INTO ALRAM (ALRAM_NO, ALRAM_TIME, ALRAM_CONTENT, MEM_ID)
VALUES (ALRAM_SEQ.NEXTVAL, SYSDATE, '알림 내용2', 'user2');
INSERT INTO ALRAM (ALRAM_NO, ALRAM_TIME, ALRAM_CONTENT, MEM_ID)
VALUES (ALRAM_SEQ.NEXTVAL, SYSDATE, '알림 내용3', 'user3');



-- ALRAM_TYPE 테이블 생성
CREATE TABLE ALRAM_TYPE (
   ALRAM_TYPE_NO NUMBER NOT NULL,
   BOARD_TYPE VARCHAR2(20) NOT NULL,
   ALRAM_NO NUMBER NOT NULL,
   PRIMARY KEY (ALRAM_TYPE_NO),
   FOREIGN KEY (ALRAM_NO) REFERENCES ALRAM(ALRAM_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN ALRAM_TYPE.ALRAM_TYPE_NO IS '시퀀스 사용';
COMMENT ON COLUMN ALRAM_TYPE.BOARD_TYPE IS '문의.채팅,구매,의뢰';

-- ALRAM_TYPE 더미 데이터
INSERT INTO ALRAM_TYPE (ALRAM_TYPE_NO, BOARD_TYPE, ALRAM_NO)
VALUES (ALRAM_TYPE_SEQ.NEXTVAL, '문의', 1);
INSERT INTO ALRAM_TYPE (ALRAM_TYPE_NO, BOARD_TYPE, ALRAM_NO)
VALUES (ALRAM_TYPE_SEQ.NEXTVAL, '채팅', 2);
INSERT INTO ALRAM_TYPE (ALRAM_TYPE_NO, BOARD_TYPE, ALRAM_NO)
VALUES (ALRAM_TYPE_SEQ.NEXTVAL, '구매', 3);




-- CHATROOM 테이블 생성
CREATE TABLE CHATROOM (
   CHATROOM_NO NUMBER NOT NULL,
   CHATROOM_ACTIVE VARCHAR2(10) NOT NULL,
   WORK_STATUS VARCHAR2(10) NOT NULL,
   MY_READ_STATUS VARCHAR2(10) NOT NULL,
   YOUR_READ_STATUS VARCHAR2(10) NOT NULL,
   MEM_ID VARCHAR2(50) NOT NULL,
   MEM_ID2 VARCHAR2(50) NOT NULL,
   PRIMARY KEY (CHATROOM_NO),
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE,
   FOREIGN KEY (MEM_ID2) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
);

COMMENT ON COLUMN CHATROOM.CHATROOM_NO IS '시퀀스 사용';
COMMENT ON COLUMN CHATROOM.CHATROOM_ACTIVE IS 'Y = 열림, N = 닫힘';
COMMENT ON COLUMN CHATROOM.WORK_STATUS IS '시작, 끝';
COMMENT ON COLUMN CHATROOM.MY_READ_STATUS IS 'Y = 읽음, N = 안읽음';
COMMENT ON COLUMN CHATROOM.YOUR_READ_STATUS IS 'Y = 읽음, N = 안읽음';

-- CHATROOM 더미 데이터
INSERT INTO CHATROOM (CHATROOM_NO, CHATROOM_ACTIVE, WORK_STATUS, MY_READ_STATUS, YOUR_READ_STATUS, MEM_ID, MEM_ID2)
VALUES (CHATROOM_SEQ.NEXTVAL, 'Y', '시작', 'Y', 'N', 'user1', 'user2');
INSERT INTO CHATROOM (CHATROOM_NO, CHATROOM_ACTIVE, WORK_STATUS, MY_READ_STATUS, YOUR_READ_STATUS, MEM_ID, MEM_ID2)
VALUES (CHATROOM_SEQ.NEXTVAL, 'Y', '끝', 'N', 'Y', 'user2', 'user3');
INSERT INTO CHATROOM (CHATROOM_NO, CHATROOM_ACTIVE, WORK_STATUS, MY_READ_STATUS, YOUR_READ_STATUS, MEM_ID, MEM_ID2)
VALUES (CHATROOM_SEQ.NEXTVAL, 'N', '시작', 'Y', 'N', 'user3', 'user1');




-- CHAT 테이블 생성
CREATE TABLE CHAT (
   CHAT_NO NUMBER NOT NULL,
   CHAT_TIME DATE DEFAULT SYSDATE NOT NULL,
   CHAT_CONTENT VARCHAR2(4000) NOT NULL,
   MEM_ID VARCHAR2(50) NOT NULL,
   CHATROOM_NO NUMBER NOT NULL,
   PRIMARY KEY (CHAT_NO),
   FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE,
   FOREIGN KEY (CHATROOM_NO) REFERENCES CHATROOM(CHATROOM_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN CHAT.CHAT_NO IS '시퀀스 사용';

-- CHAT 더미 데이터
INSERT INTO CHAT (CHAT_NO, CHAT_TIME, CHAT_CONTENT, MEM_ID, CHATROOM_NO)
VALUES (CHAT_SEQ.NEXTVAL, SYSDATE, '채팅 내용1', 'user1', 1);
INSERT INTO CHAT (CHAT_NO, CHAT_TIME, CHAT_CONTENT, MEM_ID, CHATROOM_NO)
VALUES (CHAT_SEQ.NEXTVAL, SYSDATE, '채팅 내용2', 'user2', 2);
INSERT INTO CHAT (CHAT_NO, CHAT_TIME, CHAT_CONTENT, MEM_ID, CHATROOM_NO)
VALUES (CHAT_SEQ.NEXTVAL, SYSDATE, '채팅 내용3', 'user3', 3);




-- PAY_OPTION 테이블 생성
CREATE TABLE PAY_OPTION (
   PAY_OPTION_NO NUMBER NOT NULL,
   OPTION_NAME VARCHAR2(200) NOT NULL,
   PRODUCT_NO NUMBER NOT NULL,
   PRIMARY KEY (PAY_OPTION_NO),
   FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT(PRODUCT_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN PAY_OPTION.PAY_OPTION_NO IS '시퀀스 사용';

INSERT INTO PAY_OPTION (PAY_OPTION_NO, OPTION_NAME, PRODUCT_NO)
VALUES (PAY_OPTION_SEQ.NEXTVAL, '옵션1', 1);
INSERT INTO PAY_OPTION (PAY_OPTION_NO, OPTION_NAME, PRODUCT_NO)
VALUES (PAY_OPTION_SEQ.NEXTVAL, '옵션2', 2);
INSERT INTO PAY_OPTION (PAY_OPTION_NO, OPTION_NAME, PRODUCT_NO)
VALUES (PAY_OPTION_SEQ.NEXTVAL, '옵션3', 3);




-- DETAIL_OPTION 테이블 수정
CREATE TABLE DETAIL_OPTION (
   DETAIL_OPTION_NO NUMBER NOT NULL,
   DETAIL_OPTION_NAME VARCHAR2(200) NOT NULL,
   DETAIL_OPTION_PRICE VARCHAR2(100) NOT NULL,
   PAY_OPTION_NO NUMBER NOT NULL,
   PRIMARY KEY (DETAIL_OPTION_NO),
   FOREIGN KEY (PAY_OPTION_NO) REFERENCES PAY_OPTION(PAY_OPTION_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN DETAIL_OPTION.DETAIL_OPTION_NO IS '시퀀스 사용';

-- DETAIL_OPTION 더미 데이터
INSERT INTO DETAIL_OPTION (DETAIL_OPTION_NO, DETAIL_OPTION_NAME, DETAIL_OPTION_PRICE, PAY_OPTION_NO)
VALUES (DETAIL_OPTION_SEQ.NEXTVAL, '세부옵션1', '500', 1);
INSERT INTO DETAIL_OPTION (DETAIL_OPTION_NO, DETAIL_OPTION_NAME, DETAIL_OPTION_PRICE, PAY_OPTION_NO)
VALUES (DETAIL_OPTION_SEQ.NEXTVAL, '세부옵션2', '1000', 2);
INSERT INTO DETAIL_OPTION (DETAIL_OPTION_NO, DETAIL_OPTION_NAME, DETAIL_OPTION_PRICE, PAY_OPTION_NO)
VALUES (DETAIL_OPTION_SEQ.NEXTVAL, '세부옵션3', '1500', 3);




-- BUY_OPTION 테이블 생성
CREATE TABLE BUY_OPTION (
   BUY_OPTION_NO NUMBER NOT NULL,
   BUY_OPTION_NAME VARCHAR2(200) NOT NULL,
   BUY_DETAIL_OPTION_NAME VARCHAR2(200) NOT NULL,
   BUY_OPTION_PRICE VARCHAR2(50) NOT NULL,
   BUY_OPTION_AMOUNT NUMBER DEFAULT 1 NOT NULL,
   BUY_NO NUMBER NOT NULL,
   PRIMARY KEY (BUY_OPTION_NO),
   FOREIGN KEY (BUY_NO) REFERENCES BUY(BUY_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN BUY_OPTION.BUY_OPTION_NO IS '시퀀스 사용';

-- BUY_OPTION 더미 데이터
INSERT INTO BUY_OPTION (BUY_OPTION_NO, BUY_OPTION_NAME, BUY_DETAIL_OPTION_NAME, BUY_OPTION_PRICE, BUY_OPTION_AMOUNT, BUY_NO)
VALUES (BUY_OPTION_SEQ.NEXTVAL, '구매옵션1', '구매세부옵션1', '1000', 1, 1);
INSERT INTO BUY_OPTION (BUY_OPTION_NO, BUY_OPTION_NAME, BUY_DETAIL_OPTION_NAME, BUY_OPTION_PRICE, BUY_OPTION_AMOUNT, BUY_NO)
VALUES (BUY_OPTION_SEQ.NEXTVAL, '구매옵션2', '구매세부옵션2', '2000', 1, 2);
INSERT INTO BUY_OPTION (BUY_OPTION_NO, BUY_OPTION_NAME, BUY_DETAIL_OPTION_NAME, BUY_OPTION_PRICE, BUY_OPTION_AMOUNT, BUY_NO)
VALUES (BUY_OPTION_SEQ.NEXTVAL, '구매옵션3', '구매세부옵션3', '3000', 1, 3);




-- TAG 테이블 생성
CREATE TABLE TAG (
   TAG_NO NUMBER NOT NULL,
   TAG_NAME VARCHAR2(50) NOT NULL,
   PRIMARY KEY (TAG_NO)
);

COMMENT ON COLUMN TAG.TAG_NO IS '시퀀스 사용';
COMMENT ON COLUMN TAG.TAG_NAME IS '태그가 있을시 이 테이블에 저장';

-- TAG 더미 데이터
INSERT INTO TAG (TAG_NO, TAG_NAME)
VALUES (TAG_SEQ.NEXTVAL, '태그1');
INSERT INTO TAG (TAG_NO, TAG_NAME)
VALUES (TAG_SEQ.NEXTVAL, '태그2');
INSERT INTO TAG (TAG_NO, TAG_NAME)
VALUES (TAG_SEQ.NEXTVAL, '태그3');




-- TAG_CHECK 테이블 생성
CREATE TABLE TAG_CHECK (
   TAG_CHECK_NO NUMBER NOT NULL,
   PRODUCT_NO NUMBER NOT NULL,
   TAG_NO NUMBER NOT NULL,
   PRIMARY KEY (TAG_CHECK_NO),
   FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT(PRODUCT_NO) ON DELETE CASCADE,
   FOREIGN KEY (TAG_NO) REFERENCES TAG(TAG_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN TAG_CHECK.TAG_CHECK_NO IS '시퀀스 사용';

-- TAG_CHECK 더미 데이터
INSERT INTO TAG_CHECK (TAG_CHECK_NO, PRODUCT_NO, TAG_NO)
VALUES (TAG_CHECK_SEQ.NEXTVAL, 1, 1);
INSERT INTO TAG_CHECK (TAG_CHECK_NO, PRODUCT_NO, TAG_NO)
VALUES (TAG_CHECK_SEQ.NEXTVAL, 2, 2);
INSERT INTO TAG_CHECK (TAG_CHECK_NO, PRODUCT_NO, TAG_NO)
VALUES (TAG_CHECK_SEQ.NEXTVAL, 3, 3);




-- REPORT 테이블 생성
CREATE TABLE REPORT (
   REPORT_NO NUMBER NOT NULL,
   MEM_ID1 VARCHAR2(50) NOT NULL,
   MEM_ID2 VARCHAR2(50) NOT NULL,
   REPORT_CONTENT VARCHAR2(4000) NOT NULL,
   REPORT_DATE DATE DEFAULT SYSDATE NOT NULL,
   PRIMARY KEY (REPORT_NO),
   FOREIGN KEY (MEM_ID1) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE,
   FOREIGN KEY (MEM_ID2) REFERENCES MEMBER(MEM_ID) ON DELETE CASCADE
);

COMMENT ON COLUMN REPORT.REPORT_NO IS '시퀀스 사용';

-- REPORT 더미 데이터
INSERT INTO REPORT (REPORT_NO, MEM_ID1, MEM_ID2, REPORT_CONTENT, REPORT_DATE)
VALUES (REPORT_SEQ.NEXTVAL, 'user1', 'user2', '신고 내용1', SYSDATE);
INSERT INTO REPORT (REPORT_NO, MEM_ID1, MEM_ID2, REPORT_CONTENT, REPORT_DATE)
VALUES (REPORT_SEQ.NEXTVAL, 'user2', 'user3', '신고 내용2', SYSDATE);
INSERT INTO REPORT (REPORT_NO, MEM_ID1, MEM_ID2, REPORT_CONTENT, REPORT_DATE)
VALUES (REPORT_SEQ.NEXTVAL, 'user3', 'user1', '신고 내용3', SYSDATE);




-- PRODUCTFILE 테이블 생성
CREATE TABLE PRODUCTFILE (
   FILE_NO NUMBER NOT NULL,
   ORIGIN_NAME VARCHAR2(50) NOT NULL,
   CHANGE_NAME VARCHAR2(50) NOT NULL,
   FILE_PATH VARCHAR2(200) NOT NULL,
   FILE_DATE DATE DEFAULT SYSDATE NOT NULL,
   PRODUCT_NO NUMBER NOT NULL,
   PRIMARY KEY (FILE_NO),
   FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT(PRODUCT_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN PRODUCTFILE.FILE_NO IS '시퀀스 사용';
COMMENT ON COLUMN PRODUCTFILE.PRODUCT_NO IS '시퀀스 사용';

-- PRODUCTFILE 더미 데이터
INSERT INTO PRODUCTFILE (FILE_NO, ORIGIN_NAME, CHANGE_NAME, FILE_PATH, FILE_DATE, PRODUCT_NO)
VALUES (PRODUCTFILE_SEQ.NEXTVAL, '원본명1.jpg', '변경명1.jpg', '/path/to/productfile1', SYSDATE, 1);
INSERT INTO PRODUCTFILE (FILE_NO, ORIGIN_NAME, CHANGE_NAME, FILE_PATH, FILE_DATE, PRODUCT_NO)
VALUES (PRODUCTFILE_SEQ.NEXTVAL, '원본명2.jpg', '변경명2.jpg', '/path/to/productfile2', SYSDATE, 2);
INSERT INTO PRODUCTFILE (FILE_NO, ORIGIN_NAME, CHANGE_NAME, FILE_PATH, FILE_DATE, PRODUCT_NO)
VALUES (PRODUCTFILE_SEQ.NEXTVAL, '원본명3.jpg', '변경명3.jpg', '/path/to/productfile3', SYSDATE, 3);


-- 멤버테이블에 회원 정지 기간, 회원 신고 수 컬럼 추가
ALTER TABLE MEMBER ADD MEM_SUSPENSION DATE;
ALTER TABLE MEMBER ADD MEM_REPORTCOUNT NUMBER DEFAULT 0;

-- 상품, 의뢰, 문의, 답변 테이블에 삭제(정지) 여부 추가 
ALTER TABLE PRODUCT ADD STATUS VARCHAR2(1) DEFAULT 'Y' NOT NULL;
ALTER TABLE REQUEST ADD STATUS VARCHAR2(1) DEFAULT 'Y' NOT NULL;
ALTER TABLE QNA ADD STATUS VARCHAR2(1) DEFAULT 'Y' NOT NULL;
ALTER TABLE ANSWER ADD STATUS VARCHAR2(1) DEFAULT 'Y' NOT NULL;

-- 멤버, 상품, 의뢰, 문의, 답변 테이블에 삭제된 시간 추가
ALTER TABLE PRODUCT ADD PRODUCT_DELDATE DATE;
ALTER TABLE REQUEST ADD REQUEST_DELDATE DATE;
ALTER TABLE QNA ADD QNA_DELDATE DATE;
ALTER TABLE ANSWER ADD ANSWER_DELDATE DATE;
ALTER TABLE MEMBER ADD MEM_DELDATE DATE;

COMMIT;



