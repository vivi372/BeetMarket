<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	   <div class="col-md-12 from-inline">
	    <div class="input-group-prepend">
			<select name="key" id="key" class="form-control">
				<option value="t">제목</option>
				<option value="c">내용</option>
				<option value="w">작성자</option>
			</select>
		</div>
		<button id="searchBtn" class="btn btn-primary">검색</button>
	   </div>
	  </div>
  </form>
	  <div class="col-md-4 dataRow">
	   <div class="card" style="width: 100%">
	   	<img class="card-img-top" src="${vo.image }" alt="image">
	   </div>
	   <div class="card-body">
	    <strong class="card-title"><span class="float-right">${vo.startDate }~${vo.endDate }</span>
	     {vo.title}
	    </strong>
	   </div>
	  </div>
 </div>
</body>
</html>