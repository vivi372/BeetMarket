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
	$(".datarow").click(function(){
		let faqno=$(this).data("faqno");
		location="view.do?faqno="+faqno+"&hit=1";
	});
	
	$("#key").val("${(empty po.key)?'qa':po.key }");
	$("#word").val("${(empty po.word)?'':po.word }");
});
</script>
</head>

<body>
<div class="container">
  <form action="list.do" id="searchForm">
  	<input name="page" value="1" type="hidden">
	  <div class="input-group p-3">
			<div class="input-group-prepend">
		      <select name="key" id="key" class="form-control">
		      	<option value="qa">질문/답변</option>
		      	<option value="q">질문</option>
		      	<option value="a">답변</option>
		      </select>
			</div>
			<input class="form-control" placeholder="검색"
			id="word" name="word" value="${po.word }">
			<div class="input-group-append">
				<button class="btn btn-outline-primary">
			      	<i class="fa fa-search"></i>
		   		</button>
		  	</div>
	</div>
  </form>
  <div class="card">
  	<c:forEach items="${list }" var="vo">
    <div class="card-body border">
	    <div>
	      <p class="card-text datarow" data-faqno="${vo.faqno }">[ ${vo.catename } ] &nbsp; Q. ${vo.question }</p>
	      <small class="float-right">${vo.writedate }</small>
		</div>
    </div>
    </c:forEach>
  </div>
  <div>
  	<pageNav:pageNav listURI="list.do" pageObject="${po }"></pageNav:pageNav>
  	<a href="writeform.do" type="button" class="btn btn-lg float-right btn-primary">등록</a>
  </div>
</div>
</body>
</html>