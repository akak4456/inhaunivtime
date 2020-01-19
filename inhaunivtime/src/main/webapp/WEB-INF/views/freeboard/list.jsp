<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp"%>
<div id="wrapper">
	<%@include file="../includes/wrapper_sidebar.jsp"%>
	<div id="content-wrapper">
		<div class="container-fluid">
			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-volume-up"></i> 공지사항
				</div>
				<div class="card-body">
					<a class='moveNotice' href='<c:out value="${noticeone.bno }"/>'>
						<c:out value="${noticeone.title }"/>
					</a>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i> HOT 10
				</div>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>#번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>수정일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${hotboard }" var="freeboard">
								<tr>
									<td><c:out value="${freeboard.bno }"/></td>
									<td>
										<a class='move' href='<c:out value="${freeboard.bno }"/>'>
											<c:out value="${freeboard.title }"/>
										</a>
										[<c:out value="${freeboard.replycnt }"/>] 
										<c:if test = "${freeboard.recommendcnt >0}">
											<img src="/resources/img/like.png" width="20px" height="20px"> <c:out value="${freeboard.recommendcnt }"/>
										</c:if>
									</td>
									<td><c:out value="${freeboard.userid }"/></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${freeboard.regdate }"/></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${freeboard.updatedate }"/></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-table"></i> 자유게시판
					<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_STUDENT')">
					<button id='regBtn' type="button" class="btn btn-xs float-right">새글 등록</button>
					</sec:authorize>
				</div>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>#번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>수정일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list }" var="freeboard">
								<tr>
									<td><c:out value="${freeboard.bno }"/></td>
									<td>
										<a class='move' href='<c:out value="${freeboard.bno }"/>'>
											<c:out value="${freeboard.title }"/>
										</a>
										[<c:out value="${freeboard.replycnt }"/>] 
										<c:if test = "${freeboard.recommendcnt >0}">
											<img src="/resources/img/like.png" width="20px" height="20px"> <c:out value="${freeboard.recommendcnt }"/>
										</c:if>
									</td>
									<td><c:out value="${freeboard.userid }"/></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${freeboard.regdate }"/></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${freeboard.updatedate }"/></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div>
						<form id='searchForm' action="/freeboard/list" method='get'>
							<select name='type'>
								<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
								<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
								<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
								<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 또는 내용</option>
								<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목 또는 작성자</option>
								<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':'' }"/>>제목 또는 내용 또는 작성자</option>
							</select>
							<input type='text' name='keyword'/>
							<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
							<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
							<button class='btn btn-success'>Search</button>
						</form>
					</div>
					<div class="float-right dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
						<ul class="pagination">
							<li class='paginate_button page-item previous <c:if test="${pageMaker.prev eq false }">disabled</c:if>' id="dataTable_previous">
								<a href="${pageMaker.startPage-1 }" class="page-link">Previous</a>
							</li>
							<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
								<li class='paginate_button page-item <c:if test="${num == pageMaker.cri.pageNum}">active</c:if>'>
									<a href="${num }" class="page-link">${num }</a>
								</li>
							</c:forEach>
							<li class='paginate_button page-item next <c:if test="${pageMaker.next eq false }">disabled</c:if>' id="dataTable_next">
								<a href="${pageMaker.endPage+1 }" class="page-link">Next</a>
							</li>
						</ul>
						<form id='actionForm' action="/freeboard/list" method='get'>
							<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
							<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
							<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'>
							<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>
						</form>
					</div>
				</div>

		</div>
	</div>
	<!-- /.container-fluid -->
</div>
<!-- /.content-wrapper -->
<%@include file="../includes/wrapper_footer.jsp"%>
</div>
<!-- /#wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i
	class="fas fa-angle-up"></i>
</a>

<!-- 상태알림 Modal-->
<div class="modal fade" id="registerDoneModal" tabindex="-1" role="dialog"
	aria-labelledby="registerDoneModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="registerDoneModalLabel">상태알림</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	var result = '<c:out value="${result}"/>';
	console.log(result);
	checkModal(result);
	history.replaceState({},null,null);
	function checkModal(result){
		if(result === ''||history.state){
			return;
		}
		if(result === 'modifysuccess'){
			$(".modal-body").html("수정이 완료되었습니다");
		}else if(result === 'modifyfail'){
			$(".modal-body").html("수정이 완료되지 못했습니다");
		}
		else if(result === 'removesuccess'){
			$(".modal-body").html("삭제가 완료되었습니다");
		}
		else if(result === 'removefail'){
			$(".modal-body").html("삭제가 완료되지 못했습니다");
		}
		else if(parseInt(result) > 0){
			$(".modal-body").html("게시글"+parseInt(result)+ " 번이 등록되었습니다.");
		}
		$("#registerDoneModal").modal("show");
	}
	
	$("#regBtn").on("click",function(){
		self.location="/freeboard/register";
	})
	
	var actionForm = $("#actionForm");
	
	$(".page-link").on("click",function(e){
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click",function(e){
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action","/freeboard/get");
		actionForm.submit();
	});
	
	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click",function(e){
		if(!searchForm.find("option:selected").val()){
			$(".modal-body").html("검색종류를 선택해주세요");
			$("#registerDoneModal").modal("show");
			return false;
		}
		if(!searchForm.find("input[name='keyword']").val()){
			$(".modal-body").html("키워드를 입력해주세요");
			$("#registerDoneModal").modal("show");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
	})
});
</script>
<%@include file="../includes/footer.jsp"%>

