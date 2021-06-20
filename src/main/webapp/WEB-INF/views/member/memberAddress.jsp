<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="" name="pageTitle"/>
</jsp:include>
<sec:authorize access="hasAnyRole('ROLE_USER')">
	<sec:authentication property="principal.username" var="member_id" />
	<sec:authentication property="principal.member_name" var="member_name" />
</sec:authorize>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script charset="UTF-8" type="text/javascript"
   src="https://t1.daumcdn.net/cssjs/postcode/1522037570977/180326.js"></script>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<style>
.width980-hyelin {
	width: 980px;
	margin: 0;
}
.verticalMiddle-hyelin {
	vertical-align: middle !important;
}
.verticalMiddle-hyelin img {
	margin-left: 20px;
}
.guide-hyelin {
	display: none;
}
#addressInfo {
	visibility: hidden;
}
#submitBtn {
	float: right;
	margin-top: 5px;
}
.container-fluid-master{
	position:relative;
	top:30px;
	min-height:1000px;
}
.nav-item-my>a{
	font-size:20px;
	font-family: 'Do Hyeon', sans-serif;
}
</style>      
<div class="container-fluid-master">
	<div class="row">
		<nav class="col-md-2 d-none d-md-block bg-light sidebar">
			<div class="sidebar-sticky">
				<ul class="nav flex-column">
					<li class="nav-item-my"><a class="nav-link active"
						href="${pageContext.request.contextPath }/member/myPage.do?member_id=${member_id }">
							<span data-feather="home"></span> My Page <span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item-my"><a class="nav-link"
						href="${pageContext.request.contextPath }/member/myPageMemberView.do?member_id=${member_id }">
							<span data-feather="file"></span> 내정보
					</a></li>
					<li class="nav-item-my">
						 <a class="nav-link"
						href="${pageContext.request.contextPath}/member/selectMemberAddress.do?member_id=${member_id}">
							<span data-feather="bar-chart-2"></span> 주소록관리
					</a>
					</li>
					<li class="nav-item-my">
						 <a class="nav-link"
						href="${pageContext.request.contextPath }/member/myPageQuestion.do?member_id=${member_id }">
							<span data-feather="bar-chart-2"></span> 1:1문의
					</a>
					</li>

				</ul>
			</div>
		</nav>

		<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
		<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3">
            <h3>주소록 관리</h3>
            
          </div> 
			<table class="table">
				<tr>
					<th></th>
					<th>번호</th>
					<th>우편번호</th>
					<th>주소</th>
					<th>기본 배송지</th>
				</tr>
				<c:if test="${not empty list }">
					<c:forEach var="i" items="${list }" varStatus="vs">
						<tr>
							<td class="tbl-td">
								<input type="radio" name="addrCheck" id="addr${i.address_level}" />
								<input type="hidden" name="addrLevel" id="addrLevel" value="${i.address_level}"/>
								<input type="hidden" name="addrNo" id="addrNo" value="${i.address_no}"/>
							</td>
							<td class="tbl-td">${vs.count}</td>
							<td class="tbl-td">${i.zip_code}</td>
							<td class="tbl-td">
								<c:set var="address" value="${fn:split(i.address,'#')}" />				
								<c:forEach var="addr" items="${address}" varStatus="g">
								     <%-- <c:if test="${g.count % 2 == 1}"> --%>
								     	${addr} <br />
								     <%-- </c:if> --%>
								</c:forEach> 
							</td>
							<td class="verticalMiddle-hyelin">
								<c:if test="${i.address_level == 1}">
									<img src="${pageContext.request.contextPath}/resources/img/checked.png" alt="" />
								</c:if>
							</td>
						</tr>
				 	</c:forEach>
				</c:if>
				<tr>
					<td colspan="5">
						<button type="button" class="btn" id="insertAddr">배송지 추가</button>
						<button type="button" class="btn" id="updateAddr">수정</button>
						<button type="button" class="btn" id="deleteAddr">삭제</button>
						<button type="button" class="btn" id="defaultAddr">기본배송지 설정</button> <br /> <br />
						<div id="addressInfo">
						<input type="text" class="form-control inline-hyelin addr" id="sample4_postcode" placeholder="우편번호" style="width: 120px;" required readonly>
						<input type="button" class="btn btn-light" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" size="35px"><br> 
						<input type="text" class="form-control addr" id="sample4_roadAddress" placeholder="도로명 주소" required readonly> 
						<input type="text" class="form-control addr" id="sample4_jibunAddress" placeholder="지번 주소">
						<input type="text" class="form-control addr" id="sample4_detailAddress" placeholder="상세 주소" required/>
						<span id="guide" style="color: #999"></span>
						<button type="button" class="btn btn-primary" id="submitBtn">저장</button>
						</div>
					</td>
				</tr>
			</table>
		</main>
	</div>
</div>

