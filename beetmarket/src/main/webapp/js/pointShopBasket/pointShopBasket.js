/**
 * 포인트샵 장바구니 서비스 클래스
 */

class pointShopBasketService {
	id;	
	
	list(callback,error) {
		
		
		$.getJSON(`/pointShopBasket/list.do?id=${this.id}`, 
		function(data) {
			console.log(data);
			
			//callback이 있으면 실행 -> html를 만들어 출력
			if(callback) callback(data);
			
		}).fail(function(xhr,status,err){
			console.log("포인트샵 장바구니 리스트 가져오기 오류");
			console.log("xhr-"+JSON.stringify(xhr));
			console.log("status-"+status);
			console.log("err-"+err);
			//error이 있으면 실행
			if(error) error();
			else alert("포인트 샵 장바구니 데이터를 가져오는 중 오류 발생");
		});
	}
	
	write(callback,goodsId,error) {
		
		$.ajax({
		    url: `/pointShopBasket/write.do?goodsId=${goodsId}&id=${this.id}`, // 서버 URL
		    type: "get",		   
		    processData: false, // jQuery에서 데이터를 처리하지 않도록 설정
		    contentType: false, // HTTP 헤더의 Content-Type을 자동으로 설정하지 않도록 설정
		    success: function(data) {
		        console.log(data);

				//callback이 있으면 실행 -> html를 만들어 출력
				if(callback) callback(data);
							
		    },
		    error: function(xhr,status,err) {
		        console.log("포인트샵 장바구니 등록 오류");
				console.log("xhr-"+JSON.stringify(xhr));
				console.log("status-"+status);
				console.log("err-"+err);
				//error이 있으면 실행
				if(error) error();
				else alert("포인트 샵 장바구니 등록 중 오류 발생");
		    }
		});
	}
	
	update(callback,formData,error) {
		
		$.ajax({
		    url: "/pointShop/update.do", // 서버 URL
		    type: "POST",
			enctype: 'multipart/form-data',
		    data: formData,
		    processData: false, // jQuery에서 데이터를 처리하지 않도록 설정
		    contentType: false, // HTTP 헤더의 Content-Type을 자동으로 설정하지 않도록 설정
		    success: function(data) {
		        console.log(data);

				//callback이 있으면 실행 -> html를 만들어 출력
				if(callback) callback(data);
							
		    },
		    error: function(xhr,status,err) {
		        console.log("포인트샵 상품 수정 오류");
				console.log("xhr-"+JSON.stringify(xhr));
				console.log("status-"+status);
				console.log("err-"+err);
				//error이 있으면 실행
				if(error) error();
				else alert("포인트 샵 상품 수정 중 오류 발생");
		    }
		});
	}
	
	updateStock(callback,formData,error) {
		
		$.ajax({
		    url: "/pointShop/updateStock.do", // 서버 URL
		    type: "POST",
		    data: formData,
		    processData: false, // jQuery에서 데이터를 처리하지 않도록 설정
		    contentType: false, // HTTP 헤더의 Content-Type을 자동으로 설정하지 않도록 설정
		    success: function(data) {
		        console.log(data);

				//callback이 있으면 실행 -> html를 만들어 출력
				if(callback) callback(data);
							
		    },
		    error: function(xhr,status,err) {
		        console.log("포인트샵 재고 수정 오류");
				console.log("xhr-"+JSON.stringify(xhr));
				console.log("status-"+status);
				console.log("err-"+err);
				//error이 있으면 실행
				if(error) error();
				else alert("포인트 샵 재고 수정 중 오류 발생");
		    }
		});
	}
	
	delete(callback,goodsId,stopSell,error) {
		
		$.ajax({
		    url: `/pointShop/delete.do?goodsId=${goodsId}&stopSell=${stopSell}`, // 서버 URL
		    type: "get",			   
		    processData: false, // jQuery에서 데이터를 처리하지 않도록 설정
		    contentType: false, // HTTP 헤더의 Content-Type을 자동으로 설정하지 않도록 설정
		    success: function(data) {
		        console.log(data);

				//callback이 있으면 실행 -> html를 만들어 출력
				if(callback) callback(data);
							
		    },
		    error: function(xhr,status,err) {
		        console.log("포인트샵 상품 삭제 오류");
				console.log("xhr-"+JSON.stringify(xhr));
				console.log("status-"+status);
				console.log("err-"+err);
				//error이 있으면 실행
				if(error) error();
				else alert("포인트 샵 상품 삭제 중 오류 발생");
		    }
		});
	}
}