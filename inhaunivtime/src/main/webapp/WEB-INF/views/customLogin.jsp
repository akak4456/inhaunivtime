<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>인하대타임</title>

<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">

<!-- Custom styles for this template-->
<link href="/resources/css/sb-admin.css" rel="stylesheet">

</head>

<body class="bg-dark">

	<div class="container">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">로그인</div>
			<div class="card-body">
				<form role="form" method='post' action="/login">
					<div class="form-group">
						<div class="form-label-group">
							<input type="text" id="inputUserid" name="username" class="form-control"
								placeholder="아이디" required="required"
								autofocus="autofocus"> <label for="inputUserid">아이디</label>
						</div>
					</div>
					<div class="form-group">
						<div class="form-label-group">
							<input type="password" id="inputPassword" name="password" class="form-control"
								placeholder="비밀번호" required="required"> <label
								for="inputPassword">비밀번호</label>
						</div>
					</div>
					<div class="form-group">
						<div class="checkbox">
							<label> <input type="checkbox" name='remember-me'>
								로그인 상태 유지
							</label>
						</div>
					</div>
					<a id="loginBtn" class="btn btn-primary btn-block" href="index.html">Login</a>
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
				</form>
				<div class="text-center">
					<a class="d-block small mt-3" href="/join">회원가입</a> 
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
	<script>
	$(document).ready(function(e){
		<c:if test="${error != null }">
			alert("<c:out value='${error}'/>");
		</c:if>
		<c:if test="${logout != null }">
			alert("<c:out value='${logout}'/>");
		</c:if>
		$("#loginBtn").on("click",function(e){
			e.preventDefault();
			$("form").submit();
		})
	});
	</script>
</body>

</html>
