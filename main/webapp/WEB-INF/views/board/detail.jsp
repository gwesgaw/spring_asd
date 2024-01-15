<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container-md">
<h1>게시판 상세보기</h1><br>
<c:set value="${bdto.bvo }" var="bvo"></c:set>
<div class="mb-3">
  <label for="bno" class="form-label">Bno</label>
  <input type="text" name="bno" class="form-control" id="bno" value="${bvo.bno }" readonly="readonly">
</div>
<div class="mb-3">
  <label for="title" class="form-label">Title</label>
  <input type="text" name="title" class="form-control" id="title" value="${bvo.title }" readonly="readonly">
</div>
<div class="mb-3">
  <label for="writer" class="form-label">Writer</label>
  <input type="text" name="writer" class="form-control" value="${bvo.writer }" readonly="readonly">
</div>
<div class="mb-3">
  <label for="regAt" class="form-label">reg_date</label>
  <span class="bodge text-bg-primary">조회수${bvo.readCount }</span>
  <input type="text" name="regAt" class="form-control" value="${bvo.regAt }" readonly="readonly">
</div>
<div class="mb-3">
  <label for="readCount" class="form-label">read_count</label>
  <input type="text" name="readCount" class="form-control" value="${bvo.readCount }" readonly="readonly">
</div>
<div class="mb-3">
  <label for="content" class="form-label">Content</label>
  <textarea class="form-control" name="content" id="content" rows="3" readonly="readonly">${bvo.content }</textarea>
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
							<a href="/upload/${fvo.saveDir}/${fvo.uuid}_${fvo.fileName}" download="${fvo.fileName}">
								<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-journal-arrow-down" viewBox="0 0 16 16">
		  							<path fill-rule="evenodd" d="M8 5a.5.5 0 0 1 .5.5v3.793l1.146-1.147a.5.5 0 0 1 .708.708l-2 2a.5.5 0 0 1-.708 0l-2-2a.5.5 0 1 1 .708-.708L7.5 9.293V5.5A.5.5 0 0 1 8 5z"/>
		  							<path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
		  							<path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
								</svg>
							</a>
						</div>
					</c:otherwise>
				</c:choose>
			<div class="ms-2 me-auto">
				<div class="fw-bold">${fvo.fileName }</div>
				<span class="badge rounded-pill text-bg-secondary">${fvo.fileSize }Byte</span>
			</div>
			</li>
		</c:forEach>
	</ul>
</div>

<a href="/board/list"><button type="button" class="btn btn-primary">List</button></a>
<a href="/board/modify?bno=${bvo.bno }"><button type="button" class="btn btn-success">modify</button></a>
<a href="/board/remove?bno=${bvo.bno }"><button type="button" class="btn btn-danger">delete</button></a>
<br>
<hr>
<br>

<!-- 댓글 등록 라인 -->
<div class="input-group mb-3" >
	<span id="cmtWriter" class="input-group-text">${bvo.writer }</span>
	<input type="text" id="cmtText" class="form-control" placeholder="Add Comment">
	<button type="button" id="cmtPostBtn" class="btn btn-outline-secondary">댓글 등록</button>
</div>
<br>

<!-- 댓글 표시 라인 -->
<div class="accordion" id="accordionExample">
  <div class="accordion-item">
    <h2 class="accordion-header">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
        no, cno, writer,reg_date 
      </button>
    </h2>
    <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <strong>Add Comment...</strong>
      </div>
    </div>
  </div>
</div>

<div>
	<button type="button" id="moreBtn" data-page="1">btn</button>
</div>
</div>

<!-- 모달창 -->
<div class="modal" id="myModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Writer</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      		<div class="input-group mb-3" >
      			<input type="text" id="cmtTextMod" class="form-control">
		        <button type="button" class="btn btn-primary" id="cmtModBtn">Post</button>
      		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<script type="text/javascript">
let bnoVal = `<c:out value="${bdto.bvo.bno}"/>`;
console.log(bnoVal);
</script>

<script src="/resources/js/boardComment.js"></script>
<script type="text/javascript">
spreadCommentList(bnoVal);
</script>

<jsp:include page="../layout/footer.jsp"></jsp:include>