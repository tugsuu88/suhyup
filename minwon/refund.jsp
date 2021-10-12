<%@ page import="java.util.*, java.text.*, util.*" contentType="text/html;charset=euc-kr"%>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>
<%
	//String pageNum 	= "6";
	//String ListPage = "data_01.jsp";
	//String sh_site 	= "1"; //싸이트 구분
	//String sh_class = "97"; //게시판 구분
	//String incPage 	= request.getParameter("incPage");
	//String myPage 	= request.getRequestURI();
	
	int PAGE = 1;
	String TableName = " ncas.VW_CM_COOPINFO@LK_SUHYUP_NCAS ";
    String SelectCondition = " COOP_CD, COOP_NM ";
    String WhereCondition = null;
    String OrderCondition = " Order by COOP_NM ASC ";
	
	//실명인증
	NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sSiteCode = "G5890";				// NICE로부터 부여받은 사이트 코드
    String sSitePassword = "VN2VPY5TTKBU";
    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

  	String sAuthType = "";      // 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
   	String popgubun = "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
	String customize = "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지

    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    String sReturnUrl = "https://www.suhyup.co.kr/member/checkplus_success1.jsp";      // 성공시 이동될 URL
    //String sReturnUrl = "http://localhost:8080/member/checkplus_success1.jsp";  		//로컬에서 
    String sErrorUrl = "https://www.suhyup.co.kr/member/checkplus_fail.jsp";          // 실패시 이동될 URL

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

    if( iReturn == 0 ){
        sEncData = niceCheck.getCipherData();
    }else if( iReturn == -1){
        sMessage = "암호화 시스템 에러입니다.";
    }else if( iReturn == -2){
        sMessage = "암호화 처리오류입니다.";
    }else if( iReturn == -3){
        sMessage = "암호화 데이터 오류입니다.";
    }else if( iReturn == -9){
        sMessage = "입력 데이터 오류입니다.";
    }else{
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
%>

<%@ include file="../inc/requestSecurity.jsp" %>
<%@ include file="../inc/login_check.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>민원신청 &gt; 전자민원창구 &gt; 고객지원 &gt; 수협</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<link rel="stylesheet" type="text/css" href="/css/new/service.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var titleName = "출자·배당금 환급조회 > 고객지원 > 수협";
			document.title = titleName;
		});
		
		//조회
		function fnSearch() {
			if(document.pbform.code.value == null || document.pbform.code.value == ""){
				alert("실명인증을 해주시기바랍니다.");
				return;
			}else{
				
				if(document.pbform.name.value.length == 0){
					alert("이름이 입력되지 않았습니다.");
					document.pbform.name.focus();
					return;
				}
						
				if (document.pbform.ymd.value.length == 0){
					alert("생년월일이 입력되지 않았습니다.");
					document.pbform.ymd.focus();
					return;
				}
				
				pbform.action = "refundRt.jsp";
				pbform.submit();
			} 
		}

		//숫자체크
		function checkLetter(obj, rtnyn) {
		    var src_chars = obj.value;
		    var com_chars = "";
		    
	        com_chars = "0123456789";
	        
	        if (!ContainsCharsCheck(src_chars, com_chars)) {
	            alert("숫자만 입력 가능합니다.");
	            obj.value = ContainsCharsOnly(src_chars, com_chars);
	        } else {
	            obj.value = src_chars;
	        }
		    
		    if( rtnyn == "Y") {
		        return obj.focus();
		    }
		}
		
		//포함된 문자확인
		function ContainsCharsCheck(str, chars) {
		    for (var inx = 0; inx < str.length; inx++) {
		       if (chars.indexOf(str.charAt(inx)) == -1)
		           return false;
		    }
		    return true;
		}

		//문자만
		function ContainsCharsOnly(str, chars) {
		    var rtnstr = "";
		    
		    for (var inx = 0; inx < str.length; inx++) {
		       if (chars.indexOf(str.charAt(inx)) == -1) {
		           return rtnstr;
		       } else {
		               rtnstr += str.charAt(inx);
		       }
		    }
			return rtnstr;
		}
		
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
	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

	<!-- container -->
	<div id="ContentLayer">
		
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->

		<form name="vnoform" method="post">
			<input type="hidden" name="m" value="checkplusSerivce"/>						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
			<!-- <input type="hidden" name="EncodeData" value="AgAFRzU4OTAV28PMg2XgIr/+PjbKyS4kh6WX2FXI5BxGeQ6WBN+l0yL5VXnY0mloFNKSGS4vgo8wPhVCKg5yBid2wXPzUXSI9SaI4J9NX+pYqkml1x8fqzI+J0x+n7W3fApsaCpE/IrQToLrzAlwou7nYEiXlW1BnnV45T4DIZ9B40+NnLRfnJVvxeGkxeqB2kLxHnrGAlO2C/gzocHuDwn6O8fSSCjJfLdQeDEsZMCtZuXE2dnE2rb+ImdbA3+0bnxKlqaZnkharVdM7rFGv9vMyQgJIUby5G051SgJKfdrgg5XrJMcTDMSVHzZNJcgxxH8DSGoftsI2KgGKW3jiF6KrDXzbuyF0PbjIaBFPZK1q3ac056UDulsLwjMJBakcN7FdipZXnCRzqsUjazIk3+MX4f6XkoAwUTugnO2tAvSiKOWOqp2uecDo9voCKwEDvUR8O+QvrPYne1cfVGFtMVKBaLnKWGNtJKUE4m/mYlanUU3ltj/lA=="/> -->		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
			<input type="hidden" name="EncodeData" value="<%= sEncData %>"/>		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
		    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
		    	 해당 파라미터는 추가하실 수 없습니다. -->
			<input type="hidden" name="param_r1" value=""/>
			<input type="hidden" name="param_r2" value=""/>
			<input type="hidden" name="param_r3" value=""/>
		</form>

		<form name="pbform" method="post" action="">	
			<input type="hidden" name="vDiscrNo" value=""/>
			<input type="hidden" name="code" value=""/>
			<!-- contents -->
			<div id="primaryContent">
				<p class="indicate"><span class="shHome">수협</span><span>고객지원</span>출자·배당금 환급조회</p>
				<h3>출자·배당금 환급조회</h3>
				<div class="pdl20 pdr30">
					<p class="mgb10 mgl20">출자·배당금 환급조회 확인 시 꼭 필요한 사항으로 반드시 정확하게 입력해 주세요.</p>
					<div class="mgl15">
						<table class="write" summary="출자·배당금 환급을 위한 조합명선택, 이름, 생년월일 기입">
						<caption>출자·배당금 환급조회</caption>						
						<colgroup>
							<col style="width:18%;" />
							<col style="width:auto;" />
						</colgroup>
						<tr>
							<th scope="row"><label for="cnm">조&nbsp; 합&nbsp; 명</label></th>
							<td>
								<select name="cnm" id="cnm" style="width:202px;">
<%
								Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 1);

								if( ResultVector.size() > 0){
									for (int i=0; i < ResultVector.size();i++){
										Hashtable h = (Hashtable)ResultVector.elementAt(i);

										String coopCd = (String)h.get("COOP_CD");
										String coopNm = (String)h.get("COOP_NM");
%>
									<option value="<%=coopCd%>"><%=coopNm%></option>
<%									} %>
<% 								}else{ %>
					 				<option value="">조회값이 없습니다.</option>
<% 								} %>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="name">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</label></th>
							<td>
								<input type="text" class="text readonly" name="name" id="name" style="width:198px;" readonly/>
									<a href="javascript:fnPopup();" class="btn_blue_s01 mgl10" title="새창열림">
										<span>실명인증</span>
									</a>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="ymd">생년월일</label></th>
							<td>
								<input type="text"class="text readonly" name="ymd" id="ymd" style="width:198px;" size="6" maxlength="6" onkeyup="javascript:checkLetter(this,'Y');" readonly/>
							</td>
						</tr>
						</table>
					</div>
					<div class="btnR mgt30">
						<a href="javascript:fnSearch();" class="btn_green_arrowB01 w150"><span>조회</span></a>
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
