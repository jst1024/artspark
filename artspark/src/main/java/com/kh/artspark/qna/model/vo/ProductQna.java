package com.kh.artspark.qna.model.vo;

import java.sql.Date;

import com.kh.artspark.common.model.vo.ImgFile;

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
public class ProductQna {
    private int qnaNo;
    private int productNo;
    private String qnaTitle;  // 문의 제목
    private String qnaContent;// 문의 내용
    private Date qnaDate;     // 작성일
    private String memId;     // 회원 아이디
    private String status;    // 상태
    private Date qnaDelDate;  // 삭제일
    private String qnaCategory; // 카테고리
    private String qnaFilePath;
    private ProductAnswer productAnswer; // 상품문의답변
    
    
}
