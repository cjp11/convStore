<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<meta charset="utf-8">
<title>내 위치 +Category(편의점)</title>  
</head>
<body>
	<p style="margin-top: -12px">
		<em class="link"> </em>
	</p>
	<div id="map" style="width: 600px; height: 600px;"></div>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"
		integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
		crossorigin="anonymous"></script>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7eeff374a226bbade329e8ef5a1bcc39&libraries=services"></script>
	<script>
      //마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
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

                  // 카테고리로 은행을 검색합니다 CS2 = 편의점
                  ps.categorySearch('CS2', placesSearchCB, {
                     useMapBounds : true
                  });

                  // 키워드 검색 완료 시 호출되는 콜백함수 입니다
                  function placesSearchCB(data, status, pagination) {
                     if (status === kakao.maps.services.Status.OK) {
                        for (var i = 0; i < data.length; i++) {
                           displayMarker(data[i]);
                        }
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

                     var locIwContent = '<div style="padding:5px;">　　　here!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                     locIwPosition = new kakao.maps.LatLng(lat, lon); //인포윈도우 표시 위치입니다

                     //locMarker 인포윈도우를 생성합니다
                     var locInfowindow = new kakao.maps.InfoWindow({
                        position : locIwPosition,
                        content : locIwContent
                     });

                     //locMarker 인포윈도우 출력
                     locInfowindow.open(map, locMarker);

                     //Marker에 클릭이벤트를 등록합니다
                     kakao.maps.event
                           .addListener(
                                 marker,
                                 'click',
                                 function() {

                                    // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
                                    infowindow
                                          .setContent('<div style="padding:5px;font-size:12px;">'
                                                + place.place_name
                                                + '</div>');
                                    infowindow.open(map, marker);
                                    console.log(place.place_name);

                                 });
                  }

               });
      }
   </script>
	<form name="map_form" action="start.do" method="get">
		<input type="text" name="addr" id="adr" value="" /><br> <input
			type="text" name="placeName" id="pn" value="" />
		<button id="submitBtn" type="submit">send</button>
	</form>
	
</body>
</html>