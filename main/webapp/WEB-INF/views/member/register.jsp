<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<jsp:include page="../layout/header.jsp"></jsp:include>

<!-- email, pwd, nick_name -->
<div class="container-md">
<h2>Member Register Page</h2>
<form action="/member/register" method="post">

<div class="mb-3">
  <label for="e" class="form-label">email</label>
  <input type="text" name="email" class="form-control" id="e" placeholder="email">
</div>

<div class="mb-3">
  <label for="p" class="form-label">pwd</label>
  <input type="text" name="pwd" class="form-control" id="p" placeholder="pwd">
</div>

<div class="mb-3">
  <label for="n" class="form-label">nick_name</label>
  <input type="text" name="nickName" class="form-control" id="n" placeholder="nickName">
</div>

<button type="submit" class="btn btn-primary" id="regBtn">register</button>
</form>

<jsp:include page="../layout/footer.jsp"></jsp:include>