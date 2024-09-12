<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
</head>
<body>
<div class="container">
	<h2>환영해유</h2>
	<form action="main.do" id="searchForm">
	</form>
</div>
</body>
</html>


				<c:if test="${!empty login }">
					<!-- 로그인을 했을때 -->
					<li class="nav-item mt-2 mr-1">
						<b class="text-secondary">어서오세요 ${login.name }님</b>
						<img src="${login.photo }" class="rounded-circle mb-1" alt="회원 이미지" width="30px" height="30px">
						
					</li>		
    				<ul class="navbar-nav">
						<li class="nav-item">							
							<span class="badge badge-light" id="newMsgCnt" style="margin-top: 12px; height: 20px;">${login.newMsgCnt }</span>								      		
				    	</li>			
				  		<li class="nav-item">
				      		<a class="nav-link" href="/member/logout.do">
				      			<i class="fa fa-sign-out" style="font-size:19px"></i>
				      			<b>로그아웃</b>
				      		</a>
				    	</li>
				    	<li class="nav-item">
				      		<a class="nav-link" href="/member/view.do">
				      			<i class="fa fa-address-book"></i>
				      			<b>마이페이지</b>
				      		</a>
				    	</li>
				    	<li class="nav-item">
				      		<a class="nav-link" href="/cart/list.do">
				      			<i class="fa fa-shopping-basket"></i>
				      			<b>장바구니</b>
				      		</a>
				    	</li>	
			    	</ul>	
			    		    								
				</c:if>