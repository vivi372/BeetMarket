<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 보기</title>
<%-- <jsp:include page="../jsp/webLib.jsp"/>
 --%>
<style type="text/css">
#smallImageDiv img {
	width: 80px;
	height: 80px;
	margin: 3px;
}
#smallImageDiv img:hover {
	opacity: 70%;
	cursor: pointer;
}

#goodsDetailDiv div{
	padding: 5px;
	border-bottom: 1px solid #ccc;
}
</style>

<script type="text/javascript">
$(function(){
	
	// 이벤트 처리
	// 글수정 버튼
	$("#updateBtn").click(function(){
		location = "updateForm.do?no=${vo.goods_no}";
	});
	
	// 글삭제 버튼
	$("#deleteBtn").click(function(){
		$("#pw").val("");
	});
	
	// 리스트 버튼
	$("#listBtn").click(function(){
		location = "list.do?page=${param.page}&perPageNum=${param.perPageNum}"
				;
	});
	
	// 이미지 보기 작 클릭 ->큰 보이기
	$("#smallImageDiv img").click(function(){
		$("#bigImageDiv img").attr("src", $(this).attr("src"));
	});
	
});
</script>

</head>
<body>
<div class="container">
	<div class="card">
	  <div class="card-header"><h2>상품 상세 보기</h2></div>
	  <div class="card-body">
	  	<div class="row">
	  		<div class="col-md-6">
	  			<div id="smallImageDiv">
	  				<img src="${vo.image_name }" class="img-thumbnail">
	  				<c:if test="${!empty imageList}">
	  					<c:forEach items="${imageList }" var="imageVO">
			  				<img src="${imageVO.image_name }" class="img-thumbnail">
	  					</c:forEach>
	  				</c:if>
	  			</div>
	  			<div id="bigImageDiv" class="img-thumbnail">
	  				<img src="${vo.image_name }" style="width : 100%;">
	  			</div>
	  		</div>
	  		<div class="col-md-6" id="goodsDetailDiv">
	  			<div>
	  				<i class="fa fa-check"></i>
	  				분류 : ${vo.goods_name }
	  			</div>
	  			<div>
	  				<i class="fa fa-check"></i>
	  				상품 번호 : ${vo.goods_no }
	  			</div>
	  			<div>
	  				<i class="fa fa-check"></i>
	  				상품명 : ${vo.goods_name }
	  			</div>
	  			<div>
	  				<i class="fa fa-check"></i>
	  				제조사 : ${vo.company }
	  			</div>
	  			<div>
	  				<i class="fa fa-check"></i>
	  				제조년월일 :
	  				<fmt:formatDate value="${vo.product_date }"
	  				 pattern="yyyy-MM-dd"/> 
	  			</div>
	  			<div>
	  				<i class="fa fa-check"></i>
	  				정가 : 
	  				<fmt:formatNumber value="${vo.price }" /> 원
	  			</div>
	  			<div>
	  				<i class="fa fa-check"></i>
	  				할인가 : 
	  				<fmt:formatNumber 
	  					value="${(empty vo.discount)?0:vo.discount }" /> 원
	  			</div>
	  			<div>
	  				<i class="fa fa-check"></i>
	  				할인률 : ${(empty vo.discount_rate)?0:vo.discount_rate } %
	  			</div>
	  			<div style="color: red;">
	  				<i class="fa fa-check"></i>
	  				판매가 : 
	  				<fmt:formatNumber value="${vo.sale_price }" /> 원
	  			</div>
	  			<div>
	  				<i class="fa fa-check"></i>
	  				적립금 : 
	  				<fmt:formatNumber 
	  					value="${(empty vo.saved_rate)?0:(vo.price * vo.saved_rate / 100) }" /> 원
	  				(${(empty vo.saved_rate)?0:vo.saved_rate } %)
	  			</div>
	  			<div>
	  				<i class="fa fa-check"></i>
	  				배송비 : 
	  				<fmt:formatNumber value="${vo.delivery_charge }" /> 원
	  				(5만원 이상 구매하실 경우 무료 배송이 됩니다.)
	  			</div>
	  		</div>
	  	</div>
	  	<div class="row">
	  		<div class="col-md-12">
	  			<c:if test="${!empty sizeColorList }">
	  			<div class="form-inline">
				  <div class="input-group mb-3">
				    <div class="input-group-prepend">
				      <span class="input-group-text">size / color</span>
				    </div>
				    <select class="form-control">
				    	<option value="0">size / color 선택</option>
				    	<c:forEach items="${sizeColorList }" var="sizeColorVO">
					    	<option value="${sizeColorVO.size_no }">
					    		${sizeColorVO.size_name }
					    		<c:if test="${!empty sizeColorVO.color_no && sizeColorVO.color_no != 0 }">
					    			 / ${sizeColorVO.color_name }
					    		</c:if>
					    	</option>
				    	</c:forEach>
				    </select>
				    <div class="input-group-append">
				      <button type="button" class="btn btn-secondary">+</button>
				    </div>
				  </div>
				</div>
	  			</c:if>
	  			<c:if test="${!empty optionList }">
	  			
	  			</c:if>
	  			<c:if test="${empty sizeColorList and empty optionList }">
	  			
	  			</c:if>
		  		<form action="/cart/write.do" method="post">
		  			<!-- 사용자가 구매하려는 것을 선택해서 +를 클릭하면 만들어 지는 입력 한 세트 시작 -->
		  			<div class="form-inline">
		  				<input name="list[0].goods_no" type="hidden"
		  				 value="${vo.goods_no }">
		  				<input name="list[0].size_no" type="hidden"
		  				 value="2">
		  				<input name="list[0].color_no" type="hidden"
		  				 value="0">
		  				<input name="list[0].goods_option_no" type="hidden"
		  				 value="0">
		  				<div class="form-group">
		  					<label>사이즈</label>
		  					<input value="M" readonly class="form-control">
		  				</div>
		  				<div class="form-group">
		  					<label>수량</label>
		  					<input type="number" name="list[0].count"
		  					 class="form-control" value="1" min="1">
		  				</div>
		  			</div>
		  			<!-- 사용자가 구매하려는 것을 선택해서 +를 클릭하면 만들어 지는 입력 한 세트 끝 -->
		  			<!-- 사용자가 구매하려는 것을 선택해서 +를 클릭하면 만들어 지는 입력 한 세트 시작 -->
		  			<div class="form-inline">
		  				<input name="list[1].goods_no" type="hidden"
		  				 value="${vo.goods_no }">
		  				<input name="list[1].size_no" type="hidden"
		  				 value="3">
		  				<input name="list[1].color_no" type="hidden"
		  				 value="1">
		  				<input name="list[1].goods_option_no" type="hidden"
		  				 value="0">
		  				<div class="form-group">
		  					<label>사이즈</label>
		  					<input value="M" readonly class="form-control">
		  				</div>
		  				<div class="form-group">
		  					<label>수량</label>
		  					<input type="number" name="list[1].count"
		  					 class="form-control" value="3" min="1">
		  				</div>
		  			</div>
		  			<!-- 사용자가 구매하려는 것을 선택해서 +를 클릭하면 만들어 지는 입력 한 세트 끝 -->
		  			<div>
		  			<!-- 구매 총액과 배송료는 jquery로 계산을 해서 넣어 줘야 하다. -->
		  				구매 총액 : <span id="totalPrice">${vo.sale_price * 4 }</span> 원
		  				 / 배송료 : <span id=deliveryCharge>${(vo.sale_price * 4 < 50000)?vo.delivery_charge:0 }</span>
		  			</div>
		  			<button class="btn btn-primary">장바구니 담기</button>
		  		</form>
	  		</div>
	  	</div>
	  	<div class="row">
	  		<div class="col-md-12">
	  		</div>
	  	</div>
	  </div>
	  <div class="card-footer">
	  	<button class="btn btn-primary" id="updateBtn">수정</button>
		<!-- 모달창은 열어서 비밀번호를 입력 받고 삭제하여 가는 처리 -->
	  	<button class="btn btn-danger" id="deleteBtn"
	  	  data-toggle="modal" data-target="#deleteModal">삭제</button>
	  	<button class="btn btn-warning" id="listBtn" >리스트</button>
	  </div>
	</div>
	<!-- 글보기 card 끝 -->
	
</div>

  <!-- The Modal -->
  <div class="modal fade" id="deleteModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">비밀번호 입력 모달 창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <form action="delete.do" method="post">
        	<input type="hidden" name="no" value="${vo.goods_no }">
	        <!-- Modal body -->
	        <div class="modal-body">
	        	<div class="form-group">
	          		<input class="form-control" name="pw" type="password" 
	          		 id="pw">
	          	</div>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	        	<button class="btn btn-danger" >삭제</button>
	          <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	        </div>
        
        </form>
        
      </div>
    </div>
  </div>


</body>
</html>