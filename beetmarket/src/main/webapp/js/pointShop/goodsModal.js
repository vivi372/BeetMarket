/**
 * 
 */

$(function() {
	$("#goodsModal").draggable();
		
	$("#goodsImageInput").change( function() {
		//console.log($(this).val());
		$("#modalImageNamePrint").text($(this).val());
	});
	
	$("#cateInput,#cateUpdate").change(function() {		
		if($(this).val() == '쿠폰') {
			$(this).parent().next().show();			
		} else {
			$(this).parent().next().hide();
			$("#discountRateInput").val("");
		}
	});
	
	//포인트샵 상품 모달 등장 이벤트
	$("#goodsWriteBtn").on("click", function() {
		//모달 제목 바꾸기
		$("#goodsModal .modal-title").text("상품 등록");
		//버튼 이름 바꾸기
		$("#goodsModal #goodsSubmitBtn").text("등록");
		//모달안 input,select 태그 값 초기화
		$(this).find("input").val("");
		$(this).find("select").val("");
		//상품 등록 폼 보이기
		$("#goodsModal #goodsWriteDiv").show();
		//상품 수정 폼 숨기기
		$("#goodsModal #goodsUpdateDiv").hide();
		//할인율 div 숨기기
		$("#discountRateInput").closest(".form-group").hide();
	});
	//포인트샵 상품 수정 모달 등장 이벤트
	$("#goodsListDiv").on("click",".updateBtn", function() {		
		//모달 제목 바꾸기
		$("#goodsModal .modal-title").text("상품 수정");
		//버튼 이름 바꾸기
		$("#goodsModal #goodsSubmitBtn").text("수정");
		//모달안 input,select 태그 값 초기화
		$(this).find("input").val("");
		$(this).find("select").val("");
		//수정을 위한 데이터 가져오기
		let goodsCard = $(this).closest(".goodsCard");
		let goodsId = goodsCard.data("goodsid");
		let goodsName = goodsCard.find(".goodsName").text();
		let amount = goodsCard.find(".amount").text();
		let goodsStock = goodsCard.find(".goodsStock").data("goodsstock");
		let category = goodsCard.data("category");
		let discountRate = goodsCard.data("discountrate");
		//데이터 세팅
		$("#goodsIdUpdate").val(goodsId);
		$("#goodsNameUpdate").val(goodsName);
		$("#pointAmountUpdate").val(amount);
		$("#cateUpdate").val(category);
		$("#discountRateUpdate").val(discountRate);
		$("#goodsStockUpdate").val(goodsStock);
		//상품 등록 폼 보이기
		$("#goodsModal #goodsWriteDiv").hide();
		//상품 수정 폼 숨기기
		$("#goodsModal #goodsUpdateDiv").show();
		//할인율 div 숨기기
		if(category != '쿠폰')
			$("#discountRateUpdate").closest(".form-group").hide();
		else 
			$("#discountRateUpdate").closest(".form-group").show();
	});
	
});