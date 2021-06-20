
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.pageTitle }</title>
<style>

.nav-pills .nav-link.active, .nav-pills .show>.nav-link {
    color: #fff;
    background: #000000;
    width:80px;
}

.nav-fill .nav-item {
    -ms-flex: 1 1 auto;
    flex: 1 1 auto;
    text-align: center;
    margin: 0;
}
div#chatting-room{
	display:none;
}
img#chat-icon{
	width:100px;
	height:100px;
	position:fixed; 
	bottom:0; 
	right:0;
	z-index:10;
	cursor:pointer;
}
.nav-master{
    background-color: #000000!important;
}
.login-dropdown-master{
	list-style:none;
}
.nav-master>a {
    font-size: 16px;
    color: #000000!important;
}


@media (min-width: 1000px)
.navbar-expand-md {
    -ms-flex-flow: row nowrap;
    flex-flow: row nowrap;
    -ms-flex-pack: start;
    justify-content: flex-start;
}
</style>

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.js"></script>		
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/custom.css" /> 
 

 
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
 


<!-- 
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet" href="resources/css/custom.css">
 -->



<!-- 링크를 href로 바꾸니 채팅창 원상복구 되고 메인 인덱스가 보이지 않게 되었다. 스프링 시큐리티아 연관 ??? -->

<!-- 메타값 -->
<meta name="_csrf" content="${_csrf.token}"/> 
<meta name="_csrf_header" content="${_csrf.headerName}"/> 

<!-- 소켓통신 라이브러리 --> 
<script src="${pageContext.request.contextPath }/resources/js/sockjs.min.js"></script> 


</head>	

<!-- 유저롤을 가진 유저  -->
<sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
	<sec:authentication property="principal.username" var="member_id"/>
	<sec:authentication property="principal.member_name" var="member_name"/>
</sec:authorize>

<script>
//반응형
$(function(){
   /* var w=document.getElementById("main-container"); */
   var w=$("#main-container");
   /* var style=window.getComputedStyle(w,null); */
   console.log(w.css("width"));
   /* w.css("width").on("change",function(){
      console.log($(this));
   }); */
   if(parseInt(w.css("width"))<742){
      $("#autoComplete").css("min-width","205px");
      $("#autoComplete").css("top","250px");
      if(parseInt(w.css("width"))<550){
         $("#autoComplete").css("text-align","center");
         $("#autoComplete").css("padding","0");
         $(".searchbar").css("width","auto");
      }
   }
   $(window).resize(function(){
      if(parseInt(w.css("width"))<742){
         $("#autoComplete").css("min-width","205px");
         $("#autoComplete").css("top","250px");
         if(parseInt(w.css("width"))<=550){
            $("#autoComplete").css("text-align","center");
            //$("#autoComplete").css("margin","0");
            $(".searchbar").css("width","auto");
         }else{
            //$("#autoComplete").children("li").css("padding","auto");
         }
      }
      //console.log(parseInt(w.css("width")));
      if(parseInt(w.css("width"))<740){
         $("#autoComplete").css("min-width","205px");
         $("#autoComplete").css("top","250px");
         //$("#autoComplete").css("position","none");
      }
      if(parseInt(w.css("width"))>=740){
         $("#autoComplete").css("min-width","205px");
         $("#autoComplete").css("top","50px");
         //$("#autoComplete").css("position","absolute");
      }
   });
   
});
</script>

