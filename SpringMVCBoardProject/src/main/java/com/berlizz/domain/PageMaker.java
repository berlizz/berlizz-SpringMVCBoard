package com.berlizz.domain;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {

	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10;
	private Criteria cri;

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		
		calcData();
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	public void calcData() {
		endPage = (int)(Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		
		startPage = (endPage - displayPageNum) + 1;
		
		int tempEndPage = (int)(Math.ceil(totalCount / (double)cri.getPerPageNum()));
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		
		prev = startPage == 1? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount? false : true; 
	}
	
	// uri page와 perPageNum만 생성 - 게시판 검색 버튼을 눌렀을 시 keyword와 searchType은 속성으로 따와서 붙일 때 사용(검색 조건이 없을 때 사용) 
	public String makeQuery(int page) {
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
									.queryParam("page", page)
									.queryParam("perPageNum", cri.getPerPageNum())
									.build();
		
		return uriComponents.toUriString();
	}
	
	// uri page, perPageNum, searchType, keyword 모두 생성 - list에서 이동 시 모든 속성값 가지고 다닐 때 사용
	public String makeSearch(int page) {
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
									.queryParam("page", page)
									.queryParam("perPageNum", cri.getPerPageNum())
									.queryParam("searchType", ((SearchCriteria)cri).getSearchType())
									.queryParam("keyword", ((SearchCriteria)cri).getKeyword())
									.build();
		
		return uriComponents.toUriString();
	}
	
	
}