<script>
// 우편번호 검색 api
function sample4_execDaumPostcode() {
     new daum.Postcode(
      {
         oncomplete : function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
               extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if (data.buildingName !== '' && data.apartment === 'Y') {
               extraRoadAddr += (extraRoadAddr !== '' ? ', '
                     + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if (extraRoadAddr !== '') {
               extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if (fullRoadAddr !== '') {
               fullRoadAddr += extraRoadAddr;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('sample4_roadAddress').value = fullRoadAddr;
            document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if (data.autoRoadAddress) {
               // 예상되는 도로명 주소에 조합형 주소를 추가한다.
               var expRoadAddr = data.autoRoadAddress
                     + extraRoadAddr;
               document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
                     + expRoadAddr + ')';

            } else if (data.autoJibunAddress) {
               var expJibunAddr = data.autoJibunAddress;
               document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
                     + expJibunAddr + ')';

            } else {
               document.getElementById('guide').innerHTML = '';
            }
         }
      }).open();
}

$(function() {
	   // address_level이 1인 경우 radio 체크
	   $("#addr1").attr("checked","checked");
	   
	   // 배송지 추가 버튼
	   $("#insertAddr").click(function() {
		   $("#addressInfo").css("visibility","visible");
		   
		   $("#submitBtn").click(function() {
			   var postCode = $("#sample4_postcode").val();
			   var roadAddress = $("#sample4_roadAddress").val();
			   var jibunAddress = $("#sample4_jibunAddress").val();
			   var detailAddress = $("#sample4_detailAddress").val();
			   
			   if(postCode != "" && roadAddress != "" && detailAddress != "") {
				   $.ajax({
				         url:"${pageContext.request.contextPath}/member/insertMemberAdress.do",
				         data: {
				        	  address : roadAddress + '#' + jibunAddress + '#' + detailAddress,
				        	  zip_code : postCode,
				        	  member_id : "${member_id}"
				         },
				         success:function(data) {         
				        	  location.href = "${pageContext.request.contextPath}/member/"
				        	  			    + "selectMemberAddress.do?member_id=${member_id}";
				         },
				         error:function(jqxhr, textStatus, errorThrown) {
			                  console.log("ajax처리실패!");
			                  console.log(jqxhr);
			                  console.log(textStatus);
			                  console.log(errorThrown);
				         }
			   	   });
			   } else {
				   alert("배송지 정보를 입력해주세요");
			   }
		   });
	   });
	   
	   // 배송지 삭제 버튼
	   $("#deleteAddr").focus(function() {
		   $("#addressInfo").css("visibility","hidden");
	   }).click(function() {
		   var address_no = $(this).parent().parent().parent().find("[name=addrCheck]:checked")
		   					.siblings("[name=addrNo]").val();
		   var address_level = $(this).parent().parent().parent().find("[name=addrCheck]:checked")
		   					   .siblings("[name=addrLevel]").val();
		    
		   if(address_level != 1) {
			   if(confirm("해당 배송지 정보를 삭제하시겠습니까?")) {
				   $.ajax({
				         url:"${pageContext.request.contextPath}/member/deleteMemberAddress.do",
				         data: {
				        	  address_no : address_no
				         },
				         success:function(data) {         
				        	 location.href = "${pageContext.request.contextPath}/member"
				        	 			   + "/selectMemberAddress.do?member_id=${member_id}";
				         },
				         error:function(jqxhr, textStatus, errorThrown) {
			                  console.log("ajax처리실패!");
			                  console.log(jqxhr);
			                  console.log(textStatus);
			                  console.log(errorThrown);
				         }
			   	   });
			   }
		   } else {
			   alert("기본 배송지는 삭제하실 수 없습니다.");
		   }
	   });
	   
	   // 배송지 수정 버튼
 	   $("#updateAddr").click(function() {
 		  var address_level = $(this).parent().parent().parent()
 		  					  .find("[name=addrCheck]:checked").siblings("[name=addrLevel]").val();
		   $("#addressInfo").css("visibility","visible");
		   
		   $("#submitBtn").click(function() {
			   var postCode = $("#sample4_postcode").val();
			   var roadAddress = $("#sample4_roadAddress").val();
			   var jibunAddress = $("#sample4_jibunAddress").val();
			   var detailAddress = $("#sample4_detailAddress").val();
			   
			   if(postCode != "" && roadAddress != "" && detailAddress != "") {
				   $.ajax({
				         url:"${pageContext.request.contextPath}/member/updateMemberAddress.do",
				         type: 'POST',
				         data: {
				        	  address_level : address_level,
				        	  address : roadAddress + '#' + jibunAddress + '#' + detailAddress,
				        	  zip_code : postCode,
				        	  member_id : "${member_id}"
				         },
				         success:function(data) {         
				        	  location.href = "${pageContext.request.contextPath}/member/" 
				        	  				+ "selectMemberAddress.do?member_id=${member_id}";
				         },
				         error:function(jqxhr, textStatus, errorThrown) {
			                  console.log("ajax처리실패!");
			                  console.log(jqxhr);
			                  console.log(textStatus);
			                  console.log(errorThrown);
				         }
			   	   });
			   } else {
				   alert("배송지 정보를 입력해주세요");
			   }
		   });
	   });
	   
	   // 기본 배송지 설정 버튼 
	   $("#defaultAddr").focus(function() {
		   $("#addressInfo").css("visibility","hidden");
	   }).click(function() {
		   var address_no = $(this).parent().parent().parent().find("[name=addrCheck]:checked")
		   					.siblings("[name=addrNo]").val();
		   var address_level = $(this).parent().parent().parent().find("[name=addrCheck]:checked")
		   					   .siblings("[name=addrLevel]").val();
		   
		   if(address_level != 1 && confirm("기본 배송지로 설정하시겠습니까?")) {
			   $.ajax({
			         url:"${pageContext.request.contextPath}/member/updateDefaultAddress.do",
			         data: {
			        	  address_no : address_no,
			        	  address_level : address_level,
			        	  member_id : "${member_id}"
			         },
			         success:function(data) {         
			        	  location.href = "${pageContext.request.contextPath}/member"
			        	  				+ "/selectMemberAddress.do?member_id=${member_id}";
			         },
			         error:function(jqxhr, textStatus, errorThrown) {
		                  console.log("ajax처리실패!");
		                  console.log(jqxhr);
		                  console.log(textStatus);
		                  console.log(errorThrown);
			         }
		   	   });
		   }
	   });
	});
	

  
</script>
