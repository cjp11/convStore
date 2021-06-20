<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%response.setContentType("text/html; charset=UTF-8");%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="게시물-상세보기" name="pageTitle"/>
</jsp:include>

<sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN','ROLE_ANON')">
	<sec:authentication property="principal.username" var="member_id"/>
	<sec:authentication property="principal.member_name" var="member_name"/>
</sec:authorize>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 글 상세보기</title>

<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.css?ver=1" />
<link rel="stylesheet" type="text/css" href="resources/css/boardStyle.css?ver=1" />

<style type="text/css">
#updateForm{display:none;}
</style>
<script type="text/javascript" src="resources/js/jquery-3.3.1.js"></script>  
<script type="text/javascript" src="resources/js/boardJs.js?ver=3"></script>
<script type="text/javascript" src="resources/ckeditor/ckeditor.js?ver=1"></script>

<script type="text/javascript">
   var loginId= "${member_id}";
   var loginGrade = "${member_grade}";
</script>

</head>

<body>

   <br></br>
   
   <!--detailForm_Area -->
   <div id="sty_wrap">
   <div id="detailForm">
      <div id="container" style="z-index:1">
         <table class="table">
            <colgroup>
            <!-- 형배_ 화면 중앙정렬 조정 -->
               <col width="5%">
               <col width="5%">
               <col width="10%">
               <col width="10%">
               <col width="10%">
            </colgroup>
            <thead>
            <tr>
               <th colspan="5" class="sty_dtlTit">${detail.b_title }</th>
               </tr>
               <tr class="sty_dtlTit2">
                  <th>&nbsp;</th>
                  <th>번호:${detail.b_no }</th>
                  <th>작성자:${detail.member_id }</th>
                  <th>작성일:<fmt:formatDate value="${detail.b_date }" pattern="yyyy.MM.dd" /></th>
                  <th>조회수:${detail.b_hits }</th>
               </tr>         
            </thead>
            <tbody>
               <tr>               
                  <td colspan="5">
                     <p class="sty_dtlCon">
                     ${detail.b_content }
                     </p>
                  </td>
               </tr>
            </tbody>
         </table>
         <!-- buttons -->
         <div class="sty_btnFt">
         <c:if test="${member_id == detail.member_id or member_grade =='ROLE_ADMIN' }">
            <button class="btn btn-primary sty_btnDel" onclick="boardDelete(${detail.b_no})">삭제</button>
            </c:if>
            <c:if test="${member_id == detail.member_id }">
            <button type="button" class="btn btn-default" onclick="updateForm();">수정</button>
            </c:if>
            
            <button type="reset" class="btn btn-default" onclick="location.href='BoardList.do?pageNo=1'">목록</button>
         </div>
         <!--//buttons  -->
      </div>
   </div>
   <!--// detailForm_Area -->         
   <!-- comment Area -->
   <div id="container" class="comList">
      <!-- comment Insert -->
      <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_USER')">
      <h3 class="sty_commTit">댓글을 남겨주세요</h3>
      <form name="answerForm">
         <div class="sty_commArea">
            <input type="hidden" name="b_no" value="${detail.b_no }">
            <input type="hidden" name="member_id" value="${member_id }">         
            <textarea maxlength="500" placeholder="댓글을 입력해주세요. 500자 이내로 작성 가능합니다." name="a_content"></textarea>
            <button type="button" class="btn btn-primary btn-lg sty_commBtn" name="answerBtn">등록</button>      
         </div>
      </form>
      </sec:authorize>

      <!--// comment Insert -->
      <div class="sty_commList sty_ft14"></div>   
   </div>
   <!--updateForm_Area -->
   <div id="updateForm">
      <div id="container">
         <form action="BoardUpdate.do" name="bdForm">
         <input type="hidden" name="b_no" value="${detail.b_no }">
            <table class="table">
               <colgroup>
                  <col width="30%">
                  <col width="5%">
                  <col width="10%">
                  <col width="15%">
                  <col width="10%">
               </colgroup>
               <thead>
               <tr>
                  <th colspan="5" class="sty_dtlTit"><input type="text" name="b_title" value="${detail.b_title }"></th>
                  </tr>
                  <tr class="sty_dtlTit2">
                     <th>&nbsp;</th>
                     <th>번호:${detail.b_no }</th>
                     <th>작성자:${detail.member_id }</th>
                     <th>작성일:<fmt:formatDate value="${detail.b_date }" pattern="yyyy.MM.dd" /></th>
                     <th>조회수:${detail.b_hits }</th>
                  </tr>         
               </thead>
               <tbody>
                  <tr>               
                     <td colspan="5">
                        <p class="sty_dtlCon">
                           <textarea rows="20" cols="40" name="b_content" id="b_content" class="txtarea form-control">${detail.b_content }</textarea>
                           <script type="text/javascript">
                         $(function(){
                             CKEDITOR.replace( 'b_content', {//해당 이름으로 된 textarea에 에디터를 적용
                                 width:'100%',
                                 height:'400px',
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
               <button class="btn btn-primary" onclick="return validCheck();">수정완료</button>
               <button type="button" class="btn btn-default" onclick="detailForm();">취소</button>
            </div>
            <!--//buttons  -->
         </form>
      </div>
   </div>
   <!--// updateForm_Area -->   
   <!-- footer -->
</div>
</body>
</html>