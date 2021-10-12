<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, SafeNC.kisinfo.*, Kisinfo.Check.IPINClient"%>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>



<% String pageNum = "5"; %>
<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
    String sSiteCode = "G5890";				// NICE로부터 부여받은 사이트 코드
    String sSitePassword = "VN2VPY5TTKBU";		// NICE로부터 부여받은 사이트 패스워드
    
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko"><head>	<title>민원신청 &gt; 전자민원창구 &gt; 고객지원 &gt; 수협</title>	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>	<script type="text/javascript" src="/js/public.js"></script>	<script type="text/javascript" src="/js/common.js"></script><script type="text/javascript"><!--	//약관 동의 여부 체크	function GoReg() {		if(document.vnoform.param_r1.value!="1"){			alert("실명인증을 해주시기바랍니다.");		}		else{		if (document.all.agree.checked == true && document.all.agree2.checked == true){			var d = document.pbform;			if (d.name.value.length == 0) {alert("성명을 입력해 주십시오"); d.name.focus(); return;}			if(d.Year.value==""){				alert("년을 선택해 주십시오.");				d.Year.focus();				return;			}
			if(d.Month.value==""){				alert("월을 선택해 주십시오.");				d.Month.focus();				return;			}			if(d.Day.value==""){				alert("일을 선택해주십시오.");				d.Day.focus();				return;			}
			if (pbform.sh_post_1.value.length == 0 /*|| pbform.sh_post_2.value.length == 0*/){				alert("주소가 입력되지 않았습니다.");				return;			}else if(pbform.sh_address_1.value.length == 0 || pbform.sh_address_2.value.length == 0  ){				alert("주소가 입력되지 않았습니다."); d.sh_address_2.focus(); return;			}			if (pbform.sh_tel_1.value.length == 0){				alert("전화번호가 입력되지 않았습니다.");				d.sh_tel_1.focus();				return;			}else if(pbform.sh_tel_2.value.length == 0){				alert("전화번호가 입력되지 않았습니다.");				d.sh_tel_2.focus();				return;			}else if(pbform.sh_tel_3.value.length == 0){				alert("전화번호가 입력되지 않았습니다.");				d.sh_tel_3.focus();				return;			}			if (pbform.sh_han_1.value.length == 0){				alert("핸드폰번호가 입력되지 않았습니다.");				d.sh_han_1.focus();				return;			}else if(pbform.sh_han_2.value.length == 0){				alert("핸드폰번호가 입력되지 않았습니다.");				d.sh_han_2.focus();				return;			}else if(pbform.sh_han_3.value.length == 0){				alert("핸드폰번호가 입력되지 않았습니다.");				d.sh_han_3.focus();				return;			}			if(pbform.sh_email_1.value !== ""){			//선택했을때 검사				if(!chkEmail2(pbform.sh_email_1,pbform.sh_email_2))  return;			}else if(pbform.sh_email_3.value !== ""){				//직접입력시 검사				if(!chkEmail2(pbform.sh_email_3,pbform.sh_email_4))  return;			}else{				if (!isInput(pbform.sh_email_1,"메일을 입력해 주세요")){ 	return; }				else if(!isInput(pbform.sh_email_3,"메일을 입력해 주세요")){	return;}			}			if (d.psword.value.length == 0) {alert("패스워드를 입력해 주십시오"); d.psword.focus(); return;}			if(!chkPWD(d.psword)) return;			//20140820			if(d.sh_center[0].checked==false && d.sh_center[1].checked==false){							alert("민원대상을 선택해 주십시오.");				return;			}			
			if(d.self_text.value=='글자수 15자리까지'){					alert("대상영업점을 입력해 주십시오.");				d.self_text.focus();				return;			}			//20140820
			if(d.sh_cata.value == 'cho') {				alert("분야를 선택해 주십시오");				d.sh_cata.focus();				return;			}			if(d.sh_reply_type.value == "") {				alert("회신방식을 선택해 주십시오");				d.sh_reply_type.focus();				return;			}			pbform.action = "minwon_apply02_1.jsp";			pbform.submit();
		}else if(document.all.agree.checked == false && document.all.agree2.checked == false){			alert("개인정보수집 및 이용동의서와 개인정보의 제3자(해당법인)제공 동의서에 동의하셔야 민원신청이가능합니다.");		}		else if(document.all.agree.checked == false){			alert("개인정보 수집 및 이용동의서에 동의하셔야 민원신청이 가능합니다");		}
		else if(document.all.agree2.checked == false){			alert("개인정보의 제3자(해당법인) 제공 동의서에 동의하셔야 민원신청이 가능합니다.");		}
		}	}	//우편번호 검색	function ZipSearch(){
		var pop = window.open("/minwon/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
		/*		var wint = (screen.height - 350) / 2;		var winl = (screen.width - 400) / 2;		winprops = 'height=402,width=383,top='+wint+',left='+winl+',status=no,scrollbars=yes,resize=no'		winurl = 'find_addr_v2.jsp?return1=pbform.sh_post_1&amp;return2=pbform.sh_post_2&amp;return3=pbform.sh_address_1';		win = window.open(winurl, "zipsearch", winprops)
		*/	}
	
	//우편번호 콜백
	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
		
		var frm = document.pbform;
		
		frm.sh_post_1.value = zipNo;
		frm.sh_address_1.value = roadAddrPart1;
		frm.sh_address_2.value = addrDetail;
		frm.sh_address_2.focus();
	}	//검색 우편번호 세팅	function input_zipcode(zip1,zip2,address){		var frm = document.pbform;		//alert(zip1)		frm.sh_post_1.value = zip1;		/*frm.sh_post_2.value = zip2;*/		frm.sh_address_1.value = address;		frm.sh_address_2.focus();	}		// 사용자가 이메일 도메인에 이벤트를 가했을때	function mail_change() {		var A = document.pbform;		// 밑에 직접 입력란을 활성화 시켜준다.		if(A.sh_email_3.value == 'etc') {			A.sh_email_2.value = '';		} else {			A.sh_email_2.value = A.sh_email_3.value;		}	}//--></script>
