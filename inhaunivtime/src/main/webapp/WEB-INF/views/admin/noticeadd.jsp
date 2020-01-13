<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<style>
.uploadResult{
	width:100%;
	background-color:gray;
}
.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items:center;
}
.uploadResult ul li{
	list-style:none;
	padding:10px;
}
.uploadResult ul li img{
	width:20px;
}
</style>
<div id="wrapper">
	<%@include file="../includes/wrapper_sidebar.jsp"%>
	<div id="content-wrapper">

		<div class="container-fluid">

			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-check"></i> 글 등록
				</div>
				<div class="card-body">
					<form role="form" action="/admin/noticeadd" method="post">
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="title" class="form-control">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" rows="3" name='content'></textarea>
						</div>
						<button type="submit" class="btn btn-primary">작성하기</button>
						<button type="reset" class="btn btn-danger">초기화하기</button>
					</form>
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

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">Select "Logout" below if you are ready
				to end your current session.</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<a class="btn btn-primary" href="login.html">Logout</a>
			</div>
		</div>
	</div>
</div>
<%@include file="../includes/footer.jsp"%>

