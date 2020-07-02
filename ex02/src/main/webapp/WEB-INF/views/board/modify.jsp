<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>
<div class='bigPictureWrapper'>
	<div class='bigPicture'>
	
	</div>
</div>
<script>
	function showUploadResult(uploadResultArr){
		if(!uploadResultArr || uploadResultArr.length == 0) {
			return;
		}
		
		var uploadUL = $(".uploadResult ul");
		
		var str ="";
		
		$(uploadResultArr).each(function(i, obj){
			if(obj.image){
				
				var fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				
				str += "<li data-path='" + obj.uploadPath + "'";
				str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'data-type='" + obj.image + "'";
				str += "><div><span>" + obj.fileName + "</span>";
				str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName=" + fileCallPath + "'></div></li>";
				
				
			} else {
				
				//str += "<li>" + obj.fileName + "</li>";
				var fileCallPath = encodeURIComponent( obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				
				var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
				
				var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
				console.log(originPath);
				
				originPath = originPath.replace(new RegExp(/\\/g), "/");
				console.log(originPath);
				
				str += "<li";
				str += " data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'><div>";
				str += "<span>" + obj.fileName + "</span>";
				str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.png'></div></li>";
				
			}
		})
		uploadUL.append(str);
	}

	$(document).ready(function() {
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;
		
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업도드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		(function(){
			var bno = '<c:out value="${board.bno}"/>';
			
			$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
				console.log(arr);
				
				var str = "";
				
				$(arr).each(function(i, attach){
					
					if(attach.fileType){
						var fileCallPath = encodeURIComponent( attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
						
						str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "' ><div>";
						str += "<span> " + attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' ";
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?fileName=" + fileCallPath + "'></div></li>";
					} else {
						str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "' ><div>";
						str += "<span> " + attach.fileName + "</span><br/>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' ";
						str += "<class='btn' btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						
						str += "<img src='/resources/img/attach.png'></div></li>";
					}
					
				})
				
				$(".uploadResult ul").html(str);
			})
		})();
		
		var formObj = $("form");	// form 태그를 찾음
		$('button').on("click", function(e) {
			e.preventDefault();	// 전송을 막음
			
			var operation = $(this).data("oper");	// data-oper 속성값을 구함
			
			console.log(operation);
			
			/* if(operation === 'remove') {
				
				var removeCheck = confirm("삭제하시겠습니까?");
				
				if(removeCheck == true) {
					formObj.attr("action", "/board/remove");
				} else {
					return false;
				}
				
				
					// form의 action값을 변경
			} else  */if(operation === 'list') {
				// move to list
				// self.location = '/board/list';
				formObj.attr("action", "/board/list").attr("method", "get");
				
				var pageNumTag = $("input[name='pageNum']").clone();
				var amoutTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				
				formObj.empty();
				//return;
				
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			} else if(operation == 'modify') {
				console.log("submit clicked");
				
				var str = "";
				
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					
					console.log(jobj);
					
					str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("path") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + jobj.data("type") + "'>";
				})
				formObj.append(str).submit();
			}
			formObj.submit();
		}) 
		
		$(".uploadResult").on("click", "button", function(e){
			console.log("delete file");
			
			if(confirm("Remove this file?")){
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
		})
		
		$("input[type='file']").change(function(e){
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			for(var i = 0; i < files.length; i++){
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				data:formData,
				type:'POST',
				dataType: 'json',
				success: function(result){
					console.log(result);
					showUploadResult(result);
				}
			})
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
                        	
                        	<!-- 추가 -->
                        	<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
                        	<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
                        	<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
                        	<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
                        	
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
                            <!-- <button type="submit" data-oper='remove' class="btn btn-default">Remove</button> -->
                            <button type="submit" data-oper="list" class="btn btn-info">List</button>
                            </form>
            			</div>
            		</div>
            	</div>
            </div>
        
        	<div class="row">
      			<div class="col-lg-12">
      				<div class="panel panel-default">
      					
      					<div class="panel-heading">Files</div>
      					
      					<div class="panel-body">
      						<div class="form-group uploadDiv">
      							<input type="file" name="uploadFile" multiple="multiple">
      						</div>
      					
      						<div class="uploadResult">
      							<ul>
      							</ul>
      						</div>
      					</div>
      					
      				</div>
      			</div>
      		</div>
        </div>
        <!-- content start -->

<%@include file="../includes/footer.jsp" %>