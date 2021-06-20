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
<!--
<sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
   memid = '<sec:authentication property="principal.username" var="member_id"/>';
   <sec:authentication property="principal.member_name" var="member_name"/>
</sec:authorize> -->

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
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.js"></script>
<script>
$(function(){
   
   $("#insertBtn").click(function() {
      var member_id = null;
      // session을 사용하면 사용자 정보를 담아두고 사용할 수 있지만, spring security를 사용하면
      // 사용자 정보가 인증 후 어딘가 보관되어 있을 것
      // member_id를 가져오기 위한 작업
      <sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
         member_id = '<sec:authentication property="principal.username"/>';
      </sec:authorize>
      if(member_id == null) {
         alert("장바구니 기능은 로그인 후 이용 가능!");
      }
      
      else {
         var checkedItems = [];
         var checkbox = $("input[name=checkSelect]:checked");

         // 체크된 체크박스 값을 가져온다
         checkbox.each(function(i) {
         
            // checkbox.parent() : checkbox의 부모는 <td>이다.
            // checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
            // check된 리스트 index 값 = i;
            var tr = checkbox.parent().parent().eq(i);
            var td = tr.children();
         
            // td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
            var imageSrc = td.eq(1).find('img').attr('src');
            var productName= td.eq(2).text();
            var productPrice = td.eq(3).text();
            var productStock = td.eq(4).text();

            var cartVO = {
               member_id : member_id,
               image_url : imageSrc,
               product_name : productName,
               product_price : productPrice,
               product_stock : productStock
            }
            // 가져온 값을 배열에 담는다.
            /*
            console.log(cartVO.member_id);
            console.log(cartVO.image_url);
            console.log(cartVO.product_name);
            console.log(cartVO.product_price);
            console.log(cartVO.product_stock);
            */
            checkedItems.push(cartVO);
         
         
            });
            //console.log(checkedItems);
            //console.log(JSON.stringify(checkedItems));
      
      
         $.ajax({
            type:   "post",
            contentType: "application/json; charset=utf-8",   
            async:   false,
            url:   "addInCart.do",
            dataType:   "json",
            data   :   JSON.stringify(checkedItems),
            success   :   function(response) {
               alert(response);            
            },
            error: function(response) {
               alert("에러가 발생!" );
            },
            complete: function(response) {
               //alert("작업을 완료했습니다.")
            }
         
         
         });
      }

   });
});
</script>
</head>
<body>

   <div id="container">
      <h1 style="margin-top: 0px; padding-top: 20px;">상품목록 조회</h1>
      <select name="contentnum" style="border: 1px solid #efefef;padding: 10px;margin-left: 0%;" id="contentnum" onchange="page(1)">
         <option value="10"
            <c:if test="${cupage.getContentnum() == 10 }">selected="selected"</c:if>>10
            개</option>
         <option value="20"
            <c:if test="${cupage.getContentnum() == 20 }">selected="selected"</c:if>>20
            개</option>
         <option value="30"
            <c:if test="${cupage.getContentnum() == 30 }">selected="selected"</c:if>>30
            개</option>
      </select>
      
      <table>
         <tr>
            <td><input type="text" value="${place.getPlaceName()}">
               상품정보</td>
         </tr>

      </table>

      <div class="row">
         <div>
         <button type="button" class="btn btn-outline btn-primary pull-left"
         id="insertBtn">장바구니 담기</button></div>
         <table class="table table-hover">
            <thead>
               <tr align="center" bgcolor="lightgreen">
                  <td width="1%">선택</td>
                  <td width="7%">이미지</td>
                  <td width="7%">상품 이름</td>
                  <td width="7%">가격(원)</td>
                  <td width="5%">수량(개)</td>
               </tr>
            </thead>
            <tbody>
               <c:if test="${empty list }">
                  <tr>
                  <td colspan="4" class="center">데이터가 없습니다</td>
                        <td><a href="index.jsp">이전 페이지로 돌아가기</a></td>
               </tr>
               </c:if>
               <c:if test="${not empty list }">
                  <c:forEach var="vo" items="${list }" begin="0"
                     end="${fn:length(list)-1 }" step="1">
                     <tr>
                        <td><input type="checkbox" name="checkSelect"></td>
                        <td><img src="${vo.getImageUrl() }" width="50" height="50"></td>
                        <td>${vo.getProductName() }</td>
                        <td>${vo.getProductPrice() }</td>
                        <td>${vo.getProductStock() }</td>
                  </c:forEach>
               </c:if>
         </tbody>
         <tfoot>
            <div class="row">
               <tr>
                  <td colspan="14">
                     <ul class="pagination">
                     <c:if test="${cupage.prev}">
                        <li class="page-item"><a class="page-link" href="javascript:page(${cupage.getStartPage()-1});">&laquo;</a></a></li>
                     </c:if> 
                        <c:forEach begin="${cupage.getStartPage()}" end="${cupage.getEndPage()}" var="idx">
                           <li class="page-item"><a class="page-link" href="javascript:page(${idx});">${idx}</a></li>
                        </c:forEach> 
                     <c:if test="${cupage.next}">
                        <li class="page-item"><a class="page-link" href="javascript:page(${cupage.getEndPage()+1});">&raquo;</a></li>
                     </c:if>
                     </ul>
                  </td>
               </tr>
            </div>
         </tfoot>
         </table>
      </div>
   </div>   
      <script type="text/javascript">
      /*한페이지당 게시물 */
      function page(idx) {

         var pagenum = idx;
         var contentnum = $("#contentnum option:selected").val();

         if (contentnum == 10) {
            location.href = "${pageContext.request.contextPath}/getculist.do?pagenum="
                  + pagenum + "&contentnum=" + contentnum

         } else if (contentnum == 20) {
            location.href = "${pageContext.request.contextPath}/getculist.do?pagenum="
                  + pagenum + "&contentnum=" + contentnum

         } else if (contentnum == 30) {
            location.href = "${pageContext.request.contextPath}/getculist.do?pagenum="
                  + pagenum + "&contentnum=" + contentnum

         }
      }
      </script>
</body>
</html>