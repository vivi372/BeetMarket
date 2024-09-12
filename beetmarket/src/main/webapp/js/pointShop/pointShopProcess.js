/**
 * 포인트 샵 서비스 처리
 */
$(function() {
	let service = new pointShopService;
	
	$("#pointsosh-btn").on("click", function() {
		$("#pointShopModal").modal({backdrop: 'static', keyboard: false});	
		$("#pointShopModal .modal-sidebar,#pointShopModal .modal-right-sidebar,#pointShopModal .modal-main").css("height", $("#pointShopModal .modal-content").height()-80);
		//전체 카테고리 선택 시키기
		$(".modal-sidebar .category").removeClass("cateActive");
		$("#pointShopModal").find(".category:first").addClass("cateActive");
		$("#pointShopSearch").val("");
		service.list(showList,"","");
	});	
	//검색 버튼 클릭 이벤트
	$("#searchBtn").click(function() {
		let goodsName =  $("#pointShopSearch").val();
		let category = $(".modal-sidebar .cateActive").data("category");
		service.list(showList,goodsName,category);
	});
	//input 엔터 버튼 클릭 이벤트
	$("#pointShopSearch").keyup(function(key) {
		if(key.keyCode == 13) {
			let goodsName =  $("#pointShopSearch").val();
			let category = $(".modal-sidebar .cateActive").data("category");
			service.list(showList,goodsName,category);
		}
	});
	//카테고리 클릭 이벤트
	$(".modal-sidebar .category").click(function() {
		$(".modal-sidebar .category").removeClass("cateActive");
		$(this).addClass("cateActive");
		let goodsName =  $("#pointShopSearch").val();
		let category = $(".modal-sidebar .cateActive").data("category");
		console.log(goodsName);
		console.log(category);
		service.list(showList,goodsName,category);
	});
	
	//상품 등록 버튼 클릭 이벤트
	$("#goodsModal #goodsSubmitBtn").click(function() {
		if($(this).text()=='등록') {
				let formData1 = new FormData();			
				
				
				let goodsImageFile = document.getElementById('goodsImageInput').files[0];
				//console.log(goodsImageFile);
				
				formData1.append("goodsName",$("#goodsNameInput").val());
				formData1.append("goodsImageFile",goodsImageFile);
				formData1.append("pointAmount",$("#pointAmountInput").val());
				formData1.append("goodsStock",$("#goodsStockInput").val());
				formData1.append("category",$("#cateInput").val());
				formData1.append("shipNo",$("#goodsGradeInput").val());
				formData1.append("discountRate",$("#discountRateInput").val());
				
				let keys = formData1.values();
				for(let i of keys) {
					console.log(i);
				}
				//상품을 등록
				service.write(function(data) {
					alert(data);			
					//등록후 리스트 출력
					service.list(showList,"","");
					//등록후 모달창 닫기
					$("#goodsModal").modal("hide");
				}
				,formData1);
			}
		});	
});
	

//data를 포인트샵 리스트로 출력
function showList(data) {
	
	
		
			//상품 리스트 출력할 태그
			let goodsList = `
					<div class="row">
			`;		
			
			for(let i=0;i<data.length;i++) {
				let goodsId = data[i].goodsId;
				let goodsName = data[i].goodsName;
				let goodsImage = data[i].goodsImage;				
				let goodsStock = data[i].goodsStock;
				let amount = data[i].pointAmount;
				let category = data[i].category;
				let discountRate = data[i].discountRate;
				let shipNo = data[i].shipNo;
				if(i != 0 && i%3 == 0) {
					goodsList += `
					</div>
					<div class="row">
				`;
			}
			/*<div class="card-img-overlay ml-2">
				<button class="btn btn-sm btn-outline-secondary updateBtn float-right" data-toggle="modal" data-target="#goodsModal" data-backdrop="static">
					<i class="material-icons">edit</i>
				</button>
			</div>*/
			goodsList += `
				<div class="col-md-4">
							
					<div class="card shadow-sm m-2 d-flex flex-column goodsCard" 
					data-goodsid="${goodsId}" data-category="${category}" 
					data-discountRate="${discountRate}" data-shipNo="${shipNo}">						
						<img class="card-img-top" src="${goodsImage}" alt="Card image">
							
						<button class="btn btn-sm btn-outline-secondary updateBtn float-right" data-toggle="modal" data-target="#goodsModal" data-backdrop="static">
							<i class="material-icons">edit</i>
						</button>
						
						<div class="card-body d-flex flex-column justify-content-between">
							<div class="card-title mt-2">
								<b style="font-size: 25px;" class="goodsName">${goodsName}</b>
							</div>					
							<div class="mt-auto d-flex justify-content-between align-items-center">
        						<span class="card-text"><span class="amount">${amount}</span>pt <span class="goodsStock" data-goodsstock=${goodsStock}>`;
			if(goodsStock == 0) {
				goodsList += `(품절)</span></span>`;
			} else {
				goodsList += `(${goodsStock}개 남음)</span></span>`;				
			}
			goodsList += `
							<div class="mt-2">
          							<button class="btn btn-primary btn-sm pointBasketBtn"><i class="fa fa-plus"></i></button>
        						</div>
      						</div>
      						
					  	</div>
					</div>
								
				</div>
			`;
			}		
			
			goodsList += `</div>`;
		
		$("#goodsListDiv").html(goodsList);
		
	}
