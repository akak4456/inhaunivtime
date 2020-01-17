<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
						<label>번호</label> <input type="text" name="bno" value='<c:out value="${freeboard.bno }"/>' 
							readonly="readonly" class="form-control">
					</div>
					<div class="form-group">
						<label>제목</label> <input type="text" name="title" value='<c:out value="${freeboard.title }"/>' 
							readonly="readonly" class="form-control">
					</div>
					<div class="form-group">
						<label>내용</label>
						<div class='uploadResult'>
							<ul>
							</ul>
						</div>
						<textarea class="form-control" rows="3" name='content' readonly="readonly"><c:out value="${freeboard.content }"/></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label> <input type="text" name="userid" value='<c:out value="${freeboard.userid }"/>' 
							readonly="readonly" class="form-control">
					</div>
					<div class="form-group">
						<label>추천수</label> 
						<input type="text" name="recommendcnt" value='<c:out value="${freeboard.recommendcnt }"/>' readonly="readonly" class="form-control">
					</div>
					<sec:authentication property="principal" var="pinfo"/>
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq freeboard.userid }">
							<button data-oper='modify' class="btn btn-success">수정/삭제</button>
						</c:if>
					</sec:authorize>
					<button data-oper='recommend' class="btn btn-success">추천하기</button>
					<button data-oper='list' class="btn btn-info">목록</button>
					<div class='float-right'>
						<img data-bno='<c:out value='${freeboard.bno }'/>' data-casekind='b' data-targetno='<c:out value='${freeboard.bno }'/>' class="sirenBtn" src='/resources/img/siren.png'>
					</div>
					<form id='operForm' action="/freeboard/modify" method="get">
						<input type='hidden' id='bno' name='bno' value='<c:out value="${freeboard.bno }"/>'>
						<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
						<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
						<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
						<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
					</form>
				</div>

			</div>
			<div class="card mb-3">
				<div class="card-header">
					<i class="fas fa-comments"></i> 댓글
					<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_STUDENT')">
					<button id='addReplyBtn' type="button" class="btn btn-xs float-right">답글 달기</button>
					</sec:authorize>
				</div>
				<div class="card-body">
					<ul class="chat">
						<li>
						</li>
					</ul>
				</div>
				<div class="card-footer dataTables_paginate paging_simple_numbers"">
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
<script src="/resources/js/reply.js"></script>
<script>
function generateReplyList(list){
	var str = "";
	for(var i=0,len=list.length||0;i<len;i++){
		if(list[i].replyto != null){
		str += "<li class='left clearfix reply rereply' data-rno='"+list[i].rno+"'>";	
		}else{
		str += "<li class='left clearfix reply' data-rno='"+list[i].rno+"'>";	
		}
		str += "	<div>";
		str += "		<div class='header'>";
		str += "			<strong class='primary-font'>";
		if(list[i].replyto != null){
			str += "<img src='/resources/img/arrowup.jpg'>"
		}
		str += list[i].repliername + "</strong>";
		str += "			<div class='float-right'>";
		str += "				<small class='text-muted'>" + replyService.displayTime(list[i].replydate) +"</small><br>";
		str += "				<img data-bno='<c:out value='${freeboard.bno }'/>' data-casekind='r' data-targetno='"+list[i].rno+"' class='sirenBtn' src='/resources/img/siren.png'><br>";
		if(list[i].isdelete == 'N'){
		str += "				<button class='btn btn-xs modify-btn'>수정하기</button>";
		str += "				<button class='btn btn-xs remove-btn'>삭제하기</button>";
		}
		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_STUDENT')">
		if(list[i].replyto == null){
		str += "				<button class='btn btn-xs rereply-btn'>답글달기</button>";
		}
		</sec:authorize>
		str += "			</div>";
		str += "		</div>";
		str += "		<div>";
		str += "			<p>"+list[i].reply+"</p>";
		str += "		</div>";
		str += "	</div>";
		str += "</li>";
	}
	str += "<li></li>"
	return str;
}
function generateReplyWindow(){
	var str="";
	str += "<li class='left clearfix addreply'>";
	str += "	<div>";
	str += "		<div>";	
	str += "			답글";
	str += "			<textarea class='form-control' rows='3' id='newreply'></textarea>";
	str += "			작성자";
	str += "			<input class='form-control' type='text' id='newreplier'>";
	str += "		</div>";
	str += "		<div class='float-right'>";
	str += "			<button id='addDoneBtn' type='button' class='btn btn-success'>등록완료</button>";
	str += "			<button id='addCancleBtn' type='button' class='btn btn-danger'>등록취소</button>";
	str += "		</div>";
	str += "	</div>";
	str += "</li>";
	return str;
}
function generateChangeWindow(){
	var str="";
	str += "<li class='left clearfix changereply'>";
	str += "	<div>";
	str += "		<div>";	
	str += "			답글";
	str += "			<textarea class='form-control' rows='3' id='changereply'></textarea>";
	str += "			작성자";
	str += "			<input class='form-control' type='text' id='changereplier' readonly='readonly'>";
	str += "		</div>";
	str += "		<div class='float-right'>";
	str += "			<button id='changeDoneBtn' type='button' class='btn btn-success'>수정완료</button>";
	str += "			<button id='changeCancleBtn' type='button' class='btn btn-danger'>수정취소</button>";
	str += "		</div>";
	str += "	</div>";
	str += "</li>";
	return str;
}
</script>
<script>
</script>
<script>
var bnoValue = '<c:out value="${freeboard.bno}"/>';
var amount = '<c:out value="${cri.amount }"/>';
$(document).ready(function(){
	var pageNum = 1;
	var replyPageFooter = $(".card-footer");
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum*1.0/amount)*amount;
		var startNum = endNum - (amount-1);
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * amount >= replyCnt){
			endNum = Math.ceil(replyCnt*1.0/amount);
		}else{
			next = true;
		}
		
		var str = "";
		str += "<ul class='pagination'>";
		var disabled = "disabled";
		if(prev){
			disabled = "";
		}
		console.log(startNum);
		str += "	<li class='paginate_button page-item previous "+disabled+"' id='dataTable_previous'>";
		str += "		<a href='"+(startNum-1)+"' class='page-link'>Previous</a>";
		str += "	</li>";
		for(var i=startNum; i<=endNum;i++){
		var active = pageNum == i? "active":"";
		str += "	<li class='paginate_button page-item "+active+"'>";
		str += "		<a href="+i+" class='page-link'>"+i+"</a>";
		str += "	</li>";
		}
		disabled = "disabled";
		if(next){
			disabled = "";
		}
		str += "	<li class='paginate_button page-item next "+disabled+"' id='dataTable_next'>";
		str += "		<a href='"+(endNum+1)+"' class='page-link'>Next</a>";
		str += "	</li>";
		replyPageFooter.html(str);
		$(".sirenBtn").off("click");
		$(".sirenBtn").on("click",function(e){
			var targetno = $(this).data("targetno");
			var casekind = $(this).data("casekind");
			sendDeclaration(targetno,casekind);
		})
	}
	replyPageFooter.on("click","li a",function(e){
		e.preventDefault();
		console.log("page click");
		
		var targetPageNum = $(this).attr("href");
		pageNum = targetPageNum;
		showList(pageNum);
	});
	var addReplyShow = false;
	function sendDeclaration(targetno,casekind){
		$.ajax({
			type: 'post',
			url: '/freeboard/report',
			data: JSON.stringify({targetno:targetno,casekind:casekind}),
			contentType: 'application/json; charset=utf-8',
			success:function(result,status,xhr){
				if(result === 'success'){
					alert("신고가 완료되었습니다");
				}
			},
			error:function(error){
				alert("신고를 완료하지 못했습니다. 누가 이미 신고를 하였습니다.");
			}
		})
	}
	function addReply(rno,beforeElement){
		if(addReplyShow == false){
			beforeElement.before(generateReplyWindow());
			addReplyShow = true;
			$("#addCancleBtn").on("click",function(e){
				addReplyShow = false;
				$(".addreply").remove();
			});
			$("#addDoneBtn").on("click",function(e){
				var reply = {
						reply:$("#newreply").val(),
						repliername:$("#newreplier").val(),
						bno:bnoValue,
						replyto:rno
				};
				replyService.add(reply,function(result){
					if(result === 'success')
						alert("댓글을 달았습니다");
					addReplyShow = false;
					$(".addreply").remove();
					showList(-1);
				})
			});
		}else{
			addReplyShow = false;
			$(".addreply").remove();
		}
	}
	var replyUL = $(".chat");
	showList(1);
	$(".sirenBtn").on("click",function(e){
		var targetno = $(this).data("targetno");
		var casekind = $(this).data("casekind");
		sendDeclaration(targetno,casekind);
	})
	function showList(page){
		replyService.getList({bno:bnoValue, page: page||1},function(data){
			var replyCnt = data.replyCnt;
			var list = data.list;
			console.log("replyCnt: "+replyCnt);
			console.log("list: "+list);
			if(page == -1){
				pageNum = Math.ceil(replyCnt*1.0/amount);
				showList(pageNum);
				return;
			}
			if(list == null || list.length == 0){
				replyUL.html("<li></li>");
				return;
			}
			replyUL.html(generateReplyList(list));
			//기존에 정의된 이벤트 제거
			var modifyShow = false;
			$(".modify-btn").on("click",function(e){
				if(modifyShow == false){
					var rno = $(this).parents("li").data("rno");
					var beforeElement = $(".chat li[data-rno='"+rno+"']").next();
					beforeElement.before(generateChangeWindow());
					modifyShow = true;
					$("#changeCancleBtn").on("click",function(e){
						modifyShow = false;
						$(".changereply").remove();
					});
					$("#changeDoneBtn").on("click",function(e){
						var reply = {
								reply:$("#changereply").val(),
								rno:rno
						};
						replyService.update(reply,function(result){
							if(result === 'success')
								alert("수정하였습니다");
							modifyShow = false;
							$(".changereply").remove();
							showList(pageNum);
						})
					});
				}else{
					modifyShow = false;
					$(".changereply").remove();
				}
			});
			$(".remove-btn").on("click",function(e){
				var rno = $(this).parents("li").data("rno");
				replyService.remove(rno,function(result){
					if(result==='success'){
						alert("삭제가 완료되었습니다");
						showList(pageNum);
					}
				})
			});
			$(".rereply-btn").on("click",function(e){
				var rno = $(this).parents("li").data("rno");
				var beforeElement = $(".chat li[data-rno='"+rno+"']").next();
				addReply(rno,beforeElement);
			});
			showReplyPage(replyCnt);
		})
	}
	$("#addReplyBtn").on("click",function(e){
		var beforeElement = replyUL.children().first();
		console.log("before: "+beforeElement);
		if(beforeElement == null)
			beforeElement = replyUL;
		addReply(null,beforeElement);
	});
});	
</script>
<script>
$(document).ready(function(){
	var operForm = $("#operForm");
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/freeboard/modify").submit();
	});
	$("button[data-oper='recommend']").on("click",function(e){
		operForm.attr("method","post");
		operForm.attr("action","/freeboard/recommend").submit();
	});
	$("button[data-oper='list']").on("click",function(e){
		operForm.find("#bno").remove();
		operForm.attr("action","/freeboard/list");
		operForm.submit();
	});
	
	var result = '<c:out value="${result}"/>';
	console.log(result);
	checkModal(result);
	history.replaceState({},null,null);
	function checkModal(result){
		if(result === ''||history.state){
			return;
		}
		if(result === 'updaterecommendsuccess'){
			$(".modal-body").html("추천이 완료되었습니다");
		}else if(result === 'updaterecommendfail'){
			$(".modal-body").html("추천이 완료되지 못했습니다");
		}
		$("#alertModal").modal("show");
	}
});
</script>
<script>
$(document).ready(function(){
	(function(){
		var bno = '<c:out value="${freeboard.bno}"/>';
		$.getJSON("/freeboard/getAttachList",{bno:bno},function(arr){
			console.log(arr);
			var str = "";
			$(arr).each(function(i,attach){
				var fileCallPath = encodeURIComponent(attach.uploadpath+"/"+attach.uuid+"_"+attach.filename);
				str += "<li>";
				str += "	<div>";
				str += "		<img src='/display?fileName="+fileCallPath+"'>";
				str += "	</div>";
				str += "</li>";
			});
			$(".uploadResult ul").html(str);
		});
	})();
});

</script>
<%@include file="../includes/footer.jsp"%>

