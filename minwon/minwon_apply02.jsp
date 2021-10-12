<%@ page language="java"
	import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	response.setContentType("text/html; charset=euc-kr");
%>

<%
	String sName = (String) session.getAttribute("sName");
	if(sName == null || "".equals(sName)) {
%>
<script type="text/javascript">
	alert("잘못된 요청입니다.");
	window.location.href = '/minwon/minwon_apply01.jsp';
</script>
<% 
		return;
	}
%>


<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1" />
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />

<%@ include file="../inc/requestSecurity.jsp"%>

<%
	
	String vDiscrNo = Converter.nullchk(request.getParameter("vDiscrNo"));

	String name = Converter.nullchk(request.getParameter("name"));

	if (name == null)
		name = "";

	String sh_post_1 = Converter.nullchk(request.getParameter("sh_post_1"));

	if (sh_post_1 == null)
		sh_post_1 = "";

	String sh_address_1 = Converter.nullchk(request.getParameter("sh_address_1"));

	if (sh_address_1 == null)
		sh_address_1 = "";

	String sh_address_2 = Converter.nullchk(request.getParameter("sh_address_2"));

	if (sh_address_2 == null)
		sh_address_2 = "";

	String sh_tel_1 = Converter.nullchk(request.getParameter("sh_tel_1"));

	if (sh_tel_1 == null)
		sh_tel_1 = "";

	String sh_tel_2 = Converter.nullchk(request.getParameter("sh_tel_2"));

	if (sh_tel_2 == null)
		sh_tel_2 = "";

	String sh_tel_3 = Converter.nullchk(request.getParameter("sh_tel_3"));

	if (sh_tel_3 == null)
		sh_tel_3 = "";

	String sh_han_1 = Converter.nullchk(request.getParameter("sh_han_1"));

	if (sh_han_1 == null)
		sh_han_1 = "";

	String sh_han_2 = Converter.nullchk(request.getParameter("sh_han_2"));

	if (sh_han_2 == null)
		sh_han_2 = "";

	String sh_han_3 = Converter.nullchk(request.getParameter("sh_han_3"));

	if (sh_han_3 == null)
		sh_han_3 = "";

	String sh_email_1 = Converter.nullchk(request.getParameter("sh_email_1"));

	if (sh_email_1 == null)
		sh_email_1 = "";

	String sh_email_2 = Converter.nullchk(request.getParameter("sh_email_2"));

	if (sh_email_2 == null)
		sh_email_2 = "";

	String sh_cata = Converter.nullchk(request.getParameter("sh_cata"));

	if (sh_cata == null)
		sh_cata = "";

	String sh_reply_type = Converter.nullchk(request.getParameter("sh_reply_type")); //회신방식

	if (sh_reply_type == null)
		sh_reply_type = "";

	String psword = Converter.nullchk(request.getParameter("psword"));

	if (psword == null)
		psword = "";

	//2014-08-19 생년월일 , 법인 , 대상영업점 추가 
	String Year = Converter.nullchk(request.getParameter("Year"));

	if (Year == null)
		Year = "";

	String Month = Converter.nullchk(request.getParameter("Month"));

	if (Month == null)
		Month = "";

	String Day = Converter.nullchk(request.getParameter("Day"));

	if (Day == null)
		Day = "";

	String sh_center = Converter.nullchk(request.getParameter("sh_center"));

	if (sh_center == null)
		sh_center = "";

	String self_text = Converter.nullchk(request.getParameter("self_text"));

	if (self_text == null)
		self_text = "";

	String pageNum = "5";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>민원 작성하기 &gt; 민원신청 &gt; 전자민원창구 &gt; 고객지원 &gt; 수협</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="/css/screen.css" />
