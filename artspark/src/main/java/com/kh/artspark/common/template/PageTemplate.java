package com.kh.artspark.common.template;

import com.kh.artspark.common.model.vo.PageInfo;

public class PageTemplate {
	
	
	
	public static PageInfo getPageInfo(int listCount,
									   int currentPage,
									   int pageLimit,
									   int boardLimit) {
	
		int maxPage = (int) Math.ceil((double) listCount / boardLimit);
		
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		
		int endPage = startPage + pageLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		return PageInfo.builder().pageLimit(pageLimit)
					.startPage(startPage)
					.endPage(endPage)
					.listCount(listCount)
					.currentPage(currentPage)
					.maxPage(maxPage)
					.boardLimit(boardLimit)
					.build();
	}
}
