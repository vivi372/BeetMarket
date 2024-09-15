<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
  
  <!-- 리뷰 수정 모달 -->
  <div class="modal" id="reviewupdateModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 600px;">
      <div class="modal-content">
        <form id="reviewForm" action="update.do" method="post" enctype="multipart/form-data">
          
          <!-- Modal Header -->
          <div class="modal-header" style="background-color: #f8f9fa;">
            <h5 class="modal-title" id="reviewModalLabel">리뷰수정</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>

          <!-- Modal Body (Form) -->
          <div class="modal-body">
            
            
            <!-- 리뷰 내용 입력 -->
            <div class="form-group">
              <label for="reviewNo">리뷰번호</label>
              <input class="form-control" id="reviewNo" name="reviewNo" required 	
              		value="${vo.reviewNo }">
            </div>
           
           
            
            <!-- 리뷰 내용 입력 -->
            <div class="form-group">
              <label for="reviewContent">리뷰 내용</label>
              <textarea class="form-control" id="reviewContent" name="reviewContent" rows="4" required></textarea>
            </div>

            

            <!-- 별점 입력 -->
            <div class="form-group">
              <label for="starscore">별점</label>
              <input type="number" class="form-control" id="starscore" name="starscore" max="5" min="1" required>
            </div>



            <!-- 리뷰 이미지 업로드 -->
            <div class="form-group">
              <label for="reviewFile">리뷰 이미지</label>
              <input type="file" class="form-control" id="reviewFile" name="reviewFile">
            </div>
            
            
            
            <!-- 주문 번호 입력 -->
            <div class="form-group">
              <label for="orderNo">주문 번호</label>
              <input type="number" class="form-control" id="orderNo" name="orderNo" required>
            </div>
            
            
            
          </div>

          <!-- Modal Footer -->
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            <button type="submit" class="btn btn-primary">등록</button>
          </div>
        </form>
      </div>
    </div>
  </div>

