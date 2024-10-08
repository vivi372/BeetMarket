<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 글등록</title>
 <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>

<script type="text/javascript">
$(function(){    
	// 시작일과 종료일에 datepicker를 적용
    $("#startDate").datepicker({
        dateFormat: 'yy-mm-dd',  // 날짜 형식을 'YYYY-MM-DD'로 지정
        minDate: 0, // 오늘 날짜 이전은 선택할 수 없도록 설정
        onSelect: function(selectedDate) {
            // 종료일은 시작일 이후로만 선택 가능
            $("#endDate").datepicker("option", "minDate", selectedDate);
        }
    });
    $("#endDate").datepicker({
        dateFormat: 'yy-mm-dd',  // 날짜 형식을 'YYYY-MM-DD'로 지정
        onSelect: function(selectedDate) {
            // 시작일은 종료일 이전으로만 선택 가능
            $("#startDate").datepicker("option", "maxDate", selectedDate);
        }
    });

    // 페이지 로드 시 종료일이 시작일보다 이전 날짜가 아닌지 확인
    var startDateValue = $("#startDate").val();
    var endDateValue = $("#endDate").val();
    if (startDateValue && endDateValue) {
        var startDate = new Date(startDateValue);
        var endDate = new Date(endDateValue);

        if (endDate < startDate) {
            // 종료일이 시작일보다 이전이면 종료일을 시작일로 설정
            $("#endDate").datepicker("setDate", startDate);
        }
    }
});
</script>
</head>
<body>
<div class="container">
	<h1>이벤트 수정</h1>
	<form action="update.do" method="post">
			<!-- tr : table row - 테이블 한줄 -->
			<!-- 게시판 데이터의 제목 -->
			<div class="form-group">
				<label for="no">번호</label>
				<input id="no" name="no" required readonly class="form-control" value="${param.no}">
			</div>
			<div class="form-group">
				<label for="title">제목</label>
				<input id="title" name="title" required class="form-control" value="${vo.title}">
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea class="form-control" id="content" name="content" rows="7" >${vo.content }</textarea>
			</div>
			<div class="form-group">
				<label for="startDate">시작일</label>
				<input id="startDate" name="startDate" required autocomplete="off" class="form-control datepicker" value="${vo.startDate }">
			</div>
			<div class="form-group">
				<label for="endDate">종료일</label>
				<input id="endDate" name="endDate" required autocomplete="off" class="form-control datepicker" value="${vo.endDate }">
			</div>
			<div>
				<!-- a tag : 데이터를 클릭하면 href의 정보를 가져와서 페이지 이동시킨다. -->
				<button class="btn btn-primary">수정</button>
				<button type="reset" class="btn btn-secondary">다시입력</button>
				<button type="button" onclick="history.back();" class="btn btn-warning">취소</button>
			</div>
	</form>
</div>
</body>
</html>