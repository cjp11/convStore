<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<<<<<<< HEAD
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
=======

>>>>>>> branch 'master' of https://github.com/fbrudtlr9870/Roundup.git
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="Manager-Page" name="pageTitle" />
</jsp:include>

<style>
.imsosotired {
   font-size: 20px;
   color: #337ab7;
   font-weight: bold;
}

* {
   box-sizing: border-box;
}

body {
   font-family: Arial;
   background: #f1f1f1;
}

.rightcolumn {
   float: left;
   width: 100%;
}

/*image */
.img {
   background-color: lightblue;
   width: 100%;
   padding: 20px;
}

/* Add a card effect for articles */
.card {
   background-color: white;
   padding: 20px;
   margin-top: 20px;
}

/* Clear floats after the columns */
.row:after {
   content: "";
   display: table;
   clear: both;
}

@media screen and (max-width: 800px) {
   .leftcolumn, .rightcolumn {
      width: 100%;
      padding: 0;
   }
}

@media screen and (max-width: 400px) {
   .topnav a {
      float: none;
      width: 100%;
   }
}

section div.section_div-s {
   margin: 0 auto;
   width: 850px;
   min-height: 300px;
   height: auto;
}

div.section_div-s button.btn {
   background: rgba(50, 50, 58, 0.877);
   color: white;
   border: 0px;
   border-radius: 5px;
   margin: 5px;
   padding: 3px;
   padding-left: 10px;
   padding-right: 10px;
}

div.section_div-s {
   text-align: center;
}

div.section_div-s table {
   margin: 0 auto;
   border: 1px solid #ddd;
   border-collapse: collapse;
}

div.section_div-s table tr {
   border: 1px solid #ddd;
}

div.section_div-s table tr:hover {
   border: 1px solid #ddd;
   background: #FFEAEA;
}

div.section_div-s table tr th {
   border: 1px solid #ddd;
   background: lightblue;
   padding: 15px;
}

div.section_div-s table tr td {
   border: 1px solid #ddd;
   padding: 10px;
}

.imsosotired2 {
   font-weight: bold;
   padding-bottom: 10px;
}

.btnfordh {
   display: inline-block;
   padding: 6px 50px;
   font-size: 14px;
   font-weight: 400;
   line-height: 1.42857143;
   text-align: center;
   white-space: nowrap;
   vertical-align: middle;
   -ms-touch-action: manipulation;
   touch-action: manipulation;
   cursor: pointer;
   -webkit-user-select: none;
   -moz-user-select: none;
   -ms-user-select: none;
   user-select: none;
   background-image: none;
   border: 1px solid transparent;
   border-radius: 4px;
   vertical-align: middle;
}

.btnfordhout {
   width: 100%;
   text-align: center;
}

#btnfordhin {
   display: inline-block;
   width: 50%;
}




</style>


<br>
<br>
<h2 class="imsosotired">회원관리</h2>
<br />

<div class="main-li-container">

   <div class="row">

      <div class="rightcolumn">
         <div class="section_div-s">
            <br />
            <p class="imsosotired2">총 회원 수 : ${totalContents }명</p>

            <table>
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
            <%=com.example.demo.utill.Utils.getPageBar(totalContents, cPage, numPerPage, "managerPage.do")%>

         </div>
         
                
         
        </div>
        <br><br><br>
        

      </div>

   </div>


<script>
   $(function() {
      $("tr[no]").on("click",function() {
         console.log($(this).attr("no"));
         location.href = "${pageContext.request.contextPath}/manager/managerView.do?member_id="
               + $(this).attr("no");
      });
   });
</script>
