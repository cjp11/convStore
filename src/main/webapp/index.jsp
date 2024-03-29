
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="main" name="pageTitle"/>
</jsp:include>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.js"></script>   
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua" rel="stylesheet">
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ef71da31f75cfbe631c83c174a6b3437&libraries=services"></script>
<script charset="UTF-8" type="text/javascript"
   src="https://t1.daumcdn.net/cssjs/postcode/1522037570977/180326.js"></script>
<sec:authorize access="hasAnyRole('ROLE_USER')">
   <sec:authentication property="principal.username" var="member_id"/>
   <sec:authentication property="principal.member_name" var="member_name"/>
</sec:authorize>

<html>
<head>
<title>내 위치 +Category(편의점)</title>  
<style>
.map_wrap, .map_wrap * {
   margin: 0;
   padding: 0;
   font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
   font-size: 12px;
}

.map_wrap {
   position: relative;
   width: 100%;
   height: 350px;
}

#category {
   position: absolute;
   top: 10px;
   left: 10px;
   border-radius: 5px;
   border: 1px solid #909090;
   box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
   overflow: hidden;
   z-index: 2;
}

#category li {
   float: left;
   list-style: none;
   width: 50px; px;
   border-right: 1px solid #acacac;
   padding: 6px 0;
   text-align: center;
   cursor: pointer;
}

#category li.on {
   background: #eee;
}

#category li:hover {
   background: #ffe6e6;
   border-left: 1px solid #acacac;
   margin-left: -1px;
}

#category li:last-child {
   margin-right: 0;
   border-right: 0;
}

#category li span {
   display: block;
   margin: 0 auto 3px;
   width: 27px;
   height: 28px;
}

#category li .category_bg {
   content: '';
   position: relative;
   margin-left: -12px;
   left: 50%;
   width: 30px;
   height: 30px;
   background:
      url(http://drive.google.com/uc?export=view&id=12jkCfs2U8syETm99xaTI963acQfRk7fa)
      no-repeat;
}

#category li .bank {
   background-position: -10px 0;
}

#category li .mart {
   background-position: -10px -36px;
}

#category li .pharmacy {
   background-position: -10px -72px;
}

#category li .oil {
   background-position: -10px -108px;
}

#category li .cafe {
   background-position: -10px -144px;
}

#category li .store {
   background-position: -10px -180px;
}

#category li.on .category_bg {
   background-position-x: -46px;
}

.placeinfo_wrap {
   position: absolute;
   bottom: 28px;
   left: -150px;
   width: 300px;
}

.placeinfo {
   position: relative;
   width: 100%;
   border-radius: 6px;
   border: 1px solid #ccc;
   border-bottom: 2px solid #ddd;
   padding-bottom: 10px;
   background: #fff;
}

.placeinfo:nth-of-type(n) {
   border: 0;
   box-shadow: 0px 1px 2px #888;
}

