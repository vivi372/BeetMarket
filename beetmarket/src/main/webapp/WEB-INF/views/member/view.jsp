<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>{vo.name}님 정보 보기</title>
</head>
<body>
<div class="container">
	<table>
	<tr>
		<th>Id</th>
		<td>${vo.id }</td><td>(${vo.name })</td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td>${vo.tel }</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><pre>${vo.email }</pre></td>
	</tr>
	<tr>
		<th>생년월일 : </th>
		<td>
  			<fmt:formatDate value="${vo.birth }" pattern="yyyy-MM-dd"/>
		</td>
	</tr>
	<tr>
		<th>회원 가입일 : </th>
		<td>
		<fmt:formatDate value="${vo.regDate }" pattern="yyyy-MM-dd"/>
		</td>
	</tr>
	<tr>
		<th>최근 접속일 : </th>
		<td>
		<fmt:formatDate value="${vo.conDate }" pattern="yyyy-MM-dd"/>
		</td>
	</tr>
	<tr>
		<th>등급</th>
		<td>${vo.gradeName }</td>
	</tr>
	<tr>
		<th>맴버쉽</th>
		<td>${vo.shipName }</td>
	</tr>
	</table>
</div>
</body>
</html>