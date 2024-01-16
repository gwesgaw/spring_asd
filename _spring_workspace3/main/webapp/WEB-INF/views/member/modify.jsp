<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>

<!-- email, pwd, nick_name -->
<div class="container-md">
<h2>Member Modify Page</h2>
<form action="/member/modify" method="post">

<div class="mb-3">
  <label for="e" class="form-label">email</label>
  <input type="text" name="email" class="form-control" id="e" value="${mvo.email }" readonly="readonly">
</div>

<div class="mb-3">
  <label for="p" class="form-label">pwd</label>
  <input type="text" name="pwd" class="form-control" id="p" placeholder="pwd">
</div>

<div class="mb-3">
  <label for="n" class="form-label">nick_name</label>
  <input type="text" name="nickName" class="form-control" id="n" value="${mvo.nickName }">
</div>

<!-- 해당 멤버의 권한을 출력(2개일 수도 있음) -->
<ul>
	<c:forEach items="${mvo.authList }" var="auth">
		<li>권한 : ${auth.auth } </li>
	</c:forEach>
</ul>

<button type="submit" class="btn btn-primary" id="modBtn">수정</button>
<a href="/member/delete?email=${mvo.email }"><button type="submit" class="btn btn-secondary">삭제</button></a>
</form>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>