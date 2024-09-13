<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 리스트</title>
<style type="text/css">
.dataRow>.card-header{
	background: #e0e0e0
}
.dataRow:hover{
	border-color: blue;
	cursor: pointer;
}
</style>
<script type="text/javascript">
$(function() {
	$(".dataRow").click(function() {
		let no = $(this).data("no");
		location = "view.do?no=" + no + "&inc=1"
				+ "&${pageObject.pageQuery}";
	});
	$("#key").val('${(empty pageObject.key)?"t":pageObject.key}');
});
</script>
</head>
<body>
 <div class="container">
  <form action="list.do" id="searchForm">
	  <div class="row">
	  <div class="col-md-8">
		  		<div class="input-group mb-3">
				  <div class="input-group-prepend">
				      <select name="key" id="key" class="form-control">
				      	<option value="t">제목</option>
				      	<option value="c">내용</option>
				      </select>
				  </div>
				  <input type="text" class="form-control" placeholder="검색"
				   id="word" name="word" value="${pageObject.word }">
				  <div class="input-group-append">
				      <button class="btn btn-outline-primary">
				      	<i class="fa fa-search"></i>
				      </button>
				  </div>
				</div>
		  	</div>
	  </div>
  </form>
	  <div class="col-md-4 dataRow">
	  <c:forEach items="${list }" var="vo">
	  	   <div class="card" style="width: 100%">
	   	<img class="card-img-top" src="${vo.image }" alt="image">
	   </div>
	   <div class="card-body">
	    <pre>제목:${vo.title }</pre>
		<span class="float-right">~종료일: 
		<fmt:formatDate value="${vo.endDate }" pattern="yyyy-MM-dd"/>
		</span>
		<span class="float-right">시작일: 
		<fmt:formatDate value="${vo.startDate }" pattern="yyyy-MM-dd"/>
		</span>
	   </div>
	  </c:forEach>
	  </div>
	<a href="writeForm.do" class="btn btn-primary">등록</a>
 </div>
</body>
</html>