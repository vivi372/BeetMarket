<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>

<script type="text/javascript">
$(function(){ // HTML 문서가 로딩이 다 되면 실행해 주세요.
	
	// 바로 중분류의 데이터를 세팅한다.
	$("#cate_code2").load("/ajax/getMidList.do?cate_code1=" 
			+ $("#cate_code1").val());
	// 바로 사이즈의 데이터를 세팅한다.
	$("#sizeDiv").load("/ajax/getSize.do?cate_code1=" 
			+ $("#cate_code1").val());
	// 바로 색상의 데이터를 세팅한다.
	$("#colorDiv").load("/ajax/getColor.do?cate_code1=" 
			+ $("#cate_code1").val());
	
	// 제조일을 현재 날짜 이전만 입력
	$("#product_date").datepicker("option", {"maxDate" : new Date()});
	// 판매시작일과 종료일은 현재 날짜 이후만 입력 가능
	$("#sale_startDate, #sale_endDate")
	.datepicker("option", {"minDate" : new Date()});
	
	
	/// -------------- 이벤트(동작) 처리 --------------
	// 대분류를 바꾸면 중분류도 바꿔야한다.
	$("#cate_code1").change(function(){
		// 바로 중분류의 데이터를 세팅한다.
		$("#cate_code2").load("/ajax/getMidList.do?cate_code1=" 
				+ $("#cate_code1").val());
		// 바로 사이즈의 데이터를 세팅한다.
		$("#sizeDiv").load("/ajax/getSize.do?cate_code1=" 
				+ $("#cate_code1").val());
		// 바로 색상의 데이터를 세팅한다.
		$("#colorDiv").load("/ajax/getColor.do?cate_code1=" 
				+ $("#cate_code1").val());
	});
	
	
	$("#sale_startDate").change(function() {
		//alert($(this).val());
		$("#sale_endDate").datepicker( "option", "minDate", $(this).val() );
	});
	$("#sale_endDate").change(function() {
		//alert($(this).val());
		$("#sale_startDate").datepicker( "option", "maxDate", $(this).val() );
	});
	
	let appendImageTag = "";
	appendImageTag += "<div class=\"input-group mb-3\" id=\"imageFilesDiv\">";
	appendImageTag += "<input class=\"form-control imageFiles\" type=\"file\" name=\"imageFiles\">";
	appendImageTag += "<div class=\"input-group-append\">";
	appendImageTag += "	<button type=\"button\" class=\"btn btn-danger removeImageBtn\">";
	appendImageTag += "		<i class=\"fa fa-close\"></i>";
	appendImageTag += "	</button>";
	appendImageTag += "</div>";
	appendImageTag += "</div>";

	let imageCnt = 1;
	
	// 첨부 이미지 추가 처리
	$("#addImageBtn").click(function(){
		// alert("이미지 추가");
		// alert(appendImageTag);
		if(imageCnt >= 5 ){
			alert("첨부 이미지는 최대 5개까지만 가능합니다.");
			return false;
		}
		$("#imageFieldSet").append(appendImageTag);
		imageCnt ++;
	});
	
	// 첨부 이미지 제거 처리
	$("#imageFieldSet").on("click",".removeImageBtn",
	function(){
		$(this).closest(".input-group").remove();
		imageCnt --;
	});
	
	
	let appendOptionTag = "";
	appendOptionTag += "<div class=\"input-group mb-3\" >";
	appendOptionTag += "<input class=\"form-control option_name\" name=\"option_names\">";
	appendOptionTag += "<div class=\"input-group-append\">";
	appendOptionTag += "	<button type=\"button\" class=\"btn btn-danger removeOptionBtn\">";
	appendOptionTag += "		<i class=\"fa fa-close\"></i>";
	appendOptionTag += "	</button>";
	appendOptionTag += "</div>";
	appendOptionTag += "</div>";

	let optionCnt = 1;
	
	// 옵션 추가 처리
	$("#addOptionBtn").click(function(){
		// alert("옵션 추가");
		if(optionCnt >= 5 ){
			alert("상품의 옵션은 최대 5개까지만 가능합니다.");
			return false;
		}
		$("#optionFieldSet").append(appendOptionTag);
		optionCnt ++;
	});
	
	// 옵션 제거 처리
	$("#optionFieldSet").on("click",".removeOptionBtn",
	function(){
		$(this).closest(".input-group").remove();
		optionCnt --;
	});
	
	// 사이즈나 색상의 체크 박스를 클릭하면 처리
	$("#sizeFieldSet, #colorFieldSet").on("click", "input", function(){
		// alert("사이즈나 색상 체크박스 클릭");
		// option input div 제거 - 처음 것은 제외(:not())
		$("#optionFieldSet > div:not(:first)").remove();
		optionCnt = 1;
		$("#optionFieldSet input").val("");
	});
	
	// 옵션에 input 태그 클릭하면 사이즈와 컬러의 체크박스를 전체 해제시킨다.
	$("#optionFieldSet").on("focusin", "input",
		function(){
			console.log("옵션 입력란 포커스");
			// 사이즈와 컬러의 체크박스 전부 해제 시킨다.
			$("#sizeFieldSet input, #colorFieldSet input")
			.prop("checked", false);
		}
	);
	
	// 판매가 계산하는 처리 이벤트
	$("#price, #discount, #discount_rate").keyup(function(){
		let price = 0;
		let discount = 0;
		let discount_rate = 0;
		let sale_price = 0;
		price = Number($("#price").val());
		discount = Number($("#discount").val());
		discount_rate = Number($("#discount_rate").val());
		if(discount > 0) sale_price = price - discount;
		else if(discount_rate > 0) 
			sale_price 
			= Math.floor((price - (price * discount_rate / 100)) / 10) * 10;
		else sale_price = price;
		
		$("#sale_price").val(sale_price);
		
	});
	
});
</script>

