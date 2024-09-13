/**
 * 포인트 샵 서비스 처리
 */
$(function() {
	
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
	
	//상품 수정 버튼 클릭 이벤트
	$("#goodsModal #goodsSubmitBtn").click(function() {
		if($(this).text()=='수정' && $("#goodsModal .nav-tabs").find(".active").text() == '상품 수정' ) {			
			
			let formData1 = new FormData();			
			
			if($("#imageCheckBox").is(":checked")) {
				let goodsImageFile = document.getElementById('goodsImageUpdate').files[0];
				formData1.append("goodsImageFile",goodsImageFile);
				let imageDeleteFile = $("#imageDeleteFile").val();
				formData1.append("imageDeleteFile",imageDeleteFile);
			}
			
			
			//console.log(goodsImageFile);
			
			formData1.append("goodsId",$("#goodsIdUpdate").val());			
			formData1.append("goodsName",$("#goodsNameUpdate").val());			
			formData1.append("pointAmount",$("#pointAmountUpdate").val());			
			formData1.append("category",$("#cateUpdate").val());
			formData1.append("shipNo",$("#goodsGradeUpdate").val());
			formData1.append("discountRate",$("#discountRateUpdate").val());
			
			let keys = formData1.values();
			for(let i of keys) {
				console.log(i);
			}
			//상품을 수정
			service.update(function(data) {
				
				//등록후 리스트 출력
				let goodsName =  $("#pointShopSearch").val();
				let category = $(".modal-sidebar .cateActive").data("category");
				service.list(showList,goodsName,category);									
				alert(data);				
				//등록후 모달창 닫기
				$("#goodsModal").modal("hide");
			}
			,formData1);
		}
	});	
	
	//상품 수정 버튼 클릭 이벤트
	$("#goodsModal #goodsSubmitBtn").click(function() {
		if($(this).text()=='수정' && $("#goodsModal .nav-tabs").find(".active").text() == '재고 수정' ) {			
			
			let formData1 = new FormData();			
			
			
			formData1.append("goodsId",$("#goodsIdUpdate").val());			
			formData1.append("goodsStock",$("#goodsStockUpdate").val());			
			formData1.append("currentStock",$("#currentStock").text());			
			
			
			let keys = formData1.values();
			for(let i of keys) {
				console.log(i);
			}
			//상품의 재고를 수정
			service.updateStock(function(data) {
				alert(data);				
				//등록후 리스트 출력
				let goodsName =  $("#pointShopSearch").val();
				let category = $(".modal-sidebar .cateActive").data("category");
				service.list(showList,goodsName,category);
				//등록후 모달창 닫기
				$("#goodsModal").modal("hide");
			}
			,formData1);
		}
	});	
	
	//상품 삭제 버튼 클릭
	$("#goodsListDiv").on("click",".deleteBtn",function() {			
		
		let goodsId = $(this).closest(".goodsCard").data("goodsid");			
		let stopSell = $(this).data("stopsell");		
		
		//상품의 재고를 수정
		service.delete(function(data) {
			alert(data);				
			//등록후 리스트 출력
			let goodsName =  $("#pointShopSearch").val();
			let category = $(".modal-sidebar .cateActive").data("category");
			service.list(showList,goodsName,category);
			//등록후 모달창 닫기
			$("#goodsModal").modal("hide");
		}
		,goodsId,stopSell);
		
		//부모 이벤트 막기
		e.stopPropagation();
	});
});
	

//data를 포인트샵 리스트로 출력
function showList(data) {
	
			let list = data.list;			
			let point = data.point;
			//현재 포인트 출력
			$("#pointShopPoint").text(point);
			
		
			//상품 리스트 출력할 태그
			let goodsList = `
					<div class="row">
			`;		
			
			for(let i=0;i<list.length;i++) {
				let goodsId = list[i].goodsId;
				let goodsName = list[i].goodsName;
				let goodsImage = list[i].goodsImage;				
				let goodsStock = list[i].goodsStock;
				let amount = list[i].pointAmount;
				let category = list[i].category;
				let discountRate = list[i].discountRate;
				let shipNo = list[i].shipNo;
				let stopSell = list[i].stopSell;
				if(i != 0 && i%3 == 0) {
					goodsList += `
					</div>
					<div class="row">
				`;
			}
			goodsList += `
				<div class="col-md-4">
							
					<div class="card shadow-sm m-2 d-flex flex-column goodsCard" 
					data-goodsid="${goodsId}" data-category="${category}" 
					data-discountRate="${discountRate}" data-shipNo="${shipNo}">						
						<img class="card-img-top" src="${goodsImage}" alt="Card image">`;
			
			if(stopSell == 0) {
				goodsList += `<button class="btn btn-sm btn-outline-danger deleteBtn float-right" data-stopSell=${stopSell}>
					<i class="material-icons">close</i>
					</button>`;				
			} else {
				goodsList += `<button class="btn btn-sm btn-outline-warning deleteBtn float-right" data-stopSell=${stopSell}>
					<i class="material-icons">cancel</i>
					</button>`;
			}						
							
			goodsList += `<button class="btn btn-sm btn-outline-secondary updateBtn float-right">
							<i class="material-icons">edit</i>
						</button>
						
						<div class="card-body d-flex flex-column justify-content-between">
							<div class="card-title mt-2">
								<b style="font-size: 25px;" class="goodsName">${goodsName}</b>`;
			if(stopSell == 1)
				goodsList += `<b class="text-danger">(판매중지)</b>`					
			goodsList +=		`</div>					
							<div class="mt-auto d-flex justify-content-between align-items-center">
        						<span class="card-text"><span class="amount">${amount}</span>pt <span class="goodsStock" data-goodsstock=${goodsStock}>`;
			if(goodsStock == 0) {
				goodsList += `(품절)</span></span>`;
			} else {
				goodsList += `(${goodsStock}개 남음)</span></span>`;				
			}
			goodsList += `
							
      						</div>
      						
					  	</div>
					</div>
								
				</div>
			`;
			}		
			
			goodsList += `</div>`;
			
		$("#goodsListDiv").html(goodsList);
		
		
	}
