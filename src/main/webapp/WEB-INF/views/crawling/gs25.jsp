<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Hello Spring" name="pageTitle"/>
</jsp:include>
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
<br /><br /><br />
<div class="container">
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">GS25</h1>
            
          </div>
	<div class="card-columns">	
		<c:forEach items="${gs25CrawlingList}" var="i" varStatus="vs">
			<div class="card text-white" onclick="window.open('${i['a.href']}')">
			  <img class="card-img" src="${i['img.src']}" alt="Card image">
			  <div class="card-img-overlay overlay"> 
				  <div class="text">				  
				    <h5 class="card-title">${i["eventTitle"]}</h5>
				    <p class="card-text">${i["period"] }</p>
				  </div>
			  </div>
			</div>
		</c:forEach>
	</div>
</div>
</script>
