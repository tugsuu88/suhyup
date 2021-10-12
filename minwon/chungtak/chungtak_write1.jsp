<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, SafeNC.kisinfo.*, Kisinfo.Check.IPINClient"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>


<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="/inc/requestSecurity.jsp" %>
<%@ include file="/inc/requestNameCheck.jsp" %>

<%
    String vDiscrNo   = jumin;
// 	String vDiscrNo   = "8303181000000";
// 	System.out.println("vDiscrNo == " + vDiscrNo);
// 	String vName = "테스터";
// 	iRtn = 1; //테스트 위해 심어놈
	
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
	<title>청탁금지법 위반 신고 &gt; 신고센터 &gt; 고객지원 &gt; 수협</title>
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

	<link rel="stylesheet" href="/js/jquery-ui-1.8.4.custom.css" type="text/css" />
	<script type="text/javascript" src="/js/jquery-ui-1.8.4.custom.min.js"></script>
	<script type="text/javascript" src="/js/script-date.js"></script>

	<script type="text/javascript">
	
	$(document).ready(function(){
		var clareCalendar = {
				monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				dayNamesMin: ['일','월','화','수','목','금','토'],
				weekHeader: 'Wk',
				dateFormat: 'yy-mm-dd',
				autoSize: false,
				changeMonth: true,
				changeYear: true,
				showMonthAfterYear: true,
				buttonImageOnly: true,
				buttonText: '달력선택',
				buttonImage: '/new_images/common/button/btn_sch.gif',
				yearRange: '1930:2020',
				constrainInput: false 
		};
		
		$("input[name=ct_date]").datepicker(clareCalendar);
		
	});
	
	//약관 동의 여부 체크
	function GoReg() {
			
		var d = document.pbform;
		
		//신고자 정보
		if (d.sg_name.value.length == 0) {
			alert("성명이 입력되지 않았습니다.");
			d.sg_name.focus(); 
			return;
		}
		
		if (d.sg_job.value.length == 0) {alert("직업이 입력되지 않았습니다."); d.sg_job.focus(); return;}
		
		if (d.sg_tel1.value.length == 0) {
			alert("연락처가 입력되지 않았습니다."); 
			d.sg_tel1.focus(); 
			return;
		} else if (d.sg_tel2.value.length == 0) {
			alert("연락처가 입력되지 않았습니다."); 
			d.sg_tel2.focus(); 
			return;
		} else if (d.sg_tel3.value.length == 0) {
			alert("연락처가 입력되지 않았습니다."); 
			d.sg_tel3.focus(); 
			return;
		}
		
		if (d.sg_zip1.value.length == 0) {alert("우편번호가 입력되지 않았습니다."); d.sg_zip1.focus(); return false;}
		if (d.sg_zip2.value.length == 0) {alert("우편번호가 입력되지 않았습니다."); d.sg_zip2.focus(); return false;}
		
		if (d.sg_addr1.value.length == 0) {alert("주소가 입력되지 않았습니다."); d.sg_addr1.focus(); return false;}
		if (d.sg_addr2.value.length == 0) {alert("상세주소가 입력되지 않았습니다."); d.sg_addr2.focus(); return false;}
		
		if (d.sg_pass.value.length == 0) {alert("비밀번호가 입력되지 않았습니다."); d.sg_pass.focus(); return false;}
		if (!chkPWD(d.sg_pass)) return false;
		
		//부정청탁을 한 자 또는 금품등을 제공한 자
		if (d.ct_name.value.length == 0) {alert("이름이 입력되지 않았습니다."); d.ct_name.focus(); return false;}
		
		if (d.ct_zip1.value.length == 0) {alert("우편번호가 입력되지 않았습니다."); d.ct_zip1.focus(); return false;}
		if (d.ct_zip2.value.length == 0) {alert("우편번호가 입력되지 않았습니다."); d.ct_zip2.focus(); return false;}
		
		if (d.ct_addr1.value.length == 0) {alert("주소가 입력되지 않았습니다."); d.ct_addr1.focus(); return false;}
		if (d.ct_addr2.value.length == 0) {alert("상세주소가 입력되지 않았습니다."); d.ct_addr2.focus(); return false;}
		
		//부정청탁 또는 금품등 수수 내용
		if (d.ct_date.value.length == 0) {alert("일시가 입력되지 않았습니다."); d.ct_date.focus(); return false;}
		if (d.ct_place.value.length == 0) {alert("장소가 입력되지 않았습니다."); d.ct_place.focus(); return false;}
		if (d.ct_content.value.replace(/(^\s*)|(\s*$)/gi, "").length == 0) {alert("내용을 입력해 주십시오"); d.ct_content.focus(); return;}
		if (d.ct_reason.value.replace(/(^\s*)|(\s*$)/gi, "").length == 0) {alert("신고취지 및 이유를 입력해 주십시오"); d.ct_reason.focus(); return;}
		
		if(d.bh_yn.value == undefined){
			d.bh_yn.value = "";
		}
		 
		d.submit();
	}
	
		//우편번호 검색
		function ZipSearch(zipType){
			
			var wint = (screen.height - 350) / 2;
			var winl = (screen.width - 400) / 2;
			winprops = 'height=402,width=383,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'
// 			winurl = 'find_addr_v2.jsp?return1=pbform.sg_zip1&amp;return2=pbform.sg_zip2&amp;return3=pbform.sg_addr1';
			winurl = 'chungtak_find_addr.jsp?zipType='+zipType;
			win = window.open(winurl, "ZipSearch", winprops);
		}
		
		//검색 우편번호 세팅
		function input_zipcode(zip1,zip2,address, zipGb){
// 			alert(zip1 +" = "+ zip2 +" = "+ address +" = "+ zipGb);
			
			var frm = document.pbform;
			
			if(zipGb == "1"){
				frm.sg_zip1.value = zip1;
				frm.sg_zip2.value = zip2;
				frm.sg_addr1.value = address;
				frm.sg_addr2.focus();
			}else{
				frm.ct_zip1.value = zip1;
				frm.ct_zip2.value = zip2;
				frm.ct_addr1.value = address;
				frm.ct_addr2.focus();
			}
			
			//alert(zip1)
			
		}
	
		function goView(val){
			var vForm = document.viewform;
			if(val == '1'){
				vForm.action = "chungtak_write1.jsp";
				vForm.submit();
			}else if(val == '2'){
				vForm.action = "chungtak_write2.jsp";
				vForm.submit();
			}
		}
		
		function getRadio(name) {
			var rdo = document.getElementsByName(name);
			for(var i = 0; i < rdo.length; i++) {
				if(rdo[i].checked) {
					return rdo[i].value;
				}
			}
	
			return "";
		}
	</script>

