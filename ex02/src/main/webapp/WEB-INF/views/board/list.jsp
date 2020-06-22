<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>

<script>
	$(document).ready(function() {
		var result = '<c:out value="${result}"/>';
		
		checkModal(result);	//함수호출
		
		history.replaceState({}, null, null);	// history.statue를 null 로 변경
		
		function checkModal(result) {
			if(result === '' || history.state) {
				return;
			}
			if(parseInt(result) > 0) {
				$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			}
			
			$("#myModal").modal("show");
		}
		
		 //등록화면으로 이동
	      $("#regBtn").on("click", function(){
	         self.location = "/board/register";
	      });
		 
		 // 페이징
		  var actionForm = $("#actionForm");
		 
		 $(".paginate_button a").on("click", function(e) {
			 e.preventDefault();
			 console.log('click');
			 actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			 actionForm.submit();
		 }); 
		 
		// 게시물 조회를 위한 이벤트 처리 추가
		$(".move").on("click", function(e) {
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='" +
					$(this).attr("href")+"'>'");
			actionForm.attr("action", "/board/get");
			actionForm.submit();
		})

		 // 전송
		 var searchForm = $("#searchForm");
		
		
		
		$("#searchForm button").on("click", function(e){
			
			e.preventDefault();
			
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요");
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요");
				return false;
			}
			
			var amount = $("#cntPerPage").val();
			
			searchForm.find("input[name='pageNum']").val("1");
			searchForm.find("input[name='amount']").val(amount);
			
			searchForm.submit();
			
		})

	});
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
                            <button id='regBtn' type="button" class="btn btn-primary btn-xs pull-right">글쓰기</button>
                            
                  			
                            
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>#번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>
                                <c:forEach items="${list}" var="board">
                                	<tr>
                                		<td><c:out value="${board.bno}"/></td>
                                		<td><a class="move" href='<c:out value="${board.bno}"/>'>
                                		<c:out value="${board.title}"/></a></td>
                                		<td><c:out value="${board.writer}"/></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }"/></td>
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
                                	</tr>
                                </c:forEach>
                            </table>
                            
                            <!-- 검색용  --------------------------------------->
                            
                            <div class="row">
                            	<div class="col-lg-12">
                            		
                            		<form id='searchForm' action="/board/list" method='get'>
                            			<select name='type'>
                            				<option value=" ">--</option>
                            				<option value="T">제목</option>
                            				<option value="C">내용</option>
                            				<option value="W">작성자</option>
                            				<option value="TC">제목 or 내용</option>
                            				<option value="TW">제목 or 작성자</option>
                            				<option value="TWC">제목 or 내용 or 작성자</option>
                            			</select>
                            			<input type="text" name="keyword"/>
                            			<input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum}'>
                            			<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
                            			<button class='btn btn-default'>Search</button>
                            			
                            			<select id="cntPerPage" class="pull-right" onchange="selChange()">
			                  				<option value="5"> 5 </option>
			                  				<option value="10" selected> 10 </option>
			                  				<option value="15"> 15 </option>
			                  				<option value="20"> 20 </option>
			                  			</select>	
                            		</form>
                            		
                            	</div>
                            </div>
                            
                            <!-- 검색용 -->
                            
                            <div class='pull-right'>
                            	<ul class="pagination">
                            		
                            		<c:if test="${pageMaker.prev}">
                            			<li class="paginate_button previous">
                            				<a href="${pageMaker.startPage - 1}">Previous</a>
                            			</li>
                            		</c:if>
                            		
                            		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                            			<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}">
                            				<a href="${num}">${num}</a>
                            			</li>
                            		</c:forEach>                            		
                            		
                            		<c:if test="${pageMaker.next}">
                            			<li class="paginate_button next">
                            				<a href="${pageMaker.endPage + 1}">Next</a>
                            			</li>
                            		</c:if>
                            		
                            		</ul>
                            </div>
                            
                            <form id='actionForm' action="/board/list" method="get">
                            	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                            	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                            	<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
                            	<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
                            </form>
                            		
                            <!-- 모달창 ---------------------------- -->
                            <div id="myModal" class="modal fade" role="dialog">
							  <div class="modal-dialog">
							
							    <!-- Modal content-->
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal">&times;</button>
							        <h4 class="modal-title">알림</h4>
							      </div>
							      <div class="modal-body">
							        <p>처리가 완료되었습니다.</p>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							      </div>
							    </div>
							
							  </div>
							</div>
                            <!-- 모달창 -->
            			</div>
            		</div>
            	</div>
            </div>
        </div>
        <!-- content start -->

<%@include file="../includes/footer.jsp" %>