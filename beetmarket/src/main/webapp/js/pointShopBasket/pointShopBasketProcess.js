/**
 * 포인트 샵 바스켓 서비스 처리
 */
$(function() {
	//장바구니 리스트 버튼 클릭
	$(".modal #basketBtn").click(function() {
		console.log("11");
		let basket = $(".modal-right-sidebar");
		console.log(basket);
        if (basket.width() === 0) {
            // 패널이 닫혀 있을 때 (오른쪽에서 나오는 애니메이션)
            basket.animate({width: "30%",padding: "20px"}, 500);  // 250px로 확장 (시간은 500ms)
            basketService.list(showBasketList);
        } else {
            // 패널이 열려 있을 때 (왼쪽으로 사라지는 애니메이션)
            basket.animate({width: "0",padding: "0"}, 500);  // 0px로 축소 (시간은 500ms)
        }
        
	});
	
	
	//상품 클릭시 장바구니 등록 이벤트
	$("#goodsListDiv").on("click",".goodsCard",function(e){
		console.log("클릭");
		
		let goodsId = $(this).data("goodsid");
		
		basketService.write(function(data){
			if($(".modal-right-sidebar").width() === 0) {
				$(".modal-right-sidebar").animate({width: "30%",padding: "20px"}, 500);  // 250px로 확장 (시간은 500ms)
			}
			basketService.list(showBasketList);
			alert(data);
		},goodsId);
		
	});
	
});

//data를 포인트샵 장바구니 리스트로 출력
function showBasketList(list) {			
		
		//상품 리스트 출력할 태그
		let basketList = ``;	
		let totalPoint = 0;
			
		for(let i=0;i<list.length;i++) {
			let pointShopBasketNo = list[i].pointShopBasketNo;
			let goodsId = list[i].goodsId;
			let goodsName = list[i].goodsName;
			let goodsImage = list[i].goodsImage;
			let amount = list[i].amount;				
			let pointAmount = list[i].pointAmount;		
			totalPoint += (+pointAmount)*(+amount);
			basketList += `
					<div class="media rounded-sm shadow-sm p-3 pointShopBasketItem my-2"
						data-pointamount=${pointAmount} data-pointShopBasketNo=${pointShopBasketNo}>
						<img src="${goodsImage}" class="mr-3 img-thumbnail">
						<div class="media-body">
							<h5>${goodsName}</h5>	
							<p>${pointAmount*amount}pt</p>

							<div class="input-group">
								<div class="input-group-prepend">
									<button class="btn btn-outline-primary btn-circle" type="button" id="minusBtn">-</button>
								</div>
								<input type="text" class="form-control text-center no-border" id="quantityInput" value="${amount}" style="max-width: 50px;">
								<div class="input-group-append">
									<button class="btn btn-outline-primary btn-circle" type="button" id="plusBtn">+</button>
								</div>
							</div>

						</div>
					</div>
			`;
		}
		
		$("#pointShopBasketTotalPoint").text(totalPoint+"원");
			
		$("#pointShopBasketList").html(basketList);
		
		
}
	

