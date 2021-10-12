<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, SafeNC.kisinfo.*, Kisinfo.Check.IPINClient"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<%@ include file="../inc/requestSecurity.jsp" %>
<%@ include file="../inc/requestNameCheck.jsp" %>

<%

    String vDiscrNo   = jumin;

	if (iRtn != 1) {

%>

	<script type="text/javascript">

       	alert("<%=sRtnMsg%>");

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
	<title>글쓰기 &gt; 금융사고 제보 &gt; 금융사고/금융부조리 &gt; 신고 신고센터 &gt; 고객지원 &gt; 수협</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>

<!--/********************************************위너다임 작업 시작 2008.03.13****************************************************/-->

<!-- 2015.02.02 사용안함 주석처리
<SCRIPT SRC="http://www.suhyup.co.kr/djemals/js/ax_wdigm/default.js"></SCRIPT>
 -->

<!--/********************************************위너다임 작업 끝 2008.03.13******************************************************/-->

	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript">
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
			
			//공백만 입력체크 20150224
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
			//공백만 입력체크 20150224
			if (d.contents.value.replace(/(^\s*)|(\s*$)/gi, "").length == 0) {alert("내용을 입력해 주십시오"); d.contents.focus(); return;}
			
			if (d.psword.value.length == 0) {alert("패스워드를 입력해 주십시오"); d.psword.focus(); return;}

			if(!chkPWD(d.psword)) return;

			/********************************************위너다임 작업 시작 2008.03.13****************************************************
			try{
				if(UsingRemote == true){
					if(!beScan('',mText,'')){
					return;
					}
				}
			}
			catch (e){
				var objRtn = objAX.beScanner(policy, '','', this.location, mText, '');
				if(objRtn == 0){
					return;
				}else{
					return;
				}
			}
			********************************************위너다임 작업 끝 2008.03.13******************************************************/

			d.submit();
			//d.action();

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
</script>

<style type="text/css">
.smallfont{font-size:11px;letter-spacing: -1px}
</style>

</head>

<body id="shingo01">

	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

	<!-- container -->
	<div id="ContentLayer">

		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->

<form name="pbform" method="post" action="shingo_proc.jsp">
<input type="hidden" name="vDiscrNo" value="<%=vDiscrNo%>">





		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>신고센터</span>금융사고/금융부조리 신고</p>
			<h3>금융사고/금융부조리 신고</h3>
			<div class="pdl20 pdr20">
				<h4 class="dpNone">금융사고제보</h4>
				<div class="mgl15">
					<table class="write"><!-- 20150226 -->
					<caption>금융사고/금융부조리 신고 - 이름,이메일,휴대폰,주소,전화번호,제목,내용,비밀번호 테이블 입니다</caption><!-- 20150226 -->
					<colgroup>
						<col style="width:18%;" />
						<col style="width:auto;" />
					</colgroup>
					<tr>
						<th scope="row"><span class="txt_request">*</span>이름</th>
						<td>
							<input type="text" name="name" value="<%=name%>" class="text" style="width:198px;" title="이름" />
						</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>
							<input type="text" name="sh_email_1" onBlur="checkInput(this)" value="" class="text" style="width:148px;" title="이메일주소 앞자리" /><span class="txt_at vAlignM lineH170">@</span><input type="text" name="sh_email_2" value="" class="text" style="width:148px;" title="이메일도메인 직접입력" />
							<select name="sh_email_3" onChange="mail_change()" class="mgl5" title="이메일 도메인 선택">
		                        <option value="">선택하세요 </option>
		                        <option value='naver.com'>네이버</option>
		                        <option value='daum.net'>다음</option>
		                        <option value='nate.com'>네이트</option>
		                        <option value='yahoo.co.kr'>야후</option>
		                        <option value='paran.com'>파란</option>
								<option value="">직접입력 </option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>휴대폰</th>
						<td>
							<input type="text" maxlength="3" name="sh_tel_1" value="" class="text" style="width:68px;" title="휴대폰 앞자리" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" maxlength="4" name="sh_tel_2" value="" class="text" style="width:68px;" title="휴대폰 중간번호" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" maxlength="4" name="sh_tel_3" value="" class="text" style="width:68px;" title="휴대폰 뒷자리" />
						</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td>
							<input type="text" size="4" name="sh_post_1" value="" readonly class="text" style="width:88px;" title="우편번호 앞자리" /><span class="txt_dash vAlignM">-</span><input type="text" size="4" name="sh_post_2" value="" readonly class="text" style="width:88px;" title="우편번호 뒷자리" /><a href="javascript:ZipSearch();" class="btn_blue_s01 mgl10" title="새창열림"><span>주소찾기</span></a><br />
							<input type="text" name="sh_address_1" readonly value="" class="text mgt10 mgb10" style="width:508px;" title="동까지 입력" /><br />
							<input type="text" name="sh_address_2" value="" class="text" style="width:508px;" title="상세주소" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>전화번호</th>
						<td>
							<input type="text" maxlength="3" name="sh_tele_1" value="" class="text" style="width:68px;" title="전화번호 앞자리" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" maxlength="4" name="sh_tele_2" value="" class="text" style="width:68px;" title="전화번호 중간자리" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" maxlength="4" name="sh_tele_3"  value="" class="text" style="width:68px;" title="전화번호 뒷자리" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>제       목</th>
						<td>
							<input type="text" name="title" value="" class="text w100p" title="제       목" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>내       용</th>
						<td>
							<textarea name="contents" value="" cols="1" rows="1" title="내       용"></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>비밀번호</th>
						<td>
							<input type="password" name="psword" value="" class="text" style="width:198px;" title="비밀번호" /><p class="displayInB mgl5">비밀번호는 4자리 이상 6자리 이하로 작성하여주세요.</p>
						</td>
					</tr>
					</table>
					<p class="pdl23 mgt18"><span class="txt_request mgr5">*</span>으로 표시된 부분은 필수 입력사항</p>
				</div>
				<div class="btnC mgt30">
					<a href="javascript:GoReg();" class="btn_blue_arrowB01 w150"><span>확 인</span></a><a href="javascript:GoCan();" class="btn_dGray_arrowB01 w150"><span>취 소</span></a>
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