<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container-md">

	<br>
	<h2>상세페이지</h2>
	<br>
	<div class="mb-3">
		<label for="bno" class="form-label">번호</label> <input type="text"
			name="bno" class="form-control" id="bno" value="${bvo.bno }"
			readonly="readonly">
	</div>
	<div class="mb-3">
		<label for="title" class="form-label">제목</label> <input type="text"
			name="title" class="form-control" id="title" placeholder="title"
			value="${bvo.title }">
	</div>
	<div class="mb-3">
		<label for="writer" class="form-label">작성자</label> <input
			type="text" name="writer" class="form-control" id="writer"
			value="${bvo.writer }" readonly="readonly">
	</div>
	<div class="mb-3">
		<label for="regAt" class="form-label">작성일</label> <input
			type="text" name="regAt" class="form-control" id="regAt"
			value="${bvo.regAt }" readonly="readonly"> <span
			class="badge bg-secondary">${bvo.readCount}</span>
	</div>
	<div class="mb-3">
		<label for="content" class="form-label">내용</label>
		<textarea class="form-control" name="content" id="content" rows="3">${bvo.content }</textarea>
	</div>
	
	<div class="position-relative">
	<div class="position-absolute bottom-0 end-0">
		<a href="/board/modify?bno=${bvo.bno }"><button type="button" class="btn btn-primary">게시글수정</button></a> 
		<a href="/board/list"><button type="button" class="btn btn-secondary">리스트로..</button></a>
	</div>
	</div>
	<br>

	<!-- 댓글 등록 라인 -->
	<div class="input-group mb-3">
		<span class="input-group-text" id="cmtWriter">Writer</span> 
		<input type="text" class="form-control" id="cmtText" aria-label="Amount (to the nearest dollar)">
		<button type="button" class="btn btn-success" id="cmtPostBtn">등록</button>
	</div>

	<!-- 댓글 표시 라인 -->
	<ul class="list-group list-group-flush" id="cmtListArea">
		<li class="list-group-item">
			<div class="mb-3">
				<div class="fw-bold">Writer <span class="badge rounded-pill text-bg-warning">modAt</span></div>
				content
			</div>
		</li>
	</ul>
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