<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<div id="wrapper">
	<%@include file="../includes/wrapper_sidebar.jsp"%>
	<div id="content-wrapper">

		<div class="container-fluid">

			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-check"></i> 관리자페이지
				</div>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>#번호</th>
									<th>타켓번호</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list }" var="report">
								<tr>
									<td><c:out value="${report.caseno }"/></td>
									<td>
										<a class='move' href='#' data-targetno ='${report.targetno }' data-casekind='${report.casekind }'>
											<c:if test = "${report.casekind eq 'b'.charAt(0)}">
												신고 종류 게시판, 번호:
											</c:if>
											<c:if test = "${report.casekind eq 'r'.charAt(0)}">
												신고 종류 댓글, 번호:
											</c:if>
											<c:out value="${report.targetno }"/>
										</a>
									</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${report.regdate }"/></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<button data-oper='back' class="btn btn-info">돌아가기</button>
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
<div class="modal fade" id="alertModal" tabindex="-1" role="dialog"
	aria-labelledby="alertModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="alertModalLabel">상태알림</h5>
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
	$("button[data-oper='back']").on("click",function(e){
		window.location.href = '/admin/main';
	});
	$(".move").on("click",function(e){
		var targetno = $(this).data("targetno");
		var casekind = $(this).data("casekind");
		console.log("targetno: "+targetno);
		console.log("casekind: "+casekind);
		if(casekind == 'b'){
			window.location.href = "/freeboard/get?bno="+targetno;
		}else if(casekind == 'r'){
			window.location.href = "/admin/seereportGo?rno="+targetno;
		}
	})
});
</script>
<%@include file="../includes/footer.jsp"%>

