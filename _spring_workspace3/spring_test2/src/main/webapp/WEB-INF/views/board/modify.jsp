<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container-md">
<h1>게시판 수정</h1>
<c:set value="${bdto.bvo }" var="bvo"></c:set>
<form action="/board/modify" method="post" enctype="multipart/form-data">
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

<!-- file line -->
<c:set value="${bdto.flist }" var="flist"></c:set>
<div class="mb-3">
	<label for="f" class="form-label">File</label>
	<ul class="list-group list-group-flush">
		<c:forEach items="${flist }" var="fvo">
			<li class="list-group-item">
				<c:choose>
					<c:when test="${fvo.fileType == 1 }">
						<div>
							<img alt="" src="/upload/${fvo.saveDir }/${fvo.uuid}_th_${fvo.fileName}">
						</div>
					</c:when>
					<c:otherwise>
						<div>
							<!-- 일반 파일 표시할 아이콘 -->
							<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-journal-arrow-down" viewBox="0 0 16 16">
	  							<path fill-rule="evenodd" d="M8 5a.5.5 0 0 1 .5.5v3.793l1.146-1.147a.5.5 0 0 1 .708.708l-2 2a.5.5 0 0 1-.708 0l-2-2a.5.5 0 1 1 .708-.708L7.5 9.293V5.5A.5.5 0 0 1 8 5z"/>
	  							<path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
	  							<path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
							</svg>
						</div>
					</c:otherwise>
				</c:choose>
			<div class="ms-2 me-auto">
				<div class="fw-bold">${fvo.fileName }</div>
				<span class="badge rounded-pill text-bg-secondary">${fvo.fileSize }Byte</span>
				<button type="button" data-uuid="${fvo.uuid }" class="btn btn-outline-danger file-x">X</button>
			</div>
			</li>
		</c:forEach>
	</ul>
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

<button type="submit" class="btn btn-success" id="regBtn">modify</button>
<a href="/board/list"><button type="button" class="btn btn-primary">List</button></a>
</form>
</div>
<script src="/resources/js/boardRegister.js"></script>
<script src="/resources/js/boardModify.js"></script>

<jsp:include page="../layout/footer.jsp"></jsp:include>