<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="pageTitle"/>
</jsp:include>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ef71da31f75cfbe631c83c174a6b3437&libraries=services"></script>
<script charset="UTF-8" type="text/javascript"
   src="https://t1.daumcdn.net/cssjs/postcode/1522037570977/180326.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/code/highcharts.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/code/modules/exporting.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/code/modules/export-data.js"></script>
<sec:authorize access="hasAnyRole('ROLE_USER')">
	<sec:authentication property="principal.username" var="member_id"/>
	<sec:authentication property="principal.member_name" var="member_name"/>
</sec:authorize>
<script src="${pageContext.request.contextPath }/resources/smarteditor/js/HuskyEZCreator.js" charset="UTF-8"></script>
<style>

div#update-container{
	width: 700px;
    /* margin: 0 auto; */
}
div#basket-container{
	width: 780px;
    /* margin: 0 auto; */
}
div#userId-container span.guide{
	display:none;
	font-size:12px;
	position:relative;
	top:12px;
	right:10px;
	margin-right:1000px;
}
div#userId-container span.ok{color:blue;}
div#userId-container span.error{color:orange;}
table#tbl_enroll {
	width: 980px
	margin: 0 auto;
}
#update-container h2 {
	text-align: left;
	padding-bottom: 30px;
	padding-top: 20px;
}
table#tbl_enroll input, table#tbl_enroll select{
	width: 500px;
}
div#btnDiv {
	text-align: center;
}

.list-group-item {
    position: relative;
    display: block;
    padding: .75rem 1.25rem;
    margin-bottom: -1px;
    background-color: #fff;
    border: 1px solid rgba(0,0,0,.125);
    width: 150px;
}
.mypage-detail{
	width:780px;
}
.sidenav {
    background-color: #fff; 
    height: 100%;
}
.number-hyelin {
	display:inline;
}
.table{
	width:780px;
}
.col-sm-3 {
    max-width: 200px;
}
.chart-master{
	width:780px;
}
.container-fluid-master{
	position:relative;
	top:38px;
	min-height:1000px;
}
.nav-item-my>a{
	font-size:20px;
	font-family: 'Do Hyeon', sans-serif;
}

</style>
<script>
//smarteditor 관련 설정
$(function(){
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
        oAppRef : oEditors,
        elPlaceHolder : "smarteditor",
        sSkinURI : "${pageContext.request.contextPath}/resources/smarteditor/SmartEditor2Skin.html",
        fCreator : "createSEditor2"
    });
    //전송버튼
    $("#insertBoard").click(function(){
        //id가 smarteditor인 textarea에 에디터에서 대입
        oEditors.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
        
        //간단한 유효성검사
        var title = $("#boardTitle").val().trim();
        var text = $("#smarteditor").val().trim();
        
        if(title==""){
        	alert("제목을 입력해주세요.");
        	return false;
        }
        if(text=="<p>&nbsp;</p>"){
        	alert("내용을 입력해주세요");
        	return false;
        }
        
        //폼 submit
        $("#insertBoardFrm").submit();
    });
    
});

function fn_cancelBoard(){
	if(confirm("현재 작성중인 게시글을 취소하시겠습니까?")==true){
		location.href="cancelBoard.do";
	}else{
		return false;
	}
	
}
</script>
 <div class="container-fluid-master">
      <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar">
          <div class="sidebar-sticky">
            <ul class="nav flex-column">
              <li class="nav-item-my">
                <a class="nav-link active" href="${pageContext.request.contextPath }/member/myPage.do?member_id=${member_id }">
                  <span data-feather="home"></span>
                  My Page <span class="sr-only">(current)</span>
                </a>
              </li>
              <li class="nav-item-my">
                <a class="nav-link" href="${pageContext.request.contextPath }/member/myPageMemberView.do?member_id=${member_id }">
                  <span data-feather="file"></span>
                  내정보
                </a>
              </li>
              <li class="nav-item-my">
                <a class="nav-link" href="${pageContext.request.contextPath }/member/myPageBasket.do?member_id=${member_id }">
                  <span data-feather="shopping-cart"></span>
                  장바구니
                </a>
              </li>
              
              <li class="nav-item-my">
              
                <a class="nav-link" href="${pageContext.request.contextPath}/member/selectMemberAddress.do?member_id=${member_id}">
                  <span data-feather="bar-chart-2"></span>
                  주소록관리
                </a>
              </li>
              <li class="nav-item-my">
              
                <a class="nav-link" href="${pageContext.request.contextPath }/member/myPageQuestion.do?member_id=${member_id }">
                  <span data-feather="bar-chart-2"></span>
                 임의 사항
                </a>
              </li>
              
            </ul>
          </div>
        </nav>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">


 <div class="mypage container">
	<div class="row">
	  
	<div class="col-8">

		<div id="insertBoard-container">
		
		<form action="insertEndQuestion.do" method="post" id="insertBoardFrm" enctype="multipart/form-data">
		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text" id="basic-addon1">제목</span>
		  </div>
		  <input type="text" class="form-control" id="boardTitle" name="boardTitle" aria-label="Username" aria-describedby="basic-addon1">
		</div>
		<div style="width:605px; margin:0 auto;">
		<textarea name="smarteditor" id="smarteditor" cols="30" rows="10" style="width:600px;height:500px;"></textarea>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="memberId" value="${member_id }" />
		<div style="text-align: center;">
			<button type="button" class="btn btn-success" id="insertBoard">제출</button>
			<button type="button" class="btn btn-danger" onclick="fn_cancelBoard()">취소</button>
		</div>
		</form>
		</div>
	</div>
	</div>
</div>
		  
        
         
        </main>
      </div>
    </div>
