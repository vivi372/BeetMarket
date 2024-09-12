<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>{vo.name}님 정보 보기</title>
<style type="text/css">
.btn{
	style="background-color: #87CEFA; 
	color: #FFFFFF; 
	border: 1px solid #87CEFA; 
	padding: 10px 20px; 
	border-radius: 5px; 
	font-size: 16px;"
}
.data{
	font-size: 20px; 
	margin-left: 50px; 
	margin-bottom: 10px;
}
</style>

<script>
  function goBack() {
    window.history.back();
  }
</script>
</head>
<body>
<div class="container">
	<div class="card">
		<div class="card-header" style="display: flex; align-items: center; justify-content: center;">
		  <img src="${vo.photo}" style="width: 150px; height: 150px; margin-right: 20px;">
			  <div style="font-size: 25px;">
			    ID : ${vo.id} (${vo.name})
			  </div>
		</div>
		<div class="card-body">
			<div class="data">
				TEL : ${vo.tel } &nbsp;|&nbsp; EMAIL : <span>${vo.email }</span>
			</div>
			<div class="data">
				BIRTH : <fmt:formatDate value="${vo.birth }" pattern="yyyy-MM-dd"/> &nbsp;|&nbsp; 가입일 : <fmt:formatDate value="${vo.regDate }" pattern="yyyy-MM-dd"/>
			</div>
			<div class="data">
				Grade 등급 : ${vo.gradeName } &nbsp;|&nbsp; MemberSip 등급 : ${vo.shipName }
			</div>
		</div>
		<div class="card-footer">
			<button class="btn" onclick="goBack()" >이전으로</button>
			<div class="data float-right">
				최근 접속일 : <fmt:formatDate value="${vo.conDate }" pattern="yyyy-MM-dd"/>
			</div>
		</div>
	</div>
</div>
</body>
</html>