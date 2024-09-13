<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅내역</title>

<script>
let roomno=${param.roomno };
let id='${login.id}';
</script>

<!-- BoardReplyService를 대신하는 brsvc 객체를 선언하는 js file -->
<!-- <script src="/js/chatbot/history.js"></script> -->
<!-- brsvc를 호출하여 board reply 관련 기능을 실행하는 js file
	+ event 처리 -->
<!-- <script src="/js/chatbot/historyProcess.js"></script> -->


<script>
$(function(){
	
	$("#historyajax").load("/chatajax/history.do?roomno="+roomno);
});
</script>
<style>
.message-box {
	width:50%;
    padding: 10px;
    margin-bottom: 10px;
    border-radius: 5px;
}

.text-right {
    background: #99bbff; /* 예: 오른쪽 메시지 배경색 */
    text-align: right;    
}

.text-left {
    background: #eeeeee; /* 예: 왼쪽 메시지 배경색 */
    text-align: left;
    
}
</style>
</head>

<body>
<div class="container">
	<div id="historyajax">
	
	</div>
	<div></div>
	<form action="chating.do" method="post">
	<input type="hidden" id="roomno" name="roomno" value="${param.roomno }">
	<input type="hidden" name="sender" value="${id }">
	<input type="hidden" name="accepter" value="${param.partner }">
		<div class="input-group mb-3">
		    <input class="form-control" name="content" placeholder="채팅을 입력하세요">
		    <div class="input-group-append">
		      <button id="submitbtn" class="btn btn-outline-secondary input-group-text"><i class="material-icons">send</i></button>
		    </div>
	  	</div>
  	</form>
</div>
</body>
</html>