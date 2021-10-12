<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>비밀번호 찾기 &gt; 수협</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/js/public.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
<!--	
	function GoReg() {

		var d = document.pbform;

		if (d.sg_name.value.length == 0) {alert("성명을 입력해 주십시오"); d.sg_name.focus(); return;}
		if (d.sg_tel1.value.length == 0 || d.sg_tel2.value.length == 0 || d.sg_tel3.value.length == 0) { alert("휴대폰/전화번호를 입력해주십시요"); return;}

		d.submit();
	}

	function resizeWindowHeight(wValue, hValue) {
	    var popUpWinSize = document.getElementById("popUpWinHeight");
	    var windowHeight = popUpWinSize.offsetHeight + hValue;
		window.resizeTo(wValue, windowHeight);
	}

//-->
</script>
</head>
<body onload="resizeWindowHeight(500,20);">
<form name="pbform" method="post" action="chungtak_find_psword_proc.jsp">
	<!-- 400*330 -->
	<div id="popUpWinHeight" class="wrapPopup">
		<h1 class="dpNone">수협</h1>
		<h2><span>비밀번호 찾기</span></h2>
		<div class="innerBox">
			<p class="mgb25">* 금융사고/금융부조리 신고 시, 기재되었던 항목을 정확하게 기재하여 주세요.</p>
			<table class="write mgb10" summary="이름, 연락처로 구성된 표">
				<caption>비밀번호 찾기</caption>
				<colgroup>
					<col style="width:25%;" />
					<col style="width:auto;" />
				</colgroup>
				<tr>
					<th scope="row">이 름</th>
					<td><input type="text" name="sg_name" class="text w100p" title="이름 입력" /></td>
				</tr>
				<tr>
					<th scope="row" class="pdl0 textC">연락처</th>
					<td>
						<input type="text" maxlength="4" name="sg_tel1" class="text" style="width:70px;" title="전화번호 앞자리 입력" />
						<span class="txt_dash vAlignM">-</span>
						<input type="text" maxlength="4" name="sg_tel2" class="text" style="width:70px;" title="전화번호 중간자리 입력" />
						<span class="txt_dash vAlignM">-</span>
						<input type="text" maxlength="4" name="sg_tel3"  class="text" style="width:70px;" title="전화번호 끝자리 입력" />
					</td>
				</tr>
			</table>
		</div>
		<div class="btnCenter">
			<a href="javascript:GoReg();"  class="btn_blue_s01"><span>확인</span></a><a href="javascript:self.close();"  class="btn_dGray_s01"><span>취소</span></a>
		</div>
	</div>
</form>
</body>
</html>