<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>


/* 모달 크기 설정 */
#pointShopModal .modal-dialog {
  width: 80vw; /* 너비: 화면 너비의 80% */
  height: 60vh; /* 높이: 화면 높이의 70% */
  max-width: none; /* Bootstrap의 기본 최대 너비 제한 해제 */
  overflow: hidden; /* 모달 전체에 스크롤 막기 */
}

#pointShopModal .modal-content {	
	display: flex;
	flex-direction: column; /* 세로로 레이아웃 설정 */
	height: 100%; /* 모달 크기에 맞춤 */
}

/* 사이드바와 메인 콘텐츠를 flex로 나눔 */
#pointShopModal .modal-body-content {
  display: flex;
  flex: 1; /* 남은 공간 모두 차지 */
  height: 100%;
}

/* 사이드바 설정 */
#pointShopModal .modal-sidebar {
  width: 20%; /* 모달 너비의 20% 차지 */
  background-color: white; /* 사이드바 배경색 */  
  padding: 20px;
  display: flex;
  flex-direction: column;  
  
}

/* 메인 콘텐츠 */
#pointShopModal .modal-main {
  width: 80%; /* 모달 너비의 80% 차지 */
  
  padding: 20px;
  overflow-y: auto; /* 세로 스크롤 추가 */
	/* 스크롤바 전체 스타일 */
	&::-webkit-scrollbar {
	  width: 10px; /* 스크롤바 너비 */
	  height: 8px; /* 스크롤바 높이 */
	}
	
	/* 스크롤바 트랙 */
	&::-webkit-scrollbar-track {
	  background: white; /* 트랙 배경색 */
	  border-radius: 10px; /* 트랙 모서리 둥글게 */
	}
	
	/* 스크롤바 썸 */
	&::-webkit-scrollbar-thumb {
	  background: #4da3ff; /* 썸 배경색 */
	  border-radius: 10px; /* 썸 모서리 둥글게 */
	}
}

/* 사이드바 설정 */
#pointShopModal .modal-right-sidebar {	
	width: 0; /* 모달 너비의 20% 차지 */
	
	overflow: hidden;
	background-color: white; /* 사이드바 배경색 */  
	padding: 0;
	display: flex;
	flex-direction: column;  
	box-shadow: -4px 0 5px rgba(0, 0, 0, 0.1); /* 왼쪽에 그림자 */
	overflow-y: auto; /* 세로 스크롤 추가 */
	
	/* 스크롤바 전체 스타일 */
	&::-webkit-scrollbar {
	  width: 10px; /* 스크롤바 너비 */
	  height: 8px; /* 스크롤바 높이 */
	}
	
	/* 스크롤바 트랙 */
	&::-webkit-scrollbar-track {
	  background: white; /* 트랙 배경색 */
	  border-radius: 10px; /* 트랙 모서리 둥글게 */
	  height: 95%;
	}
	
	/* 스크롤바 썸 */
	&::-webkit-scrollbar-thumb {
	  background: #4da3ff; /* 썸 배경색 */
	  border-radius: 10px; /* 썸 모서리 둥글게 */
	}
	
}

.cateActive {
	color: #007bff;
	border-right: 5px solid #007bff;
}

#pointShopModal .modal-sidebar h4 {
	display: flex; 
	justify-content: center; 
	align-items: center; 	
}
#pointShopModal .modal-sidebar .category {
	cursor: pointer;	
}

/* 포인트샵 상품 카드 css */
#pointShopModal .modal-main .card {
	width:100%; 
	border: none; 
	height: 400px;
}
#pointShopModal .modal-main img {
	object-fit: cover; 
	height: 250px;
}

#pointShopModal .card {
	position: relative; /* 부모 요소에 상대적인 위치 설정 */
}

#pointShopModal .card-img-top {
	position: relative; /* 이미지 요소에 상대적인 위치 설정 */
}


#pointShopModal .updateBtn {
	position: absolute;
	top: 0;
	right: 0;
	z-index: 1; /* 버튼을 이미지보다 위로 배치 */
}

#goodsModal .modal-content {
  	min-height: 670px; /* 최소 높이 설정 */
}

</style>

<script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.6/dist/JsBarcode.all.min.js"></script>

<script src="/js/pointShop/pointShop.js"></script>
<script src="/js/pointShop/pointShopProcess.js"></script>
<script src="/js/pointShop/goodsModal.js"></script>