</head>
<body>
<div class="container">
	<h2>상품 등록</h2>
	<form action="write.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="perPageNum" value="${param.perPageNum }">
	
	<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:p-#,pl-#,pr-#,pt-#,pb-#,px-#,py-#) -->
	 <fieldset class="border p-4">
	 	<legend class="w-auto px-2"><b style="font-size: 14pt;">[상품 기본 정보 입력]</b></legend>
		<!-- 상품 기본 정보 입력 시작 -->
		<div class="form-inline">
			<div class="form-group">
				<label for="cate_code1">대분류</label> 
				<select class="form-control" name="cate_code1" 
				 id="cate_code1" style="margin: 0 10px;">
					<c:forEach items="${bigList }" var="vo">
						<option value="${vo.cate_code1 }">${vo.cate_name }</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="cate_code2">중분류</label> 
				<select class="form-control" name="cate_code2"
				 id="cate_code2"  style="margin: 0 10px;">
					<!-- ajax를 이용한 중분류 option 로딩하기 -->
				</select>
			</div>
		</div>
		<div class="form-group">
			<label for="goods_name">상품명</label>
			<input class="form-control" name="goods_name"
			 id="goods_name" required>
		</div>
		
		<div class="form-group">
			<label for="company">제조사</label>
			<input class="form-control" name="company"
			 id="company" required>
		</div>
		
		<div class="form-group">
			<label for="product_date">제조날짜</label>
			<input class="form-control datepicker" name="product_date"
			 id="product_date" required readonly>
		</div>
		
		<div class="form-group">
			<!-- VO객체의 프로퍼티와 이름이 다르다. 파일 자체이므로 DB에는 이름만 저장 -->
			<label for="detailImageFile">상세 설명 이미지</label>
			<input class="form-control" name="detailImageFile"
			 id="detailImageFile" type="file">
		</div>
		
		<div class="form-group">
			<label for="content">상세 설명</label>
			<textarea class="form-control" name="content" id="content"
				rows="7"></textarea>
		</div>
		<div class="form-group">
			<!-- VO객체의 프로퍼티와 이름이 다르다. 파일 자체이므로 DB에는 이름만 저장 -->
			<label for="imageFile">대표 이미지</label>
			<input class="form-control" name="imageFile" id="imageFile" required
			 type="file">
		</div>
		<!-- 상품 기본 정보 입력 끝 -->
	</fieldset>


	<!-- p-# : padding 상대적인 설정 -->
	 <fieldset class="border p-4">
		<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:pl-#,pr-#,pt-#,pb-#,py-#) -->
	 	<legend class="w-auto px-2"><b style="font-size: 14pt;">[상품 가격 정보 입력]</b></legend>
		<!-- 가격 정보 입력 시작 -->
		<div class="form-group">
			<label for="price">정가</label>
			<input class="form-control" name="price"
			 id="price" required value="0">
		</div>
		<div class="form-group">
			<label for="discount">할인가</label>
			<input class="form-control" name="discount"
			 id="discount" value="0">
		</div>
		<div class="form-group">
			<label for="discount_rate">할인율</label>
			<input class="form-control" name="discount_rate"
			 id="discount_rate" value="0">
		</div>
		<div class="form-group">
			<label for="sale_price">판매가</label>
			<input class="form-control" name="sale_price" readonly
			 id="sale_price" value="0">
		</div>
		<div class="form-group">
			<label for="delivery_charge">배송료</label>
			<input class="form-control" name="delivery_charge"
			 id="delivery_charge" vlaue="0">
		</div>
		<div class="form-group">
			<label for="saved_rate">적립율</label>
			<input class="form-control" name="saved_rate"
			 id="saved_rate" value="0">
		</div>
		<div class="form-group">
			<label for="sale_startDate">판매 시작일</label>
			<input class="form-control datepicker" name="sale_startDate"
			 id="sale_startDate" required readonly>
		</div>
		<div class="form-group">
			<label for="sale_endDate">판매 종료일</label>
			<input class="form-control datepicker" name="sale_endDate"
			 id="sale_endDate" required readonly>
		</div>
		
		<!-- 가격 정보 입력 끝 -->
	</fieldset>
	
	<!-- p-# : padding 상대적인 설정 -->
	 <fieldset class="border p-4">
		<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:pl-#,pr-#,pt-#,pb-#,py-#) -->
	 	<legend class="w-auto px-2"><b style="font-size: 14pt;">[상품 옵션 정보 입력]</b></legend>
		<div class="m-4" style="color: red;">
			사이즈 / 색상과 옵션을 같이 사용할 수 없습니다.
			사이즈나 색상을 선택하면 옵션이 사라집니다. 옵션을 선택하면 반대가 됩니다.
		</div>
		 <fieldset class="border p-4" id="sizeFieldSet">
			<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:pl-#,pr-#,pt-#,pb-#,py-#) -->
		 	<legend class="w-auto px-2"><b style="font-size: 14pt;">[사이즈]</b></legend>
			<div id="sizeDiv" class="form-inline" ></div>
		 </fieldset>
		 
		 <fieldset class="border p-4" id="colorFieldSet">
			<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:pl-#,pr-#,pt-#,pb-#,py-#) -->
		 	<legend class="w-auto px-2"><b style="font-size: 14pt;">[색상]</b></legend>
			<div  id="colorDiv" class="form-inline" ></div>
		 </fieldset>
		 
		 <fieldset class="border p-4" id="optionFieldSet">
			<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:pl-#,pr-#,pt-#,pb-#,py-#) -->
		 	<legend class="w-auto px-2">
		 		<b style="font-size: 14pt;">[옵션]</b>
		 		<button type="button" id="addOptionBtn" class="btn btn-primary btn-sm">
		 			add Option
		 		</button>
		 	</legend>
			<div  id="optionDiv">
				<div class="input-group mb-3">
					<input name="option_names" class="form-control" />
				</div>
			</div>
		 </fieldset>
	 </fieldset>
	 
	<!-- p-# : padding 상대적인 설정 -->
	 <fieldset class="border p-4"  id="imageFieldSet">
		<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:pl-#,pr-#,pt-#,pb-#,py-#) -->
	 	<legend class="w-auto px-2">
	 		<b style="font-size: 14pt;">[상품 첨부 이미지 입력]</b>
	 		<button type="button" id="addImageBtn" class="btn btn-primary btn-sm">
	 			add Image
	 		</button>
	 	</legend>
	 	<div class="input-group mb-3">
			<!-- VO객체의 프로퍼티와 이름이 다르다. 파일 자체이므로 DB에는 이름만 저장 -->
		 	<input class="form-control imageFiles" type="file" name="imageFiles">
		</div>
	 	
	 </fieldset>
	 
		<button type="submit" class="btn btn-primary">등록</button>
		<button type="reset" class="btn btn-warning">새로입력</button>
		<button type="button" class="cancelBtn btn btn-success">취소</button>
	</form>
</div>
</body>
</html>