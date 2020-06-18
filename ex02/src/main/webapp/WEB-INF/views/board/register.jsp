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
                            	글 등록
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            
                            <form role="form" action="/board/register" method="post">
                            	<div class="form-group">
                            		<label>Title</label> <input class="form-control" name="title">
                            	</div>
                            	
                            	<div class="form-group">
                            		<label>Content</label>
                            		<textarea rows="3" class="from-control" name="content"></textarea>
                            	</div>
                            	
                            	<div class="form-group">
                            		<label>Writer</label> <input class="form-control" name="writer">
                            		<button type="submit" class="btn btn-default">Submit</button>
                            		<button type="reset" class="btn btn-default">Reset Button</button>
                            	</div>
                            </form>
            			</div>
            		</div>
            	</div>
            </div>
        </div>
        <!-- content start -->

<%@include file="../includes/footer.jsp" %>