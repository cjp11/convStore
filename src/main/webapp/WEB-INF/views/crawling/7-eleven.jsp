<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Hello Spring" name="pageTitle"/>
</jsp:include>

<br /><br /><br />

<style>

.overlay {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100%;
  width: 100%;
  opacity: 0;
  transition: .5s ease;
  background-color: #008CBA;
}

.card:hover .overlay {
  opacity: 1;
}

.text {
  color: white;
  font-size: 20px;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  text-align: center;
}

</style>
<div class="container">
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">7ELEVEN</h1>
            
          </div>
	<form name="actFrm" id="actFrm" action="" method="post" accept-charset="utf-8">
		<input type="hidden" name="seqNo" id="seqNo" value="" title="시퀀스 번호">		
		<input type="hidden" name="intPageSize" id="intPageSize" value="8" title="더보기 클릭시 추가 리스트 수">		
		<input type="hidden" name="listNo" id="listNo" value="" title="다른이벤트보기 순서">		
	</form>
	<div class="card-columns">	
		<c:forEach items="${data}" var="i" varStatus="vs">
			<div class="card text-white" onclick="${i['a.href']}">
			  <img class="card-img" src="http://7-eleven.co.kr/${i['img.src']}" alt="Card image">
			  <div class="card-img-overlay overlay">
				  <div class="text">				  
				    <h5 class="card-title">${i["dt"]}</h5>
				    <p class="card-text">${i["dd"]}</p>
				  </div>
			  </div>
			</div>
		</c:forEach>
	</div>
</div>
<script>
var fncGoView = function(objVal, listNo){
	$("#seqNo").val(objVal);
	$("#listNo").val(listNo);
	$("#intPageSize").val(8);

//	$("#actFrm").attr("target", "ifrmAction");
	$("#actFrm").attr("target", "_blank");
//	$("#actFrm").attr("enctype", "multipart/form-data");
	$("#actFrm").attr("action","http://www.7-eleven.co.kr/event/eventView.asp").submit();
};

</script>
