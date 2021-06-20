<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="회원등록" name="pageTitle"/>
</jsp:include>   
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script charset="UTF-8" type="text/javascript"
   src="https://t1.daumcdn.net/cssjs/postcode/1522037570977/180326.js"></script>
<style>

div#update-container{
   width:980px;
   margin:0 auto;
}

div#userId-container span.guide{
   display:none;
   font-size:12px;
   top:12px;
   right:10px;
   margin-right:300px;
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
span.req {
   color: red;
}
</style>

<script>
$(function(){
   // 비밀번호 체크
   $("#password_chk").blur(function(){
      var p1 = $("#member_password_").val();
      var p2 = $(this).val();
      if(p1!=p2){
         alert("패스워드가 일치하지 않습니다.");
         $("#member_password_").focus();         
      };
   });
   
   // 아이디 체크
   $("#member_id_").on("keyup",function(){
      var member_id = $(this).val().trim();
      var regExp2 = /[0-9]/; 
      
      if(member_id.length<2 || member_id.length>8){
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
   
   
   $("#member_name_").blur(function(){
      var member_name = $(this).val().trim();
      
      if(member_name.length<2 || member_name.length>8) {
         alert("이름을 2글자 이상 8글자 이하로 적으세요.");               
      }
      //형배_ 공백문자 사용불가능 추가
      //var blank_pattern = /^\s+|\s+$/g;(/\s/g
      var name_pattern = /[\s]/g;
      if( name_pattern.test(member_name) == true){
          alert('공백은 사용할 수 없습니다. ');
          return false;
      }
        
        //이름에 특수 문자가 들어간 경우
        if (!check(member_name,"이름이 잘못 되었습니다.")) {
            return false;
        }
   });
   
   // 전화번호 체크
   $("#member_phone_").blur(function(){
      var member_phone = $(this).val().trim();
      var regExp0 = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
      if(member_phone.length<8 || member_phone.length>11 || member_phone.indexOf("-") != -1) { 
         alert("전화번호는 -를 포함하지 않는 최대 11자리입니다.");               
      } else if(!regExp0.test($("#member_phone_").val())){
         alert("올바른 형식으로 작성해주세요.");   
      }
   });
});   

// 유효성 검사
function validate(str){
   var member_id = $("#member_id_").val().trim();
   var member_password = $("#member_password_").val().trim();
   var member_name = $("#member_name_").val().trim();
   /* var member_birthday = $("#member_birthday_").val().trim(); */
   var member_phone = $("#member_phone_").val().trim();

   var regExp = /^[가-힣]{2,8}$/;
   var regExp0 = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
   var regExp1 = /^[a-z]{4,8}$/;
   var regExp2 = /[0-9]/; 
   
   if(member_id.length<4 || member_id.length>12){
      alert("아이디는 최소4자리이상 12자 이하여야 합니다");
      $("#member_id_").val("");
      $("#member_id_").focus();
      return false;
   }

   if(member_password.length<4 || member_password.length>8){
      alert("비밀번호는 최소4자리이상이거나 8자리 미만여야 합니다.");
      /* member_password.focus(); */
      $("#member_password_").focus();
      return false;      
   }
   
   if(!regExp.test(member_name)){
      alert("이름을 2글자 이상 8글자 이하로 적으세요.");
      $("#member_name_").val("");
      //$("#member_name_").focus();
      return false;
   }
   
   if(member_password.length<4 || member_password.length>8){
      alert("비밀번호는 최소4자리이상이거나 8자리 미만여야 합니다.");
      /* member_password.focus(); */
      $("#member_password_").focus();
      return false;      
   }

    
   if(!regExp0.test($("#member_phone_").val())){
      alert("전화번호는 -를 포함하지 않는 최대 11자리입니다.");
      return false;
   }

   return true;
}

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

</script>
   <div id="update-container">
   <h2>회원가입</h2>
   <hr size="5px;" style="background:rgb(126, 183, 230);">
      <form action="memberEnrollEnd.do" method="post" onsubmit="return validate();">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
         <table class="table" id="tbl_enroll">
         <tr>
            <th><label for="member_id_">아이디 <span class="req">*</span></label></th>
            <td>
               <div id="userId-container">
                  <input type="text" name="member_id" id=member_id_ class="input form-control" placeholder="4자리이상 12자 미만으로 적으세요" required />
                  <span class="guide ok">이 아이디는 사용가능합니다.</span>
                  <span class="guide error">이 아이디는 사용할 수 없습니다.</span>
                  <input type="hidden" id="idDuplicateCheck" value="0" />
               </div>
            </td>
         </tr>
         <tr>
            <th><label for="member_password_">비밀번호 <span class="req">*</span></label></th>
            <td><input type="password" name="member_password" id="member_password_" class="input form-control" required/></td>
         </tr>
         <tr>
            <th><label for="password_chk">비밀번호 확인 <span class="req">*</span></label></th>
            <td><input type="password" id="password_chk" class="form-control" required /></td>
         </tr>
         <tr>
            <th><label for="member_name_">이름 <span class="req">*</span></label></th>
            <td><input type="text" name="member_name" id="member_name_" class="form-control" required autocomplete="off" /></td>
         </tr>
         <tr>
            <!-- 형배_ <span class="req">*</span> -->
            <th><label for="member_email_">이메일 <span class="req">*</span></label></th>
            <td><input type="email" name="member_email" id="member_email_" class="form-control" autocomplete="off" /></td>
         </tr>
         <tr>
            <th><label for="member_phone_">전화번호 <span class="req">*</span></label></th>
            <td><input type="text" name="member_phone" id="member_phone_" class="form-control" placeholder="-를 제외하고 입력하세요" required autocomplete="off"/></td>
         </tr>
         <tr>
            <th><label for="member_birthday_">생일 <span class="req">*</span></label></th>
            <td><input type="date" name="member_birthday" id="member_birthday_" class="form-control"  required/></td>
         </tr>
         <tr>
            <!-- 형배_ <span class="req">*</span> -->
            <th><label for="member_gender_">성별 <span class="req">*</span></label></th>
            <td>
               <select name="member_gender" id="member_gender_" class="form-control">
                  <!-- <option value="성별" disabled selected>성별</option> -->
                  <option value="M" selected>남자</option>
                  <option value="F">여자</option>
               </select>
            </td>
         </tr>
         <tr>
            <th><label for="sample4_postcode">주소 <span class="req">*</span></label></th>
            <td>
               <input type="text" name="sample4_postcode" class="form-control inline-hyelin" id="sample4_postcode" placeholder="우편번호" style="width: 120px; display:inline;" required> 
                   <input type="button" class="btn btn-light" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" style="width: 120px;"><br>
                   <input type="text" class="form-control" name="sample4_roadAddress" id="sample4_roadAddress" placeholder="도로명 주소" required > 
                   <input type="text" class="form-control" name="sample4_jibunAddress" id="sample4_jibunAddress" placeholder="지번 주소">
                   <input type="text" class="form-control" name="sample4_detailAddress" id="sample4_detailAddress" placeholder="상세 주소" required>
                   <span id="guide" style="color: #999"></span>
                </td>
         </tr>
         </table>   
         <hr />
         
         
         <div id="btnDiv">
            <input type="submit" value="가입" class="btn btn-outline-primary"/> &nbsp;
            <input type="reset" value="취소" class="btn btn-outline-primary"/>
         </div>
      <br><br> 
      </form>
   </div>