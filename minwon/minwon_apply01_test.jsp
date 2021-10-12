<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, SafeNC.kisinfo.*, Kisinfo.Check.IPINClient"%>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>



<% String pageNum = "5"; %>
<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
    String sSiteCode = "G5890";				// NICE로부터 부여받은 사이트 코드
    String sSitePassword = "VN2VPY5TTKBU";
    
    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
  	
   	String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
   	
   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize 	= "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
		
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    String sReturnUrl = "http://www.suhyup.co.kr/member/checkplus_success.jsp";      // 성공시 이동될 URL
    String sErrorUrl = "http://www.suhyup.co.kr/member/checkplus_fail.jsp";          // 실패시 이동될 URL

    // 입력될 plain 데이타를 만든다.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
    
    String sMessage = "";
    String sEncData = "";
    
    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
    if( iReturn == 0 )
    {
        sEncData = niceCheck.getCipherData();
    }
    else if( iReturn == -1)
    {
        sMessage = "암호화 시스템 에러입니다.";
    }    
    else if( iReturn == -2)
    {
        sMessage = "암호화 처리오류입니다.";
    }    
    else if( iReturn == -3)
    {
        sMessage = "암호화 데이터 오류입니다.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "입력 데이터 오류입니다.";
    }    
    else
    {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>수협 - 바다사랑 고객사랑</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/member.css' />

<!--[if IE 7]><link rel="stylesheet" type="text/css" href="../css/footer.css"     /><![endif]-->

<!--[if IE 8]><link rel="stylesheet" type="text/css" href="../css/footer_IE8.css" /><![endif]-->

<script type="text/javascript" src="../js/common.js"></script>

<script type="text/javascript">

<!--

	//약관 동의 여부 체크

	function GoReg() {


		if(document.vnoform.param_r1.value!="1"){
			alert("실명인증을 해주시기바랍니다.");
		}
		else{
		if (document.all.agree.checked == true && document.all.agree2.checked == true){
			
			var d = document.pbform;



			if (d.name.value.length == 0) {alert("성명을 입력해 주십시오"); d.name.focus(); return;}

			if(d.Year.value==""){				alert("년을 선택해 주십시오.");				d.Year.focus();				return;			}
			if(d.Month.value==""){				alert("월을 선택해 주십시오.");				d.Month.focus();				return;			}			if(d.Day.value==""){				alert("일을 선택해주십시오.");				d.Day.focus();				return;			}
			if (pbform.sh_post_1.value.length == 0 || pbform.sh_post_2.value.length == 0){

				alert("주소가 입력되지 않았습니다.");

				return;

			}else if(pbform.sh_address_1.value.length == 0 || pbform.sh_address_2.value.length == 0  ){

				alert("주소가 입력되지 않았습니다."); d.sh_address_2.focus(); return;

			}



			if (pbform.sh_tel_1.value.length == 0){

				alert("전화번호가 입력되지 않았습니다.");

				d.sh_tel_1.focus();

				return;

			}else if(pbform.sh_tel_2.value.length == 0){

				alert("전화번호가 입력되지 않았습니다.");

				d.sh_tel_2.focus();

				return;

			}else if(pbform.sh_tel_3.value.length == 0){

				alert("전화번호가 입력되지 않았습니다.");

				d.sh_tel_3.focus();

				return;

			}



			if (pbform.sh_han_1.value.length == 0){

				alert("핸드폰번호가 입력되지 않았습니다.");

				d.sh_han_1.focus();

				return;

			}else if(pbform.sh_han_2.value.length == 0){

				alert("핸드폰번호가 입력되지 않았습니다.");

				d.sh_han_2.focus();

				return;

			}else if(pbform.sh_han_3.value.length == 0){

				alert("핸드폰번호가 입력되지 않았습니다.");

				d.sh_han_3.focus();

				return;

			}

			if(pbform.sh_email_1.value !== ""){

			//선택했을때 검사

				if(!chkEmail2(pbform.sh_email_1,pbform.sh_email_2))  return;

			}else if(pbform.sh_email_3.value !== ""){

				//직접입력시 검사

				if(!chkEmail2(pbform.sh_email_3,pbform.sh_email_4))  return;

			}else{

				if (!isInput(pbform.sh_email_1,"메일을 입력해 주세요")){ 	return; }

				else if(!isInput(pbform.sh_email_3,"메일을 입력해 주세요")){	return;}

			}



			if (d.psword.value.length == 0) {alert("패스워드를 입력해 주십시오"); d.psword.focus(); return;}

			if(!chkPWD(d.psword)) return;

			//20140820			if(d.sh_center[0].checked==false && d.sh_center[1].checked==false){							alert("민원대상을 선택해 주십시오.");				return;			}			
			if(d.self_text.value=='글자수 15자리까지'){					alert("대상영업점을 입력해 주십시오.");				d.self_text.focus();				return;			}			//20140820
			if(d.sh_cata.value == 'cho') {

				alert("분야를 선택해 주십시오");

				d.sh_cata.focus();

				return;

			}



			if(d.sh_reply_type.value == "") {

				alert("회신방식을 선택해 주십시오");

				d.sh_reply_type.focus();

				return;

			}



			pbform.action = "minwon_apply02_test.jsp";

			pbform.submit();



		}else if(document.all.agree.checked == false && document.all.agree2.checked == false){

			alert("개인정보수집 및 이용동의서와 개인정보의 제3자(해당법인)제공 동의서에 동의하셔야 민원신청이가능합니다.");

		}		else if(document.all.agree.checked == false){							alert("개인정보 수집 및 이용동의서에 동의하셔야 민원신청이 가능합니다");								}
		else if(document.all.agree2.checked == false){							alert("개인정보의 제3자(해당법인) 제공 동의서에 동의하셔야 민원신청이 가능합니다.");								}
		}

	}



	//우편번호 검색

	function ZipSearch(){

		var wint = (screen.height - 350) / 2;

		var winl = (screen.width - 400) / 2;

		winprops = 'height=402,width=383,top='+wint+',left='+winl+',status=no,scrollbars=yes,resize=no'

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
<script language='javascript'>
	window.name ="Parent_window";
	
	function fnPopup(){
		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.vnoform.EncodeData.value = "<%= sEncData %>";
		document.vnoform.param_r1.value="";
		document.vnoform.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.vnoform.target = "popupChk";
		document.vnoform.submit();
	}
	</script>
</head>

<body id="minwon01">

<%@ include file="/include/shHeader.jsp" %>

<!-- start content table--><div id="ContentLayer"><table width="920" border="0" align="center" cellpadding="0" cellspacing="0">

<tr><td>
<form name="vnoform" method="post">
		<input type="hidden" name="m" value="checkplusSerivce">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
		<input type="hidden" name="EncodeData" value="<%= sEncData %>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	    
	    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
	    	 해당 파라미터는 추가하실 수 없습니다. -->
		<input type="hidden" name="param_r1" value="">
		<input type="hidden" name="param_r2" value="">
		<input type="hidden" name="param_r3" value="">
	    
		
	</form>
<form name="pbform" method="post" action="">

<input type="hidden" name="vDiscrNo" value="">



<table cellpadding="0" cellspacing="0" id="contentTable">

<tr>

	<td valign="top" id="sideContent">

	<table cellpadding="0" cellspacing="0">

	<tr>

		<td width="180" height="125" valign="top"><img src="images/left_large_tit.gif" alt="전자민원부패신고" width="180" height="170" /></td>

	</tr>

	<tr>

		<td height="10"></td>

	</tr>

	<tr>

		<td><img src="images/sc_bt_on_01.gif" alt="전자민원창구" /></td>

	</tr>

  	<tr>

		<td height="3"></td>

	</tr>

	<tr>

		<td><a href="minwon_03.jsp"><img src="images/sc_bt_off_013.gif" /></a></td>

	</tr>

	<tr>

		<td><a href="minwon_apply01.jsp"><img src="images/sc_bt_on_011.gif" alt="민원신청"/></a></td>

	</tr>

	<tr>

		<td><a href="minwon_apply03.jsp"><img src="images/sc_bt_off_012.gif" alt="민원처리결과조회" /></a></td>

	</tr>

	<tr>

		<td><a href="minwon_result.jsp"><img src="images/sc_bt_off_014.gif" alt="민원처리결과공시" /></a></td>

	</tr>

	<tr>

		<td height="15"></td>

	</tr>

	<tr>

		<td><a href="shingo_001.jsp"><img src="images/sc_bt_off_02.gif" alt="금융사고신고" /></a></td>

	</tr>

	<tr>

		<td><a href="taxfree.jsp"><img src="images/sc_bt_off_03.gif" alt="면세유부정유통신고" /></a></td>

	</tr>

		  <tr>

		  <td><a href="corruption.jsp"><img src="images/sc_bt_off_04.gif" alt="상담센터" border="0" /></a></td>

	</tr>
	<tr>
		  <td><a href="budget.jsp"><img src="images/sc_bt_off_05.gif" alt="예산낭비신고센터" border="0" /></a></td>
	</tr>
	<tr>
		<td><a href="shingo_004.jsp"><img src="images/sc_bt_off_06.gif" alt="공익신고제도 안내" border="0" /></a></td>
	</tr>
	</table>

    </td>

    <td id="primaryContent" valign="top">

      <table cellpadding="0" cellspacing="0">

        <tr>

          <td >

            <table cellpadding="0" cellspacing="0" border="0">

              <tr>

                <td id="navigator"><a href="/">Home</a> &gt; <a href="minwon_apply01.jsp">전자민원</a>

                  > 전자민원창구</td>

              </tr>

              <tr>

                <td id="title"><img src="../images/pcTitle050101.gif" /></td>

              </tr>

              <tr>

                <td id="content">

                  <!-- 본문영역 시작 -->

				  <table cellpadding="0" cellspacing="0">

                    <tr>

                      <td>

                        <!-- 개인정보제공 동의서 시작 -->

                        <table cellspacing="0" style="width:745px; border:1px solid #E9E9E9; background-color:#F8F8F7;">

                          <tr>

                            <td style="padding-left:10px; padding-top:10px;"><b><font color="#0033CC">::

                              개인정보 수집 및 이용 동의서 ::</font></b></td>

                          </tr>

                          <tr>

                            <td style="padding:10px;">



                              <table width="100%" border="0" cellspacing="0" cellpadding="10px" style="border:1px solid #E9E9E9; background-color:#FFFFFF;">

                                <tr>

                                  <td>

								   <!-- 약관 내용 시작 -->
									<br/>									&nbsp;<strong>● 개인정보 수집 및 이용목적</strong> <br/>									&nbsp;&nbsp;제공하신 개인정보는 신속하고 공정한 민원상담 &middot; 처리(본인식별, 민원 사실관계 확인 및 민원처리결과 통지 등)를 위한 용도로 <br/>&nbsp;&nbsp;수집 &middot; 이용됩니다.<br/>									<br/>									&nbsp;<strong>● 수집하려는 개인정보의 항목</strong><br/>									&nbsp;&nbsp;성명, 생년월일, 주소, 전화(핸드폰)번호, 이메일 주소, 본인거래정보, 민원내용 등<br/>									<br/>									&nbsp;<strong>● 개인정보의 보유 및 이용기간</strong><br/>									&nbsp;&nbsp;위 개인정보는 수집 &middot; 이용에 관한 동의일로부터 처리 종료일까지 민원사무처리를 위하여 보유 &middot; 이용되며, 민원 종결 후에는 <br/> &nbsp;&nbsp;기타 법령 상 의무이행 및 소비자보호 업무수행을 위해 보유 &middot; 이용됩니다. <br/>									<br/>									&nbsp;<strong>● 동의를 거부할 권리 및 동의 거부에 따른 불이익</strong></br> 									&nbsp;&nbsp;귀하께서 개인정보의 수집 &middot; 이용 동의에 거부할 권리가 있으나, 위 정보는 본인 식별 및 민원에 대한 사실관계 확인에 필수적인 <br/> &nbsp;&nbsp;정보로 수집 &middot; 이용에 동의하셔야만 민원처리가 가능합니다. 
									<br/><br/>
                              <!-- 약관 내용 끝 -->

								  </td>

                                </tr>

                              </table>

                            </td>

                          </tr>

                          <!-- 체크 버튼 -->

                          <tr>

                            <td style="padding-left:10px; padding-bottom:10px;">

                              <input type="checkbox" name="agree" value="ok" />

                              위에 내용을 충분히 인지하고 개인정보 수집 &middot; 이용에 동의합니다.</td>

                          </tr>

                        </table><br/>

                        <!-- 개인정보제공 동의서 끝 -->						<!-- 개인정보의 제3자(해당법인)제공 동의 시작 -->                        <table cellspacing="0" height="" style="width:745px; border:1px solid #E9E9E9; background-color:#F8F8F7;">                          <tr>                            <td style="padding-left:10px; padding-top:10px;"><b><font color="#0033CC">::                              개인정보의 제3자(해당법인)제공 동의서 ::</font></b></td>                          </tr>                          <tr>                            <td style="padding:10px;">                              <table width="100%" border="0" cellspacing="0" cellpadding="10px" style="border:1px solid #E9E9E9; background-color:#FFFFFF;">                                <tr>                                  <td>								   <!-- 약관 내용 시작 -->								<br/>								&nbsp;<strong>● 개인정보를 제공받는 자</strong> <br/>								&nbsp;&nbsp;민원의 대상이 되는 수협중앙회(지사무소 포함), 회원조합, 자회사<br/>								<br/>								&nbsp;<strong>● 개인정보를 제공받는 자의 이용목적</strong><br/>								&nbsp;&nbsp;제기된 민원과 관련한 사실관계 확인 관련자료 제출<br/>								<br/>								&nbsp;<strong>● 제공하는 개인정보의 항목</strong><br/>								&nbsp;&nbsp;민원인이 제공한 성명, 생년월일, 주소, 전화(핸드폰)번호, 이메일 주소, 본인거래정보, 민원내용 등<br/>								<br/>								&nbsp;<strong>● 개인정보를 제공받는 자의 개인정보의 보유 및 이용기간</strong><br/>								&nbsp;&nbsp;해당법인은 민원(분쟁조정)사무의 처리 외의 목적으로 개인정보를 이용할 수 없으며 위 개인정보는 관계법령 등의 규정에 의하여 <br/>&nbsp;&nbsp;기록 &middot; 보존되고 기간이 경과할 경우 「개인정보보호법」등에서 정하는 바에 따라 파기됩니다. <br/>								<br/>								&nbsp;<strong>● 동의를 거부할 권리 및 동의 거부에 따른 불이익</strong> <br/>								&nbsp;&nbsp;귀하께서 개인정보의 해당법인 제공에 동의하지 않을 수 있으나, 미동의로 본인 식별 및 민원에 대한 사실관계 확인이 어려울 경우 <br/>&nbsp;&nbsp;민원처리가 불가능할 수 있습니다. 								<br/>								<br/>                              <!-- 약관 내용 끝 -->								  </td>                                </tr>                              </table>                            </td>                          </tr>                          <!-- 체크 버튼 -->                          <tr>                            <td style="padding-left:10px; padding-bottom:10px;">                              <input type="checkbox" name="agree2" value="ok" />                              위 내용을 충분히 인지하고 개인정보 제3자(해당법인) 제공에 동의합니다.</td>                          </tr>                        </table><br/>                        <!-- 개인정보의 제3자(해당법인)제공 동의 끝 -->

                        <!-- 민원신청 입력 창 시작 -->

                        <table cellspacing="0" class="join_form">

                          <caption class="basic">:: 민원 결과 조회 확인시 꼭 필요한 사항으로 *표시가

                          되어있는 항목은 반드시 정확하게 입력해 주세요 ::</caption>

                          <tr>

                            <th class="essential">이름</th>

                            <td>

                              <input type="text" class="typeText" name="name" onKeyDown="" value="">
                              <a href="javascript:fnPopup();"><img src="../pub_img/btn_name.gif" title="실명인증" /></a>
                               ( 이름은 실명으로 공백없이 입력하세요.)
								
                            </td>

                          </tr>						  <tr>                            <th class="essential">생년월일</th>
							<!-- 년 -->							<td>							<select name="Year">								<option value="">년</option>								 <%								 								//String strYear = Integer.toString(currentCalendar.get(Calendar.YEAR));																	  for(int yyyy=2014; yyyy>=1925; yyyy--){								 %>								   <option value="<%=yyyy%>"><%=yyyy%>년</option>								 <%								  }								 %>							</select>													<select name="Month">								<option value="">월</option>								<option value="01">1월</option><option value="02">2월</option><option value="03">3월</option>								<option value="04">4월</option><option value="05">5월</option><option value="06">6월</option>								<option value="07">7월</option><option value="08">8월</option><option value="09">9월</option>								<option value="10">10월</option><option value="11">11월</option><option value="12">12월</option>							</select>														<!-- 일 -->							<select name="Day">								<option value="">일</option>									<option value="01">1일</option><option value="02">2일</option><option value="03">3일</option>								<option value="04">4일</option><option value="05">5일</option><option value="06">6일</option>								<option value="07">7일</option><option value="08">8일</option><option value="09">9일</option>								<option value="10">10일</option><option value="11">11일</option><option value="12">12일</option>								<option value="13">13일</option><option value="14">14일</option><option value="15">15일</option>								<option value="16">16일</option><option value="17">17일</option><option value="18">18일</option>								<option value="19">19일</option><option value="20">20일</option><option value="21">21일</option>								<option value="22">22일</option><option value="23">23일</option><option value="24">24일</option>										<option value="25">25일</option><option value="26">26일</option><option value="27">27일</option><option value="28">28일</option>								<option value="29">29일</option><option value="30">30일</option><option value="31">31일</option>																	</select>							</td>						</tr>
                          <tr>

                            <th class="essential">주소</th>

                            <td>

                              <input type="text" size="4" name="sh_post_1" value="" readonly class="typeText input_mini" />

                              <span class="sp_txt">-</span>

                              <input type="text" size="4" name="sh_post_2" value="" readonly class="typeText input_mini" />

                              <a href="javascript:ZipSearch();"><img src="../pub_img/mb_bt_addr.gif" title="주소찾기" /></a>

                              <br />

                              <input type="text" name="sh_address_1" readonly value="" class="typeText input_addr_01"/><br />

                              <input type="text" name="sh_address_2" value="" class="typeText input_addr_02">

                            </td>

                          </tr>

                          <tr>

                            <th class="essential">전화번호</th>

                            <td>

                              <input type="text" maxlength="3" name="sh_tel_1" value="" class="typeText input_mini" />

                              <span class="sp_txt">-</span>

                              <input type="text" maxlength="4" name="sh_tel_2" value="" class="typeText input_mini" />

                              <span class="sp_txt">-</span>

                              <input type="text" maxlength="4" name="sh_tel_3" value="" class="typeText input_mini" />

                            </td>

                          </tr>

                          <tr>

                            <th class="essential">휴대폰</th>

                            <td>

                              <input type="text" maxlength="3" name="sh_han_1" value="" class="typeText input_mini" />

                              <span class="sp_txt">-</span>

                              <input type="text" maxlength="4" name="sh_han_2" value="" class="typeText input_mini" />

                              <span class="sp_txt">-</span>

                              <input type="text" maxlength="4" name="sh_han_3" value="" class="typeText input_mini" />

                            </td>

                          </tr>

                          <tr>

                            <th class="essential">이메일</th>

                            <td>

                              <input type="text" name="sh_email_1" onBlur="checkInput(this)" value="" class="typeText input_txt" />

                              <span class="sp_txt">@</span>

                              <input type="text" name="sh_email_2" value="" class="typeText input_txt" />

                              <select name="sh_email_3" onChange="mail_change()">

                                <option value="">선택하세요 </option>

                                <option value='naver.com'>네이버</option>

                                <option value='hanmail.net'>한메일</option>

                                <option value='nate.com'>네이트</option>

                								<option value="">직접입력</option>

                              </select>

                            </td>

                          </tr>

                          <tr>

                            <th class="essential">비밀번호</th>

                            <td>

                              <input type="password" name="psword" value=""class="typeText input_txt" />&nbsp;비밀번호는 4자리 이상 6자리 이하로 작성하여주세요.



                            </td>

                          </tr>												<tr>                            <th class="essential">민원대상</th>
							<td>							<input type="radio" name="sh_center" value="수협중앙회"/> 수협중앙회 <input type="radio" name="sh_center" value="회원조합"/> 회원조합 <br/>							대상영업점 <input style="color:#BDBDBD" size="30" type="text" name="self_text" maxlength="15" value="글자수 15자리까지" onfocus="this.value=''" onblur="if(this.value =='') this.value='글자수 15자리까지';"/> (직접입력)							<td>																				</tr>												
                          <tr>

                            <th class="essential">분야선택</th>

                            <td>

                              <select name="sh_cata">

                                <option value='cho'>선택하세요 </option>

                                <option value='수협은행'>수협은행</option>

                                <option value='펀드판매관련' >펀드판매관련</option>

                                <option value='공제보험'>공제보험</option>

                                <option value='바다마트'>바다마트</option>

                                <option value='공판장(경매)'>공판장(경매)</option>

                                <option value='면세유류'>면세유류</option>

                                <option value='회원조합/어촌계'>회원조합/어촌계</option>

                                <option value='고객지원불친철'>고객지원불친철</option>

                                <option value='기타사항'>기타사항</option>

                              </select>

                            </td>

                          </tr>

                          <tr>

                            <th class="essential">회신방식</th>

                            <td>

                              <select name="sh_reply_type">

                                <option value="">선택하세요 </option>

                                <option value="홈페이지">홈페이지</option>

                                <option value="이메일" >이메일</option>

                                <option value="휴대폰">휴대폰</option>

                              </select>

                            </td>

                          </tr>

                        </table>

                        <p class="essential">필수 입력사항</p>

                        <table cellspacing="0" class="button">

                          <tr>

                            <td> <a href="javascript:GoReg();"><img src="../pub_img/btminwon_ok.gif" title="민원신청버튼" width="68" height="18" /></a>

                              <a href="javascript:pbform.reset();"><img src="../pub_img/btminwon_cancel.gif" title="다시입력버튼" width="68" height="18" /></a>

                            </td>

                          </tr>

                        </table>

                        <!-- 민원신청 입력 창 시작 -->

                      </td>

                    </tr>

                  </table>





                  <!-- 본문영역 끝-->

                </td>

              </tr>

            </table>

          </td>

        </tr>

      </table>

    </td>

  </tr>

</table>

<!-- end content table-->

</form>

</td>
</tr>
</table>

</div><%@ include file="/include/shFooter.jsp" %></body>

</html>