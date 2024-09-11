<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 게시판 글수정</title>
</head>
<body>
<div class="container">
	<h2>일반 게시판 글수정</h2>
	<form action="update.do" method="post">
		<div class="form-group">
			<label for="no">번호</label>
			<input class="form-control" name="no" id="no" required readonly
			 value="${vo.no }">
		</div>
		<div class="form-group">
			<label for="title">제목</label>
			<input class="form-control" name="title" id="title" required
			 value="${vo.title }">
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea class="form-control" name="content" id="content"
				rows="7" required>${vo.content }</textarea>
		</div>
		<div class="form-group">
			<label for="writer">작성자</label>
			<input class="form-control" name="writer" id="writer" required
			 value="${vo.writer }">
		</div>
		<div class="form-group">
			<label for="pw">비밀번호(본인 확인용)</label>
			<input class="form-control" name="pw" id="pw" required
			 type="password">
		</div>
		<button type="submit" class="btn btn-primary">수정</button>
		<button type="reset" class="btn btn-warning">새로입력</button>
		<button type="button" class="cancelBtn btn btn-success">취소</button>
	</form>
</div>
</body>
</html>