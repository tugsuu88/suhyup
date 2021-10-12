<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="../inc/requestSecurity.jsp" %>

<%@ include file="../inc/requestNameCheck.jsp" %>

<%

    String vDiscrNo   = jumin;

	if (iRtn != 1) {

%>

	<script type=text/javascript>

       	alert(sRtnMsg);

       	history.go(-1);

	</script>

<%

		return;

	}

%>

<% String pageNum = "5"; %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>글쓰기 &gt; 행동강령 신고·상담센터 &gt; 신고센터 &gt; 고객지원 &gt; 수협</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript" src="../js/quickMenu.js"></script>

<!--/********************************************위너다임 작업 시작 2008.03.13****************************************************/-->



<!--/********************************************위너다임 작업 끝 2008.03.13******************************************************/-->

<script type="text/javascript">

<!--

	//약관 동의 여부 체크

	function GoReg() {

			var mText  = document.pbform.contents.value;

			var d = document.pbform;



			if (d.name.value.length == 0) {alert("성명을 입력해 주십시오"); d.name.focus(); return;}



			if (d.sh_tel_1.value.length == 0){

				alert("휴대폰번호가 입력되지 않았습니다.");

				d.sh_tel_1.focus();

				return;

			}else if(d.sh_tel_2.value.length == 0){

				alert("휴대폰번호가 입력되지 않았습니다.");

				d.sh_tel_2.focus();

				return;

			}else if(d.sh_tel_3.value.length == 0){

				alert("휴대폰번호가 입력되지 않았습니다.");

				d.sh_tel_3.focus();

				return;

			}



			if (d.sh_tele_1.value.length == 0){

				alert("전화번호가 입력되지 않았습니다.");

				d.sh_tele_1.focus();

				return;

			}else if(d.sh_tele_2.value.length == 0){

				alert("전화번호가 입력되지 않았습니다.");

				d.sh_tele_2.focus();

				return;

			}else if(d.sh_tele_3.value.length == 0){

				alert("전화번호가 입력되지 않았습니다.");

				d.sh_tele_3.focus();

				return;

			}



			//if (d.title.value.length == 0) {alert("제목을 입력해 주십시오"); d.title.focus(); return;}
			if (d.title.value.replace(/(^\s*)|(\s*$)/gi, "").length == 0) {alert("제목을 입력해 주십시오"); d.title.focus(); return;}


			var keyword = d.title.value;

			//var keyword_sp_char = "~`!@#$%^&*_=|\\<,>.?/{}[]:\"'";

			var keyword_sp_char = "`@#$%^&*=|\\<,>:\'";

			if(CheckSpecialChar(keyword, keyword_sp_char) == false)

			{

				alert("특수문자(" + keyword_sp_char + ")를 입력하실 수 없습니다.");

				d.title.focus();

				return;

			}



			if(keyword.length >= 101){

				alert("제목의 글자수가 초과하였습니다. 100자이내로 작성하여주세요.");

				d.title.focus();

				return;

			}



			//if (d.contents.value.length == 0) {alert("내용을 입력해 주십시오"); d.contents.focus(); return;}
			if (d.contents.value.replace(/(^\s*)|(\s*$)/gi, "").length == 0) {alert("내용을 입력해 주십시오"); d.contents.focus(); return;}
			
			if (d.psword.value.length == 0) {alert("패스워드를 입력해 주십시오"); d.psword.focus(); return;}

			if(!chkPWD(d.psword)) return;



			d.submit();





	}

	function GoCan(){

		history.go(-1);

	}



	//우편번호 검색

	function ZipSearch(){

		var wint = (screen.height - 350) / 2;

		var winl = (screen.width - 400) / 2;

		winprops = 'height=402,width=383,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = 'find_addr_v2.jsp?return1=pbform.sh_post_1&amp;return2=pbform.sh_post_2&amp;return3=pbform.sh_address_1';

		win = window.open(winurl, "zipsearch", winprops)

	}



	//검색 우편번호 세팅

	function input_zipcode(zip1,zip2,address){

		var frm = document.pbform;

		//alert(zip1)

		frm.sh_post_1.value = zip1;

		frm.sh_post_2.value = zip2;

		frm.sh_address_1.value = address;

		frm.sh_address_2.focus();

	}



	function GoCan(){

		history.go(-1);

	}



	// 사용자가 이메일 도메인에 이벤트를 가했을때

	function mail_change() {

		var A = document.pbform;



		// 밑에 직접 입력란을 활성화 시켜준다.

		if(A.sh_email_3.value == 'etc') {

			A.sh_email_2.value = '';

		} else {

			A.sh_email_2.value = A.sh_email_3.value;

		}

	}



