<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>

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
                            <div class="form-group">
                            	<label>번호</label> <input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly">
                            </div>
                            
                            
                            <div class="form-group">
                            	<label>제목</label> <input class="form-control" name="title" value='<c:out value="${board.title}"/>' readonly="readonly">
                            </div>
                            
                            <div class="form-group">
                            		<label>Content</label>
                            		<textarea rows="3" class="from-control" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>
                            </div>
                            
                            <div class="form-group">
                            		<label>Writer</label> <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
                            		
                            </div>
                            
                            <button data-oper="modify" class="btn btn-default">Modify</button>
                            <button data-oper="list" class="btn btn-info">List</button>
            			</div>
            		</div>
            	</div>
            </div>
        </div>
        <!-- content start -->

<%@include file="../includes/footer.jsp" %>