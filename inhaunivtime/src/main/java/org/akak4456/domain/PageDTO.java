package org.akak4456.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(this.cri.getPageNum()*1.0/this.cri.getAmount()*1.0))*this.cri.getAmount();
		
		this.startPage = this.endPage -(this.cri.getAmount()-1);
		
		int realEnd = (int) (Math.ceil(this.total*1.0/cri.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		
		this.next = this.endPage < realEnd;
	}
}
