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
	alert("�߸��� ��û�Դϴ�.");
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

	String sh_reply_type = Converter.nullchk(request.getParameter("sh_reply_type")); //ȸ�Ź��

	if (sh_reply_type == null)
		sh_reply_type = "";

	String psword = Converter.nullchk(request.getParameter("psword"));

	if (psword == null)
		psword = "";

	//2014-08-19 ������� , ���� , ��󿵾��� �߰� 
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
<title>�ο� �ۼ��ϱ� &gt; �ο���û &gt; ���ڹο�â�� &gt; ������ &gt; ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="/css/screen.css" />
<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<!--/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************/-->
<!-- <SCRIPT SRC="http://www.suhyup.co.kr/djemals/js/ax_wdigm/default.js"></SCRIPT> -->
<!--/********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/-->
<script type="text/javascript" src="/js/public.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
	//��� ���� ���� üũ
	function GoReg() {

		var mText = document.pbform.contents.value;
		/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************
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
		 ********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/

		if (pbform.sh_title.value.length == 0) {
			alert("������ �Է��� �ֽʽÿ�");
			pbform.sh_title.focus();
			return;
		}

		// Ư������ üũ: + ; ( ) - �� ����
		var keyword = pbform.sh_title.value;

		//var keyword_sp_char = "~`!@#$%^&*_=|\\<,>.?/{}[]:\"'";

		var keyword_sp_char = "`@#$%^&*=|\\<,>:\'";

		if (CheckSpecialChar(keyword, keyword_sp_char) == false) {
			alert("Ư������(" + keyword_sp_char + ")�� �Է��Ͻ� �� �����ϴ�.");
			pbform.sh_title.focus();
			return;
		}

		if (keyword.length >= 101) {
			alert("������ ���ڼ��� �ʰ��Ͽ����ϴ�. 100���̳��� �ۼ��Ͽ��ּ���.");
			pbform.sh_title.focus();
			return;
		}

		if (pbform.contents.value.length == 0) {
			alert("������ �Է��� �ֽʽÿ�");
			pbform.contents.focus();
			return;
		}

		if (pbform.contents.value.length >= 2001) {
			alert("������ ���ڼ��� �ʰ��Ͽ����ϴ�. 2000���̳��� �ۼ��Ͽ��ּ���.");
			pbform.contents.focus();
			return;
		}

		var istrue = uploadFile_Change(pbform.file1.value);
		if (istrue == false) {
			return;
		}

		var src = getFileExtension(pbform.file1.value);
		
		alert('������ ������ �ǰ� ����帮��, �ο� �����Ϸκ��� 6������ �̳��� �亯 �帮���� �ϰڽ��ϴ�.');
		pbform.action = "minwon_proc.jsp";
		pbform.encoding = "multipart/form-data";
		pbform.submit();
	}
	function BackToApply1() {
		//window.location.href = '/minwon/minwon_apply01.jsp';
		history.back();
	}

	//������ ���� �� ��Ŀ�� �̵��� ȣ��
	function uploadFile_Change(value) {

		/* var src = getFileExtension(value);
		if (src == "") {
			//alert("�ùٸ� ������ �Է��ϼ���");
			return true;
		} else if (!((src.toLowerCase() == "hwp")
				|| (src.toLowerCase() == "ppt") || (src.toLowerCase() == "xls")
				|| (src.toLowerCase() == "gul") || (src.toLowerCase() == "doc")
				|| (src.toLowerCase() == "txt") || (src.toLowerCase() == "pdf")
				|| (src.toLowerCase() == "jpg") || (src.toLowerCase() == "gif") || (src
				.toLowerCase() == "bmp"))) {
			alert("hwp �� ppt, xls, gul, doc, txt, pdf, jpg, gif, bmp ���ϸ� ÷�� �����մϴ�.");
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
			alert("hwp �� ppt, xls, gul, doc, txt, pdf, jpg, gif, bmp ���ϸ� ÷�� �����մϴ�.");
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
				alert("hwp �� ppt, xls, gul, doc, txt, pdf, jpg, gif, bmp ���ϸ� ÷�� �����մϴ�.");
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

	//������ Ȯ���ڸ� ������
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
			<!--2014-8-19 �������,���� , ��󿵾� �߰�  -->
			<input type="hidden" name="Year" value="<%=Year%>"> 
			<input type="hidden" name="Month" value="<%=Month%>"> 
			<input type="hidden" name="Day" value="<%=Day%>"> 
			<input type="hidden" name="sh_center" value="<%=sh_center%>"> 
			<input type="hidden" name="self_text" value="<%=self_text%>">

			<!-- contents -->
			<div id="primaryContent">
				<p class="indicate">
					<span class="shHome">����</span><span>������</span><span>���ڹο�â��</span>�ο���û
				</p>
				<h3>�ο���û</h3>
				<div class="pdl20 pdr30">
					<h4 class="title_arrow_green01 mgb15">�ο� �ۼ��ϱ�</h4>
					<div class="mgl15">
						<div class="box_upperNotify mgb40">
							<ul>
								<li><strong>�����߾�ȸ�� �ο��� ������ �ֽø� �ִ��� ģ���ϰ� ���ϰ� �亯��
										�帮�ڽ��ϴ�.</strong><br /> �ο����׿� ���� ��ȸ�� ���ο�ó�������ȸ�� ���������� Ȯ���Ͻø� �˴ϴ�.</li>
							</ul>
						</div>
						<table class="write" summary="�ο� �ۼ��� ���� ����, ����, ����÷�� �ۼ�">
							<caption>�ο� �ۼ��ϱ�</caption>
							<colgroup>
								<col style="width: 18%;" />
								<col style="width: auto;" />
							</colgroup>
							<tr>
								<th scope="row">�� ��</th>
								<td><input type="text" name="sh_title" class="text w100p"
									title="����" /></td>
							</tr>
							<tr>
								<th scope="row">�� ��</th>
								<td><textarea name="contents" cols="1" rows="1"
										class="w100p" title="����"></textarea></td>
							</tr>
							<tr>
								<th scope="row">�� ��</th>
								<td>
									<input type="file" class="text w100p" size="70" name="file1" value="" title="����÷��" />
										<ul class="lineH180 mgt5">
											<li>�� �������� : hwp, ppt, xls, gul, doc, txt, pdf ���ϸ� ÷��
												�����մϴ�.</li>
											<li>�� �̹������� : jpg, gif, bmp ���ϸ� ÷�� �����մϴ�.</li>
											<li>�� �����̸��� ������ �����ϸ� ���������� �Է��� �ֽʽÿ�.</li>
										</ul>
								</td>
							</tr>
						</table>
					</div>
					<div class="btnR mgt30">
						<a href="javascript:GoReg();" class="btn_blue_arrowB01 w150"><span>�ο���û</span></a>
						<a href="javascript:pbform.reset();" class="btn_green_arrowB01 w150"><span>�ٽ��Է�</span></a>
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
					<span class="shHome">����</span><span>������</span><span>���ڹο�â��</span>�ο���û
				</p>
				<h3>�ο���û</h3>
				<div class="pdl20 pdr30">
					<div class="mgl15">
						<div class="box_upperNotify mgb40">
							<ul>
								<li><strong>�߸��� �׼���</strong><br />���� �������� ���ư����� �ڷ� ��ư�� �����ʽÿ�</li>
							</ul>
						</div>
					</div>
					<div class="btnR mgt30">
						<a href="javascript:BackToApply1();" class="btn_blue_arrowB01 w150"><span>�ڷ�</span></a>
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