<body class="Site">
<div id="main-container">
<!-- navigation bar start-->
<nav class="navbar navbar-expand-md navbar-dark fixed-top nav-master">
        <a class="navbar-brand" href="${pageContext.request.contextPath }">
		    <img src="${pageContext.request.contextPath }/resources/img/all_logo.png" width="110" height="50" class="d-inline-block align-top" alt=""> <!-- 2020_11_24_수정_주홍 -->
		    올 편  
		</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
          <ul class="navbar-nav mr-auto">
		    
		    <li class="nav-item dropdown">
		        <a class="nav-link dropdown-toggle" style="font-size:14px;" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          편의점 행사상품
		        </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
					<a class="dropdown-item" href="${pageContext.request.contextPath }/crawling/7-eleven">7ELEVEN</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath }/crawlingEmart">emart24</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath }/crawling/gs25">GS25</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath }/crawling/ministop">ministop</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath }/crawling/cu">CU</a>
		        </div>
		    </li>
            <li class="nav-item">
              <a class="nav-item nav-link" style="font-size:14px;" href="${pageContext.request.contextPath }/noticeboard/noticeBoardList.do">게시판(임의)</a>
            </li>
            <li class="nav-item">
              <a class="nav-item nav-link" style="font-size:14px;" href="${pageContext.request.contextPath }/BoardList.do?pageNo=1">자유 게시판</a>
            </li>
          </ul>
          
		<c:choose>
			<c:when test="${empty member_id and empty admin_id}">
					<button type="button" class="btn btn-outline-light"
						onclick="location.href='${pageContext.request.contextPath}/member/loginPage.do'" style="margin-right: 10px;">Log In</button>
			</c:when>
			<c:otherwise>
					<li class="nav-item dropdown login-dropdown-master" id="userMenu-hyelin">
				        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				          ${member_name }님
				        </a>
				        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
				        <sec:authorize access="hasRole('ROLE_USER')">
				          <a class="dropdown-item" href="${pageContext.request.contextPath }/member/myPage.do?member_id=${member_id }" style="color:black">
                   			<img src="${pageContext.request.contextPath }/resources/img/mypage.png" alt="" />  내 페이지
                   		  </a>
				          <a class="dropdown-item" href="${pageContext.request.contextPath }/cart/myCartList.do?member_id=${member_id}" style="color:black">
                    		<img src="${pageContext.request.contextPath }/resources/img/basket.png" alt="" />  장바구니
                    	  </a>
                    	  <a class="dropdown-item" href="${pageContext.request.contextPath }/member/myPageBasket.do?member_id=${member_id}" style="color:black">
                    		<img src="${pageContext.request.contextPath }/resources/img/basket.png" alt="" />  위시리스트
                    	  </a>
                    	  </sec:authorize>
                    	 <sec:authorize access="hasRole('ROLE_ADMIN')">
                    	 <a class="dropdown-item" href="${pageContext.request.contextPath }/manager/managerPage.do" style="color:black">
                   			<img src="${pageContext.request.contextPath }/resources/img/admin.png" alt="" />  관리자페이지
                   		  </a>
                   		  <a class="dropdown-item" href="${pageContext.request.contextPath }/manager/managerPage.do" style="color:black">
                   			<img src="${pageContext.request.contextPath }/resources/img/admin.png" alt="" />  임의항목
                   		  </a>
              			</sec:authorize> 
                    	  <hr />
                    	  <button type="button" class="btn btn-link" onclick="document.getElementById('logout-form').submit();">Log Out</button>
                    	  </div>
				      </li>			    
					<form id="logout-form" action="<c:url value="/logout"/>"
						method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</form>
			</c:otherwise>
		</c:choose>
	</div>
      </nav>
 </div>    
