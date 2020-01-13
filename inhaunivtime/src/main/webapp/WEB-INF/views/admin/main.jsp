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
					<i class="fas fa-check"></i> 관리자페이지
				</div>
				<div class="card-body">
					<button data-oper='noticeadd' class="btn btn-success">공지추가</button>
					<button data-oper='seereport' class="btn btn-success">신고내역보기</button>
					<button data-oper='blockuser' class="btn btn-info">유저차단</button>
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
	$("button[data-oper='noticeadd']").on("click",function(e){
		window.location.href = '/admin/noticeadd'
	});
	$("button[data-oper='seereport']").on("click",function(e){
		window.location.href = '/admin/seereport';
	});
	$("button[data-oper='blockuser']").on("click",function(e){
		window.location.href = '/admin/blockuser';
	});
});
</script>
<%@include file="../includes/footer.jsp"%>

