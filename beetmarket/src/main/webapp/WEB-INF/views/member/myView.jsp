<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BeetMarket</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/memberStyle.css">
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
	  <img src="/upload/image/image.jpg" style="width: 50px; height: 50px;">
	  	<button class="btn_2" type="button">${homeVO.point_delta } 원&nbsp;&nbsp; <i class="fa fa-angle-right"></i></button>
	  	<hr class="thick-line">
	  	<a href="#" class="btn_3"> EVENT <i class="fa fa-angle-right"></i></a>
	  </form>
    </div>
    <div class="col-sm-10 centered-content2">
  		
  	</div> 
  </div>
</div>	
</body>
</html>