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
	<title>�۾��� &gt; ������� ���� &gt; �������/���������� &gt; �Ű� �Ű��� &gt; ������ &gt; ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>

<!--/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************/-->

<!-- 2015.02.02 ������ �ּ�ó��
<SCRIPT SRC="http://www.suhyup.co.kr/djemals/js/ax_wdigm/default.js"></SCRIPT>
 -->

<!--/********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/-->

	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript">
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
			
			//���鸸 �Է�üũ 20150224
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
			//���鸸 �Է�üũ 20150224
			if (d.contents.value.replace(/(^\s*)|(\s*$)/gi, "").length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.contents.focus(); return;}
			
			if (d.psword.value.length == 0) {alert("�н����带 �Է��� �ֽʽÿ�"); d.psword.focus(); return;}

			if(!chkPWD(d.psword)) return;

			/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************
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
			********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/

			d.submit();
			//d.action();

	}

	//�����ȣ �˻�
	function ZipSearch(){
		var wint = (screen.height - 350) / 2;
		var winl = (screen.width - 400) / 2;
		winprops = 'height=402,width=383,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'
		winurl = 'find_addr_v2.jsp?return1=pbform.sh_post_1&amp;return2=pbform.sh_post_2&amp;return3=pbform.sh_address_1';
		win = window.open(winurl, "zipsearch", winprops)
	}

	//�˻� �����ȣ ����
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
			<p class="indicate"><span class="shHome">����</span><span>������</span><span>�Ű���</span>�������/���������� �Ű�</p>
			<h3>�������/���������� �Ű�</h3>
			<div class="pdl20 pdr20">
				<h4 class="dpNone">�����������</h4>
				<div class="mgl15">
					<table class="write"><!-- 20150226 -->
					<caption>�������/���������� �Ű� - �̸�,�̸���,�޴���,�ּ�,��ȭ��ȣ,����,����,��й�ȣ ���̺� �Դϴ�</caption><!-- 20150226 -->
					<colgroup>
						<col style="width:18%;" />
						<col style="width:auto;" />
					</colgroup>
					<tr>
						<th scope="row"><span class="txt_request">*</span>�̸�</th>
						<td>
							<input type="text" name="name" value="<%=name%>" class="text" style="width:198px;" title="�̸�" />
						</td>
					</tr>
					<tr>
						<th scope="row">�̸���</th>
						<td>
							<input type="text" name="sh_email_1" onBlur="checkInput(this)" value="" class="text" style="width:148px;" title="�̸����ּ� ���ڸ�" /><span class="txt_at vAlignM lineH170">@</span><input type="text" name="sh_email_2" value="" class="text" style="width:148px;" title="�̸��ϵ����� �����Է�" />
							<select name="sh_email_3" onChange="mail_change()" class="mgl5" title="�̸��� ������ ����">
		                        <option value="">�����ϼ��� </option>
		                        <option value='naver.com'>���̹�</option>
		                        <option value='daum.net'>����</option>
		                        <option value='nate.com'>����Ʈ</option>
		                        <option value='yahoo.co.kr'>����</option>
		                        <option value='paran.com'>�Ķ�</option>
								<option value="">�����Է� </option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>�޴���</th>
						<td>
							<input type="text" maxlength="3" name="sh_tel_1" value="" class="text" style="width:68px;" title="�޴��� ���ڸ�" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" maxlength="4" name="sh_tel_2" value="" class="text" style="width:68px;" title="�޴��� �߰���ȣ" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" maxlength="4" name="sh_tel_3" value="" class="text" style="width:68px;" title="�޴��� ���ڸ�" />
						</td>
					</tr>
					<tr>
						<th scope="row">�ּ�</th>
						<td>
							<input type="text" size="4" name="sh_post_1" value="" readonly class="text" style="width:88px;" title="�����ȣ ���ڸ�" /><span class="txt_dash vAlignM">-</span><input type="text" size="4" name="sh_post_2" value="" readonly class="text" style="width:88px;" title="�����ȣ ���ڸ�" /><a href="javascript:ZipSearch();" class="btn_blue_s01 mgl10" title="��â����"><span>�ּ�ã��</span></a><br />
							<input type="text" name="sh_address_1" readonly value="" class="text mgt10 mgb10" style="width:508px;" title="������ �Է�" /><br />
							<input type="text" name="sh_address_2" value="" class="text" style="width:508px;" title="���ּ�" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>��ȭ��ȣ</th>
						<td>
							<input type="text" maxlength="3" name="sh_tele_1" value="" class="text" style="width:68px;" title="��ȭ��ȣ ���ڸ�" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" maxlength="4" name="sh_tele_2" value="" class="text" style="width:68px;" title="��ȭ��ȣ �߰��ڸ�" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" maxlength="4" name="sh_tele_3"  value="" class="text" style="width:68px;" title="��ȭ��ȣ ���ڸ�" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>��       ��</th>
						<td>
							<input type="text" name="title" value="" class="text w100p" title="��       ��" />
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>��       ��</th>
						<td>
							<textarea name="contents" value="" cols="1" rows="1" title="��       ��"></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>��й�ȣ</th>
						<td>
							<input type="password" name="psword" value="" class="text" style="width:198px;" title="��й�ȣ" /><p class="displayInB mgl5">��й�ȣ�� 4�ڸ� �̻� 6�ڸ� ���Ϸ� �ۼ��Ͽ��ּ���.</p>
						</td>
					</tr>
					</table>
					<p class="pdl23 mgt18"><span class="txt_request mgr5">*</span>���� ǥ�õ� �κ��� �ʼ� �Է»���</p>
				</div>
				<div class="btnC mgt30">
					<a href="javascript:GoReg();" class="btn_blue_arrowB01 w150"><span>Ȯ ��</span></a><a href="javascript:GoCan();" class="btn_dGray_arrowB01 w150"><span>�� ��</span></a>
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