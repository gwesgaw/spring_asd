<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container-md">
<h1>게시판 수정</h1>
<form action="/board/modify" method="post">
<div class="mb-3">
  <label for="bno" class="form-label">Bno</label>
  <input type="text" name="bno" class="form-control" id="bno" value="${bvo.bno }" readonly="readonly">
</div>
<div class="mb-3">
  <label for="title" class="form-label">Title</label>
  <input type="text" name="title" class="form-control" id="title" value="${bvo.title }">
</div>
<div class="mb-3">
  <label for="writer" class="form-label">Writer</label>
  <input type="text" name="writer" class="form-control" value="${bvo.writer }" readonly="readonly">
</div>
<div class="mb-3">
  <label for="writer" class="form-label">reg_date</label>
  
  <input type="text" name="reg_date" class="form-control" value="${bvo.regAt }" readonly="readonly">
</div>
<div class="mb-3">
  <label for="writer" class="form-label">read_count</label>
  <input type="text" name="read_count" class="form-control" value="${bvo.readCount }" readonly="readonly">
</div>
<div class="mb-3">
  <label for="content" class="form-label">Content</label>
  <textarea class="form-control" name="content" id="content" rows="3">${bvo.content }</textarea>
</div>

<button type="submit" class="btn btn-success" id="regBtn">modify</button>
<a href="/board/list"><button type="button" class="btn btn-primary">List</button></a>
</form>
</div>

<jsp:include page="../layout/footer.jsp"></jsp:include>