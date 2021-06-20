<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%response.setContentType("text/html; charset=UTF-8");%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글 입력화면" name="pageTitle"/>
</jsp:include>

<sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
	<sec:authentication property="principal.username" var="member_id"/>
	<sec:authentication property="principal.member_name" var="member_name"/>
</sec:authorize>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 글작성</title>
</head>

<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.css?ver=1" />
<link rel="stylesheet" type="text/css" href="resources/css/boardStyle.css?ver=1" />
<script type="text/javascript" src="resources/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="resources/js/boardJs.js?ver=3"></script>
<script type="text/javascript" src="resources/ckeditor/ckeditor.js"></script>

<body>

	<br></br>
	<br></br>
	
	<div id="container">
		<form action="BoardInsert.do" name="bdForm">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="member_id" value="${member_id}">
			<table class="table">
				<colgroup>
					<col width="80%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th colspan="2" class="sty_dtlTit"><input type="text" name="b_title"></th>
					</tr>
					<tr class="sty_dtlTit2">
						<th>&nbsp;</th>
						<th>작성자 : ${member_id}</th>
					</tr>

				</thead>
				<tbody>
					<tr>
						<td colspan="2" style="padding:0">
							<p class="sty_dtlCon">
								<textarea rows="20" cols="40" name="b_content" id="b_content" class="sty_txtarea form-control"></textarea>
								<script type="text/javascript">
							    $(function(){
							         
							        CKEDITOR.replace( 'b_content', {//해당 이름으로 된 textarea에 에디터를 적용
							            width:'100%',
							            height:'500px',
							            filebrowserImageUploadUrl: 'imageUpload.do' //여기 경로로 파일을 전달하여 업로드 시킨다.
							        });
							         
							         
							        CKEDITOR.on('dialogDefinition', function( ev ){
							            var dialogName = ev.data.name;
							            var dialogDefinition = ev.data.definition;
							          
							            switch (dialogName) {
							                case 'image': //Image Properties dialog
							                    //dialogDefinition.removeContents('info');
							                    dialogDefinition.removeContents('Link');
							                    dialogDefinition.removeContents('advanced');
							                    break;
							            }
							        });
							         
							    });
								</script>
							</p>
						</td>
					</tr>
				</tbody>
			</table>
			
			<!-- buttons -->	
			<div class="sty_btnFt">
				<button class="btn btn-primary" onclick="return validCheck();">등록</button>
				<button type="reset" class="btn btn-default" onclick="boardList()">취소</button>
			</div>
			<!-- //buttons -->					
		</form>
	</div>
		
</body>
</html>