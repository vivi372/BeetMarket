<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BeetMarket</title>
<style>
.centered-content {
	border-radius: 5%; /* 완전한 원형으로 만듭니다 */
	width: 150px; /* 너비 설정 */
	height: 150px; /* 높이 설정 */
	object-fit: cover; /* 이미지 비율 유지 및 영역에 맞게 조정 */
	background: white;
	display: flex;
	align-items: center; /* 수직 가운데 정렬 */
	text-align: center; /* 텍스트 가운데 정렬 */
	padding: 10px; /* 여백 추가 (선택 사항) */
 }
 .btn_1{
 	background-color: #E0FFFF; /* 파란색 */
    color: #333333; /* 텍스트 색상: 흰색 */
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    margin-left: 100px;
 }
.centered-content1 {
	margin-left:10px;
	border-radius: 5%; /* 완전한 원형으로 만듭니다 */
	width: 150px; /* 너비 설정 */
	height: 150px; /* 높이 설정 */
    text-align: right; /* 텍스트를 가운데 정렬 */
    font-weight: bold; /* 두꺼운 글자 */
    padding-top: 20px; /* 위쪽 여백 */
    background-color: white; /* 배경색 */
    font-size: 30px; /* 글자 크기 */
}
 .btn_2{
 	background-color: white; /* 파란색 */
    color: #1C86EE; /* 텍스트 색상: 흰색 */
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    font-size: 20px;
    cursor: pointer;
    margin-left: 100px;
 }
 .centered-content2{
	margin-left:10px;
	margin-top : 10px;
	border-radius: 5%; /* 완전한 원형으로 만듭니다 */
	width: 150px; /* 너비 설정 */
	height: 150px; /* 높이 설정 */
    background-color: white; /* 배경색 */
 }
</style>
</head>
<body>
<div class="container">
 <div class="row">
    <div class="col-sm-5 centered-content">
    	<img src="${homeVO.photo }" style="width: 100px; height: 100px;"> &nbsp;&nbsp;&nbsp; ${homeVO.id }님
    	<button class="btn_1">내정보</button>  
    </div>
    <div class="col-sm-5 centered-content1" >
	  <form action="#">
	  	<button class="btn_2">${homeVO.point_delta } 원&nbsp;&nbsp; <i class="fa fa-angle-right"></i></button>
	  </form>
    </div>
    <div class="col-sm-10 centered-content2">
  		
  	</div> 
  </div>
</div>	
</body>
</html>