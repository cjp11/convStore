<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="마이페이지" name="pageTitle"/>
</jsp:include>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script charset="UTF-8" type="text/javascript"
   src="https://t1.daumcdn.net/cssjs/postcode/1522037570977/180326.js"></script>
<style>
<style>
.list-group-item {
    position: relative;
    display: block;
    padding: .75rem 1.25rem;
    margin-bottom: -1px;
    background-color: #fff;
    border: 1px solid rgba(0,0,0,.125);
    width: 150px;
}
.imsosotired {
   font-size: 20px;
   color: #337ab7;
   font-weight: bold;
}
#update-container{
	width:100%;
}

section#enroll-container-dh {
   text-align: center;
}

section#enroll-container-dh input {
   margin: 3px;
}

section#enroll-container-dh table {
   margin: 0 auto;
}

section#enroll-container-dh table th {
   padding: 5px 15px 5px 130px;
   text-align: right;
}

section#enroll-container-dh table td {
   padding: 5px 50px 5px 5px;
   text-align: left;
}

.updatebody-dh {
   background-color: rgb(82, 55, 36);
   color: rgb(255, 255, 255);
   /* font: 400 0.875rem/1.5 "Open Sans", sans-serif; */
   margin: 0;
   min-height: 100%;
}

table#enroll-dh {
   border-spacing: 20px;
   border: 1px solid lightgrey;
   height: 500px;
   width: 980px;
   border-radius: 0.35rem;
}

table input[id="userName-dh"]:focus, table input[id="userName-dh"]:hover,
   table input[id="age-dh"]:focus, table input[id="age-dh"]:hover, table input[id="email-dh"]:focus,
   table input[id="email-dh"]:hover, table input[id="phone-dh"]:focus,
   table input[id="phone-dh"]:hover, table input[id="tel"]:focus, table input[id="tel"]:hover
   {
   background-color: whitesmoke;
}

table input[id="userName-dh"], table input[id="age-dh"], table input[id="email-dh"],
   table input[id="phone-dh"], input[id="userId-dh"] {
   background-color: lightblue;
   color: black;
   border-bottom-left-radius: 0;
   border-top-left-radius: 0;
   border: 0;
   color: inherit;
   font: inherit;
   margin: 0;
   outline: 2;
   padding: 10px;
   /* -webkit-transition: background-color .3s; */
   transition: background-color .3s;
}