<!-- navigation bar end-->
      
         <!-- 채팅아이콘 -->
            <img src="resources/img/live_chat.png" id="chat-icon" style="width: 80px; height: 80px;"/> <!-- 2020_11_24_수정_주홍 -->
			<input type="hidden" name="" id="popupFlag" value="${param.flag }"/>
            <!-- 채팅 관련 html 시작 -->            
             <div id="chatting-room">
               <input type="hidden" name="member_id" value="${member_id}" />
                <div style="text-align:center;">현재 접속중인 사용자<span id="connected-member"style="font-weight:bold;"> ? </span> 명 
                   <button type="button" class="close" aria-label="Close" id="hide_chatting">
                    <span aria-hidden="true">&times;</span>
               </button>
                </div> 
               <c:if test="${member_id!=null }">
               <div style="text-align:center;margin-top:10px;">채팅방에 접속되었습니다.</div>  
               </c:if>
               <c:if test="${member_id==null }">
               <div style="text-align:center;margin-top:10px;">로그인 후 사용가능합니다.</div>  
               </c:if>        
               <div id="chatting-content"></div>

               <div id="member-chat">
               <sec:authorize access="hasRole('ROLE_USER')">
                    <form name="successUpload" style="width:120px; float:right;"> 
			        <input type="text" name="" id="chatUpload" readOnly hidden="true"/> 			        
			        <button style="width:100px;" type="button" class="btn btn-danger" id="sendPhoto">이미지전송</button> 
			        </form> 
			   </sec:authorize>
                  <input id="insertText" style="float:left; width:230px;"class="form-control form-control-sm" type="text">
                  <button style="float:left; width:50px;" type="button" class="btn btn-primary" id="insertChat">전송</button>
                  <sec:authorize access="hasRole('ROLE_USER')">
                  <button style="float:left; width:50px;" type="button" class="btn btn-success" id="insertPhoto">첨부</button>
                  </sec:authorize> 
               </div>

               <sec:authorize access="hasRole('ROLE_ADMIN')">
               <input id="admin-notice" style="float:left; width:230px;"class="form-control form-control-sm" type="text"> 
               <button style="float:left; width:50px;" type="button" class="btn btn-success" id="insertNotice">공지</button>
               </sec:authorize>
            </div> 
</body>
<script>
$(function(){
   $("#chat-icon").click(function(){
      $("#chatting-room").show();
       //스크롤바 설정 
       var offset = $(".chatting-comment:last").offset(); 
       $("#chatting-content").animate({scrollTop : offset.top}, 10); 
   });
   $("#hide_chatting").click(function(){
      $("#chatting-room").hide();
      $("#chat-icon").show();
   });
   
});
</script>

<!-- 채팅 관련 스크립트(소켓) --> 
<script> 
 
	var sock=new SockJS("<c:url value="/echo"/>");
	//var sock = new SockJS("<wss://allpyon.com value="/echo"/>");
sock.onmessage= onMessage;
sock.onclose = onClose; 
sock.onopen=function(){ 
	<sec:authorize access="hasRole('ROLE_USER')"> 
     sendMessage();
 	</sec:authorize>
     $.ajax({ 
           url:"${pageContext.request.contextPath}/chatting/showChat.do", 
           type:"post", 
           dataType:"json", 
           success:function(data){ 
             for(var index in data){ 
               var c = data[index]; 
               if(index=="connectCount"){ 
                 //$("#connected-member").text(c); 
               } 
               if(index=="list"){ 
                 var html='<div>'; 
                 for(var li in c){ 
                   html+='<div class="chatting-comment" style="text-align:left;">'; 
                   html+='<strong>['+c[li].member_id+'] :</strong> '+c[li].chat_content+'</div>'; 
                 } 
                 html+='</div>'; 
                  $("#chatting-content").html(html); 
               } 
             } 
              
           }, 
           error:function(jqxhr, testStatus, errorThrown){ 
            console.log("ajax처리실패"); 
            console.log(jqxhr); 
            console.log(testStatus); 
            console.log(errorThrown); 
           } 
         }); 
}  
$(function(){ 
  $("#insertChat").click(function(){ 
     var chatText=$("#insertText").val().trim(); 
     var member_id =$("[name=member_id]").val().trim(); 
     if(chatText==""){ 
         alert("내용을 입력하셔야 합니다."); 
         return false; 
       } 
        
       if(member_id ==""){ 
         alert("로그인 후 이용가능합니다."); 
         return false; 
       }else{ 
         sendMessage(); 
         $("#insertText").val(''); 
       } 
  }); 
  $("#insertText").keypress(function (e) {
      var chatText=$("#insertText").val().trim();
      var member_id =$("[name=member_id]").val().trim();
      
      if(e.which == 13){
          if(chatText==""){
             alert("내용을 입력하셔야 합니다.");
             return false;
          }
          
          if(member_id ==""){
             alert("로그인 후 이용가능합니다.");
             return false;
          }else{
        	 sendMessage();
             $("#insertText").val('');
             $("#insertText").blur();
          }
      }
  });
  $("#insertNotice").click(function(){
     var adminNotice=$("#admin-notice").val().trim(); 
     var member_id =$("[name=member_id]").val().trim();
     if(adminNotice==""){ 
         alert("내용을 입력하셔야 합니다."); 
         return false; 
     }
     sendNotice(); 
      $("#admin-notice").val(''); 
  });
  $("#insertPhoto").click(function(){ 
	    var popUrl = "${pageContext.request.contextPath}/resources/smarteditor/sample/photo_uploader/chat_uploader.html";   
	    var popOption = "width=460, height=360,top=700, left=800, resizable=no, scrollbars=no, status=no;"; 
	      window.open(popUrl,"",popOption);   
	  }); 
	  $("#sendPhoto").click(function(){ 
	     if($("#chatUpload").val()!=""){ 
	       sendPhoto(); 
	     }else{ 
	       alert("먼저 이미지를 등록하세요!"); 
	     } 
	       
	 }); 
}); 
function sendPhoto(){ 
	sock.send($("#chatUpload").val()+"~!@#"); 
} 
function sendMessage(){
  sock.send($("#insertText").val());
} 

