/**
 * 채팅내역 로딩 객체인 history를 호출하여 실질적인 jsp 내용 채우기
 */
 
 function showhistory(roomno){
 	historyservice.list(roomno,
 		function(data){	//성공시 실행하는 함수 -> callback
 			let list=data.list;
			let str="";
			if(list==null||list.length==0){
				$(".reply").html("<li>데이터가 존재하지 않습니다.</li>");
				$(".pagination").html("");
				return;
			}
			
			//채팅이 있는 경우, 하나씩 div 생성
			for(let i=0;i<list.length;i++){
				str+=`
				
				`;
			}
 		}
 	)
 }