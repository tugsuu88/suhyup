<% String pageNum = "5"; %>

<%@ page contentType="text/html;charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<%
	//191119 웹 취약점 수정
	session.removeAttribute("minwonMids");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>본인확인 &gt; 민원처리결과조회 &gt; 전자민원창구 &gt; 고객지원 &gt; 수협</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	<script type="text/javascript" src="/js/asisFooter.js"></script>
<script language="JavaScript">
<!--

	function MM_openBrWindow(theURL,winName,features) { //v2.0
	  window.open(theURL,winName,features);
	}

	function GoReg() {

		var d = document.pbform;

		if (d.name.value.length == 0) {alert("성명을 입력해 주십시오"); d.name.focus(); return;}

		if (pbform.sh_han_1.value.length == 0){
			alert("휴대폰/전화번호를 입력해주십시요");
			d.sh_han_1.focus();
			return;
		}else if(pbform.sh_han_2.value.length == 0){
			alert("휴대폰/전화번호를 입력해주십시요");
			d.sh_han_2.focus();
			return;
		}else if(pbform.sh_han_3.value.length == 0){
			alert("휴대폰/전화번호를 입력해주십시요");
			d.sh_han_3.focus();
			return;
		}

		if (d.passwd.value.length == 0) {alert("비밀번호를 입력해 주십시오"); d.passwd.focus(); return;}

		pbform.submit();
	}
	function EnterCheck9() {
		if(event.keyCode == 13)		//익스플로러에서.
		{
			GoReg();
		} else {

		}
	}
	
//-->
</script>

</head>
<body id="minwon02">
	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->
	<!-- container -->
	<div id="ContentLayer">

		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->

<form name="pbform" method="post" action="minwon_apply06.jsp">

		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>전자민원창구</span>민원처리결과조회</p>
			<h3>민원처리결과 조회</h3>
			<div class="pdl20 pdr30">
				<div class="mgl15">
					<table class="write" summary="민원처리결과 조회를 위한 이름, 휴대폰 혹은 전화번호, 비밀번호 입력 조회">
					<caption>민원처리결과 조회</caption>
					<colgroup>
						<col style="width:18%;" />
						<col style="width:auto;" />
					</colgroup>
					<tr>
						<th class="pdl0 textC" scope="row"><label for="name">이름</label></th>
						<td>
							<input type="text" name="name" id="name" value="" onKeyDown="EnterCheck9();" class="text" style="width:198px;" />
						</td>
					</tr>
					<tr>
						<th scope="row" class="pdl0 textC">연락처</th>
						<td>
							<label for="telephone" class="tts">연락처 종류 선택</label>
							<select name="telephone" id="telephone" class="mgr5">
								<option value="휴대폰">휴대폰</option>
								<option value="전화번호">전화번호</option>
							</select>
							
							<label for="sh_han_1" class="tts">연락처 첫번째 자리</label>
							<input type="text" maxlength="3" name="sh_han_1" value="" class="text" style="width:68px;" id="sh_han_1" />
							<span class="txt_dash vAlignM">-</span>
							<label for="sh_han_2" class="tts">연락처 중간자리</label>
							<input type="text" maxlength="4" name="sh_han_2" value="" class="text" style="width:68px;" id="sh_han_2" />
							<span class="txt_dash vAlignM">-</span>
							<label for="sh_han_3" class="tts">연락처 마지막자리</label>
							<input type="text" maxlength="4" name="sh_han_3" value="" class="text" style="width:68px;" id="sh_han_3" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="passwd">비밀번호</label></th>
						<td>
							<input type="password" name="passwd" id="passwd" onKeyDown="EnterCheck9();" class="text" style="width:198px;" title="비밀번호" />
								<a href="javascript:NewPopUp('minwon_psword.jsp','360','260');" class="btn_blue_s01 mgl10" title="새창열림">
									<span>비밀번호 찾기</span>
								</a>
						</td>
					</tr>
					</table>
				</div>
				<div class="btnR mgt30">
					<a href="javascript:GoReg();" class="btn_green_arrowB01 w150"><span>조회</span></a>
				</div>
			</div>
		</div>
		<!-- //contents -->
		
</form>

	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->
</body>
</html>