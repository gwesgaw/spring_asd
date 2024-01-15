<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>

<!-- email, pwd, nick_name -->
<div class="container-md">
<h2>Member Register Page</h2>
<form action="/member/login" method="post">

<div class="mb-3">
  <label for="e" class="form-label">email</label>
  <input type="text" name="email" class="form-control" id="e" placeholder="email">
</div>

<div class="mb-3">
  <label for="p" class="form-label">pwd</label>
  <input type="text" name="pwd" class="form-control" id="p" placeholder="pwd">
</div>

<button type="submit" class="btn btn-primary">Login</button>
</form>

<c:if test="${not empty param.errMsg }">
 <div class="mb-3 text-danger">
 	<c:choose>
 		<c:when test="${param.errMsg eq 'Bad credentials'}">
 			<c:set value="이메일 & 비밀번호가 일치하지 않습니다." var="errText"></c:set>
 		</c:when>
 		<c:otherwise>
 			<c:set value="관리자에게 문의해주세요" var="errText"></c:set>
 		</c:otherwise>
 	</c:choose>
 	${errText }
 </div>
</c:if>

<jsp:include page="../layout/footer.jsp"></jsp:include>