<style type="text/css">
.smallfont{font-size:11px;letter-spacing: -1px}
</style>

</head>

<body id="chungtak_write1">

	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

	<!-- container -->
	<div id="ContentLayer">

		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->
		
		<form name="viewform" method="post" action="chungtak_write2.jsp">
			<input type="hidden" name="enc_data" value="<%=enc_data%>" />
		    <input type="hidden" name="param_r1" value="<%=param_r1%>" />
		    <input type="hidden" name="param_r2" value="<%=param_r2%>" />
		    <input type="hidden" name="param_r3" value="<%=param_r3%>" />
			<input type="hidden" name="vDiscrNo" value="<%=vDiscrNo%>" />
		</form>

		<form name="pbform" method="post" action="chungtak_proc.jsp">
			<input type="hidden" name="vDiscrNo" value="<%=vDiscrNo%>" />
			<input type="hidden" name="type" value="1" />
			<input type="hidden" name="zipGb1" value="1" />
			<input type="hidden" name="zipGb2" value="2" />
			
			<!-- contents -->
			<div id="primaryContent">
			
				<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>신고센터</span>청탁금지법 위반 신고</p>
				<h3>신고하기</h3>
				<div class="pdl20 pdr20">
					<p class="mgb10 mgl15">결과 조회 확인시 꼭 필요한 사항으로 *표시가 되어있는 항목은 반드시 정확하게 입력해 주세요</p>
					<div class="mgl15">
						<table class="write mgb25" summary="신고형식 선택">
							<caption>신고형식</caption>
							<colgroup>
								<col style="width:18%;"/>
								<col style="width:auto;"/>
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">신고 형식</th>
								<td style="height:auto;">
									<input type="radio" name="register" class="radio mgr5 mgl10" id="register01" checked="checked" onclick="goView(1);"/><label for="register01">자진신고용</label>
									<input type="radio" name="register" class="radio mgr5 mgl40" id="register02" onclick="goView(2);"/><label for="register02">제3자신고용</label>
								</td>
							</tr>
							</tbody>
						</table>
						
						<h4 class="title_dot_blue">신고자 정보</h4>
						<table class="write mgb25" summary="성명, 직업(소속), 연락처, 주소, 비밀번호 입력 테이블">
							<caption>신고자 정보</caption>
							<colgroup>
								<col style="width:18%;"/>
								<col style="width:auto;"/>
							</colgroup>
							<tbody>
							<tr>
								<th scope="row"><span class="txt_request">*</span>성명</th>
								<td>
									<input type="text" class="text" value="<%=name%>" name="sg_name" style="width:198px;" title="성명" readonly="readonly" />			
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="txt_request">*</span>직업(소속)</th>
								<td>
									<input type="text" class="text" style="width:198px;" name="sg_job" title="직업(소속)" maxlength="15" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="txt_request">*</span>연락처</th>
								<td>
									<input type="text" class="text" style="width:68px;" name="sg_tel1" title="연락처 첫번째자리" maxlength="3" /><span class="txt_dash vAlignM">-</span>
									<input type="text" class="text" style="width:68px;" name="sg_tel2" title="연락처 중간자리" maxlength="4" /><span class="txt_dash vAlignM">-</span>
									<input type="text" class="text" style="width:68px;" name="sg_tel3" title="연락처 마지막 자리" maxlength="4" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="txt_request">*</span>주소</th>
								<td>
									<input type="text" class="text" name="sg_zip1" style="width:88px;" title="우편번호" maxlength="3" readonly="readonly" /><span class="txt_dash vAlignM">-</span>
									<input type="text" class="text" name="sg_zip2" style="width:88px;" title="우편번호 뒷자리"  maxlength="3" readonly="readonly" />
										<a href="javascript:ZipSearch('1');" class="btn_blue_s01 mgl10" title="새창열림"><span>주소찾기</span>
									</a><br />
									<input type="text" class="text mgt10 mgb10" name="sg_addr1" style="width:508px;" title="동까지 입력" maxlength="200" readonly="readonly" /><br />
									<input type="text" class="text" name="sg_addr2" style="width:508px;" title="상세주소" maxlength="200" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="txt_request">*</span>비밀번호</th>
								<td>
									<input type="password" name="sg_pass" class="text" style="width:198px;" title="비밀번호" maxlength="6" /><p class="displayInB mgl5">비밀번호는 4자리 이상 6자리 이하로 작성하여주세요.</p>
								</td>
							</tr>
							</tbody>
						</table>
						
						<h4 class="title_dot_blue">부정청탁을 한 자 또는 금품등을 제공한 자</h4>
						<table class="write mgb25" summary="성명, 직업(소속), 연락처, 주소, 법인,단체등의 경우 명칭, 소재지, 대표자성명 입력 테이블">
							<caption>부정청탁을 한 자 또는 금품등을 제공한 자</caption>
							<colgroup>
								<col style="width:18%;"/>
								<col style="width:auto;"/>
							</colgroup>
							<tbody>
							<tr>
								<th scope="row"><span class="txt_request">*</span>성명</th>
								<td>
									<input type="text" class="text" name="ct_name" style="width:198px;" title="성명" maxlength="15" />
								</td>
							</tr>
							<tr>
								<th scope="row">직업(소속)</th>
								<td>
									<input type="text" class="text" name="ct_job" style="width:198px;" title="직업(소속)" maxlength="15"/>
								</td>
							</tr>
							<tr>
								<th scope="row">연락처</th>
								<td>
									<input type="text"class="text" name="ct_tel1" style="width:68px;" title="연락처 첫번째자리" maxlength="3" /><span class="txt_dash vAlignM">-</span>
									<input type="text" class="text" name="ct_tel2" style="width:68px;" title="연락처 중간자리" maxlength="4" /><span class="txt_dash vAlignM">-</span>
									<input type="text"  class="text" name="ct_tel3" style="width:68px;" title="연락처 마지막 자리" maxlength="4" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="txt_request">*</span>주소</th>
								<td>
									<input type="text" class="text" name="ct_zip1" style="width:88px;" title="우편번호" maxlength="3" readonly="readonly" /><span class="txt_dash vAlignM">-</span>
									<input type="text" class="text" name="ct_zip2" style="width:88px;" title="우편번호 뒷자리"  maxlength="3" readonly="readonly" />
										<a href="javascript:ZipSearch('2');" class="btn_blue_s01 mgl10" title="새창열림"><span>주소찾기</span>
									</a><br />
									<input type="text" class="text mgt10 mgb10" readonly="readonly" name="ct_addr1" style="width:508px;" title="동까지 입력" maxlength="200"/><br />
									<input type="text" class="text" name="ct_addr2" style="width:508px;" title="상세주소" maxlength="200" />
								</td>
							</tr>
							<tr>
								<th scope="row">법인·단체등의 경우</th>
								<td>
									<div><label for="companyName" class="displayInB w70">명칭</label>
										<input type="text" name="ct_corp" id="companyName" class="text" style="width:440px;" title="명칭" maxlength="15"/>
									</div>
									<div class="mgt10 mgb10"><label for="companyPlace" class="displayInB w70">소재지</label>
										<input type="text" name="ct_corpaddr" id="companyPlace" class="text" style="width:440px;" title="소재지" maxlength="15"/>
									</div>
									<div><label for="ceoName" class="displayInB w70">대표자성명</label>
										<input type="text" name="ct_corpname" id="ceoName" class="text" style="width:440px;" title="대표자성명" maxlength="15"/>
									</div>
								</td>
							</tr>
							</tbody>
						</table>
						
						<h4 class="title_dot_blue">부정청탁 또는 금품등 수수 내용</h4>
						<table class="write mgb25" summary="일시, 장소, 내용, 신고취지 및 이유 입력 테이블">
							<caption>부정청탁 또는 금품등 수수 내용</caption>
							<colgroup>
								<col style="width:18%;"/>
								<col style="width:auto;"/>
							</colgroup>
							<tbody>
							<tr>
								<th scope="row"><span class="txt_request">*</span>일시</th>
								<td>
									<input type="text" class="text" name="ct_date" style="width:508px;" title="일시" maxlength="20"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="txt_request">*</span>장소</th>
								<td>
									<input type="text" class="text" name="ct_place" style="width:508px;" title="장소" maxlength="20" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="txt_request">*</span>내용</th>
								<td>
									<textarea style="width:508px; min-height:60px;" name="ct_content" title="내용입력"></textarea><br />
									(금품 등 수수의 경우 그 종류 및 가액)
								</td>
								
							</tr>
							<tr>
								<th scope="row"><span class="txt_request">*</span>신고취지 및 <br />이유</th>
								<td>
									<textarea style="width:508px; min-height:50px;" name="ct_reason" title="신고취지 및 이유 입력"></textarea>
								</td>
							</tr>
							</tbody>
						</table>
						
						<h4 class="title_dot_blue">금품등 반환여부 및 방법(금품등 수수의 경우)</h4>
						<table class="write mgb25" summary="반환여부, 반환일시·장소 및 방법, 비고 입력 테이블">
							<caption>금품등 반환여부 및 방법(금품등 수수의 경우)</caption>
							<colgroup>
								<col style="width:18%;"/>
								<col style="width:auto;"/>
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">반환여부</th>
								<td style="height:auto;">
									<input type="radio" name="bh_yn" class="radio mgr5 mgl10" id="bh_yn01" value="Y" title="반환여부" /><label for="bh_yn01">반환</label>
									<input type="radio" name="bh_yn" class="radio mgr5 mgl40" id="bh_yn02" value="N" title="반환여부" /><label for="bh_yn02">미반환</label>
								</td>
							</tr>
							<tr>
								<th scope="row">반환 일시·장소 및 방법</th>
								<td>
									<textarea style="width:508px; min-height:60px;" name="bh_place" title="반환 일시·장소 및 방법" /></textarea>
									<br/ >* (반환한 경우)
								</td>
							</tr>
							<tr>
								<th scope="row">비고</th>
								<td>
									<input type="text" class="text" name="etc" style="width:508px;" title="비고"/>
								</td>
							</tr>
							</tbody>
						</table>
						<div class="btnR mgt30">
							<a href="javascript:GoReg();" class="btn_blue_arrowB01 w150"><span>글올리기</span></a>
						</div>
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