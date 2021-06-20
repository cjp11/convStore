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
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js?autoload=false"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ef71da31f75cfbe631c83c174a6b3437&libraries=services"></script>
<script charset="UTF-8" type="text/javascript"
   src="https://t1.daumcdn.net/cssjs/postcode/1522037570977/180326.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/code/highcharts.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/code/modules/exporting.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/code/modules/export-data.js"></script>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<sec:authorize access="hasAnyRole('ROLE_USER')">
	<sec:authentication property="principal.username" var="member_id"/>
	<sec:authentication property="principal.member_name" var="member_name"/>
</sec:authorize>
<style>
div#questionView-container{
	width:640px;
	min-height:500px;
	margin:0 auto;
	border:1px solid lightgray;
}
div.questionView-title{
	width:590px;
	height:30px;
}
div.questionView-title.title{
	margin:20px 20px 0px 20px;
	border-bottom: 1px dotted lightgray;
}
div.questionView-title.title span, div.questionView-title.member span{
	font-size: 15sp;
	font-weight: bold;
}
div.questionView-title.member{
	margin:10px 10px 10px 20px;
}
div#questionView-comment{
	width:638px;
	background: rgb(229, 228, 221);
}
div#questionView-comment.read{
	width:600px;
	margin:0 auto;
}
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
function fn_insertQuestion(){
	location.href="${pageContext.request.contextPath}/member/insertQuestion.do";
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
	    <div class="tab-content" id="nav-tabContent">
	      <div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-question-list">
				<div id="questionView-container">
					<div class="questionView-title title">
						<div style="float:left;">
							<span>${question["question_title"]}</span>
							임의 사항
						</div>
						<div style="float:right;">
							${question["question_reg_date"] }
						</div>
					</div>
					
					<div class="questionView-title member">
						<span>관리자</span>
					</div>
					<br /><br />
					<div id="questionView-comment">
						${question["question_comment"]}
					</div>
				
					
				</div>
			</div>
		</div>
	</div>
</div>
</div>
		  
        
         
        </main>
      </div>
    </div>
