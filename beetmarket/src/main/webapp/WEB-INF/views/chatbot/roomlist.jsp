<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅목록</title>
<script>
$(function(){
	$(".roomrow").click(function(){
		let roomno=$(this).data("roomno");
		let partner=$(this).find(".partner").text();
		let formTag = `
			<form action="history.do" method="post" id="formTag">
				<input type="hidden" name="roomno" value="\${roomno}">
				<input type="hidden" name="partner" value="\${partner}">
			</form>
		`;
		
		$(".container").append(formTag);
		$("#formTag").submit();
		//location="history.do?roomno="+roomno+"&partner="+partner;
	});
	
});
</script>
</head>

<body>
<div class="container">
	<div class="card">
		<div class="card-header"><h3>채팅목록</h3></div>
		<div class="card-body">
			<c:forEach items="${roomlist }" var="vo">
				<div class="roomrow border p-3" data-roomno="${vo.roomno }">
					<p>
					<span class="partner">${(vo.sender!=id)?vo.sender:vo.accepter }</span>
					<c:if test="${empty vo.acceptdate }"><i class="fa fa-circle float-right" style="font-size:10px;color:red"></i></c:if>
					</p>
					<p>${vo.content }</p>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
</body>
</html>