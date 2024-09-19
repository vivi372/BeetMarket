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
.imageDiv {
	background: black;
}
</style>
<script type="text/javascript">
$(function() {
	$(".dataRow").click(function() {
		let no = $(this).data("no");
//  		alert("no=" + no);
		location = "view.do?no=" + no + "&${pageObject.pageQuery}";
		
	});
	$("#key").val('${(empty pageObject.key)?"t":pageObject.key}');
	// perPageNum 처리
	$("#perPageNum").change(function(){
		alert("change perPageNum");
		// page는 1페이지 + 검색 데이터를 전부 보낸다.
		$("#searchForm1").submit();
	});
	// 이미지 사이즈 조정 5:4
	let imgWidth = $(".imageDiv:first").width();
	let imgHeight = $(".imageDiv:first").height();
	console.log("image width=" + imgWidth + ", height=" + imgHeight)
	// 높이 계산 - 너비는 동일하다. : 이미지와 이미지를 감싸고 있는 div의 높이로 사용
	let height = imgWidth / 5 * 4;
	// 전체 imageDiv의 높이를 조정한다.
	$(".imageDiv").height(height);
	// 이미지 배열로 처리하면 안된다. foreach 사용 - jquery each()
	$(".imageDiv > img").each(function(idx, image) {
		//alert(image);
		//alert(height);
		//alert($(image).height());
		// 이미지가 계산된 높이 보다 크면 줄인다.
		if ($(image).height() > height) {
			let image_width = $(image).width();
			let image_height = $(image).height();
			let width = height / image_height * image_width;

			console.log("chaged image width = " + width);

			// 이미지 높이 줄이기
			$(image).height(height);
			// 이미지 너비 줄이기
			$(image).width(width);

		}
	});
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
	  <div class="col-md-4">
	  <c:forEach items="${list }" var="vo">
	  <div class="card dataRow" data-no="${vo.no}"style="width: 100%">
	   	<img class="card-img-top" src="${vo.image }" alt="image">
	   <div class="card-body">
	    <pre>제목:${vo.title }</pre>
		<span class="float-right">~종료일: 
		<fmt:formatDate value="${vo.endDate }" pattern="yyyy-MM-dd"/>
		</span>
		<span class="float-right">시작일: 
		<fmt:formatDate value="${vo.startDate }" pattern="yyyy-MM-dd"/>
		</span>
	   </div>
	   </div>
	  </c:forEach>
	  </div>
	<a href="writeForm.do" class="btn btn-primary ">등록</a>
 </div>
</body>
</html>