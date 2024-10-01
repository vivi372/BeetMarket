<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제</title>

<style>
.custom-control-label:hover{
	cursor: pointer;
}
.custom-checkbox .custom-control-input:checked~.custom-control-label::before{
 	background-color: black;
    border-color: black;   
}
.dataRow, .backBtn {
	cursor: pointer;
}
</style>
<script src="https://js.tosspayments.com/v2/standard"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/uuid/8.1.0/uuidv4.min.js"></script>
<script type="text/javascript" src="/js/order/telInput.js"></script>
<script type="text/javascript" src="/js/BoardInputUtil.js"></script>
<script type="text/javascript" src="/js/priceUtils.js"></script>
<script type="text/javascript" src="/js/order/dlvy.js"></script>
<script type="text/javascript" src="/js/order/toss.js"></script>
<link href="/css/basketOrder/basic.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">




	$(function() {     
		
		
		
		//가격 정보 출력
		//전제 주문 금액 출력
		let totalGoodsPrice = 0;
		let totalCostPrice = 0;
		//판매자의 배송비
		$(".sellerListItem").each(function() {
			//해당 판매자의 배송비 무료 조건
			let freedelivery = $(this).data("freedelivery");
			//해당 판매자의 배송비
			let goodsCost = $(this).data("goodscost");
			//판매자의 상품들의 가격을 전부 더 해 totalPrice에 저장한다.
			let totalSellerPrice = 0;
			$(this).find(".orderPricePrint").each(function() {

				totalSellerPrice += (+$(this).text())*(+$(this).closest(".orderListItem").find("#amount").val());
			});
			//모든 상품 가격이 배송비 무료 조건보다 비싸면 배송비를 0원으로 출력
			//console.log(totalPrice);
			if(totalSellerPrice >= freedelivery) goodsCost = 0;
			
			
			$(this).find(".dlvyChargePrint").text(goodsCost)
			$(this).find(".dlvyChargeInput").val(goodsCost);
			
			//전체 상품 금액 계산
			totalGoodsPrice += totalSellerPrice;
			//전체 배송 금액 계산
			totalCostPrice += (+$(this).find(".dlvyChargePrint").text());
		});
		
		$("#totalGoodsPrice").text(totalGoodsPrice);
		$("#totalCostPrice").text(totalCostPrice);
		$("#totalOrderPrice").text(totalGoodsPrice+totalCostPrice);
		
		
		
		
		
		//아작스를 이용해 모달창에 배송지 리스트 띄우기
		$("#dlvyList").load("/dlvy/list.do", function() {
			//결제 폼 시작시 기본 배송지 입력하기위해 배송지 정보 가져오기
			let $listItem = $("#dlvyList").find(".dlvyListItem:first");
			
			//배송지가 존재할때
			if($listItem.length > 0) {
				//결제 폼에 기본 배송지 입력
				dlvySelect($listItem);		
			} else {	
				//배송지가 없을때 부트스트랩 alert를 등장시켜 배송지 등록시키게 한다.
				let dlvyAlert = `
					<div class="alert alert-dark" id="dlvyAlert">
					아직 등록된 배송지가 없습니다. <a class="alert-link" id="dlvyAlertLink">배송지 등록하기</a>.
				  	</div>`;
				$("#dlvyBtn").hide();
				$("#dlvyPrintDiv").prepend(dlvyAlert);				
			}
			
		});
		
	});
	
	$(function() { //제이 쿼리 준비	
		//상품 사진,상품 이름 클릭 시 이벤트
		$(".dataRow").click(function() {
			let listItem = $(this).closest(".orderListItem");
			//해당 상품에 해당하는 상세보기로 이동시킨다.
			let goodsNo = listItem.data("goodsno");
			let categoryNo = listItem.data("categoryno");		
			
			location = "/goods/shopView.do?goodsNo="+goodsNo;	
			
		});
		
		
		
		//처음에는 개별 배송메모 입력을 숨기고 비활성화 시킨다.
		$("#eachDlvyMemoDiv").hide();
		$("#eachDlvyMemoDiv").find(".eachDlvyMemo").attr("disabled",true)
		//배송메모 개별 입력 이벤트
		$("#dlvyMemoCheck").change(function() {
			//배송메모 개별 입력을 체크하면 입력 태그를 보이게 한고 비활성화도 푼다
			if($(this).is(":checked")){			
				$("#dlvyMemo").hide();
				$("#dlvyMemo").attr('disabled',true);
				$("#eachDlvyMemoDiv").show();
				$("#eachDlvyMemoDiv").find(".eachDlvyMemo").removeAttr("disabled");
			} else{	
				//배송메모 개별 입력을 체크 해제하면 입력 태그를 숨기고 비활성화한다.
				$("#dlvyMemo").show();
				$("#dlvyMemo").removeAttr('disabled');
				$("#eachDlvyMemoDiv").hide();
				$("#eachDlvyMemoDiv").find(".eachDlvyMemo").attr("disabled",true);			
			}
		});		
		
		
	});
	
	 
