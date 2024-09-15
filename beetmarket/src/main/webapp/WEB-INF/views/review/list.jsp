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
.dataRow>.card-header {
	background: #e0e0e0;
}
.dataRow:hover {
	border-color: orange;
	cursor: pointer;
}
.imageDiv {
    width: 100%;
    text-align: center;
    overflow: hidden;
}

.imageDiv img {
    width: 80%;
    height: 200px;
    object-fit: cover;
}
.starscore {
    color: gold;
    font-size: 20px;
}
</style>

<script type="text/javascript">
$(function() {

	// 리뷰 등록 모달창
	$("#reviewWriteBtn").click(function() {
		$("#reviewModal").modal("show");
	});

	// 리뷰 수정 모달창
	$("#reviewUpdateBtn").click(function() {
		$("#reviewUpdateModal").modal("show");
	});

	// 리뷰 삭제 처리
	$(".deleteBtn").click(function() {
		let reviewNo = $(this).data("reviewno");
		if (confirm("리뷰를 삭제하시겠습니까?")) {
			$.ajax({
				type: "POST",
				url: "delete.do",
				data: { reviewNo: reviewNo },
				success: function(result) {
					alert("리뷰가 삭제되었습니다.");
					location.reload(); // 삭제 후 페이지를 새로고침
				},
				error: function() {
					alert("리뷰 삭제 중 오류가 발생했습니다.");
				}
			});
		}
	});

	// perPageNum 처리
	$("#perPageNum").change(function() {
		$("#searchForm").submit();
	});

	// 검색 데이터 세팅
	$("#key").val('${(empty pageObject.key)?"t":pageObject.key}');
	$("#perPageNum").val('${(empty pageObject.perPageNum)?"10":pageObject.perPageNum}');
});
</script>

</head>
<body>
<div class="container">
	<div class="card">
		<div class="card-header">
			<h2>리뷰</h2>
			<!-- 총 리뷰 개수 및 평균 평점 표시 추가 -->
			<h4>전체 리뷰 개수: ${totalReviewCount}</h4> <!-- 주석: 총 리뷰 개수 표시 -->
			<h4>평균 평점: ${averageRating} / 5</h4> <!-- 주석: 평균 평점 표시 -->
		</div>
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
								<input type="text" class="form-control" placeholder="검색" id="word" name="word" value="${pageObject.word}">
								<div class="input-group-append">
									<button class="btn btn-outline-primary">
										<i class="fa fa-search"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="col-md-4">
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
					</div>
				</form>
			</div>

			<c:forEach items="${list }" var="vo">
				<div class="card dataRow">
					<div class="card-header">
						작성자: ${vo.id }
						<input type="hidden" value="${vo.reviewNo}">
					</div>
					<div class="card-body">
						<pre>${vo.reviewContent }</pre>
						<!-- 리뷰 평점 추가 -->
						<div class="starscore">
							평점: ${vo.starscore} / 5 <!-- 주석: 각 리뷰의 평점 표시 -->
						</div>
						<div class="imageDiv text-center align-content-center">
                            <img class="card-img-top" src="${pageContext.request.contextPath}${vo.reviewImage}" alt="image">
                        </div>
					</div>
					<div class="card-footer">
						<span class="float-right">
							<fmt:formatDate value="${vo.writeDate }" pattern="yyyy-MM-dd"/>
						</span>
						<!-- 삭제 버튼 추가 -->
						<button type="button" class="btn btn-danger deleteBtn" data-reviewno="${vo.reviewNo}">
							삭제
						</button>
					</div>
				</div>
			</c:forEach>
		</div>

		<div class="card-footer">
			<div>
				<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
			</div>
			<button type="button" class="button btn-primary" id="reviewWriteBtn">리뷰 등록</button>
			<button type="button" class="button btn-primary" id="reviewUpdateBtn">수정</button>
		</div>
	</div>

	<jsp:include page="writeForm.jsp" />
	<jsp:include page="updateForm.jsp" />
</div>

</body>
</html>