<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<!--/********************************************위너다임 작업 시작 2008.03.13****************************************************/-->
<!-- <SCRIPT SRC="http://www.suhyup.co.kr/djemals/js/ax_wdigm/default.js"></SCRIPT> -->
<!--/********************************************위너다임 작업 끝 2008.03.13******************************************************/-->
<script type="text/javascript" src="/js/public.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
	//약관 동의 여부 체크
	function GoReg() {

		var mText = document.pbform.contents.value;
		/********************************************위너다임 작업 시작 2008.03.13****************************************************
		try{
			if(UsingRemote == true){
				if(!beScan('',mText,'')){
				return;
				}
			}
		}catch (e){
			var objRtn = objAX.beScanner(policy, '','', this.location, mText, '');
			if(objRtn == 0){
				return;
			}else{
				return;
			}
		}
		 ********************************************위너다임 작업 끝 2008.03.13******************************************************/

		if (pbform.sh_title.value.length == 0) {
			alert("제목을 입력해 주십시오");
			pbform.sh_title.focus();
			return;
		}

		// 특수문자 체크: + ; ( ) - 는 가능
		var keyword = pbform.sh_title.value;

		//var keyword_sp_char = "~`!@#$%^&*_=|\\<,>.?/{}[]:\"'";

		var keyword_sp_char = "`@#$%^&*=|\\<,>:\'";

		if (CheckSpecialChar(keyword, keyword_sp_char) == false) {
			alert("특수문자(" + keyword_sp_char + ")를 입력하실 수 없습니다.");
			pbform.sh_title.focus();
			return;
		}

		if (keyword.length >= 101) {
			alert("제목의 글자수가 초과하였습니다. 100자이내로 작성하여주세요.");
			pbform.sh_title.focus();
			return;
		}

		if (pbform.contents.value.length == 0) {
			alert("내용을 입력해 주십시오");
			pbform.contents.focus();
			return;
		}

		if (pbform.contents.value.length >= 2001) {
			alert("내용의 글자수가 초과하였습니다. 2000자이내로 작성하여주세요.");
			pbform.contents.focus();
			return;
		}

		var istrue = uploadFile_Change(pbform.file1.value);
		if (istrue == false) {
			return;
		}

		var src = getFileExtension(pbform.file1.value);
		
		alert('고객님의 소중한 의견 감사드리며, 민원 접수일로부터 6영업일 이내에 답변 드리도록 하겠습니다.');
		pbform.action = "minwon_proc.jsp";
		pbform.encoding = "multipart/form-data";
		pbform.submit();
	}
	function BackToApply1() {
		//window.location.href = '/minwon/minwon_apply01.jsp';
		history.back();
	}

	//파일을 선택 후 포커스 이동시 호출
	function uploadFile_Change(value) {

		/* var src = getFileExtension(value);
		if (src == "") {
			//alert("올바른 파일을 입력하세요");
			return true;
		} else if (!((src.toLowerCase() == "hwp")
				|| (src.toLowerCase() == "ppt") || (src.toLowerCase() == "xls")
				|| (src.toLowerCase() == "gul") || (src.toLowerCase() == "doc")
				|| (src.toLowerCase() == "txt") || (src.toLowerCase() == "pdf")
				|| (src.toLowerCase() == "jpg") || (src.toLowerCase() == "gif") || (src
				.toLowerCase() == "bmp"))) {
			alert("hwp 와 ppt, xls, gul, doc, txt, pdf, jpg, gif, bmp 파일만 첨부 가능합니다.");
			pbform.file1.value = "";
			//document.form1.afile.value = "";
			//form1.afile.focus();
			//pbform.file1.focus();
			return false;
		} else {
			return true;
		} 
		 */
		/* 
		var src = getFileExtension(value);
		if (!((src.toLowerCase() == "hwp")
				|| (src.toLowerCase() == "ppt") || (src.toLowerCase() == "xls")
				|| (src.toLowerCase() == "gul") || (src.toLowerCase() == "doc")
				|| (src.toLowerCase() == "txt") || (src.toLowerCase() == "pdf")
				|| (src.toLowerCase() == "jpg") || (src.toLowerCase() == "gif") || (src
				.toLowerCase() == "bmp"))) {
			alert("hwp 와 ppt, xls, gul, doc, txt, pdf, jpg, gif, bmp 파일만 첨부 가능합니다.");
			pbform.file1.value = "";
			//document.form1.afile.value = "";
			//form1.afile.focus();
			//pbform.file1.focus();
			return false;
		} else {
			return true;
		} */
		
		
		var src = getFileExtension(value);
		 if(src != null && src != '') {
			if (!((src.toLowerCase() == "hwp")
					|| (src.toLowerCase() == "ppt") || (src.toLowerCase() == "xls")
					|| (src.toLowerCase() == "gul") || (src.toLowerCase() == "doc")
					|| (src.toLowerCase() == "txt") || (src.toLowerCase() == "pdf")
					|| (src.toLowerCase() == "jpg") || (src.toLowerCase() == "gif") || (src
					.toLowerCase() == "bmp"))) {
				alert("hwp 와 ppt, xls, gul, doc, txt, pdf, jpg, gif, bmp 파일만 첨부 가능합니다.");
				pbform.file1.value = "";
				//document.form1.afile.value = "";
				//form1.afile.focus();
				//pbform.file1.focus();
				return false;
			} else {
				return true;
			}
		}
	}

	//파일의 확장자를 가져옮
	function getFileExtension(filePath) {
		var lastIndex = -1;
		lastIndex = filePath.lastIndexOf('.');
		var extension = "";

		if (lastIndex != -1) {
			extension = filePath.substring(lastIndex + 1, filePath.len);
		} else {
			extension = "";
		}
		return extension;
	}
