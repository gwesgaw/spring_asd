<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container-md">
<br><br>
<h2>글쓰기페이지</h2>
<br>
<form action="/board/register" method="post">

<div class="mb-3">
  <label for="title" class="form-label">제목</label>
  <input type="text" name="title" class="form-control" id="title" placeholder="제목을 작성해주세요...">
</div>

<div class="mb-3">
  <label for="writer" class="form-label">작성자</label>
  <input type="text" name="writer" class="form-control" id="writer">
</div>

<div class="mb-3">
  <label for="content" class="form-label">내용</label>
  <textarea class="form-control" name="content" id="content" rows="3" placeholder="내용을 작성해주세요..."></textarea>
</div>

<a href="/"><button type="button" class="btn btn-secondary">취소</button></a>
<button type="submit" class="btn btn-secondary" id="regBtn">전송</button>

</form>
</div>

<br><br>

<jsp:include page="../layout/footer.jsp"></jsp:include>