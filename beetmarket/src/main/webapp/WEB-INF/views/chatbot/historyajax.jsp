<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
	<div class="card">
	    <div class="card-header">
	    	<h3>${partner }</h3>
	    </div>
	    <div class="card-body">
	    <c:forEach items="${histroylist}" var="vo">
	        <c:if test="${vo.sender == login.id}">
	         <div class="row">
	         	<div class="col-5"></div>
	            <div class="message-box border text-right col-7" style="float: right;">
	                <small>${vo.sender}</small>
	                <p>${vo.content}</p>
	            </div>
	         </div>
	        </c:if>
	        <c:if test="${vo.sender != login.id}">
	        <div class="row">
	            <div class="message-box border text-left col-7">
	                <small>${vo.sender}</small>
	                <p>${vo.content}</p>
	            </div>
	       		<div class="col-5"></div>
	        </div>
	        </c:if>
	    </c:forEach>
	    </div>
	</div>