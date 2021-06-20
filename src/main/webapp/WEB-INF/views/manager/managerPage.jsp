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
<sec:authorize access="hasAnyRole('ROLE_USER')">
	<sec:authentication property="principal.username" var="member_id"/>
	<sec:authentication property="principal.member_name" var="member_name"/>
</sec:authorize>
<style>
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
/* 지도api관련 */
    .map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:780px;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
.map-card{
	width:780px;
}
.delivery-map{
	display:hidden;
}
</style>



<sec:authorize access="hasAnyRole('ROLE_USER')">
	<sec:authentication property="principal.username" var="member_id"/>
	<sec:authentication property="principal.member_name" var="member_name"/>
</sec:authorize>

<div class="mypage container">
	<div class="row">
		<div class="col-sm-3 sidenav">
			<div class="list-group" id="list-tab" role="tablist">
				<a class="list-group-item list-group-item-action active" id="list-home-list" href="${pageContext.request.contextPath }/manager/managerPage.do" role="tab" aria-controls="home">Home</a>
				<a class="list-group-item list-group-item-action" id="list-profile-list" href="${pageContext.request.contextPath }/manager/memberManagement.do" role="tab" aria-controls="profile">회원관리</a>
				<a class="list-group-item list-group-item-action" id="list-deletedMember-list" href="${pageContext.request.contextPath }/manager/deletedMember.do" role="tab" aria-controls="deletedMember">탈퇴회원목록</a> 
				<a class="list-group-item list-group-item-action" id="list-allEvent-list" href="#" role="tab" aria-controls="settings">전체이벤트</a> 
				<a class="list-group-item list-group-item-action" id="list-question-list" href="${pageContext.request.contextPath }/manager/managerQuestion.do" role="tab" aria-controls="question">임의 사항</a>
			</div>
		</div>
		<div class="col-8">
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="list-home"
					role="tabpanel" aria-labelledby="list-home-list">
					<!-- home -->
					<!-- chart넣을부분 -->
					<div class="card text-center chart-master">
						<div class="card-header">
							<ul class="nav nav-tabs card-header-tabs">
								<li class="nav-item"><a class="nav-link active" href="#">카테고리</a>
								</li>
							</ul>
						</div>
						<div class="card-body">
							<div id="ca-container"
								style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto">
								<!-- 이 부분에 차트 삽입 -->
							</div>
						</div>
					</div>

					<!-- chart넣을부분 끝-->

					<!-- 지도api시작 -->
					<!-- ---------------------------------------------------------------------------------------------------------------------------- -->

				</div>



			</div>
		</div>
	</div>
</div>


<br /><br /><br />

<script type="text/javascript">
/* 차트부분스크립트 */
// Make monochrome colors
var pieColors = (function () {
    var colors = [],
        base = Highcharts.getOptions().colors[0],
        i;

    for (i = 0; i < 10; i += 1) {
        // Start out with a darkened base color (negative brighten), and end
        // up with a much brighter color
        colors.push(Highcharts.Color(base).brighten((i - 3) / 7).get());
    }
    return colors;
}());


</script>
