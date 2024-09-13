<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰</title>

<style type="text/css">
.dataRow>.card-header{
	background: #e0e0e0
}
.dataRow:hover{
	border-color: orange;
	cursor: pointer;
}
</style>

<script type="text/javascript">
$(function(){
	
	// 이벤트 처리
	
	// 모달창
	$("#reviewWriteBtn").click(function(){
		$("#reviewModal").modal("show");
	});
	
	// perPageNum 처리
	$("#perPageNum").change(function(){
		// alert("change perPageNum");
		// page는 1페이지 + 검색 데이터를 전부 보낸다.
		$("#searchForm").submit();
	});
	
	// 검색 데이터 세팅
	$("#key").val('${(empty pageObject.key)?"t":pageObject.key}');
	// perPageNum 세팅
	$("#perPageNum")
	.val('${(empty pageObject.perPageNum)?"10":pageObject.perPageNum}');
	
});
</script>

</head>
<body>
<div class="container">
	<div class="card">
	  <div class="card-header"><h2>리뷰</h2></div>
	  <div class="card-body">
	  	<div id="searchDiv">
	  	  <form action="list.do" id="searchForm">
		  	<input name="page" value="1" type="hidden">
			  <div class="row">
			  	<div class="col-md-8">
			  		<div class="input-group mb-3">
					  <div class="input-group-prepend">
					      <select name="key" id="key" class="form-control">
					      	<option value="t">제목</option>
					      	<option value="c">내용</option>
					      	<option value="w">작성자</option>
					      	<option value="tc">제목/내용</option>
					      	<option value="tw">제목/작성자</option>
					      	<option value="cw">내용/작성자</option>
					      	<option value="tcw">모두</option>
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
			  	<!-- col-md-8의 끝 : 검색 -->
			  	<div class="col-md-4">
			  		<!-- 너비를 조정하기 위한 div 추가. float-right : 오른쪽 정렬 -->
			  		<div style="width: 200px;" class="float-right">
					  <div class="input-group mb-3">
					    <div class="input-group-prepend">
					      <span class="input-group-text">Rows/Page</span>
					    </div>
					    <select id="perPageNum" name="perPageNum" class="form-control">
					    	<option>10</option>
					    	<option>15</option>
					    	<option>20</option>
					    	<option>25</option>
					    </select>
					  </div>
				  </div>
			  	</div>
			  	<!-- col-md-4의 끝 : 한페이지당 표시 데이터 개수 -->
			  </div>
		  </form>
	  	
	  	</div>
	  	<c:forEach items="${list }" var="vo">
			<div class="card dataRow">
			  <div class="card-header">
			  ${vo.id }
		  	<input type="hidden" value="${vo.reviewNo }" >
			  </div>
			  <div class="card-body">
			  	<pre>${vo.reviewContent }</pre>
			  </div>
			  <div class="card-footer">
			  	<span class="float-right">
			  		<fmt:formatDate value="${vo.writeDate }"
			  		 pattern="yyyy-MM-dd"/>
			  	</span>
			  </div>
			</div>
	  	</c:forEach>
	  </div>
	  <div class="card-footer">
	  	<div>
	  		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
	  	</div>
	  <!-- 리뷰 등록 버튼 -->
	  <button type="button" class="btn btn-primary" id="reviewWriteBtn">
	    리뷰 등록
	  </button>
	  
	  <button class="btn btn-primary" id="updateBtn">수정</button>
	  
	  </div>
	</div>
	<jsp:include page="writeForm.jsp" />
</div>
</body>
</html>