//-->

</script>

</head>

<body id="shingo01">

	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

<form name="pbform" method="post" action="corruption_proc.jsp">

<input type="hidden" name="vDiscrNo" value="<%=vDiscrNo%>">

	<!-- container -->
	<div id="ContentLayer">
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->
		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>신고센터</span>행동강령 신고·상담센터</p>
			<h3>행동강령 신고·상담센터</h3>
			<div class="pdl20 pdr20">
				<div class="mgl15">
					<table class="write02" summary="">
					<caption></caption>
					<colgroup>
						<col style="width:14%;" />
						<col style="width:auto;" />
					</colgroup>
					<tr>
						<th scope="row"><span class="txt_request">*</span>이름</th>
						<td>
							<input type="text" class="text" style="width:198px;" title="이  름" name="name" value="<%=name%>" />
						</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>
							<input type="text" class="text" style="width:98px;" title="이메일주소" name="sh_email_1" onBlur="checkInput(this)" value="" />
							<span class="txt_at vAlignM lineH170">@</span>
							<input type="text" class="text" style="width:98px;" title="이메일 도메인 직접입력" name="sh_email_2" value="" />
							<select class="mgl5" title="이메일 도메인 선택" name="sh_email_3" onChange="mail_change()">
                          		<option value="">선택하세요 </option>
                          		<option value='naver.com'>네이버</option>
                          		<option value='hanmail.net'>한메일</option>
                          		<option value='nate.com'>네이트</option>
   						  		<option value="">직접입력 </option>
							</select>
							<p class="displayInB mgl5">(빠른 회신을 위하여 가급적 기재해 주십시요.)</p>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>휴대폰</th>
						<td>
							<input type="text" class="text" style="width:68px;" title="휴대폰번호 앞자리" maxlength="3" name="sh_tel_1"  value="" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:68px;" title="휴대폰번호 중간자리" maxlength="4" name="sh_tel_2"  value="" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:68px;" title="휴대폰번호 마지막자리" maxlength="4" name="sh_tel_3"  value="" />
						</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td>
							<input type="text" class="text" style="width:88px;" title="우편번호 앞자리" name="sh_post_1" value="" readonly />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:88px;" title="우편번호 뒷자리" name="sh_post_2" value="" readonly />
							<a href="javascript:ZipSearch();" class="btn_blue_s01 mgl10" title="새창열림"><span>주소찾기</span></a><br />
							<input type="text" class="text mgt10 mgb10" style="width:508px;" title="상세주소 첫번째" name="sh_address_1" readonly value="" /><br />
							<input type="text" class="text" style="width:508px;" title="상세주소 두번째" name="sh_address_2" value="" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>전화번호</th>
						<td>
							<input type="text" class="text" style="width:68px;" title="전화번호 앞자리" maxlength="3" name="sh_tele_1"  value="" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:68px;" title="전화번호 중간자리" maxlength="4" name="sh_tele_2"  value="" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:68px;" title="전화번호 마지막자리" maxlength="4" name="sh_tele_3"  value="" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>제       목</th>
						<td>
							<input type="text" class="text w100p" title="제       목" name="title" value="" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>내       용</th>
						<td>
							<textarea cols="1" rows="1" title="내       용" name="contents" value=""></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>비밀번호</th>
						<td>
							<input type="password" class="text" style="width:198px;" title="비밀번호" name="psword" value="" />
							<p class="displayInB mgl5">(게시물을 수정 또는 삭제할 때 필요합니다.)</p>
						</td>
					</tr>
					</table>
					<p class="pdl23 mgt18"><span class="txt_request mgr5">*</span>으로 표시된 부분은 필수 입력사항</p>
				</div>
				<div class="btnC mgt30">
					<a href="javascript:GoReg();" class="btn_blue_arrowB01 w150"><span>확 인</span></a>
					<a href="javascript:GoCan();" class="btn_dGray_arrowB01 w150"><span>취 소</span></a>
				</div>
			</div>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->

</form>

	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->
</body>
</html>