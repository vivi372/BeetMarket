/**
 * 토스 결제 위젯 관련 js
 */

$(function(){
	main();
})
async function main() {
	const button = document.getElementById("orderSubmitBtn");
	
    // ------  결제위젯 초기화 ------
    const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
    const tossPayments = TossPayments(clientKey);
    // 회원 결제
    const customerKey = uuidv4();
    const widgets = tossPayments.widgets({
      customerKey,
    });

    // ------ 주문의 결제 금액 설정 ------
    await widgets.setAmount({
      currency: "KRW",
      value: 1000,
	});
	
    await Promise.all([
        // ------  결제 UI 렌더링 ------
        widgets.renderPaymentMethods({
          selector: "#payment-method",
          variantKey: "DEFAULT",
        }),
        // ------  이용약관 UI 렌더링 ------
        widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
     ]);

	button.addEventListener("click", async function () {
			
		let data = $("#writeForm").serializeArray();
		
		console.log(data);			
		let form = {
				  dlvyName: '',
				  recipient: '',
				  tel: '',
				  addr: '',
				  postNo: '',
				  items: [],  // goods 관련 항목들은 여기에 배열로 들어감
		};			
		data.forEach((item) => {
			if(item.name != 'dlvyMemo') {
				
			  if (item.name === 'goodsNo' || item.name === 'optNo' || item.name === 'amount' || item.name === 'orderPrice' || item.name === 'dlvyCharge') {
			    // items 배열에 해당하는 값을 그룹화하여 추가
			    if (form.items.length === 0 || form.items[form.items.length - 1][item.name]) {
				
			    	form.items.push({});
			    }
			    form.items[form.items.length - 1][item.name] = item.value;
			  } else {
			    // 공통 필드 처리
			    form[item.name] = item.value;
			  }
			} 
		});	
		
		let cnt = 0;
		data.forEach((x) => {
			if(x.name=='dlvyMemo') {
				form.items[cnt++]['dlvyMemo'] = x.value;				
			}
		});
		
		if(cnt < form.items.length) {
			form.items.forEach((item)=> {
				item['dlvyMemo'] = form.items[0]['dlvyMemo'];
			});
		}
		
		console.log(form);
		
		
			
		let base64Form = window.btoa(unescape(encodeURIComponent(JSON.stringify(form))));
			
			
		//location = "write.do?query="+encodeURIComponent(base64Form); 
		
		await widgets.requestPayment({
            orderId: uuidv4(),
            orderName:  $(".goodsTitle:first").text()+ " 외 "+$(".goodsTitle").length+"건",
            successUrl: window.location.origin + "/order/write.do?query="+base64Form ,
            failUrl: window.location.origin + "/order/write.do",
            customerEmail: "ym970825@naver.com",
         });
		
	});
}