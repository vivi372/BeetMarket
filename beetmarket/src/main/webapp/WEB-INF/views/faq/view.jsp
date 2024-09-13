<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
$(function(){
	$("#catename").click(function(){
		alert("카테고리 클릭");
	});
	
	$("#udtbtn").click(function(){
		location="updateform.do?faqno="+${vo.faqno};
	});
});
</script>
</head>

<body>
<div class="container">
		<div class="card">
			<div class="card-body">
				<small id="catename">${vo.catename }</small>
				<div class="question pt-5">
					<h1 style="color: blue">Q.</h1>
					<h4>${vo.question }</h4>
				</div>
				<hr>
				<div class="answer">
					<h1 style="color: blue">A.</h1>
					<small style="color: blue">${vo.answerline }</small> <br/> <span>${vo.answer }</span>
				</div>
				<br/>
				<small>${vo.writedate }에 작성된 문서입니다.</small>
				<div class="float-right">
					<button class="btn btn-success" id="udtbtn" type="button">수정</button>
					<a class="btn btn-secondary" type="button" href="list.do">이전</a>
					<button class="btn btn-danger" type="button" data-toggle="modal" data-target="#dltModal">삭제</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- The Modal -->
  <div class="modal fade" id="dltModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      	
      	<!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">삭제를 누르셨습니다.</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
      	
      	<!-- Modal body -->
        <div class="modal-body">
          삭제시 데이터가 완전히 삭제됩니다.<br/>정말 삭제하시겠습니까?
        </div>
      	
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" data-dismiss="modal">그대로 두기</button>
          <a type="button" href="delete.do?faqno=${vo.faqno }" class="btn btn-danger">삭제하기</a>
        </div>
        
      </div>
    </div>
  </div>
	
	
</body>
</html>