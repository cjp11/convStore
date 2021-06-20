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

div#question_container{
	text-align: center;
}
div#question_container tr th{
	text-align: center;
}
div.mypage{
   width:100%;
   margin:0;
   
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
   width:100%;
   font-size:13.5px;
}

.col-sm-3 {
    max-width: 200px;
}
.chart-master{
   width:780px;
}

.center-hyelin {
   text-align: center;
   margin-top: 15px;
}
.border-bottom-hyelin {
   border-bottom: 1px solid rgba(0,0,0,.1);
}
.padding-hyelin{
   padding-bottom: 20px !important;
   padding-top: 20px !important;
}
.btnBuy {
   width: 100%;
}
.nav-item-my>a{
	font-size:20px;
	font-family: 'Do Hyeon', sans-serif;
}
.container-fluid-master{
	position:relative;
	top:38px;
	min-height:1000px;
}
</style>


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
						<a class="nav-link"
						href="${pageContext.request.contextPath }/manager/managerQuestion.do">
							<span data-feather="bar-chart-2"></span> 임의 사항
					</a>
					</li>

				</ul>
			</div>
		</nav>

		<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
		<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h3>임의 사항</h3>
            
          </div>
		<div class="mypage container">
			<div class="row"></div>
		
						<div id="question_container">
						
							<table class="table table-striped">
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>아이디</th>
									<th>날짜</th>
								</tr>
								<c:if test="${list !=null }">
									<c:forEach items="${list }" var="f">
										<tr>
											<td>${f["question_no"] }</td>
											<td style="text-align: left;"><a
												href="managerQuestionView.do?no=${f['question_no']}"
												style="color: black;"> ${f["question_title"] } </a></td>
											<td>${f["member_id"]}</td>
											<td>${f["question_reg_date"] }</td>
										</tr>

									</c:forEach>
								</c:if>
							</table>
							<br />
							<!-- 페이지바 -->
							<%
				int count = Integer.parseInt(String.valueOf(request.getAttribute("count")));
				int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
				int cPage = 1;
				try{
					cPage = Integer.parseInt(request.getParameter("cPage"));
				}catch(NumberFormatException e){
					
				}
			%>
							<%=com.example.demo.utill.Utils.getPageBar(count,cPage,numPerPage,"managerQuestion.do")%>
						</div>
					
		</div>
	</div>







</div>


