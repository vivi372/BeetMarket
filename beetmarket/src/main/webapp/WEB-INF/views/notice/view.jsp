<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글보기</title>
</head>
<body>
<div class="container">
   <div class="card-body">
    <div class="card" data-no="${vo.no}">
     <div class="card-header">
      <span class="float-left"  pattern="yyyy-MM-dd">
        작성일: ${vo.writeDate }
      </span>
      <span class="float-right" pattern="yyyy-MM-dd">
        시작일:${vo.startDate }~ 종료일: ${vo.endDate }
      </span>
      <div style="clear: both;"></div> <!-- float 요소 정리 -->
      ${vo.no }. ${vo.title }
     </div>
    <div class="card-body">
     <pre>${vo.content }</pre>
    </div>
    <div class="card-footer">
		<a href="updateForm.do?no=${vo.no }" class="btn btn-primary">수정</a>
		<button class="btn btn-danger" id="deleteBtn" data-toggle="modal" data-target="#deleteModal">삭제</button>
		<a href="list.do" class="btn btn-success">리스트</a>
	</div>
    </div>
   </div>
 </div>
<!-- container의 끝 -->
</body>
</html>