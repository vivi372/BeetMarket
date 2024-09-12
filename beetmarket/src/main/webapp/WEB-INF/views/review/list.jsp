<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<div class="row" style="margin: 40px -10px 0 -10px">
	<div class="col-lg-12">
		<!-- 카드 형식으로 리뷰 리스트를 출력 -->
		<div class="card">
			<!-- 리뷰 리스트 제목 -->
			<div class="card-header" style="background: #e0e0e0;">
				<i class="fa fa-comments fa-sw"></i> Reviews
				<!-- 새로운 리뷰 등록을 위한 모달 창 버튼 -->
				<button type="button" class="btn btn-primary btn-sm pull-right"
				 data-toggle="modal" data-target="#reviewModal" id="newReviewBtn">
				  New Review
				</button>
			</div>
			
			<!-- 리뷰 리스트 출력 부분 -->
			<div class="card-body">
			
				<ul class="chat">
					<!-- foreach로 리뷰 데이터를 반복 출력 -->
					<c:forEach var="review" items="${reviewList}">
						<li class="left clearfix" data-rno="${review.reviewNo}">
							<div>
								<!-- 리뷰 작성자 정보 -->
								<div class="header">
									<strong class="primary-font">${review.id}</strong>
									<small class="pull-right text-muted">${review.WriteDate}</small>
								</div>
								<!-- 리뷰 내용 -->
								<p><pre>${review.reviewContent}</pre></p>
								<!-- 리뷰 이미지 출력 (있을 경우만 출력) -->
								<c:if test="${not empty review.reviewImage}">
									<img src="${pageContext.request.contextPath}/upload/review/${review.reviewImage}" 
										alt="리뷰 이미지" style="width: 100px; height: auto;">
								</c:if>
							</div>
						</li>
					</c:forEach>
				</ul>
			
			</div>
			
			<!-- 페이지네이션 -->
			<div class="card-footer">
				<ul class="pagination pagination-sm">
				  <c:if test="${pageObject.prevPage > 0}">
					  <li class="page-item"><a class="page-link" href="?page=${pageObject.prevPage}">Previous</a></li>
				  </c:if>
				  <c:forEach var="page" begin="${pageObject.startPage}" end="${pageObject.endPage}">
					  <li class="page-item <c:if test="${pageObject.page == page}">active</c:if>">
						  <a class="page-link" href="?page=${page}">${page}</a>
					  </li>
				  </c:forEach>
				  <c:if test="${pageObject.nextPage <= pageObject.totalPage}">
					  <li class="page-item"><a class="page-link" href="?page=${pageObject.nextPage}">Next</a></li>
				  </c:if>
				</ul>
			</div>
			
		</div>
	</div>
</div>

<!-- 모달 창 (리뷰 등록 및 수정) -->
<div class="modal" id="reviewModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- 모달 창 헤더 -->
      <div class="modal-header">
        <h4 class="modal-title">리뷰 등록</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- 모달 창 바디 (리뷰 내용 입력) -->
      <div class="modal-body">
      	<!-- 리뷰 번호를 저장하는 hidden input -->
      	<input type="hidden" id="reviewNo">
      	<!-- 리뷰 내용 입력창 -->
        <textarea rows="4" class="form-control" id="reviewContent"></textarea>
      </div>

      <!-- 모달 창 푸터 (버튼) -->
      <div class="modal-footer">
      	<!-- 등록 버튼 -->
      	<button class="btn btn-primary" id="reviewWriteBtn">등록</button>
      	<!-- 수정 버튼 -->
      	<button class="btn btn-success" id="reviewUpdateBtn">수정</button>
        <!-- 취소 버튼 -->
        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
      </div>

    </div>
  </div>
</div>