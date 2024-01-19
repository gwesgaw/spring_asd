<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<sec:authentication property="principal.mvo.email" var="authEmail"/>
<div class="container-md">
<h1>Board Register Page</h1>
<form action="/board/register" method="post" enctype="multipart/form-data">
<div class="mb-3">
  <label for="title" class="form-label">Title</label>
  <input type="text" name="title" class="form-control" id="title" placeholder="title...">
</div>
<div class="mb-3">
  <label for="writer" class="form-label">Writer</label>
  <input type="text" name="writer" class="form-control" value="${authEmail}" id="writer">
</div>
<div class="mb-3">
  <label for="content" class="form-label">Content</label>
  <textarea class="form-control" name="content" id="content" rows="3"></textarea>
</div>

<!-- file 입력 라인 추가 -->
<div class="mb-3">
  <label for="file" class="form-label">files...</label>
  <input type="file" name="files" class="form-control" id="files" multiple="multiple" style="display: none;"><br>
  <!-- 파일 트리거 사용하기 위해서 주는 버튼 -->
  <button type="button" class="btn btn-primary" id="trigger">fileUpload</button>
</div>
<!-- 파일 목록 표시라인 -->
<div class="mb-3" id="fileZone">
</div>

<button type="submit" class="btn btn-primary" id="regBtn">등록</button>
</form>
<script src="/resources/js/boardRegister.js"></script>
</div>
<jsp:include page="../layout/footer.jsp"></jsp:include>