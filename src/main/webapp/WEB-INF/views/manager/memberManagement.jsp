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
div.mypage{
	width:100%;
	margin:0;
	
	min-height:780px;
}
.col-sm-3 {
    max-width: 200px;
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
table {
   margin: 0 auto;
   border: 1px solid #ddd;
   border-collapse: collapse;
   width:780px;
}

table tr {
   border: 1px solid #ddd;
}

table tr:hover {
   border: 1px solid #ddd;
   background: #FFEAEA;
}

table tr th {
   border: 1px solid #ddd;
   background: lightblue;
   padding: 18px;
}

table tr td {
   border: 1px solid #ddd;
   padding: 12px;
   font-size: 15px;
}

.table-dh{
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



<sec:authorize access="hasAnyRole('ROLE_USER')">
	<sec:authentication property="principal.username" var="member_id"/>
	<sec:authentication property="principal.member_name" var="member_name"/>
</sec:authorize>

<script>
   $(function() {
      $("tr[no]").on("click",function() {
         console.log($(this).attr("no"));
         location.href = "${pageContext.request.contextPath}/manager/managerView.do?member_id="
               + $(this).attr("no");
      });
   });
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
            <h3>회원관리</h3>
            
          </div>

		<div class="mypage container">
			<div class="row">
				
					
							<br />
						

								<p class="imsosotired2">총 회원 수 : ${totalContents }명</p>

								<table class="table-dh">
									<tr>
										<th>아이디</th>
										<th>이름</th>
										<th>성별</th>
										<th>생년월일</th>
										<th>전화번호</th>
										<th>이메일</th>
										<th>가입일</th>
										<th>회원등급</th>
									</tr>
									<c:forEach items="${list}" var="m">
										<tr no="${m.member_id }">
											<td>${m.member_id }</td>
											<td>${m.member_name }</td>
											<td>${m.member_gender }</td>
											<td>${m.member_birthday }</td>
											<td>${m.member_phone }</td>
											<td>${m.member_email }</td>
											<td>${m.member_enrollDate }</td>
											<td>${m.member_grade }</td>

										</tr>
									</c:forEach>

								</table>

								<br />
								<ul class="pagination justify-content-center pagination-sm"
									style="clear: both;margin: auto;margin-top: 100px;">
									<!-- 페이지바 -->
									<%
	               int totalContents = Integer.parseInt(String.valueOf(request.getAttribute("totalContents")));
	               int numPerPage = Integer.parseInt(String.valueOf(request.getAttribute("numPerPage")));
	               int cPage = 1;
	               try {
	                  cPage = Integer.parseInt(request.getParameter("cPage"));
	               } catch (NumberFormatException e) {
	
	               }
	            %>
									<%=com.example.demo.utill.Utils.getPageBar(totalContents, cPage, numPerPage, "memberManagement.do")%>
								</ul>
						

					

				
			</div>
		</div>






		</main>
	</div>
</div>

