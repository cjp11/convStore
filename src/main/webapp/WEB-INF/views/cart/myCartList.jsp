<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="main" name="pageTitle" />
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록 출력</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/bootstrap.css?ver=1" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/boardStyle.css?ver=1" />
<style>
#container {
   width: 700px;
   margin: 0 auto;
}
.center {
   text-align: center;
}

.border-none, .border-none td {
   border: none;
}
</style>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.js"></script>

<script>



$(function() {
	
	$(".deleteBtn").click(function() {
		<sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
		   member_id = '<sec:authentication property="principal.username"/>';
		</sec:authorize>
		console.log(1111);
		var cart_id = $(this).attr("value");
		console.log(cart_id);
		
		var objParam = {
				cart_id : cart_id,
		}
		console.log(objParam);
		
		$.ajax({
			type:	"POST",
			async:	false,
			contentType: "application/json; charset=utf-8",
			url:		"removeCartItem.do",
			dataType:	"json",
			data	:	objParam,
			success	:	function(response) {
				alert(response);				
			},
			error: function(response) {
				alert("에러가 발생!" );
			},
			complete: function(response) {
				//alert("작업을 완료했습니다.")
			}
		
		
		});
	}); 
		
	
});

</script>


</head>
<body>

	<div id="container">
		<h1>장바구니</h1>
		<hr>

		<table>
			<tr>
				<td><strong>장바구니 정보</strong></td>
			</tr>
		</table>

		<div class="row">

			<table class="table table-hover">
				<tr align="center" bgcolor="lightgreen">
					<td width="1%">선택</td>
					<td width="7%">이미지</td>
					<td width="7%">상품 이름</td>
					<td width="7%">가격(원)</td>
					<td width="5%">수량(개)</td>
					<td width="7%">삭제</td>

				</tr>
				<c:choose>
					<c:when test="${empty myCartList }">
						<tr>
							<td colspan=5><strong>장바구니에 상품이 없습니다.</strong></td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<c:forEach var="vo" items="${myCartList }" begin="0"
								end="${fn:length(myCartList)-1 }" step="1">
								<tr align="center">
									<td><input type="checkbox" name="checkSelect" checked></td>
									<td><img src="${vo.getImage_url() }" width="100px"
										height="50px"></td>
									<td>${vo.getProduct_name() }</td>
									<td>${vo.getProduct_price() }</td>
									<td>${vo.getProduct_stock() }</td>
									<td>
										<button type="button" class="deleteBtn" 
										>삭제</button>
									</td>

								</tr>
							</c:forEach>
					</c:otherwise>
				</c:choose>


			</table>
		</div>
	</div>

</body>
</html>