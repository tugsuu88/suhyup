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
	<title>금융사고/금융부조리 신고 &gt; 신고센터 &gt; 고객지원 &gt; 수협</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript">

<!--



	function MM_openBrWindow(theURL,winName,features) { //v2.0

	  window.open(theURL,winName,features);

	}



	//약관 동의 여부 체크

	function GoReg() {

			var d = document.pbform;



			if (d.sh_tel_1.value.length == 0){

				alert("휴대폰/전화번호가 입력되지 않았습니다.");

				d.sh_tel_1.focus();

				return;

			}else if(d.sh_tel_2.value.length == 0){

				alert("휴대폰/전화번호가 입력되지 않았습니다.");

				d.sh_tel_2.focus();

				return;

			}else if(pbform.sh_tel_3.value.length == 0){

				alert("휴대폰/전화번호가 입력되지 않았습니다.");

				d.sh_tel_3.focus();

				return;

			}

			if (d.passwd.value.length == 0) {alert("패스워드를 입력해 주십시오"); d.passwd.focus(); return;}



			d.submit();



	}

	function GoCan(){

		history.go(-1);

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

<body id="shingo01">

	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

	<!-- container -->
	<div id="ContentLayer">
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->
		
		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>신고센터</span>금융사고/금융부조리 신고</p>
			<h3>금융사고/금융부조리 신고</h3>

<form name="pbform" method="post" action="shingo_list.jsp">

			<div class="pdl20 pdr20">
				<h4 class="dpNone">금융사고제보</h4>
				<div class="mgl15">
					<div class="shingo_txt mgb28">
						<p class="p_text_bul pdl10 mgb10">입력하신 주민번호에 해당되는 고객입력자료만 보실 수 있습니다.</p>
						<p class="pdl10">(입력하신 정보는 외부로는 절대 유출되지 않습니다.)</p>
					</div>
					<!-- 20150226 :: START -->
					<table class="write01" summary="금융사고/금융부조리 신고를 위한 개인정보 입력 테이블입니다.">
						<caption>금융사고/금융부조리 신고</caption>
						<colgroup>
							<col style="width:20%;" />
							<col style="width:auto;" />
						</colgroup>
						<tr>
							<th scope="row" class="vAlignM"><label for="name01">이름</label></th>
							<td>
								<input type="text" class="text" style="width:198px;" title="이름" id="name01" name="name" value="<%=name%>" />
							</td>
						</tr>
						<tr>
							<th scope="row" class=""><label for="tel">연락처</label></th>
							<td>
								<select name="telephone" title="연락처 선택">
									<option value="휴대폰" >휴대폰</option>
									<option value="전화번호" >전화번호</option>
								</select>
								
								<select title="번호 앞자리 선택" style="width:68px" id="tel" name="sh_tel_1">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="019">019</option>
									<option value="02">02</option>
									<option value="031">031</option>
									<option value="032">032</option>
									<option value="033">033</option>
									<option value="041">041</option>
									<option value="042">042</option>
									<option value="043">043</option>
									<option value="044">044</option>
									<option value="051">051</option>
									<option value="052">052</option>
									<option value="053">053</option>
									<option value="054">054</option>
									<option value="055">055</option>
									<option value="061">061</option>
									<option value="062">062</option>
									<option value="063">063</option>
									<option value="064">064</option>
									<option value="070">070</option>
								</select>
								<span class="txt_dash">-</span>
								<input type="text" class="text" style="width:68px;" title="번호 중간자리 입력" maxlength="4" name="sh_tel_2" />
								<span class="txt_dash vAlignM">-</span>
								<input type="text" class="text" style="width:68px;" title="번호 마지막자리 입력" maxlength="4" name="sh_tel_3" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="pass">비밀번호</label></th>
							<td>
								
								<input type="password" id="pass" name="passwd" onKeyDown="EnterCheck9();" class="text" style="width:198px;" title="비밀번호" /><a href="javascript:NewPopUp('shingo_find_psword.jsp','360','260');" class="btn_blue_s01 mgl10" title="새창열림"><span>비밀번호 찾기</span></a>
							</td>
						</tr>
					</table>
					<!-- 20150226 :: END -->
					<div class="btnC mgt65">
						<a class="btn_blue_arrowB01 w150" href="javascript:GoReg();">
							<span>확인</span>
						</a>
						<a class="btn_gray_arrowB01 w150" href="javascript:GoCan();">
							<span>취소</span>
						</a>
					</div>
				</div>
			</div>
				
</form>

		</div>
		<!-- //contents -->

	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->
</body>
</html>