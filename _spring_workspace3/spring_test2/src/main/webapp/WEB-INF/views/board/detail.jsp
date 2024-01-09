<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container-md">
<h1>게시판 상세보기</h1><br>
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
let bnoVal = `<c:out value="${bvo.bno}"/>`;
console.log(bnoVal);
</script>

<script src="/resources/js/boardComment.js"></script>
<script type="text/javascript">
spreadCommentList(bnoVal);
</script>

<jsp:include page="../layout/footer.jsp"></jsp:include>