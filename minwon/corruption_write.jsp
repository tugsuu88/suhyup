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
	<title>�۾��� &gt; �ൿ���� �Ű�����㼾�� &gt; �Ű����� &gt; �������� &gt; ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript" src="../js/quickMenu.js"></script>

<!--/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************/-->



<!--/********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/-->

<script type="text/javascript">

<!--

	//��� ���� ���� üũ

	function GoReg() {

			var mText  = document.pbform.contents.value;

			var d = document.pbform;



			if (d.name.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.name.focus(); return;}



			if (d.sh_tel_1.value.length == 0){

				alert("�޴�����ȣ�� �Էµ��� �ʾҽ��ϴ�.");

				d.sh_tel_1.focus();

				return;

			}else if(d.sh_tel_2.value.length == 0){

				alert("�޴�����ȣ�� �Էµ��� �ʾҽ��ϴ�.");

				d.sh_tel_2.focus();

				return;

			}else if(d.sh_tel_3.value.length == 0){

				alert("�޴�����ȣ�� �Էµ��� �ʾҽ��ϴ�.");

				d.sh_tel_3.focus();

				return;

			}



			if (d.sh_tele_1.value.length == 0){

				alert("��ȭ��ȣ�� �Էµ��� �ʾҽ��ϴ�.");

				d.sh_tele_1.focus();

				return;

			}else if(d.sh_tele_2.value.length == 0){

				alert("��ȭ��ȣ�� �Էµ��� �ʾҽ��ϴ�.");

				d.sh_tele_2.focus();

				return;

			}else if(d.sh_tele_3.value.length == 0){

				alert("��ȭ��ȣ�� �Էµ��� �ʾҽ��ϴ�.");

				d.sh_tele_3.focus();

				return;

			}



			//if (d.title.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.title.focus(); return;}
			if (d.title.value.replace(/(^\s*)|(\s*$)/gi, "").length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.title.focus(); return;}


			var keyword = d.title.value;

			//var keyword_sp_char = "~`!@#$%^&*_=|\\<,>.?/{}[]:\"'";

			var keyword_sp_char = "`@#$%^&*=|\\<,>:\'";

			if(CheckSpecialChar(keyword, keyword_sp_char) == false)

			{

				alert("Ư������(" + keyword_sp_char + ")�� �Է��Ͻ� �� �����ϴ�.");

				d.title.focus();

				return;

			}



			if(keyword.length >= 101){

				alert("������ ���ڼ��� �ʰ��Ͽ����ϴ�. 100���̳��� �ۼ��Ͽ��ּ���.");

				d.title.focus();

				return;

			}



			//if (d.contents.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.contents.focus(); return;}
			if (d.contents.value.replace(/(^\s*)|(\s*$)/gi, "").length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.contents.focus(); return;}
			
			if (d.psword.value.length == 0) {alert("�н����带 �Է��� �ֽʽÿ�"); d.psword.focus(); return;}

			if(!chkPWD(d.psword)) return;



			d.submit();





	}

	function GoCan(){

		history.go(-1);

	}



	//������ȣ �˻�

	function ZipSearch(){

		var wint = (screen.height - 350) / 2;

		var winl = (screen.width - 400) / 2;

		winprops = 'height=402,width=383,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = 'find_addr_v2.jsp?return1=pbform.sh_post_1&amp;return2=pbform.sh_post_2&amp;return3=pbform.sh_address_1';

		win = window.open(winurl, "zipsearch", winprops)

	}



	//�˻� ������ȣ ����

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



	// ����ڰ� �̸��� �����ο� �̺�Ʈ�� ��������

	function mail_change() {

		var A = document.pbform;



		// �ؿ� ���� �Է¶��� Ȱ��ȭ �����ش�.

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
			<p class="indicate"><span class="shHome">����</span><span>��������</span><span>�Ű�����</span>�ൿ���� �Ű�����㼾��</p>
			<h3>�ൿ���� �Ű�����㼾��</h3>
			<div class="pdl20 pdr20">
				<div class="mgl15">
					<table class="write02" summary="">
					<caption></caption>
					<colgroup>
						<col style="width:14%;" />
						<col style="width:auto;" />
					</colgroup>
					<tr>
						<th scope="row"><span class="txt_request">*</span>�̸�</th>
						<td>
							<input type="text" class="text" style="width:198px;" title="��  ��" name="name" value="<%=name%>" />
						</td>
					</tr>
					<tr>
						<th scope="row">�̸���</th>
						<td>
							<input type="text" class="text" style="width:98px;" title="�̸����ּ�" name="sh_email_1" onBlur="checkInput(this)" value="" />
							<span class="txt_at vAlignM lineH170">@</span>
							<input type="text" class="text" style="width:98px;" title="�̸��� ������ �����Է�" name="sh_email_2" value="" />
							<select class="mgl5" title="�̸��� ������ ����" name="sh_email_3" onChange="mail_change()">
                          		<option value="">�����ϼ��� </option>
                          		<option value='naver.com'>���̹�</option>
                          		<option value='hanmail.net'>�Ѹ���</option>
                          		<option value='nate.com'>����Ʈ</option>
   						  		<option value="">�����Է� </option>
							</select>
							<p class="displayInB mgl5">(���� ȸ���� ���Ͽ� ������ ������ �ֽʽÿ�.)</p>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>�޴���</th>
						<td>
							<input type="text" class="text" style="width:68px;" title="�޴�����ȣ ���ڸ�" maxlength="3" name="sh_tel_1"  value="" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:68px;" title="�޴�����ȣ �߰��ڸ�" maxlength="4" name="sh_tel_2"  value="" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:68px;" title="�޴�����ȣ �������ڸ�" maxlength="4" name="sh_tel_3"  value="" />
						</td>
					</tr>
					<tr>
						<th scope="row">�ּ�</th>
						<td>
							<input type="text" class="text" style="width:88px;" title="������ȣ ���ڸ�" name="sh_post_1" value="" readonly />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:88px;" title="������ȣ ���ڸ�" name="sh_post_2" value="" readonly />
							<a href="javascript:ZipSearch();" class="btn_blue_s01 mgl10" title="��â����"><span>�ּ�ã��</span></a><br />
							<input type="text" class="text mgt10 mgb10" style="width:508px;" title="���ּ� ù��°" name="sh_address_1" readonly value="" /><br />
							<input type="text" class="text" style="width:508px;" title="���ּ� �ι�°" name="sh_address_2" value="" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>��ȭ��ȣ</th>
						<td>
							<input type="text" class="text" style="width:68px;" title="��ȭ��ȣ ���ڸ�" maxlength="3" name="sh_tele_1"  value="" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:68px;" title="��ȭ��ȣ �߰��ڸ�" maxlength="4" name="sh_tele_2"  value="" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:68px;" title="��ȭ��ȣ �������ڸ�" maxlength="4" name="sh_tele_3"  value="" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>��       ��</th>
						<td>
							<input type="text" class="text w100p" title="��       ��" name="title" value="" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>��       ��</th>
						<td>
							<textarea cols="1" rows="1" title="��       ��" name="contents" value=""></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>��й�ȣ</th>
						<td>
							<input type="password" class="text" style="width:198px;" title="��й�ȣ" name="psword" value="" />
							<p class="displayInB mgl5">(�Խù��� ���� �Ǵ� ������ �� �ʿ��մϴ�.)</p>
						</td>
					</tr>
					</table>
					<p class="pdl23 mgt18"><span class="txt_request mgr5">*</span>���� ǥ�õ� �κ��� �ʼ� �Է»���</p>
				</div>
				<div class="btnC mgt30">
					<a href="javascript:GoReg();" class="btn_blue_arrowB01 w150"><span>Ȯ ��</span></a>
					<a href="javascript:GoCan();" class="btn_dGray_arrowB01 w150"><span>�� ��</span></a>
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