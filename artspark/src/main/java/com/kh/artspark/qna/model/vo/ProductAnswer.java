package com.kh.artspark.qna.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ProductAnswer {
    private int answerNo; // 답변번호
    private String answerTitle; // 답변제목
    private String answerContent; // 답변내용
    private Date answerDate; // 답변작성일
    private String memId; // 작성자 아이디
    private int qnaNo; // 문의번호
    private String status; // 상태
    private String answerFilePath;
}
