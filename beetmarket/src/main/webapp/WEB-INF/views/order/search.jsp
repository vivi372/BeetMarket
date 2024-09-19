<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    /* 사용자 정의 CSS */
    .custom-checkbox {
        display: flex;
        flex-wrap: wrap;
    }
    .custom-checkbox button {
        margin: 5px;
    }
</style>

<script type="text/javascript">
$(function() {
	

	//주문 상태 버튼 클릭 이벤트
	$(".menu-item").click(function() {
		if($(this).hasClass("btn-dark")) {
			
			$("#searchForm #orderStateInput").val("");
			$("#searchForm").submit();
		} else {
				
			$("#searchForm #orderStateInput").val($(this).text());
			$("#searchForm").submit();
		}
	
	});
	
	//검색 값 세팅
	$("#searchForm #minDate").val("${searchVO.minDate}");
	$("#searchForm #maxDate").val("${searchVO.maxDate}");
	$("#searchForm #goodsTitleInput").val("${searchVO.goodsTitle}");
	$("#searchForm .menu-item").each(function() {
		if($(this).text() == "${searchVO.orderState}"){
			$(this).removeClass("btn-light");
			$(this).addClass("btn-dark");
			$("#searchForm #orderStateInput").val("${searchVO.orderState}");
		}			
	});
	//기간 선택 버튼 클릭 이벤트
	$(".periodBtn").click(function() {
		$("#maxDate").val(dateToString(new Date()));
		$("#minDate").val(subtractDate($("#maxDate").val(),$(this).data("period")));
		$("#searchForm").submit();
	});
	$("#minDate, #maxDate").change(function() {
		$("#searchForm").submit();
	});
});
</script>

	<form action="list.do" id="searchForm">
    	<div class="input-group mb-3">
	       	<!-- 검색 word 입력 -->
	 		<input type="text" class="form-control" placeholder="상품 이름 검색" id="goodsTitleInput" name="goodsTitle">
	 		<div class="input-group-append">
				<button class="btn btn-dark searchBtn" type="submit"><i class="fa fa-search"></i></button>
			</div>
		</div>
		 <!-- 버튼 그룹 -->
         주문 기간
         <div class="custom-checkbox my-2">
             <button type="button" class="btn btn-outline-dark periodBtn" data-period="5y">5년</button>
             <button type="button" class="btn btn-outline-dark periodBtn" data-period="6m">6개월</button>
             <button type="button" class="btn btn-outline-dark periodBtn" data-period="3m">3개월</button>
             <button type="button" class="btn btn-outline-dark periodBtn" data-period="1m">1개월</button>             
         </div>
		
        <div class="tab-content" id="pills-tabContent">
            <div class="tab-pane fade show active" id="pills-5y" role="tabpanel" aria-labelledby="pills-5y-tab">
                <!-- 날짜 선택기 -->
                <div class="form-row">
                    <div class="form-group col-md-5">
                        <input type="date" id="minDate" name="minDate" class="form-control" value="2019-08-31">
                    </div>
                    <div class="form-group col-md-1 text-center">
                        ~
                    </div>
                    <div class="form-group col-md-5">
                        <input type="date" id="maxDate" name="maxDate" class="form-control" value="2024-08-31">
                    </div>
                </div>
                <!-- 버튼 그룹 -->
                 주문 상태
                <div class="custom-checkbox">
                    <button type="button" class="btn btn-light menu-item">결제완료</button>
                    <button type="button" class="btn btn-light menu-item">배송준비</button>
                    <button type="button" class="btn btn-light menu-item">배송중</button>
                    <button type="button" class="btn btn-light menu-item">배송완료</button>
                    <button type="button" class="btn btn-light menu-item">구매확정</button>
                    <button type="button" class="btn btn-light menu-item">취소요청</button>
                    <button type="button" class="btn btn-light menu-item">반품요청</button>
                    <button type="button" class="btn btn-light menu-item">요청처리</button>
                </div>
                <input type="hidden" name="orderState" id="orderStateInput">
              
            </div>
        </div>
    </form>

    