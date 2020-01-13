<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../includes/header.jsp"%>
<div id="wrapper">
	<%@include file="../includes/wrapper_sidebar.jsp"%>
	<div id="content-wrapper">
			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-volume-up"></i> 공지사항
				</div>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>#번호</th>
									<th>제목</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list }" var="notice">
								<tr>
									<td><c:out value="${notice.bno }"/></td>
									<td>
										<a class='move' href='<c:out value="${notice.bno }"/>'>
											<c:out value="${notice.title }"/>
										</a>
									</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.regdate }"/></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
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
						<form id='actionForm' action="/notice/list" method='get'>
							<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
							<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
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
		actionForm.attr("action","/notice/get");
		actionForm.submit();
	});
});
</script>
<%@include file="../includes/footer.jsp"%>

