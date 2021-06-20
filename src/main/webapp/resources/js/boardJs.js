/* -------------------------------------------게시판 적용 스크립트-------------------------------- */
/*list 다중체크*/

/*form null 체크*/
function bdCheck() {
	if (document.search.input.value == "") {
		alert("검색 키워드를 입력하세요");
		document.search.input.focus();
		return;
	}
	document.search.submit();
}

/* null 유효성 체크 */
function isNull(elm) {
	var elm;
	return (elm == null || elm == "" || elm == "undefined") ? true : false;
}



/* 게시판에서 null일때 */
function validCheck() {
	var thisform = document.bdForm;
	
	if ( (isNull(bdForm.b_title.value)) ) {
		alert("제목을 입력해주세요");
		bdForm.b_title.focus();
		return false;
	
	} else if ( isNull(CKEDITOR.instances.b_content.getData())) {
		alert("내용을 입력해주세요");
		bdForm.b_title.focus();
		return false;
	}
}

/* admin에서 모든글 삭제 */

function allChk(bool) {
	var chks = document.getElementsByName("chk");
	for (var i = 0; i < chks.length; i++) {
		chks[i].checked = bool;
	}
}



$(function() {
	$("#mudelForm").submit(function() {
		if ($("#mudelForm input:checked").length == 0) {
			alert("하나 이상 체크해 주세요.");
			return false;
		} else {

			return true;
		}

	});
});


/* textarea 마지막 bottom라인 추가 */
$(document).ready(function() {
	$(".sty_dtlCon").parent().css({
		"border-bottom" : "1px solid #ddd"
	});

	$(".sty_pnoId").css({
		"color" : "#ff8040",
		"font-size" : "14px",
		"font-weight" : "bold"
	});
});

/* detail과 update */
function detailForm() {
	var flag = confirm("게시글 수정을 취소하시겠습니까?");

	if (flag == true) {
		$("#updateForm").hide();
		$("h3").parent().show();
		$("#detailForm").show();
	}
}



function updateForm() {
	$("#detailForm").hide();
	$(".comList").hide(); // 게시판 수정화면에 댓글영역 감추기 위해
	$("#updateForm").show();
}
//글작성 취소
function boardList() {
	var flag = confirm("게시글 작성을 취소하시겠습니까?");

	if (flag == true) {
		location.href = 'BoardList.do?pageNo=1';
	}
}

$(document).ready(function() {
	$(".AnswerUpdate").hide();
});

function UpdateForm(index) {
	$(".AnswerAfter").eq(index).hide();
	$(".AnswerUpdate").eq(index).show();

}

$(function() {
//페이지1일때 << 막기
	if (Page == 1) {
		$("#firstPage").removeAttr("onclick");
	}
	//마지막페이지일떄 >> 막기
	if (total == Page) {
		$("#lastPage").removeAttr("onclick");
	}

})
//페이지 넘기기
function boardListPage(page) {
	if (page < 1) {
		page = 1;
	}
	if (page > total) {
		page = total;
	}
	location.href = "BoardList.do?pageNo=" + page;
}
// 검색 페이지 넘기기
function boardSearchPage(page, option, input) {
	if (page < 1) {
		page = 1;
	}
	if (page > total) {
		page = total;
	}
	location.href = "BoardSearch.do?pageNo=" + page + "&option=" + option + "&input=" + input;

}


/* 첫번째 댓글 패딩값 제어 */
$(document).ready(function() {
	$(".sty_commList:eq(0)").css({
		"padding-top" : "20px"
	});
});



var b_no = location.href.split("?b_no=")[1];


$(function() {


	$('.sty_commBtn').click(function() {
		var insertData = $('[name=answerForm]').serialize();
		answerInsert(insertData);
	});
});

function answerInsert(insertData) {
	$.ajax({
		url : 'AnswerInsert.do',
		type : 'post',
		data : insertData,
		success : function(data) {
			if (data == 1) {
				answerList();
				$('[name=a_content]').val('');
			}
		},error:function(request,status,error){
		    alert("내용을 입력해주세요");
		   }
	});
}