function sendNotice(){
   sock.send("[공지사항] : "+$("#admin-notice").val());
}
 
function onClose(){ 
  $("#chatting-content").append("접속이 끊어졌습니다."); 
} 
 
function onMessage(evt){ 
  var data=evt.data; 
  var sessionid=null; 
  var message=null; 
  var strArr=data.split('|'); 
  var authorize = '${member_id}';
  
  sessionid=strArr[0]; 
  message=strArr[1]; 
   
  if(sessionid==""){ 
       $("#connected-member").html(" "+message+" "); 
  }else if(sessionid=="중복 로그인감지로 인해 접속이 끊어집니다."){ 
        alert("중복 로그인 감지로 로그인을 해제합니다."); 
        location.href="${pageContext.request.contextPath}"; 
  }else if(sessionid=="관리자공지"){
        alert(message); 
  }else if(sessionid=="img"+authorize){ 
	    var id = sessionid.substring(3,sessionid.length); 
	    var html='<div class="chatting-comment" style="text-align:left;">';   
	    html+='<strong>['+id+'] :</strong>';
	    <!-- html+='<img src="https://allpyon.com/demo/resources/upload/chatting/'+message+'"width="100px" height="120px">'; -->
	    html+='<img src="http://localhost:8090/demo/resources/upload/chatting/'+message+'"width="100px" height="120px">';
	    
	    html+='</div>';   
	      $("#chatting-content").append(html);        
	      var offset = $(".chatting-comment:last").offset();  
	      $("#chatting-content").animate({scrollTop : offset.top}, 10); 
  }else if(sessionid=="신상품업로드"){
	  var popUrl = "${pageContext.request.contextPath}/product/newProductPop.do";   
	    var popOption = "width=460, height=360,top=300, left=400, resizable=no, scrollbars=no, status=no;"; 
	      window.open(popUrl,"",popOption); 
  }
  else {  
       var html='<div class="chatting-comment" style="text-align:left;">';  
       html+='<strong>['+sessionid+'] :</strong>'+message;  
       html+='</div>';  
       $("#chatting-content").append(html);       
       var offset = $(".chatting-comment:last").offset(); 
       $("#chatting-content").animate({scrollTop : offset.top}, 10); 
     }   
} 
 
</script> 
<script>
$(function(){	
	if($("#popupFlag").val() =='1'){
		console.log("ttt"+$("#popupFlag"));
		sock.send("신상품업로드!@#");		
	}

});
</script>