table input[id="userId-dh"]  {
   background-color: lightpink;
   color: black;
   border-bottom-left-radius: 0;
   border-top-left-radius: 0;
   border: 0;
   color: inherit;
   font: inherit;
   margin: 0;
   outline: 0;
   padding: 1;
   /* -webkit-transition: background-color .3s; */
   transition: background-color .3s;
}
.table{
	width:80%;
}
.col-sm-3 {
    max-width: 200px;
}
div.mypage{
	width:100%;
	margin:0;
	
	min-height:780px;
}
.nav-item-my>a{
	font-size:25px;
	font-family: 'Do Hyeon', sans-serif;
}
.container-fluid-master{
	position:relative;
	top:38px;
	min-height:1000px;
}
</style>
<script>
$(function(){
	var memberAddress = "${memberAddress.address}";
	var address = memberAddress.split("#");
	console.log(memberAddress);
	console.log(address);
	$("#sample4_roadAddress").val(address[0]);
	$("#sample4_jibunAddress").val(address[1]);
	$("#sample4_detailAddress").val(address[2]); 
});
function validate(){
	return true;
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
            <h1 class="h2">회원관리</h1>
            
          </div>

		<div class="mypage container">
			<div class="row">
				
							
							<br>
							<div id="update-container">
								
								<form action="${pageContext.request.contextPath }/member/memberUpdate.do" method="post" onsubmit="return validate();">
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" />
									<table class="table" id="tbl_enroll">
										<tr>
											<th><label for="member_id_">아이디</label></th>
											<td>
												<div id="userId-container">
													<input type="text" name="member_id" id=member_id_
														class="input form-control" value="${member.member_id }"
														readonly required />

												</div>
											</td>
										</tr>
										<tr>
											<th><label for="member_name_">이름</label></th>
											<td><input type="text" name="member_name"
												id="member_name_" class="form-control"
												value="${member.member_name }" required autocomplete="off" readonly/></td>
										</tr>
										<tr>
											<th><label for="member_email_">이메일</label></th>
											<td><input type="email" name="member_email"
												id="member_email_" class="form-control"
												value="${member.member_email} " autocomplete="off" readonly/></td>
										</tr>
										<tr>
											<th><label for="member_phone_">전화번호</label></th>
											<td><input type="text" name="member_phone"
												id="member_phone_" class="form-control"
												value="${member.member_phone}" placeholder="-를 제외하고 입력하세요"
												required autocomplete="off" readonly/></td>
										</tr>
										<tr>
											<th><label for="member_birthday_">생일</label></th>
											<td><input type="date" name="member_birthday"
												id="member_birthday_" value="${member.member_birthday }"
												class="form-control" readonly/></td>
										</tr>
										<tr>
											<th><label for="member_gender_">성별</label></th>
											<td><select name="member_gender" id="member_gender_"
												class="form-control" required readonly>
													<option value="" disabled selected>성별</option>
													<c:if test="${member.member_gender eq 'F' }">
														<option value="F" selected>여자</option>
														<!-- <option value="M">남자</option> -->
													</c:if>
													<c:if test="${member.member_gender eq 'M' }">
														<!-- <option value="F">여자</option> -->
														<option value="M" selected>남자</option>
													</c:if>
											</select></td>
										</tr>
										<tr>
											<th><label for="sample4_postcode">주소</label></th>
											<td>
												<input type="text" name="sample4_postcode" class="form-control inline-hyelin" id="sample4_postcode" value="${memberAddress.zip_code }" style="width: 120px; display: inline;" required readonly> 
												<input type="button" class="btn btn-light" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" style="width: 120px;"><br> 
												<input type="text" class="form-control" name="sample4_roadAddress" id="sample4_roadAddress" placeholder="도로명 주소" value="" readonly>
												<input type="text" class="form-control" name="sample4_jibunAddress" id="sample4_jibunAddress" placeholder="지번 주소" readonly> 
												<input type="text" class="form-control" name="sample4_detailAddress" id="sample4_detailAddress" placeholder="상세 주소" readonly> 
												<span id="guide" style="color: #999"></span>
											</td>
										</tr>
										<tr>
											<th>회원등급</th>
											<td><input type="radio" name="member_grade"
												id="member_grade_1" value="A"
												${member.member_grade=='A'?'checked':'' }> <label
												for="member_grade_1">A</label> <input type="radio"
												name="member_grade" id="member_grade_2" value="G"
												${member.member_grade=='G'?'checked':'' }> <label
												for="member_grade_2">G</label></td>
										</tr>
									</table>
									<div id="btnDiv">
										<input type="submit" value="수정"
											class="btn btn-outline-success" /> &nbsp;

									</div>
								</form>
							</div>

			</div>

		</div>





		</main>
	</div>
</div>

<script>
/* 주소검색api */
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
           
           console.log($("#sample4_postcode"));
           // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
           if (data.autoRoadAddress) {
              //예상되는 도로명 주소에 조합형 주소를 추가한다.
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
$(function(){
	$("#password_chk").blur(function(){
		var p1 = $("#member_password_").val();
		var p2 = $(this).val();
		if(p1!=p2){
			alert("패스워드가 일치하지 않습니다.");
			$("#member_password_").focus();			
		};
	});
	
	$("#member_id_").on("keyup",function(){
		var member_id = $(this).val().trim();
		if(member_id.length<4){
			$(".guide").hide();
			$("#idDuplicateCheck").val(0);
			return;
		}
		
		$.ajax({
			url : "checkIdDuplicate.do",
			data : {member_id:member_id},
			dataType:"json",
			success : function(data){
				console.log(data);//{isUsable: false}
				if(data.isUsable==true){
					$(".guide.error").hide();
					$(".guide.ok").show();
					$("#idDuplicateCheck").val(1);	
				}
				else{
					$(".guide.error").show();
					$(".guide.ok").hide();
					$("#idDuplicateCheck").val(0);						
				}
			},
			error:function(jqxhr,textStatus,errorThrown){
				console.log("ajax실패",jqxhr,textStatus,errorThrown);
				
			}
			
		});
		
	});
});	
/*
 * 유효성검사함수
 */
function validate(str){
	var member_id = $("#member_id_");
	var member_password = $("#member_password_");
	var member_name = $("#member_name_");
	var member_birthday = $("#member_birthday_");
	var member_phone = $("#member_phone_")
	
	if(member_id.val().trim().length<4 || member_id.val().trim().length>=12){
		alert("아이디는 최소4자리이상 12자 미만여야 합니다");
		member_id.focus();
		return false;
	}
	
	if(member_password.val().trim().length<4 || member_password.val().trim().length>8){
		alert("비밀번호는 최소4자리이상이거나 8자리 미만여야 합니다.");
		member_password.focus();
		return false;		
	}
	
	if(member_name.val().trim().length>8){
		alert("이름을 8글자 미만로 적어주세요");
		return false;
	}
	
	
	if (member_name.val().indexOf(" ") >= 0) {
        alert("이름에 공백을 사용할 수 없습니다.")
        document.member_name_.focus()
        document.member_name_.select()
        return false;
    }
	
	return true;
}
$(function(){
	var memberAddress = "${memberAddress.address}";
	var address = memberAddress.split("#");
	console.log(memberAddress);
	console.log(address);
	$("#sample4_roadAddress").val(address[0]);
	$("#sample4_jibunAddress").val(address[1]);
	$("#sample4_detailAddress").val(address[2]); 
});
function deleteMember(member_id){
	if(confirm("탈퇴하시겠습니까?")){	
		location.href = "${pageContext.request.contextPath}/member/memberDelete.do?member_id="+member_id;
	}else{
		return;
	}
}
</script>