function answerList() {
	$.ajax({
		url : 'AnswerList.do',
		type : 'get',
		data : {
			'b_no' : b_no
		},
		success : function(data) {
			var a = '';
			$.each(data, function(key, value) {
				var b = '';
				var c = '';
				var d = '';
				if (value.a_en == 'Y') {
					if (value.lv != 1) {
						b = '&nbsp;&nbsp;&nbsp;' + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㄴ';
						c = '&nbsp;&nbsp;&nbsp;' + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
						d = value.pno_id;
					}
					
					a += '<ul class="sty_commL">';
					a += '<li class="sty_ftBold">' + b + value.member_id + '&nbsp;</li><li class="sty_pnoId">' + d + '&nbsp;</li>&nbsp;<li>' + value.a_date+'</li>';
					a += '<li><a id="answerResFalse' + value.a_no + '" onclick="answerReForm(' + value.a_no + ');"> 답글 </a></li>';
					a += '</ul>';
					a += '<ul class="sty_commR">';
					if (loginGrade == 'ROLE_ADMIN' || loginId == value.member_id) {
						a += '<li><a onclick="answerDelete(' + value.a_no + ');"> 삭제 </a></li>';
					}
					if (loginId == value.member_id) {
						a += '<li class="sty_h10"><a>'+'|'+'</a></li>';
						a += '<li><a id="updateFalse' + value.a_no + '" onclick="answerUpdate(' + value.a_no + ',\'' + value.a_content + '\');"> 수정 </a></li>';
					}
					a += '</ul>';
					a += '<div class="sty_commCon sty_clrBoth">';
					a += '<p class="sty_commText answerContent'+value.a_no+'"><span>'+ c +'</span>'+value.a_content+'</p>';
					a += '</div>';
					a += '<div id="answerRe' + value.a_no + '"></div>';

				} else {
					a += '<div class="sty_commCon">';
					a += '<div class="answerContent' + value.a_no + '"> <p  class="sty_commText" style="padding-left:30px"><span>삭제된 댓글입니다</span></p>';
					a += '</div></div>';
					a += '<div id="answerRe' + value.a_no + '"></div>';
				}
			});

			$(".sty_commList").html(a);
		}
	});
}




function answerRe() {
	var reInsertData = $('[name=answerReForm]').serialize();
	$.ajax({
		url : 'AnswerInsertRe.do',
		type : 'post',
		data : reInsertData,
		success : function(data) {
			if (data == 1) {
				answerList();
			}
		},error:function(request,status,error){
		    alert("내용을 입력해주세요");
		   }
	});
}

function answerReForm(a_no) {
	$("#answerResFalse" + a_no).text("답글취소").attr("onclick", "answerList()");

	$("#updateFalse" + a_no).attr("onclick", "");

	var a = '';
	a += '<form name="answerReForm"><div  class="sty_commArea">';
	a += '<input type="hidden" name="b_no" value=' + b_no + '>';
	a += '<input type="hidden" name="a_pno" value=' + a_no + '>';
	a += '<input type="hidden" name="member_id" value=' + loginId + '>';
	a += '<div class="sty_plusInsert sty_commArea sty_bgWt" style="padding: inherit; width: auto;">';
	a += '<textarea class="a_con" name="a_content" maxlength="500" placeholder="댓글을 입력해주세요. 500자 이내로 작성 가능합니다."></textarea>';
	a += '<button type="button" class="btn btn-primary btn-lg sty_commBtn" id="answerReButton' + a_no + '" onclick="answerRe();">등록</button>';
	a += '</div></div></form>';
	$("#answerRe" + a_no).html(a);
}

function answerUpdate(a_no, a_content) {
	$("#updateFalse" + a_no).text("수정취소").attr("onclick", "answerList()");
	$("#answerResFalse" + a_no).attr("onclick", "");
	var a = '';
	a += '<div class="sty_commArea">';
	a += '<textarea class="a_con' + a_no + '" name="a_content maxlength=500">'+a_content+'</textarea>';
	a += '<button class="btn btn-primary btn-lg sty_commBtn" type="button" onclick="answerUpdateProc(' + a_no + ');">수정</button>';
	a += '</div>';
	$('.answerContent' + a_no).html(a);
}

function answerUpdateProc(a_no) {
	var updateContent = $('.a_con'+a_no).val();
	$.ajax({
		url : 'AnswerUpdate.do',
		type : 'post',
		data : {
			'a_content' : updateContent,
			'a_no' : a_no
		},
		success : function(data) {
			if (data == 1) answerList(b_no);
		},error:function(request,status,error){
		    alert("내용을 입력해주세요");
		   }
	});
}

function answerDelete(a_no) {
	var flag = confirm("댓글을 삭제하시겠습니까?");

	if (flag == true) {

		$.ajax({
			url : 'AnswerDelete.do?a_no=' + a_no,
			type : 'post',
			success : function(data) {
				if (data == 1) {
					alert("삭제되었습니다.");

				} else {
					alert("삭제에 실패하셨습니다");
				}
				answerList(b_no);

			}
		});
	}
}


function boardDelete(b_no) {
	
	var flag = confirm("게시글을 삭제하시겠습니까?");

	if (flag == true) {
		location.href = 'BoardDelete.do?b_no=' + b_no;
	}
}


$(document).ready(function() {
	answerList();
});

