/**
 * 채팅내역을 불러오는 객체 생성
 */
 
 let historyservice={
 	"list":function(callback, error){
 		$.getJSON(
 		//ajax할 uri / (성공시 실행할 함수 / 오류 처리 함수)
 			"/chatajax/history.do?roomno="+roomno,
 			function(data){
 				if(callback) callback(data);
 			}
 		).fail(function(xhr, status, err){
 			console.log("*** 채팅 내역 로딩 중 오류 발생 ***")
			console.log("fail()-xhr: "+xhr);
			console.log("fail()-status: "+status);
			console.log("fail()-error: "+err);
 		});
 	}
 }