<script language='javascript'>
	window.name ="Parent_window";
	function fnPopup(){		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');		document.vnoform.EncodeData.value = "<%= sEncData %>";		document.vnoform.param_r1.value="";		document.vnoform.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";		document.vnoform.target = "popupChk";		document.vnoform.submit();	}
</script>
</head>
<body id="minwon01">
	<!-- header -->	<%@ include file="/include/shHeader.jsp" %>	<!-- //header -->
	<!-- container -->	<div id="ContentLayer">
		<!-- LNB -->		<%@ include file="/include/lnbService.jsp" %>		<!-- //LNB --><form name="vnoform" method="post">		<input type="hidden" name="m" value="checkplusSerivce">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->		<input type="hidden" name="EncodeData" value="<%= sEncData %>">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->	    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.	    	 해당 파라미터는 추가하실 수 없습니다. -->		<input type="hidden" name="param_r1" value="">		<input type="hidden" name="param_r2" value="">		<input type="hidden" name="param_r3" value=""></form>
<form name="pbform" method="post" action=""><input type="hidden" name="vDiscrNo" value=""/>
		<!-- contents -->		<div id="primaryContent">			<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>전자민원창구</span>민원신청</p>			<h3>민원신청</h3>			<div class="pdl20 pdr30">				<h4 class="title_arrow_green01 mgb15">개인정보 수집 및 이용 동의서</h4>				<dl class="box_line03 mgb20 mgl15">					<dt>개인정보 수집 및 이용목적</dt>					<dd>제공하신 개인정보는 신속하고 공정한 민원상담 · 처리(본인식별, 민원 사실관계 확인 및 민원처리결과 통지 등)를 위한 용도로 수집 · 이용됩니다.</dd>					<dt>수집하려는 개인정보의 항목</dt>					<dd>성명, 생년월일, 주소, 전화(핸드폰)번호, 이메일 주소, 본인거래정보, 민원내용 등</dd>					<dt>개인정보의 보유 및 이용기간</dt>					<dd>						위 개인정보는 수집 · 이용에 관한 동의일로부터 처리 종료일까지 민원사무처리를 위하여 보유 · 이용되며, 민원 종결 후에는 						기타 법령 상 의무이행 및 소비자보호 업무수행을 위해 보유 · 이용됩니다. 					</dd>					<dt>동의를 거부할 권리 및 동의 거부에 따른 불이익</dt>					<dd>						귀하께서 개인정보의 수집 · 이용 동의에 거부할 권리가 있으나, 위 정보는 본인 식별 및 민원에 대한 사실관계 확인에 필수적인 						정보로 수집 · 이용에 동의하셔야만 민원처리가 가능합니다. 					</dd>				</dl>				<div class="mgb50 pdl25">					<input type="checkbox" class="checkbox mgr5" id="agree1" name="agree" value="ok" /><label for="agree1">위에 내용을 충분히 인지하고 개인정보 수집 · 이용에 동의합니다.</label>				</div>								<h4 class="title_arrow_green01 mgb15">개인정보의 제3자(해당법인)제공 동의서</h4>				<dl class="box_line03 mgb20 mgl15">					<dt>개인정보를 제공받는 자</dt>					<dd>민원의 대상이 되는 수협중앙회(지사무소 포함), 회원조합, 자회사</dd>					<dt>개인정보를 제공받는 자의 이용목적</dt>					<dd>제기된 민원과 관련한 사실관계 확인 관련자료 제출</dd>					<dt>제공하는 개인정보의 항목</dt>					<dd>민원인이 제공한 성명, 생년월일, 주소, 전화(핸드폰)번호, 이메일 주소, 본인거래정보, 민원내용 등</dd>					<dt>개인정보를 제공받는 자의 개인정보의 보유 및 이용기간</dt>					<dd>						해당법인은 민원(분쟁조정)사무의 처리 외의 목적으로 개인정보를 이용할 수 없으며 위 개인정보는 관계법령 등의 규정에 의하여 						기록 · 보존되고 기간이 경과할 경우 「개인정보보호법」등에서 정하는 바에 따라 파기됩니다. 					</dd>					<dt>동의를 거부할 권리 및 동의 거부에 따른 불이익</dt>					<dd>						귀하께서 개인정보의 해당법인 제공에 동의하지 않을 수 있으나, 미동의로 본인 식별 및 민원에 대한 사실관계 확인이 어려울 경우 						민원처리가 불가능할 수 있습니다.					</dd>				</dl>				<div class="mgb65 pdl25">					<input type="checkbox" class="checkbox mgr5" id="agree2"  value="ok" /><label for="agree2">위 내용을 충분히 인지하고 개인정보 제3자(해당법인) 제공에 동의합니다.</label>				</div>								<p class="mgb10 mgl20">민원 결과 조회 확인시 꼭 필요한 사항으로 *표시가 되어있는 항목은 반드시 정확하게 입력해 주세요</p>				<div class="mgl15">					<table class="write" summary="민원 신청을 위한 이름, 생년월일, 주소, 전화번호, 휴대폰, 이메일, 비밀번호, 민원대상, 분야선택, 회신방식 등록">					<caption>민원 신청 등록</caption>					<colgroup>						<col style="width:18%;" />						<col style="width:auto;" />					</colgroup>					<tr>						<th scope="row"><span class="txt_request">*</span>이름</th>						<td>							<input type="text" name="name" class="text" style="width:198px;" title="이름" /><a href="javascript:fnPopup();" class="btn_blue_s01 mgl10" title="새창열림"><span>실명인증</span></a><p class="displayInB mgl5">( 이름은 실명으로 공백없이 입력하세요.)</p>						</td>					</tr>					<tr>						<th scope="row"><span class="txt_request">*</span>생년월일</th>						<td>							<select name="Year" class="mgr10" title="생년">								<option value="">년</option>								 <%								//String strYear = Integer.toString(currentCalendar.get(Calendar.YEAR));								  for(int yyyy=2014; yyyy>=1914; yyyy--){								 %>								   <option value="<%=yyyy%>"><%=yyyy%>년</option>								 <%								  }								 %>							</select>							<select name="Month" class="mgr10" title="생월">								<option value="">월</option>								<option value="01">1월</option><option value="02">2월</option><option value="03">3월</option>								<option value="04">4월</option><option value="05">5월</option><option value="06">6월</option>								<option value="07">7월</option><option value="08">8월</option><option value="09">9월</option>								<option value="10">10월</option><option value="11">11월</option><option value="12">12월</option>							</select>							<select name="Day" class="mgr10" title="생일">								<option value="">일</option>									<option value="01">1일</option><option value="02">2일</option><option value="03">3일</option>								<option value="04">4일</option><option value="05">5일</option><option value="06">6일</option>								<option value="07">7일</option><option value="08">8일</option><option value="09">9일</option>								<option value="10">10일</option><option value="11">11일</option><option value="12">12일</option>								<option value="13">13일</option><option value="14">14일</option><option value="15">15일</option>								<option value="16">16일</option><option value="17">17일</option><option value="18">18일</option>								<option value="19">19일</option><option value="20">20일</option><option value="21">21일</option>								<option value="22">22일</option><option value="23">23일</option><option value="24">24일</option>										<option value="25">25일</option><option value="26">26일</option><option value="27">27일</option><option value="28">28일</option>								<option value="29">29일</option><option value="30">30일</option><option value="31">31일</option>																	</select>						</td>					</tr>					<tr>						<th scope="row"><span class="txt_request">*</span>주소</th>						<td>							<input type="text" size="4" name="sh_post_1" value="" readonly class="text" style="width:88px;" title="우편번호" /><!--<span class="txt_dash vAlignM">-</span><input type="text" size="4" name="sh_post_2" value="" readonly class="text" style="width:88px;" title="우편번호 뒷자리" />--><a href="javascript:ZipSearch();" class="btn_blue_s01 mgl10" title="새창열림"><span>주소찾기</span></a><br />							<input type="text" name="sh_address_1" readonly value="" class="text mgt10 mgb10" style="width:508px;" title="동까지 입력" /><br />							<input type="text" name="sh_address_2" value="" class="text" style="width:508px;" title="상세주소" />						</td>					</tr>					<tr>						<th scope="row"><span class="txt_request">*</span>전화번호</th>						<td>							<input type="text" maxlength="3" name="sh_tel_1" onKeyUp="return autoTab(this, 3, event);" value="" class="text" style="width:68px;" title="전화번호 첫번째자리" /><span class="txt_dash vAlignM">-</span><input type="text" maxlength="4" name="sh_tel_2" onKeyUp="return autoTab(this, 4, event);" value="" class="text" style="width:68px;" title="전화번호 중간자리" /><span class="txt_dash vAlignM">-</span><input type="text" maxlength="4" name="sh_tel_3" onKeyUp="return autoTab(this, 4, event);" value="" class="text" style="width:68px;" title="전화번호 마지막 자리" />						</td>					</tr>					<tr>						<th scope="row"><span class="txt_request">*</span>휴대폰</th>						<td>							<input type="text" maxlength="3" name="sh_han_1" onKeyUp="return autoTab(this, 3, event);" value="" class="text" style="width:68px;" title="휴대폰번호 앞자리" /><span class="txt_dash vAlignM">-</span><input type="text" maxlength="4" name="sh_han_2" onKeyUp="return autoTab(this, 4, event);" value="" class="text" style="width:68px;" title="휴대폰번호 중간자리" /><span class="txt_dash vAlignM">-</span><input type="text" maxlength="4" name="sh_han_3" onKeyUp="return autoTab(this, 4, event);" value="" class="text" style="width:68px;" title="휴대폰번호 마지막 자리" />						</td>					</tr>					<tr>						<th scope="row"><span class="txt_request">*</span>이메일</th>						<td>							<input type="text" name="sh_email_1" onBlur="checkInput(this)" value="" class="text" style="width:148px;" title="이메일 주소 아이디" /><span class="txt_at vAlignM lineH170">@</span><input type="text" name="sh_email_2" value="" class="text" style="width:148px;" title="이메일 주소 도메인 직접입력" />							<select name="sh_email_3" onChange="mail_change()" class="mgl5" title="이메일주소 도메인 선택">								<option>선택하세요</option>                                <option value='naver.com'>네이버</option>                                <option value='hanmail.net'>한메일</option>                                <option value='nate.com'>네이트</option>   								<option value="">직접입력</option>							</select>						</td>					</tr>					<tr>						<th scope="row"><span class="txt_request">*</span>비밀번호</th>						<td>							<input type="password" name="psword" value="" class="text" style="width:198px;" title="비밀번호" /><p class="displayInB mgl5">비밀번호는 4자리 이상 6자리 이하로 작성하여주세요.</p>						</td>					</tr>					<tr>						<th scope="row"><span class="txt_request">*</span>민원대상</th>						<td>							<ul>								<li class="mgb25">									<span class="displayInB w70">법인구분 :</span>									<input type="radio" name="sh_center" value="수협중앙회" class="radio mgr5" id="complaint1" /><label for="complaint1">수협중앙회</label>									<input type="radio" name="sh_center" value="회원조합" class="radio mgr5 mgl10" id="complaint2" /><label for="complaint2">회원조합</label>								</li>								<li>									<span class="displayInB w70">대상영업점</span>									<input type="text" name="self_text" size="30" maxlength="15" value="글자수 15자리까지" onfocus="this.value=''" onblur="if(this.value =='') this.value='글자수 15자리까지';" class="text mgr5" style="width:198px;" title="민원대상영업점" />(직접입력) 								</li>							</ul>						</td>					</tr>					<tr>						<th scope="row"><span class="txt_request">*</span>분야선택</th>						<td>							<select name="sh_cata" title="분야선택">                                <option value='cho'>선택하세요</option>                                <option value='수협은행'>수협은행</option>                                <option value='펀드판매관련' >펀드판매관련</option>                                <option value='공제보험'>공제보험</option>                                <option value='바다마트'>바다마트</option>                                <option value='공판장(경매)'>공판장(경매)</option>                                <option value='면세유류'>면세유류</option>                                <option value='회원조합/어촌계'>회원조합/어촌계</option>                                <option value='고객지원불친철'>고객지원불친철</option>                                <option value='기타사항'>기타사항</option>							</select>						</td>					</tr>					<tr>						<th scope="row"><span class="txt_request">*</span>회신방식</th>						<td>							<select name="sh_reply_type" title="회신방식선택">                                <option value="">선택하세요 </option>                                <option value="홈페이지">홈페이지</option>                                <option value="이메일" >이메일</option>                                <option value="휴대폰">휴대폰</option>							</select>						</td>					</tr>					</table>					<p class="pdl23 mgt18"><span class="txt_request mgr5">*</span>으로 표시된 부분은 필수 입력사항</p>				</div>				<div class="btnR mgt30">					<a href="javascript:GoReg();" class="btn_blue_arrowB01 w150"><span>민원신청</span></a><a href="javascript:pbform.reset();" class="btn_green_arrowB01 w150"><span>다시입력</span></a>				</div>			</div>		</div>		<!-- //contents --></form>	</div>	<!-- //container -->	<!-- footer -->	<%@ include file="/include/shFooter.jsp" %>	<!-- //footer --></body></html>