<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div class="container-md">
<h1>즐거운 이야기 게시판</h1>
<br>

<!-- 써치 -->
<div class="col-sm-12 col-md-6">
	<form action="#" method="get">
	<div class="input-group mb-3">
	<c:set value="${ph.pgvo.type}" var="typed"></c:set>
		<select name="type" class="form-select" id="inputGroupSelect01">
			<option ${ph.pgvo.type == null ? 'selected' : '' }>choose...</option>
			<option value="t" ${typed eq 't' ? 'selected' : '' }>title</option>
			<option value="w" ${typed eq 'w' ? 'selected' : '' }>writer</option>
			<option value="c" ${typed eq 'c' ? 'selected' : '' }>content</option>
			<option value="tw" ${typed eq 'tw' ? 'selected' : '' }>title&writer</option>
			<option value="tc" ${typed eq 'tc' ? 'selected' : '' }>title&content</option>
			<option value="wc" ${typed eq 'wc' ? 'selected' : '' }>writer&content</option>
			<option value="twc" ${typed eq 'twc' ? 'selected' : '' }>All</option>
		</select>
		<input type="text" name="keyword" value="${ph.pgvo.keyword }" placeholder="Search...">
		<input type="hidden" name="pageNo" value="1">
		<input type="hidden" name="qty" value="10">
		<button type="submit" class="btn btn-success">Search
		<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${ph.totalCount }</span>
		</button>
		</div>
	</form>
</div>

<table class="table">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">title</th>
      <th scope="col">writer</th>
      <th scope="col">commentCount</th>
      <th scope="col">fileCount</th>
      <th scope="col">regAt</th>
      <th scope="col">readCount</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach items="${list }" var="bvo">
    <tr>
      <th scope="row">${bvo.bno }</th>
      <td><a href="/board/detail?bno=${bvo.bno }">${bvo.title }</a></td>
      <td>${bvo.writer }</td>
      <td>${bvo.cmtQty }</td>
      <td>${bvo.hasFile }</td>
      <td>${bvo.regAt }</td>
      <td>${bvo.readCount }</td>
    </tr>
    </c:forEach>
  </tbody>
</table>

<!-- 페이지네이션 -->
<nav aria-label="Page navigation example">
  <ul class="pagination">
  <!-- 이전 -->
  <c:if test="${ph.prev }">
    <li class="page-item">
      <a class="page-link" href="/board/list?pageNo=${ph.startPage-1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    </c:if>
    
    <!-- 페이지 번호 -->
    <c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
    	<li class="page-item"><a class="page-link" href="/board/list?pageNo=${i }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}"> ${i } </a></li>
    </c:forEach>
    
    <!-- 다음 -->
    <c:if test="${ph.next }">
    <li class="page-item">
      <a class="page-link" href="/board/list?pageNo=${ph.endPage+1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
    </c:if>
    <li class="page-item">
      <a class="page-link" href="/board/list">
        <span aria-hidden="true">전체보기</span>
      </a>
    </li>
  </ul>
</nav>

<jsp:include page="../layout/footer.jsp"></jsp:include>