</script>

</head>
<body class="bg-light">

<div class="container" style="margin-bottom: 70px">
	<h3 class="text-center my-3"><b>주문/결제</b></h3>
	<br>
	<form id="writeForm">	
	
		<!-- 결제후 장바구니 삭제를 위한 장바구니 번호 데이터 -->
		<c:forEach items="${basketNo }" var="no">
			<input type="hidden" id="basketNo" name="basketNo" value="${no }">
		</c:forEach>
		<i class="material-icons float-right backBtn" onclick="history.back()" style="font-size:36px">arrow_back</i>		
		<h3><b>배송지</b></h3>
		<!-- 배송지를 입력하는 div -->
		<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm" id="dlvyPrintDiv">		
			<!-- 배송지 입력을 위한 모달을 나타내는 버튼 -->
			<button class="btn btn-outline-secondary btn-md float-right" id="dlvyBtn" type="button" data-toggle="modal" data-target="#dlvySelModal">변경</button>
			<!-- 배송지 관련 데이터를 write.jsp로 넘긴다 -->
			<!-- 받는 사람(배송지명) -->
			
			<h5><b id="recipientPrint"></b></h5>
			<input type="hidden" name="dlvyAddrNo" id="dlvyAddrNoInput">
			<!-- 전화번호 -->
			<small class="text-secondary" id="telPrint"></small>			
			<!-- 주소 -->
			<br><span id="addrPrint"></span>			
			<hr>
			<!-- 주문이 다중 주문일때 등장 -->
			<c:if test="${optList.size()>1 }">
				<div class="custom-control custom-checkbox mb-2">
					<input type="checkbox" class="custom-control-input" id="dlvyMemoCheck">    
					<label class="custom-control-label" for="dlvyMemoCheck"><b>배송 메모 개별 입력</b></label>							
		 		</div>
		 	</c:if>
		  	<input type="text" class="form-control my-3" id="dlvyMemo" name="dlvyMemo" maxlength="100" placeholder="배송 메모를 입력해주세요.">			  			
			<c:if test="${optList.size()>1 }">
				<div id="eachDlvyMemoDiv">
				<!-- 주문 상품 만큼 배송메모 입력 태그 생성 -->
					<c:forEach items="${optList }" var="opt">
						<c:forEach items="${goodsList }" var="vo">
							<c:if test="${opt.goodsNo == vo.goodsNo }">
							${vo.goodsName } (${opt.optName })				
				  			<input type="text" class="form-control my-3 eachDlvyMemo" name="dlvyMemo" maxlength="100" placeholder="배송 메모를 입력해주세요.">			  			
		  					</c:if>
		  				</c:forEach>
		  			</c:forEach>
	  			</div>		
	 		</c:if>	  						
		</div>
		

		
		<br>
		<h3><b>주문상품</b></h3>
		<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm sellerListItem" data-freedelivery="${ goodsList[0].free_ship_limit}" data-goodscost="${ goodsList[0].merchant_delivery}">
		<!-- 배송비 -->
		<span class="float-right text-secondary">배송비 : <span class="dlvyChargePrint"></span><span class="won">원</span></span> 		
		<h5>${ goodsList[0].store_name}</h5>
		<hr>
			
		<c:forEach items="${optList }" var="opt" varStatus="vs">
			<c:forEach items="${goodsList }" var="vo">
				<c:if test="${opt.goodsNo == vo.goodsNo }">
					<c:if test="${vs.index != 0 && vo.store_name != goodsList[vs.index-1].store_name}">
						${"</div>" }
						${"<div class='border rounded p-3 mb-2 bg-white text-dark shadow-sm sellerListItem' data-freedelivery='vo.free_ship_limit' data-goodscost='${ vo.merchant_delivery}'>" }
						${"<span class='float-right text-secondary'배송비 : <span class='dlvyChargePrint'></span><span class='won'>원</span></span>" }
						${"<h5>${ vo.store_name}</h5>" }
						${"<hr>" }
						${"<input type='hidden' id='dlvyCharge' name='dlvyCharge' value=''>" }
					</c:if>
					<div class="orderListItem mt-2" data-goodsno="${vo.goodsNo }">	
						<!-- 히든 입력 구간 : 상품 코드, 장바구니 번호(결제 삭제하기 위해),희망 관람일,카테고리 번호 -->
						<input type="hidden" id="goodsNo" name="goodsNo" value="${vo.goodsNo }">
						<!-- 이미지와 상품 정보칸 나누기 위해 그리드 시스템 사용 -->
						<!-- 주문상품 정보를 출력하고 히든으로 주문 상품 번호,옵션 번호,수량를 입력하는 div -->
						<div class="row">
							<div class="col-2">
								<!-- 상품 이미지 -->
								<img class="rounded img-fluid dataRow" src="${vo.goodsMainImage }" alt="상품 사진" width="150" height="150">
							</div>
							<div class="col-10"> 										
				  				<!-- 상품 이름 -->
				  				<h5><b class="dataRow text-truncate goodsTitle">${vo.goodsName }</b></h5>			  							
				  				
				  									
				  				<input type="hidden" id="optNo" name="optNo" value="${opt.optNo }">
				  				<c:if test="${!empty opt.optName}">
					  				<!-- 옵션 이름 -->
									<h5><span class="badge badge-pill badge-secondary">옵션</span> ${opt.optName}</h5>
								</c:if>	 					
								<!-- 수량 -->
								<h5><span class="badge badge-pill badge-secondary">수량</span> ${opt.amount}개</h5>
				  				<input type="hidden" id="amount" name="amount" value="${opt.amount}">				  				
				  				<!-- 결제 금액 -->
				  				<h5><b class="mt-3"><span class="orderPricePrint">${vo.goodsPrice + ((empty opt.optPrice)?0:opt.optPrice) }</span><span class="won">원</span></b></h5>	    
				  				<input type="hidden" class="orderPriceInput" name="orderPrice" value="${vo.goodsPrice + ((empty opt.optPrice)?0:opt.optPrice) }">				

				  				<input type="hidden" class="dlvyChargeInput" name="dlvyCharge" value="">
							</div>				
						</div>				
							
					</div>
				</c:if>
			</c:forEach>
		</c:forEach>
		</div>
		
		<h3><b>결제 상세</b></h3>
		<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">	
		<!-- 글부분만 숫자 부분을 나누기 위해 그리드 사용 -->
			<h5><b class="text-dark">쿠폰 선택</b></h5>
			<select class="form-control">
				<option selected style="display: none;">쿠폰을 선택해 주세요.</option>	
				<option>10% 할인 쿠폰(-8,990원)</option>
				<option>15% 할인 쿠폰(-13,485원)</option>
			</select>
		</div>			
		
		<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">	
		<!-- 글부분만 숫자 부분을 나누기 위해 그리드 사용 -->
			<div class="row">
				<div class="col-6"> <!-- 글부분(설명) -->
					<h5><b class="text-dark">주문금액</b></h5>
					<div style="border-left: 5px solid #aaa;"> <!-- 앞에 수직으로 선을 만들기 위해 div의 style 사용 -->
						<div class="ml-2 mt-1">상품 금액</div> <!-- 왼쪽의 마진을 주기위해 span 태그안에 데이터를 넣은 후 ml 클래스로 마진을 준다. -->
						<div class="ml-2 mt-1">할인 금액</div> <!-- 왼쪽의 마진을 주기위해 span 태그안에 데이터를 넣은 후 ml 클래스로 마진을 준다. -->
						<div class="ml-2 mt-1">배송비(수수료)</div>					
					</div>
				</div>				
				<div class="col-6 text-right"> <!-- 숫자부분(금액) - 텍스트를 오른쪽에 붙히기 위해 text-right 클래스 사용 -->
					<!-- 금액을 출력한다 -->
					<h5><b class="text-dark">총 <span id="totalOrderPrice"></span><span class="won">원</span></b></h5>								
					<div class="ml-2 mt-1"><span id="totalGoodsPrice"></span><span class="won">원</span></div>
					<div class="ml-2 mt-1"><span id="totalDiscountPrice">0</span><span class="won">원</span></div>
					<div class="ml-2 mt-1"><span id="totalCostPrice"></span><span class="won">원</span></div>						
								
				</div>
			</div>	
		</div>			
		
		<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">	
		<!-- 글부분만 숫자 부분을 나누기 위해 그리드 사용 -->
			<div class="row">
				<div class="col-6"> <!-- 글부분(설명) -->
					<h5><b class="text-dark">구매 적립</b></h5>
					<div style="border-left: 5px solid #aaa;"> <!-- 앞에 수직으로 선을 만들기 위해 div의 style 사용 -->
						<div class="ml-2 mt-1">기본적립</div> <!-- 왼쪽의 마진을 주기위해 span 태그안에 데이터를 넣은 후 ml 클래스로 마진을 준다. -->
						<div class="ml-2 mt-1">등급 추가 적립(브론즈)</div>					
					</div>
				</div>				
				<div class="col-6 text-right"> <!-- 숫자부분(금액) - 텍스트를 오른쪽에 붙히기 위해 text-right 클래스 사용 -->
					<!-- 금액을 출력한다 -->
					<h5><b class="text-dark">총 <span id="">1,798</span><span class="won">원</span></b></h5>								
					<div class="ml-2 mt-1"><span id="">899</span><span class="won">원</span></div>
					<div class="ml-2 mt-1"><span id="">899</span><span class="won">원</span></div>						
								
				</div>
			</div>	
		</div>			
		
		<br>
		<h3><b>결제 수단</b></h3>
		<!-- 결제 수단을 입력받는 div -->
		<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">	
			<!-- radio 타입 input 태그를 이용해 결제 방법과 상세를 입력 받는다. -->
			<div class="custom-control custom-radio my-2">
			    <input type="radio" class="custom-control-input" id="card" checked value="카드">
			    <label class="custom-control-label" for="card">카드 간편 결제</label>			    
			    <!-- 카드 상세 정보를 입력받는다 - 그리드를 이용해 카드 정보를 한줄로 입력 받는다. radio를 선택했을때 등장-->
			    
  			</div>
  			<div class="custom-control custom-radio my-2">
			    <input type="radio" class="custom-control-input" id="phone" value="핸드폰">
			    <label class="custom-control-label" for="phone">일반 결제</label>
			    <!-- 핸드폰 상세 정보를 입력받는다 - radio를 선택했을때 등장-->
			     <!-- 결제 UI -->
			    <div id="payment-method"></div>
			    <!-- 이용약관 UI -->
			    <div id="agreement"></div>
			    
  			</div>  			
		</div>
		
		<!-- 결제 버튼을 어디서도 볼수있게 하기 위해 하단에 고정된 네비바 생성 -->
		<nav class="navbar navbar-expand-sm bg-white navbar-dark fixed-bottom shadow">
			<!-- 결제 버튼을 클릭하면 입력된 정보와 함께 write.jsp로 이동한다. -->
			<button type="button" id="orderSubmitBtn" class="btn btn-block btn-dark"><b>결제</b></button>	 
		</nav>
	</form>
	
	<!-- 배송지 변경 모달 -->	    
	<div class="modal fade" id="dlvySelModal">
		<div class="modal-dialog modal-dialog-centered h-50  modal-lg">
	    	<div class="modal-content">		        
		        <div class="modal-header">
		          	<h4 class="modal-title"><b>배송지 목록</b></h4>
		          	<!-- 모달창이 사라지는 아이콘 버튼 -->
		          	<button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>	        
		        
		        <div class="modal-body">
		        	<div id="dlvyList">
		        	
		        	</div>
		        </div>
		        	
		        
		        <div class="modal-footer">		        
		          	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        </div>	        
	      	</div>
	 	</div>
	 </div>
  	
</div>
</body>

</html>