.placeinfo_wrap .after {
   content: '';
   position: relative;
   margin-left: -12px;
   left: 50%;
   width: 22px;
   height: 12px;
   background:
      url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.placeinfo a, .placeinfo a:hover, .placeinfo a:active {
   color: #fff;
   text-decoration: none;
}

.placeinfo a, .placeinfo span {
   display: block;
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
}

.placeinfo span {
   margin: 5px 5px 0 5px;
   cursor: default;
   font-size: 13px;
}

.placeinfo .title {
   font-weight: bold;
   font-size: 14px;
   border-radius: 6px 6px 0 0;
   margin: -1px -1px 0 -1px;
   padding: 10px;
   color: #fff;
   background: #d95050;
   background: #d95050
      url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
      no-repeat right 14px center;
}

.placeinfo .tel {
   color: #0f7833;
}

.placeinfo .jibun {
   color: #999;
   font-size: 11px;
   margin-top: 0;
}
</style>
</head>



<body>
<br><br><br><br>
<div class="content-section" id="contact">
		<div class="container">
			<div class="searchBox">
			<form name="map_form" action='start.do' method="get">
		<hidden input type="text" name="changeName" id="pn2"
			style="width: 200px;
		   height: 25.98438px;" />
		<hidden input type="text" name="address" id="adr"
			style="width: 200px;
		   height: 25.98438px;"/>
		   점포명: <input type="text" name="placeName" id="pn4"
			style="width: 180px; height: 29px;" />
			주소:   <input
			type="text" name="addr" id="pn3"
			style="width: 226px; height: 29px; margin-bottom: 10px;" />

		<button id="submitBtn" type="submit">재고검색</button>
	</form>
				<!-- <input class="searchInput" type="text" name="" placeholder="Search">
				<button class="searchButton" href="#">
					<i class="material-icons">편의점 검색</i>
				</button> -->
			</div>

			<!-- ////////////////////////////////////////////////////////////////////// -->
			<div class="row">




<!-- 2020_11_24_추가_시작_주홍 -->
<body>

	<p style="margin-top: -12px">
		<em class="link"> </em>
	</p>
	<div class="map_wrap">
		<div id="map"
			style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
		<ul id="category">
			<li id="CS2" data-order="5" style="background-color: rgb(241,243,244);">"click"<span class="category_bg store"></span>
		</ul>
	</div>
	<p style="margin-top: -12px">
		<em class="link"></em>
	</p>
	<div id="map" style="width: 10px; height: 10px;"></div>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"
		integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
		crossorigin="anonymous"></script>
	<!-- <script type="text/javascript"
src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05e91b3448aa9a644d40f7ad8293b48d&libraries=services"></script> -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=05e91b3448aa9a644d40f7ad8293b48d&libraries=services,clusterer,drawing"></script>
	<script>
		//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var placeOverlay = new kakao.maps.CustomOverlay({
			zIndex : 1
		}), contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
		markers = [], // 마커를 담을 배열입니다
		currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다

		var infowindow = new kakao.maps.InfoWindow({
			zIndex : 1
		});

		//HTML5의 geolocation으로 사용할 수 있는지 확인합니다
		if (navigator.geolocation) {

			//1. 현재 내위치의 위도 경도
			//2. 내위치 중심으로 지도 표현
			//3. 현재 내가 보이는 영역안의 편의점 표시

			// GeoLocation을 이용해서 접속 위치를 얻어옵니다
			navigator.geolocation
					.getCurrentPosition(function(position) {

						//주소-좌표간 변환 서비스 객체를 생성한다.
						var geocoder = new kakao.maps.services.Geocoder();

						var lat = position.coords.latitude, // 위도
						lon = position.coords.longitude; // 경도+
						console.log(lat);
						console.log(lon);

						//좌표 값에 해당하는 구 주소와 도로명 주소 정보를 요청한다.
						var coord = new kakao.maps.LatLng(lat, lon);
						var callback = function(result, status) {
							if (status === kakao.maps.services.Status.OK) {
								console.log(result[0].address.address_name);
								var el = document.getElementById('adr');
								el.value = result[0].address.address_name;

							}
						};

						geocoder.coord2Address(coord.getLng(), coord.getLat(),
								callback);

						var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
						message = '<div style="padding:5px;">"내위치"</div>' // 인포윈도우에 표시될 내용입니다
						mapContainer = document.getElementById('map'), // 지도를 표시할 div
						mapOption = {
							center : locPosition,//new kakao.maps.LatLng(37.3941905, 126.94064039999999), // 지도의 중심좌표
							//locPosition 지도의 좌표를 담은 변수
							level : 3
						// 지도의 확대 레벨
						};

						// 지도를 생성합니다
						var map = new kakao.maps.Map(mapContainer, mapOption);

						// 장소 검색 객체를 생성합니다
						var ps = new kakao.maps.services.Places(map);

						//지도에 idle 이벤트를 등록합니다
						kakao.maps.event.addListener(map, 'idle', searchPlaces);

						// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
						contentNode.className = 'placeinfo_wrap';

						//커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
						//지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
						addEventHandle(contentNode, 'mousedown',
								kakao.maps.event.preventMap);
						addEventHandle(contentNode, 'touchstart',
								kakao.maps.event.preventMap);

						//커스텀 오버레이 컨텐츠를 설정합니다
						placeOverlay.setContent(contentNode);

						// 각 카테고리에 클릭 이벤트를 등록합니다
						addCategoryClickEvent();

						//엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
						function addEventHandle(target, type, callback) {
							if (target.addEventListener) {
								target.addEventListener(type, callback);
							} else {
								target.attachEvent('on' + type, callback);
							}
						}
						//카테고리 검색을 요청하는 함수입니다
						function searchPlaces() {
							if (!currCategory) {
								return;
							}

							// 커스텀 오버레이를 숨깁니다 
							placeOverlay.setMap(null);

							// 지도에 표시되고 있는 마커를 제거합니다
							removeMarker();

							ps.categorySearch(currCategory, placesSearchCB, {
								useMapBounds : true
							});
						}

						// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
						function placesSearchCB(data, status, pagination) {
							if (status === kakao.maps.services.Status.OK) {

								// 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
								displayPlaces(data);
								// 카테고리로 은행을 검색합니다 CS2 = 편의점
								ps.categorySearch('CS2', placesSearchCB, {
									useMapBounds : true
								});

								// 키워드 검색 완료 시 호출되는 콜백함수 입니다
								function placesSearchCB(data, status,
										pagination) {
									if (status === kakao.maps.services.Status.OK) {
										for (var i = 0; i < data.length; i++) {
											displayMarker(data[i]);
										}
									}
								}
							} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
								// 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

							} else if (status === kakao.maps.services.Status.ERROR) {
								// 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

							}
						}
						//지도에 마커를 표출하는 함수입니다
						function displayPlaces(places) {

							// 몇번째 카테고리가 선택되어 있는지 얻어옵니다
							// 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
							var order = document.getElementById(currCategory)
									.getAttribute('data-order');

							for (var i = 0; i < places.length; i++) {

								// 마커를 생성하고 지도에 표시합니다
								var marker = addMarker(new kakao.maps.LatLng(
										places[i].y, places[i].x), order);

								// 마커와 검색결과 항목을 클릭 했을 때
								// 장소정보를 표출하도록 클릭 이벤트를 등록합니다
								(function(marker, place) {
									kakao.maps.event.addListener(marker,
											'click', function() {
												displayPlaceInfo(place);
											});
								})(marker, places[i]);
							}
						}
						//마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
						function addMarker(position, order) {
							var imageSrc = 'http://drive.google.com/uc?export=view&id=12jkCfs2U8syETm99xaTI963acQfRk7fa', // 마커 이미지 url, 스프라이트 이미지를 씁니다
							imageSize = new kakao.maps.Size(27, 28), // 마커 이미지의 크기
							imgOptions = {
								spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
								spriteOrigin : new kakao.maps.Point(46,
										(order * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
								offset : new kakao.maps.Point(11, 28)
							// 마커 좌표에 일치시킬 이미지 내에서의 좌표
							}, markerImage = new kakao.maps.MarkerImage(
									imageSrc, imageSize, imgOptions), marker = new kakao.maps.Marker(
									{
										position : position, // 마커의 위치
										image : markerImage
									});

							marker.setMap(map); // 지도 위에 마커를 표출합니다
							markers.push(marker); // 배열에 생성된 마커를 추가합니다

							return marker;
						}
						//지도 위에 표시되고 있는 마커를 모두 제거합니다
						function removeMarker() {
							for (var i = 0; i < markers.length; i++) {
								markers[i].setMap(null);
							}
							markers = [];
						}

						// 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
						function displayPlaceInfo(place) {
							var content = '<div class="placeinfo">'
									+ '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">'
									+ place.place_name + '</a>';
							console.log(place.place_name);
							var yy = document.getElementById('pn2');
							yy.value = place.place_name;
							var rename = yy.value.replace(/ /gi, '-');
							console.log(rename);
							var result = document.getElementById('pn4');
							result.value = rename;

							if (place.road_address_name) {
								content += '    <span title="' + place.road_address_name + '">'
										+ place.road_address_name
										+ '</span>'

										+ '  <span class="jibun" title="' + place.address_name + '">(지번 : '
										+ place.address_name + ')</span>';
								console.log(place.address_name);
								var xx = document.getElementById('pn3');
								xx.value = place.address_name;
							} else {
								content += '    <span title="' + place.address_name + '">'
										+ place.address_name + '</span>';
							}

							content += '    <span class="tel">' + place.phone
									+ '</span>' + '</div>'
									+ '<div class="after"></div>';

							contentNode.innerHTML = content;
							placeOverlay.setPosition(new kakao.maps.LatLng(
									place.y, place.x));
							placeOverlay.setMap(map);
						}
						//각 카테고리에 클릭 이벤트를 등록합니다
						function addCategoryClickEvent() {
							var category = document.getElementById('category'), children = category.children;

							for (var i = 0; i < children.length; i++) {
								children[i].onclick = onClickCategory;

							}
						}
						//카테고리를 클릭했을 때 호출되는 함수입니다
						function onClickCategory() {
							var id = this.id, className = this.className;

							placeOverlay.setMap(null);

							if (className === 'on') {
								currCategory = '';
								changeCategoryClass();
								removeMarker();
							} else {
								currCategory = id;
								changeCategoryClass(this);
								searchPlaces();
							}
						}
						//클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
						function changeCategoryClass(el) {
							var category = document.getElementById('category'), children = category.children, i;

							for (i = 0; i < children.length; i++) {
								children[i].className = '';
							}

							if (el) {
								el.className = 'on';
							}
						}

						/////////////////로컬마커
						var locMarker = new kakao.maps.Marker({
							map : map,
							position : locPosition
						});

						/////////////<<<< 편의점 마커 이미지 파트 시작
						//GS25 이미지
						var GsimageSrc = 'http://drive.google.com/uc?export=view&id=1IQamK8q8n6Z_qiVG4tSBrrSfP4Lg6VAB', // 마커이미지의 주소입니다
						GsimageSize = new kakao.maps.Size(50, 40), // 마커이미지의 크기입니다
						GsimageOption = {
							offset : new kakao.maps.Point(27, 69)
						}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

						//CU 이미지
						var CuimageSrc = 'http://drive.google.com/uc?export=view&id=1h817PatMkX8Cg1twRdENFWBYvlQZ7s7v', // 마커이미지의 주소입니다
						CuimageSize = new kakao.maps.Size(50, 40), // 마커이미지의 크기입니다
						CuimageOption = {
							offset : new kakao.maps.Point(27, 69)
						}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

						//이마트 이미지
						var EmimageSrc = 'http://drive.google.com/uc?export=view&id=1cf23S1usCUoO0bXFT6lyt46UboNK7bu-', // 마커이미지의 주소입니다
						EmimageSize = new kakao.maps.Size(50, 40), // 마커이미지의 크기입니다
						EmimageOption = {
							offset : new kakao.maps.Point(27, 69)
						}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

						//세븐일레븐 이미지
						var SevenimageSrc = 'http://drive.google.com/uc?export=view&id=1BTxAzHsELZ0lRXyhgd1IJlz-27sXOm7T', // 마커이미지의 주소입니다
						SevenimageSize = new kakao.maps.Size(50, 40), // 마커이미지의 크기입니다
						SevenimageOption = {
							offset : new kakao.maps.Point(27, 69)
						}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

						//미니스톱 이미지
						var MiniimageSrc = 'http://drive.google.com/uc?export=view&id=1iXCrXVnXGhv5mV5lumwaxNX9A_VS4U8f', // 마커이미지의 주소입니다
						MiniimageSize = new kakao.maps.Size(50, 40), // 마커이미지의 크기입니다
						MiniimageOption = {
							offset : new kakao.maps.Point(27, 69)
						}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

						//기타 편의점 이미지
						var imageSrc = 'http://drive.google.com/uc?export=view&id=1wrro7R0tKQFi_s5wr6yBqlB1z4TDYXSp', // 마커이미지의 주소입니다
						imageSize = new kakao.maps.Size(50, 40), // 마커이미지의 크기입니다
						imageOption = {
							offset : new kakao.maps.Point(27, 69)
						}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
						/////////////>>>> 편의점 마커 이미지 파트 끝

						/////////////<<<< 편의점 마커의 이미지정보를 가지고 있는 마커이미지를 생성 시작
						var GsmarkerImage = new kakao.maps.MarkerImage(
								GsimageSrc, GsimageSize, GsimageOption);
						var CumarkerImage = new kakao.maps.MarkerImage(
								CuimageSrc, CuimageSize, CuimageOption);
						var EmmarkerImage = new kakao.maps.MarkerImage(
								EmimageSrc, EmimageSize, EmimageOption);
						var SevenmarkerImage = new kakao.maps.MarkerImage(
								SevenimageSrc, SevenimageSize, SevenimageOption);
						var MinimarkerImage = new kakao.maps.MarkerImage(
								MiniimageSrc, MiniimageSize, MiniimageOption);
						var markerImage = new kakao.maps.MarkerImage(imageSrc,
								imageSize, imageOption);
						/////////////>>>> 편의점 마커의 이미지정보를 가지고 있는 마커이미지를 생성 끝

						/////////////<<<< 지도에 편의점별 마커를 표시하는 함수 시작
						function displayMarker(place) {
							// console.log(place.place_name); // 지도에 마커가 로딩되면 플래이스 네임을 콘솔창에 출력
							var placeText = place.place_name;

							if (placeText.indexOf("GS25") != -1) {
								console.log("indexOf: GS25")
								var marker = new kakao.maps.Marker({
									map : map,
									position : new kakao.maps.LatLng(place.y,
											place.x),
									image : GsmarkerImage
								// 마커이미지 설정
								});
							} else if (placeText.indexOf("CU") != -1) {
								console.log("indexOf: CU")
								var marker = new kakao.maps.Marker({
									map : map,
									position : new kakao.maps.LatLng(place.y,
											place.x),
									image : CumarkerImage
								// 마커이미지 설정
								});
							} else if (placeText.indexOf("이마트24") != -1) {
								console.log("indexOf: 이마트24")
								var marker = new kakao.maps.Marker({
									map : map,
									position : new kakao.maps.LatLng(place.y,
											place.x),
									image : EmmarkerImage
								// 마커이미지 설정
								});
							} else if (placeText.indexOf("세븐일레븐") != -1) {
								console.log("indexOf: 세븐일레븐")
								var marker = new kakao.maps.Marker({
									map : map,
									position : new kakao.maps.LatLng(place.y,
											place.x),
									image : SevenmarkerImage
								// 마커이미지 설정
								});
							} else if (placeText.indexOf("미니스톱") != -1) {
								console.log("indexOf: 미니스톱")
								var marker = new kakao.maps.Marker({
									map : map,
									position : new kakao.maps.LatLng(place.y,
											place.x),
									image : MinimarkerImage
								// 마커이미지 설정
								});
							} else {
								console.log("indexOf: 기타편의점")
								var marker = new kakao.maps.Marker({
									map : map,
									position : new kakao.maps.LatLng(place.y,
											place.x),
									image : markerImage
								// 마커이미지 설정
								});
							}
							/////////////>>>> 지도에 편의점별 마커를 표시하는 함수 끝

							//locMarker 가 표시될 위치입니다
							var locMarkerPosition = new kakao.maps.LatLng(lat,
									lon);

							//locMarker를 생성합니다
							var locMarker = new kakao.maps.Marker({
								position : locMarkerPosition
							});

							//locMarker가 지도 위에 표시되도록 설정합니다
							locMarker.setMap(map);

							var locIwContent = '<div style="width:150px;text-align:center;padding:6px 0;">here</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
							locIwPosition = new kakao.maps.LatLng(lat, lon); //인포윈도우 표시 위치입니다

							//locMarker 인포윈도우를 생성합니다
							var locInfowindow = new kakao.maps.InfoWindow({
								position : locIwPosition,
								content : locIwContent
							});

							//locMarker 인포윈도우 출력
							locInfowindow.open();

							//Marker에 클릭이벤트를 등록합니다
							kakao.maps.event.addListener(marker, 'click',
									function() {

										// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
										infowindow.setContent();
										infowindow.open(map, marker);
										console.log(place.place_name);
										var placeName = document
												.getElementById('pn');
										placeName.value = place.place_name;
										var rename = placeName.value.replace(
												/ /gi, '-');
										console.log(rename);
										var result = document
												.getElementById('pn2');
										result.value = rename;
									});
						}

					});

		}
	</script>
	
</body>
				</html>
			</div>
			<!-- /.row -->
			<!-- ////////////////////////////////////////////////////////////////////// -->

			<div class="row">
				<div class="col-md-7 col-sm-6"></div>
				<!-- /.col-md-7 -->
				<div class="col-md-5 col-sm-6">
					<div class="contact-form"></div>
					<!-- /.contact-form -->
				</div>
				<!-- /.col-md-5 -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container -->
	</div>
	<!-- /#contact -->




	<div class="content-section" id="portfolio">
		<div class="container">
			<div class="row">
				<div class="heading-section col-md-12 text-center">
					<h2>MD추천</h2>
				</div>
				<!-- /.heading-section -->
			</div>
			<!-- /.row -->
			<div class="row">
				<div class="portfolio-item col-md-3 col-sm-6">
					<div class="portfolio-thumb">
						<img src="images/gallery/p1.jpg" alt="">
						<div class="portfolio-overlay">
							<h3>New Walk</h3>
							<p>Asperiores commodi illo fuga perferendis dolore
								repellendus sapiente ipsum.</p>
							<a href="images/gallery/p1.jpg" data-rel="lightbox"
								class="expand"> <i class="fa fa-search"></i>
							</a>
						</div>
						<!-- /.portfolio-overlay -->
					</div>
					<!-- /.portfolio-thumb -->
				</div>
				<!-- /.portfolio-item -->
				<div class="portfolio-item col-md-3 col-sm-6">
					<div class="portfolio-thumb">
						<img src="images/gallery/p2.jpg" alt="">
						<div class="portfolio-overlay">
							<h3>Boat</h3>
							<p>Asperiores commodi illo fuga perferendis dolore
								repellendus sapiente ipsum.</p>
							<a href="images/gallery/p2.jpg" data-rel="lightbox"
								class="expand"> <i class="fa fa-search"></i>
							</a>
						</div>
						<!-- /.portfolio-overlay -->
					</div>
					<!-- /.portfolio-thumb -->
				</div>
				<!-- /.portfolio-item -->
				<div class="portfolio-item col-md-3 col-sm-6">
					<div class="portfolio-thumb">
						<img src="images/gallery/p7.jpg" alt="">
						<div class="portfolio-overlay">
							<h3>Urban</h3>
							<p>Asperiores commodi illo fuga perferendis dolore
								repellendus sapiente ipsum.</p>
							<a href="images/gallery/p7.jpg" data-rel="lightbox"
								class="expand"> <i class="fa fa-search"></i>
							</a>
						</div>
						<!-- /.portfolio-overlay -->
					</div>
					<!-- /.portfolio-thumb -->
				</div>
				<!-- /.portfolio-item -->
				<div class="portfolio-item col-md-3 col-sm-6">
					<div class="portfolio-thumb">
						<img src="images/gallery/p8.jpg" alt="">
						<div class="portfolio-overlay">
							<h3>Cycling</h3>
							<p>Asperiores commodi illo fuga perferendis dolore
								repellendus sapiente ipsum.</p>
							<a href="images/gallery/p8.jpg" data-rel="lightbox"
								class="expand"> <i class="fa fa-search"></i>
							</a>
						</div>
						<!-- /.portfolio-overlay -->
					</div>
					<!-- /.portfolio-thumb -->
				</div>
				<!-- /.portfolio-item -->
				<div class="portfolio-item col-md-3 col-sm-6">
					<div class="portfolio-thumb">
						<img src="images/gallery/p3.jpg" alt="">
						<div class="portfolio-overlay">
							<h3>Digital Era</h3>
							<p>Asperiores commodi illo fuga perferendis dolore
								repellendus sapiente ipsum.</p>
							<a href="images/gallery/p3.jpg" data-rel="lightbox"
								class="expand"> <i class="fa fa-search"></i>
							</a>
						</div>
						<!-- /.portfolio-overlay -->
					</div>
					<!-- /.portfolio-thumb -->
				</div>
				<!-- /.portfolio-item -->
				<div class="portfolio-item col-md-3 col-sm-6">
					<div class="portfolio-thumb">
						<img src="images/gallery/p4.jpg" alt="">
						<div class="portfolio-overlay">
							<h3>Horizon</h3>
							<p>Asperiores commodi illo fuga perferendis dolore
								repellendus sapiente ipsum.</p>
							<a href="images/gallery/p4.jpg" data-rel="lightbox"
								class="expand"> <i class="fa fa-search"></i>
							</a>
						</div>
						<!-- /.portfolio-overlay -->
					</div>
					<!-- /.portfolio-thumb -->
				</div>
				<!-- /.portfolio-item -->
				<div class="portfolio-item col-md-3 col-sm-6">
					<div class="portfolio-thumb">
						<img src="images/gallery/p5.jpg" alt="">
						<div class="portfolio-overlay">
							<h3>Aquatic City</h3>
							<p>Asperiores commodi illo fuga perferendis dolore
								repellendus sapiente ipsum.</p>
							<a href="images/gallery/p5.jpg" data-rel="lightbox"
								class="expand"> <i class="fa fa-search"></i>
							</a>
						</div>
						<!-- /.portfolio-overlay -->
					</div>
					<!-- /.portfolio-thumb -->
				</div>
				<!-- /.portfolio-item -->
				<div class="portfolio-item col-md-3 col-sm-6">
					<div class="portfolio-thumb">
						<img src="images/gallery/p6.jpg" alt="">
						<div class="portfolio-overlay">
							<h3>New Path</h3>
							<p>Asperiores commodi illo fuga perferendis dolore
								repellendus sapiente ipsum.</p>
							<a href="images/gallery/p6.jpg" data-rel="lightbox"
								class="expand"> <i class="fa fa-search"></i>
							</a>
						</div>
						<!-- /.portfolio-overlay -->
					</div>
					<!-- /.portfolio-thumb -->
				</div>
				<!-- /.portfolio-item -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container -->
	</div>
	<!-- /#portfolio -->






	<div id="footer">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-xs-12 text-left">
					<span>DEMO PROJECT OF TEAM-1 </span>
				</div>
				<!-- /.text-center -->
				<div class="col-md-4 hidden-xs text-right">
					<a href="#top" id="go-top">Back to top</a>
				</div>
				<!-- /.text-center -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container -->
	</div>
	<!-- /#footer -->

	<script src="js/vendor/jquery-1.11.0.min.js"></script>
	<script>
		window.jQuery
				|| document
						.write('<script src="js/vendor/jquery-1.11.0.min.js"><\/script>')
	</script>
	<script src="js/bootstrap.js"></script>
	<script src="js/plugins.js"></script>
	<script src="js/main.js"></script>

	<!-- Google Map -->
	<script src="http://maps.google.com/maps/api/js?sensor=true"></script>
	<script src="js/vendor/jquery.gmap3.min.js"></script>

	<!-- Google Map Init-->
	<script type="text/javascript">
		jQuery(function($) {
			$('#map_canvas').gmap3({
				marker : {
					address : '37.769725, -122.462154'
				},
				map : {
					options : {
						zoom : 15,
						scrollwheel : false,
						streetViewControl : true
					}
				}
			});

			/* Simulate hover on iPad
			 * http://stackoverflow.com/questions/2851663/how-do-i-simulate-a-hover-with-a-touch-in-touch-enabled-browsers
			 --------------------------------------------------------------------------------------------------------------*/
			$('body').bind('touchstart', function() {
			});
		});
	</script>
	<!-- templatemo 406 flex -->
</body>
</html>
<!-- 2020_11_24_추가_종료_주홍 -->