<script type="text/javascript">
	$(function() {	
		
		window.addEventListener("resize", function() {			
			
			$("#pointShopModal .modal-sidebar,#pointShopModal .modal-right-sidebar,#pointShopModal .modal-main").css("height", $("#pointShopModal .modal-content").height()-80);
		
		});
		
		
		
// 		$("#barcodeBtn").click(function() {
// 			JsBarcode("#barcode", "123456789012", {
// 			    format: "CODE128",
// 			    displayValue: true
// 			});
// 		});
		
		$("#pointShopModal").draggable();
		
				
		
		
		$(".modal #basketBtn").click(function() {
			console.log("11");
			let basket = $(".modal-right-sidebar");
			console.log(basket);
	        if (basket.width() === 0) {
	            // 패널이 닫혀 있을 때 (오른쪽에서 나오는 애니메이션)
	            basket.animate({width: "30%",padding: "20px"}, 500);  // 250px로 확장 (시간은 500ms)
	        } else {
	            // 패널이 열려 있을 때 (왼쪽으로 사라지는 애니메이션)
	            basket.animate({width: "0",padding: "0"}, 500);  // 0px로 축소 (시간은 500ms)
	        }
		});
	});
</script>

<!-- The Modal -->
<div class="modal" id="pointShopModal" style="overflow: hidden;">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			
			<nav class="navbar navbar-expand-sm">
				<ul class="navbar-nav">
					<li class="nav-item active">
						<h3>
							<b class="nav-link text-dark">BeetSHOP</b>
						</h3>
					</li>
				</ul>
				<div class="w-50 mx-auto input-group">
					<!-- 검색 word 입력 -->
					<input type="text" class="form-control" id="pointShopSearch" placeholder="상품 이름 검색">
					<div class="input-group-append">
						<button class="btn btn-primary" id="searchBtn" type="button">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</div>
				
				<div class="mx-auto" style="font-size: 20px;">
					<i class="fa fa-bitcoin"></i>
					<span class="text-primary"><b>1000pt</b></span>
				</div>
				
				<button type="button" class="close ml-auto" data-dismiss="modal">&times;</button>
			</nav>
			<!-- 사이드바와 메인 콘텐츠 영역 -->
        	<div class="modal-body-content">
				<!-- 왼쪽 20% 사이드바 -->
	        	<div class="modal-sidebar">
	        		<div class="ml-1 my-3 py-2 cateActive category" data-category="">
	          			<h4><b>전체</b></h4>	        		
	        		</div> 
	        		<div class="ml-1 my-3 py-2 category" data-category="쿠폰">
	          			<h4><b>쿠폰</b></h4>	        		
	        		</div> 
	        		<div class="ml-1 my-3 py-2 category" data-category="상품권">
	          			<h4><b>상품권</b></h4>	        		
	        		</div> 
	        		<div class="ml-1 my-3 py-2 category" data-category="음식">
	          			<h4><b>음식</b></h4>	        		
	        		</div>  
	        		
	        		<div class="mt-auto">
	        			<button type="button" id="basketBtn" class="btn btn-primary btn-block">
	        				<i class="fa fa-shopping-cart"></i>
	        				&emsp;장바구니
	        			</button>
	        		</div>	          			          		
	        	</div>
	        	
	        	
			
	        	<div class="modal-main">
	        		<button class="btn btn-primary" id="goodsWriteBtn">add</button>
	        		<!-- 상품 데이터가 출력 -->
	        		<div id="goodsListDiv">
						<div class="row">
							<div class="col-md-3">
							
								<div class="card shadow-sm m-2" data-goodsid="1">
									<img class="card-img-top" src="/upload/pointshop/c1.jpg" alt="Card image">
									<div class="card-body">
										<h4 class="card-title">10% 할인 쿠폰</h4>
										<p class="card-text">10000pt(2개 남음)</p>									
								  	</div>
								</div>
								
							</div>
						</div>
					</div>
				</div>
				
				
				<!-- 오른쪽 20% 사이드바 -->
	        	<div class="modal-right-sidebar left-shadow">
	        		<div class="ml-1 my-3 py-2">
	          			<h4><b>장바구니</b></h4>	 
	          		    		
	        		</div> 	        			        		
	        			          			          		
	        	</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="goodsModal.jsp"/>