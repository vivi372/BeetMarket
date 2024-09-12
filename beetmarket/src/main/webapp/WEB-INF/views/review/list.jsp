<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 리스트</title>
</head>
<body>

    <!-- 전체 컨테이너 시작 -->
    <div class="container">
        <!-- 페이지 제목 -->
        <h1>리뷰 리스트</h1>
	   <form action="list.do" id="searchForm">
        <!-- 리뷰 리스트를 테이블 형식으로 출력 -->
        <table class="table table-hover">
            <!-- 테이블 헤더 -->
            <thead>
                <tr>
                    <th>리뷰 번호</th> <!-- 리뷰 번호를 표시 -->
                    <th>작성일</th> <!-- 리뷰 작성일을 표시 -->
                    <th>평점</th> <!-- 별점(평점)을 표시 -->
                    <th>리뷰 이미지</th> <!-- 리뷰 이미지 파일을 표시 -->
                    <th>리뷰 내용</th> <!-- 리뷰의 내용을 표시 -->
                    <th>상품명</th> <!-- 리뷰에 대한 상품 이름을 표시 -->
                    <th>작성자</th> <!-- 리뷰 작성자의 아이디를 표시 -->
                </tr>
            </thead>

            <!-- 테이블 바디 -->
            <tbody>
                <!-- JSTL 반복문으로 서버에서 넘어온 리뷰 리스트 데이터를 반복 출력 -->
                <c:forEach var="review" items="${reviewList}">
                    <tr>
                        <!-- 리뷰 번호 -->
                        <td>${review.reviewNo}</td>

                        <!-- 리뷰 작성일 -->
                        <td>${review.WriteDate}</td>

                        <!-- 리뷰 평점 -->
                        <td>${review.starscore} / 5</td>

                        <!-- 리뷰 이미지, 이미지가 없는 경우 '이미지 없음' 표시 -->
                        <td>
                            <c:choose>
                                <c:when test="${not empty review.reviewImage}">
                                    <!-- 이미지가 있는 경우 -->
                                    <img src="${pageContext.request.contextPath}/upload/review/${review.reviewImage}" 
                                        alt="리뷰 이미지" style="width: 100px; height: auto;">
                                </c:when>
                                <c:otherwise>
                                    <!-- 이미지가 없는 경우 -->
                                    이미지 없음
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <!-- 리뷰 내용 -->
                        <td>${review.reviewContent}</td>

                        <!-- 상품 이름 -->
                        <td>${review.goodsName}</td>

                        <!-- 작성자 아이디 -->
                        <td>${review.id}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 페이지네이션 (페이지 이동을 위한 링크들) -->
        <div class="pagination">
            <a href="?page=${pageObject.prevPage}">이전</a>
            <c:forEach begin="${pageObject.startPage}" end="${pageObject.endPage}" var="page">
                <a href="?page=${page}">${page}</a>
            </c:forEach>
            <a href="?page=${pageObject.nextPage}">다음</a>
        </div>
	</form>
    </div> <!-- 전체 컨테이너 끝 -->
</body>
</html>
