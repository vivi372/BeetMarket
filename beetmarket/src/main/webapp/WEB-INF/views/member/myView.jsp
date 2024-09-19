<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BeetMarket</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/memberStyle.css">
<jsp:include page="Msg.jsp"></jsp:include>
</head>
<body>
<div class="container">
 <div class="row">
    <div class="col-sm-5 centered-content">
    	<img src="${homeVO.photo }" style="width: 100px; height: 100px;"> &nbsp;&nbsp;&nbsp; ${homeVO.id }님
    	<a href="updateForm.do" class="btn_1">내정보 수정</a>
    </div>
    <div class="col-sm-5 centered-content1" >
	  <form action="pointList.do">
	  <img src="/upload/image/image.jpg" style="width: 50px; height: 50px;">
	  	<button class="btn_2">${(empty homeVO.point_delta)? 0: homeVO.point_delta} 원&nbsp;&nbsp; <i class="fa fa-angle-right"></i></button>
	  	<hr class="thick-line">
	  	<a href="/event/list.do" class="btn_3"> EVENT <i class="fa fa-angle-right"></i></a>
	  </form>
    </div>
    <div class="centered-content2" style="width: 940px; position: relative;">
  		<div class="nav-links">
        <a href="/basket/list.do"><i class="fa fa-credit-card"></i> 장바구니</a>
        <a href="/order/list.do"><i class="fa fa-cart-plus"></i> 주문배송</a>
        <a href="#"><i class="fa fa-copyright"></i> 쿠폰리스트</a>
        <img src="/upload/image/image.jpg" style="width: 50px; height: 50px; position: absolute; bottom: 10px; right: 10px; z-index: 100;">
    	</div>
  	</div> 
  </div>
  
  
  
</div>	
</body>
</html>