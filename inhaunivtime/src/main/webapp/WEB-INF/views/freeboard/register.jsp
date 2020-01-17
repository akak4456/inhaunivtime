<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
					<form role="form" action="/freeboard/register" method="post">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="title" class="form-control">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" rows="3" name='content'></textarea>
						</div>
						<div class="form-group">
							<label>작성자</label>
							<input type="text" name="userid" class="form-control"
							value='<sec:authentication property="principal.username"/>' readonly="readonly">
						</div>
						<button type="submit" class="btn btn-primary">작성하기</button>
						<button type="reset" class="btn btn-danger">초기화하기</button>
					</form>
				</div>

			</div>
			<div class="card mb-3">
				<div class="card-header">
					첨부 이미지
				</div>
				<div class="card-body">
					<div class="form-group uploadDiv">
						<input type="file" name="uploadFile" multiple>
					</div>
					<div class='uploadResult'>
						<ul>
						
						</ul>
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
<script>
$(document).ready(function(e){
	var formObj = $("form[role='form']");
	$("button[type='submit']").on("click",function(e){
		e.preventDefault();
		console.log("submit clicked");
		
		var str = "";
		$(".uploadResult ul li").each(function(i,obj){
			var jobj = $(obj);
			
			console.dir(jobj);
			
			str += "<input type='hidden' name='attachList["+i+"].filename' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadpath' value='"+jobj.data("path")+"'>";
			
		});
		formObj.append(str).submit();
	});
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz|jar)$");
	var maxSize = 5242880;
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일이 너무 큽니다");
			return false;
		}
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$("input[type='file']").change(function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		for(var i=0;i<files.length;i++){
			if(!checkExtension(files[i].name,files[i].size)){
				return false;
			}
			formData.append("uploadFile",files[i]);
		}
		$.ajax({
			url: '/uploadAjaxAction',
			processData:false,
			contentType:false,
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			data:formData,
			type:'POST',
			dataType:'json',
			success:function(result){
				console.log(result);
				showUploadResult(result);
			},
			error:function(result){
				alert("이미지만 업로드 가능합니다");
			}
		});
	});
	function showUploadResult(uploadResultArr){
		if(!uploadResultArr || uploadResultArr.length == 0){return;}
		
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		
		$(uploadResultArr).each(function(i,obj){
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+"s_"+obj.uuid+"_"+obj.fileName);
			str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='true'>";
			str += "	<div>";
			str += "		<span>"+obj.fileName+"</span>";
			str += "		<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning'>";
			str += "			<i class='fa fa-times'></i>";
			str += "		</button><br>";
			str += "		<img src='/display?fileName="+fileCallPath+"'>";
			str += "	</div>";
			str += "</li>";
		})
		uploadUL.append(str);
		$(".uploadResult").on("click","button",function(e){
			console.log("delete file");
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			
			var targetLi = $(this).closest("li");
			
			$.ajax({
				url:'/deleteFile',
				data:{fileName:targetFile,type:type},
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				dataType:'text',
				type:'POST',
				success:function(result){
					if(result == "deleted"){
						alert("삭제하였습니다");
						targetLi.remove();
					}
				}
			});
		});
	}
	
})
</script>
<%@include file="../includes/footer.jsp"%>

