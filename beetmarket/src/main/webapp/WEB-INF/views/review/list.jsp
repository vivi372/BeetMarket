<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰</title>

<!-- Font Awesome for star icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

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

.star-rating {
    display: inline-block;
    font-size: 0; /* to remove spacing between stars */
    direction: ltr; /* 왼쪽에서 오른쪽으로 방향 지정 */
}

.star-rating .fa-star {
    font-size: 24px; /* set star size */
    color: lightgray; /* default star color (empty stars) */
    float: left; /* 왼쪽에서부터 채워지도록 float 사용 */
}

.star-rating .fa-star.checked {
    color: gold; /* color for filled stars */
}

.star-rating {
    display: inline-block;
    font-size: 0;
}

.star-rating .fa-star {
    font-size: 24px;
    color: lightgray;
    position: relative;
    display: inline-block;
}

.star-rating .fa-star.checked {
    color: yellow; /* 완전히 채워진 별 */
}

.star-rating .fa-star.partially-filled {
    background: linear-gradient(90deg, yellow var(--percent), lightgray var(--percent));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}
</style>

<script type="text/javascript">
$(function() {

	// 리뷰 등록 모달창
	$("#reviewWriteBtn").click(function() {
		$("#reviewModal").modal("show");
	});

	// 리뷰 수정 모달창
	$(function() {
	    // 리뷰 수정 모달창
	    $(".btn-primary#reviewUpdateBtn").click(function() {
	        $("#reviewupdateModal").modal("show");
	    });
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
            <h4>전체 리뷰 개수: ${totalReviewCount}</h4>

            <!-- 총 별점 표시 -->
			<div class="star-rating">
			    <!-- 평균 평점의 정수 부분과 소수 부분 분리 -->
			    <c:set var="integerPart" value="${fn:substringBefore(averageRating, '.')}"/>
			    <c:set var="decimalPart" value="${fn:substring(fn:substringAfter(averageRating, '.'), 0, 1)}"/>
			
			    <c:forEach begin="1" end="5" varStatus="status">
			        <c:choose>
			            <c:when test="${status.index <= integerPart}">
			                <!-- 완전히 채워진 별 -->
			                <i class="fa fa-star checked"></i>
			            </c:when>
			            <c:when test="${status.index == integerPart + 1}">
			                <!-- 소수점 값을 바탕으로 부분적으로 채워진 별 -->
			                <i class="fa fa-star partially-filled" style="--percent: ${decimalPart * 10}%"></i>
			            </c:when>
			            <c:otherwise>
			                <!-- 빈 별 -->
			                <i class="fa fa-star"></i>
			            </c:otherwise>
			        </c:choose>
			    </c:forEach>
			</div>

            <!-- 평균 평점 표시 -->
            <h4>평균 평점: <fmt:formatNumber value="${averageRating}" type="number" maxFractionDigits="2" /> / 5</h4>
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

			<!-- 리뷰 리스트 반복 -->
			<c:forEach items="${list}" var="vo">
				<div class="card dataRow">
					<div class="card-header">
						작성자: ${vo.id}
						<input type="hidden" value="${vo.reviewNo}">
					</div>
					<div class="card-body">
						<div class="star-rating">
							<c:out value="${vo.starscore}" />
							<c:forEach begin="1" end="5" varStatus="status">
								<i class="fa fa-star ${status.index <= vo.starscore ? 'checked' : ''}"></i>
								<!-- 각 리뷰의 평점에 따라 별 채우기 -->
							</c:forEach>
						</div>
						<pre>${vo.reviewContent}</pre>
						<!-- 리뷰 내용 표시 -->

						<!-- 리뷰 이미지 표시 -->
						<div class="imageDiv text-center align-content-center">
                            <img class="card-img-top" src="${pageContext.request.contextPath}${vo.reviewImage}" alt="image">
                        </div>
					</div>
					<div class="card-footer">
						<span class="float-right">
							<fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd"/>
						</span>

						<!-- 좋아요 추가/삭제 버튼 -->
						<!-- 좋아요 추가 버튼 -->
						<!-- 좋아요 추가 버튼 -->
						<form action="${pageContext.request.contextPath}/reviewlike/write" method="post" style="display:inline;">
						    <input type="hidden" name="reviewNo" value="${vo.reviewNo}">
						    <input type="hidden" name="id" value="${sessionScope.user.id}"> <!-- id로 전달 -->
						    <button type="submit" class="btn btn-success">좋아요</button>
						</form>
						
						<form action="${pageContext.request.contextPath}/reviewlike/delete" method="post" style="display:inline;">
						    <input type="hidden" name="reviewNo" value="${vo.reviewNo}">
						    <input type="hidden" name="id" value="${sessionScope.user.id}"> <!-- id로 전달 -->
						    <button type="submit" class="btn btn-secondary">좋아요 취소</button>
						</form>

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
				<pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
			</div>
			<button type="button" class="btn btn-primary" id="reviewWriteBtn">리뷰 등록</button>
			<button type="button" class="btn btn-primary" id="reviewUpdateBtn">수정</button>
		</div>
	</div>

	<jsp:include page="writeForm.jsp" />
	<jsp:include page="updateForm.jsp" />
	
</div>

</body>
</html>
