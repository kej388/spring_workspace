<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>
<script>
	$(document).ready(function() {
		var formObj = $("form");	// form 태그를 찾음
		$('button').on("click", function(e) {
			e.preventDefault();	// 전송을 막음
			
			var operation = $(this).data("oper");	// data-oper 속성값을 구함
			
			console.log(operation);
			
			if(operation === 'remove') {
				formObj.attr("action", "/board/remove");	// form의 action값을 변경
			} else if(operation === 'list') {
				// move to list
				// self.location = '/board/list';
				formObj.attr("action", "/board/list").attr("method", "get");
				formObj.empty();
				//return;
			}
			formObj.submit();
		}) 
	})
	
</script>

		<!-- content start ------------------ -->
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board List Page
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<form role="form" action='/board/modify' method="post">
                            <div class="form-group">
                            	<label>번호</label> <input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly">
                            </div>
                            
                            
                            <div class="form-group">
                            	<label>제목</label> <input class="form-control" name="title" value='<c:out value="${board.title}"/>'>
                            </div>
                            
                            <div class="form-group">
                            		<label>Content</label>
                            		<textarea rows="3" class="from-control" name="content"><c:out value="${board.content}"/></textarea>
                            </div>
                            
                            <div class="form-group">
                            		<label>Writer</label> <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
                            		
                            </div>
                            
                            <div class="form-group">
                            	<label>Date</label>
                            	<input class="form-control" name='regDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate }"/>' readonly="readonly">
                            </div>
                            
                            <div class="form-group">
                            	<label>Update Date</label>
                            	<input class="form-control" name='updateDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate }"/>' readonly="readonly">
                            </div>
                            
                            <button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
                            <button type="submit" data-oper='remove' class="btn btn-default">Remove</button>
                            <button type="submit" data-oper="list" class="btn btn-info">List</button>
                            </form>
            			</div>
            		</div>
            	</div>
            </div>
        </div>
        <!-- content start -->

<%@include file="../includes/footer.jsp" %>