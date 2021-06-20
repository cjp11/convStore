<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="편의점마스터" name="pageTitle"/>
</jsp:include>

<sec:authorize access="hasAnyRole('ROLE_USER')">
	<sec:authentication property="principal.username" var="member_id"/>
	<sec:authentication property="principal.member_name" var="member_name"/>
</sec:authorize>
<style>
.container-fluid-master{
	position:relative;
	top:38px;
	min-height:1000px;
}
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
div.questionView-comment{
	width:638px;
	background: rgb(229, 228, 221);
}
div.questionView-comment.read{
	width:600px;
	margin:0 auto;
}
div.mypage{
   width:980px;
   margin:0 auto;
   
   min-height:780px;
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
   font-size:13.5px;
}

.col-sm-3 {
    max-width: 200px;
}
.nav-item-my>a{
	font-size:25px;
	font-family: 'Do Hyeon', sans-serif;
}
</style>
<script>
function fn_insertQuestion(){
	location.href="${pageContext.request.contextPath}/manager/insertQuestion.do?member_id="+'${question["member_id"] }'+"&question_no="+'${question["question_no"] }';
}

</script>
<div class="container-fluid-master">
	<div class="row">
		<nav class="col-md-2 d-none d-md-block bg-light sidebar">
			<div class="sidebar-sticky">
				<ul class="nav flex-column">
					<li class="nav-item-my"><a class="nav-link active"
						href="${pageContext.request.contextPath }/manager/managerPage.do">
							<span data-feather="home"></span> Home <span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item-my"><a class="nav-link"
						href="${pageContext.request.contextPath }/manager/memberManagement.do">
							<span data-feather="file"></span> 회원관리
					</a></li>
					<li class="nav-item-my"><a class="nav-link"
						href="${pageContext.request.contextPath }/manager/deletedMember.do">
							<span data-feather="shopping-cart"></span> 탈퇴회원목록
					</a></li>
					
					<li class="nav-item-my">
						<!-- wnth지워주세염 --> <a class="nav-link"
						href="${pageContext.request.contextPath }/manager/managerQuestion.do">
							<span data-feather="bar-chart-2"></span> 임의 사항
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
						<div class="tab-pane fade show active" id="list-home"
							role="tabpanel" aria-labelledby="list-question-list">
							<div id="questionView-container">
								<div class="questionView-title title">
									<div style="float: left;">
										<span>${question["question_title"]}</span> | 임의 사항
									</div>
									<div style="float: right;">
										${question["question_reg_date"] }</div>
								</div>

								<div class="questionView-title member">
									<span>${question["member_id"] }</span>
								</div>
								<br />
								<br />
								<div id="questionView-comment">
									${question["question_comment"]}</div>


							</div>
							<br /> <input type="button" class="btn btn-light" value="답변하기"
								style="float: left;" onclick="fn_insertQuestion();" />
						</div>
					</div>
				</div>
			</div>
		</div>






		</main>
	</div>
</div>
