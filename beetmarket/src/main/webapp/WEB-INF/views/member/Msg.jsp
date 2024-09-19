<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
	<!-- msg를 표시할 모달 창 -->
	<!-- The Modal -->
	<div class="modal" id="msgModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">처리 결과 모달 창</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        ${msg }
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>

	<c:if test="${ !empty msg }">
		<!-- 모달을 보이게하는 javascript -->
		<script type="text/javascript">
			$(function(){
				$("#msgModal").modal("show");
			});
		</script>
	</c:if>