</script>
</head>
<body id="minwon01">
	<!-- header -->
	<%@ include file="/include/shHeader.jsp"%>
	<!-- //header -->
	<!-- container -->
	<div id="ContentLayer">
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp"%>
		<!-- //LNB -->
	<%
	String sessionName=(String)session.getAttribute("sessname");
	%>
	
	<%
	if (sessionName==null) 
	{ sessionName="";}
	if ( sessionName.equals(aes.aesEncode("suhyupApply1"))) { %>
			<form name="pbform" method="post" enctype="" action="">
			<input type="hidden" name="name" value="<%=name%>" />
			<input type="hidden" name="sh_post_1" value="<%=sh_post_1%>"> 
			<input type="hidden" name="sh_address_1" value="<%=sh_address_1%>">
			<input type="hidden" name="sh_address_2" value="<%=sh_address_2%>">
			<input type="hidden" name="sh_tel_1" value="<%=sh_tel_1%>"> 
			<input type="hidden" name="sh_tel_2" value="<%=sh_tel_2%>"> 
			<input type="hidden" name="sh_tel_3" value="<%=sh_tel_3%>"> 
			<input type="hidden" name="sh_han_1" value="<%=sh_han_1%>"> 
			<input type="hidden" name="sh_han_2" value="<%=sh_han_2%>"> 
			<input type="hidden" name="sh_han_3" value="<%=sh_han_3%>"> 
			<input type="hidden" name="sh_email_1" value="<%=sh_email_1%>"> 
			<input type="hidden" name="sh_email_2" value="<%=sh_email_2%>"> 
			<input type="hidden" name="sh_cata" value="<%=sh_cata%>"> 
			<input type="hidden" name="psword" value="<%=psword%>"> 
			<input type="hidden" name="vDiscrNo" value="<%=vDiscrNo%>"> 
			<input type="hidden" name="sh_reply_type" value="<%=sh_reply_type%>">
			<!--2014-8-19 생년월일,법인 , 대상영업 추가  -->
			<input type="hidden" name="Year" value="<%=Year%>"> 
			<input type="hidden" name="Month" value="<%=Month%>"> 
			<input type="hidden" name="Day" value="<%=Day%>"> 
			<input type="hidden" name="sh_center" value="<%=sh_center%>"> 
			<input type="hidden" name="self_text" value="<%=self_text%>">

			<!-- contents -->
			<div id="primaryContent">
				<p class="indicate">
					<span class="shHome">수협</span><span>고객지원</span><span>전자민원창구</span>민원신청
				</p>
				<h3>민원신청</h3>
				<div class="pdl20 pdr30">
					<h4 class="title_arrow_green01 mgb15">민원 작성하기</h4>
					<div class="mgl15">
						<div class="box_upperNotify mgb40">
							<ul>
								<li><strong>수협중앙회에 민원을 제출해 주시면 최대한 친절하고 상세하게 답변을
										드리겠습니다.</strong><br /> 민원사항에 대한 조회는 ‘민원처리결과조회’ 페이지에서 확인하시면 됩니다.</li>
							</ul>
						</div>
						<table class="write" summary="민원 작성을 위한 제목, 내용, 파일첨부 작성">
							<caption>민원 작성하기</caption>
							<colgroup>
								<col style="width: 18%;" />
								<col style="width: auto;" />
							</colgroup>
							<tr>
								<th scope="row">제 목</th>
								<td><input type="text" name="sh_title" class="text w100p"
									title="제목" /></td>
							</tr>
							<tr>
								<th scope="row">내 용</th>
								<td><textarea name="contents" cols="1" rows="1"
										class="w100p" title="내용"></textarea></td>
							</tr>
							<tr>
								<th scope="row">파 일</th>
								<td>
									<input type="file" class="text w100p" size="70" name="file1" value="" title="파일첨부" />
										<ul class="lineH180 mgt5">
											<li>※ 문서파일 : hwp, ppt, xls, gul, doc, txt, pdf 파일만 첨부
												가능합니다.</li>
											<li>※ 이미지파일 : jpg, gif, bmp 파일만 첨부 가능합니다.</li>
											<li>※ 파일이름은 영문을 권장하며 띄워쓰기없이 입력해 주십시요.</li>
										</ul>
								</td>
							</tr>
						</table>
					</div>
					<div class="btnR mgt30">
						<a href="javascript:GoReg();" class="btn_blue_arrowB01 w150"><span>민원신청</span></a>
						<a href="javascript:pbform.reset();" class="btn_green_arrowB01 w150"><span>다시입력</span></a>
					</div>
				</div>
			</div>
			<!-- //contents -->
		</form>
<% } else { %>
		<form name="pbform" method="post" enctype="" action="">

			<!-- contents -->
			<div id="primaryContent">
				<p class="indicate">
					<span class="shHome">수협</span><span>고객지원</span><span>전자민원창구</span>민원신청
				</p>
				<h3>민원신청</h3>
				<div class="pdl20 pdr30">
					<div class="mgl15">
						<div class="box_upperNotify mgb40">
							<ul>
								<li><strong>잘못된 액세스</strong><br />이전 페이지로 돌아가려면 뒤로 버튼을 누르십시오</li>
							</ul>
						</div>
					</div>
					<div class="btnR mgt30">
						<a href="javascript:BackToApply1();" class="btn_blue_arrowB01 w150"><span>뒤로</span></a>
					</div>
				</div>
			</div>
			<!-- //contents -->
		</form>
<% } %>
	
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/include/shFooter.jsp"%>
	<!-- //footer -->
</body>
</html>