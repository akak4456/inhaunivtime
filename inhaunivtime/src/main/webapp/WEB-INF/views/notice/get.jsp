<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<style>
.card-body a{
	color: #000000;
	text-decoration: none;
}
ul.chat{
	list-style-type:none;
}
.reply{
	border-bottom: 1px solid black;
	border-width:70%;
}
.uploadResult ul li{
	list-style:none;
	padding:10px;
}
.sirenBtn{
	width:30%;
	height:30%;
}
</style>
<div id="wrapper">
	<%@include file="../includes/wrapper_sidebar.jsp"%>
	<div id="content-wrapper">

		<div class="container-fluid">

			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-check"></i> 글 조회
				</div>
				<div class="card-body">
					<div class="form-group">
						<label>번호</label> <input type="text" name="bno" value='<c:out value="${notice.bno }"/>' 
							readonly="readonly" class="form-control">
					</div>
					<div class="form-group">
						<label>제목</label> <input type="text" name="title" value='<c:out value="${notice.title }"/>' 
							readonly="readonly" class="form-control">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="3" name='content' readonly="readonly"><c:out value="${notice.content }"/></textarea>
					</div>
					<button data-oper='remove' class="btn btn-danger">삭제</button>
					<button data-oper='list' class="btn btn-info">목록</button>
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
	<form id='operForm' action="/freeboard/modify" method="get">
		<input type='hidden' id='bno' name='bno' value='<c:out value="${notice.bno }"/>'>
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
	</form>
</div>
<script src="/resources/js/reply.js"></script>
<script>
</script>
<script>
$(document).ready(function(){
	var operForm = $("#operForm");
	$("button[data-oper='remove']").on("click",function(e){
		operForm.attr("method","post");
		operForm.attr("action","/notice/remove");
		operForm.submit();
		alert("삭제완료");
	});
	$("button[data-oper='list']").on("click",function(e){
		operForm.find("#bno").remove();
		operForm.attr("action","/notice/list");
		operForm.submit();
	});
});
</script>
<%@include file="../includes/footer.jsp"%>

