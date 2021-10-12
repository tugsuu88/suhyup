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
// 	String vName = "�׽���";
// 	iRtn = 1; //�׽�Ʈ ���� �ɾ��
	
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
	<title>ûŹ������ ���� �Ű� &gt; �Ű��� &gt; ������ &gt; ����</title>
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
	
	<link rel="stylesheet" href="/js/jquery-ui-1.8.4.custom.css" type="text/css" />
	<script type="text/javascript" src="/js/jquery-ui-1.8.4.custom.min.js"></script>
	<script type="text/javascript" src="/js/script-date.js"></script>

	<script type="text/javascript">
	
	$(document).ready(function(){
		var clareCalendar = {
				monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
				dayNamesMin: ['��','��','ȭ','��','��','��','��'],
				weekHeader: 'Wk',
				dateFormat: 'yy-mm-dd',
				autoSize: false,
				changeMonth: true,
				changeYear: true,
				showMonthAfterYear: true,
				buttonImageOnly: true,
				buttonText: '�޷¼���',
				buttonImage: '/new_images/common/button/btn_sch.gif',
				yearRange: '1930:2020',
				constrainInput: false 
		};
		
		$("input[name=ct_date]").datepicker(clareCalendar);
		
	});

	//��� ���� ���� üũ
	function GoReg() {
			
		var d = document.pbform;
		
		//�Ű��� ����
		if (d.sg_name.value.length == 0) {alert("�������� ��ΰ� �ƴմϴ�."); d.sg_name.focus(); return;}
		
		if (d.sg_job.value.length == 0) {alert("������ �Էµ��� �ʾҽ��ϴ�."); d.sg_job.focus(); return;}
		
		if (d.sg_tel1.value.length == 0) {
			alert("����ó�� �Էµ��� �ʾҽ��ϴ�."); 
			d.sg_tel1.focus(); 
			return;
		} else if (d.sg_tel2.value.length == 0) {
			alert("����ó�� �Էµ��� �ʾҽ��ϴ�."); 
			d.sg_tel2.focus(); 
			return;
		} else if (d.sg_tel3.value.length == 0) {
			alert("����ó�� �Էµ��� �ʾҽ��ϴ�."); 
			d.sg_tel3.focus(); 
			return;
		}
		
		if (d.sg_zip1.value.length == 0) {alert("�����ȣ�� �Էµ��� �ʾҽ��ϴ�."); d.sg_zip1.focus(); return;}
		if (d.sg_zip2.value.length == 0) {alert("�����ȣ�� �Էµ��� �ʾҽ��ϴ�."); d.sg_zip2.focus(); return;}
		
		if (d.sg_addr1.value.length == 0) {alert("�ּҰ� �Էµ��� �ʾҽ��ϴ�."); d.sg_addr1.focus(); return;}
		if (d.sg_addr2.value.length == 0) {alert("���ּҰ� �Էµ��� �ʾҽ��ϴ�."); d.sg_addr2.focus(); return;}
		
		if (d.sg_pass.value.length == 0) {alert("��й�ȣ�� �Էµ��� �ʾҽ��ϴ�."); d.sg_pass.focus(); return false;}
		if (!chkPWD(d.sg_pass)) return;
		
		
		//�� �Ű��� (�ʼ�)
		if (d.ct_name.value.length == 0) {alert("�̸��� �Էµ��� �ʾҽ��ϴ�."); d.ct_name.focus(); return;}
		
		if (d.ct_zip1.value.length == 0) {alert("�����ȣ�� �Էµ��� �ʾҽ��ϴ�."); d.ct_zip1.focus(); return;}
		if (d.ct_zip2.value.length == 0) {alert("�����ȣ�� �Էµ��� �ʾҽ��ϴ�."); d.ct_zip2.focus(); return;}
		
		if (d.ct_addr1.value.length == 0) {alert("�ּҰ� �Էµ��� �ʾҽ��ϴ�."); d.ct_addr1.focus(); return;}
		if (d.ct_addr2.value.length == 0) {alert("���ּҰ� �Էµ��� �ʾҽ��ϴ�."); d.ct_addr2.focus(); return;}
		
		
		//�� �������� ����
		if (d.ct_date.value.length == 0) {alert("�Ͻð� �Էµ��� �ʾҽ��ϴ�."); d.ct_date.focus(); return;}
		if (d.ct_place.value.length == 0) {alert("��Ұ� �Էµ��� �ʾҽ��ϴ�."); d.ct_place.focus(); return;}
		if (d.ct_content.value.replace(/(^\s*)|(\s*$)/gi, "").length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.ct_content.focus(); return;}
		if (d.ct_reason.value.replace(/(^\s*)|(\s*$)/gi, "").length == 0) {alert("�Ű����� �� ������ �Է��� �ֽʽÿ�"); d.ct_reason.focus(); return;}
		
		
		d.submit();
	}
	
	//�����ȣ �˻�
	function ZipSearch(zipType){
		
		var wint = (screen.height - 350) / 2;
		var winl = (screen.width - 400) / 2;
		winprops = 'height=402,width=383,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'
	//		winurl = 'find_addr_v2.jsp?return1=pbform.sg_zip1&amp;return2=pbform.sg_zip2&amp;return3=pbform.sg_addr1';
		winurl = 'chungtak_find_addr.jsp?zipType='+zipType;
		win = window.open(winurl, "ZipSearch", winprops);
	}
	
	//�˻� �����ȣ ����
	function input_zipcode(zip1,zip2,address, zipGb){
		var frm = document.pbform;
		
		if(zipGb == "1"){
			frm.sg_zip1.value = zip1;
			frm.sg_zip2.value = zip2;
			frm.sg_addr1.value = address;
			frm.sg_addr2.focus();
		}else if(zipGb == "2"){
			frm.ct_zip1.value = zip1;
			frm.ct_zip2.value = zip2;
			frm.ct_addr1.value = address;
			frm.ct_addr2.focus();
		}else if(zipGb == "3"){
			frm.ct_zip1_c.value = zip1;
			frm.ct_zip2_c.value = zip2;
			frm.ct_addr1_c.value = address;
			frm.ct_addr2_c.focus();
		}
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
<form name="viewform" method="post" action="chungtak_write1.jsp">
	<input type="hidden" name="enc_data" value="<%=enc_data%>" />
    <input type="hidden" name="param_r1" value="<%=param_r1%>" />
    <input type="hidden" name="param_r2" value="<%=param_r2%>" />
    <input type="hidden" name="param_r3" value="<%=param_r3%>" />
	<input type="hidden" name="vDiscrNo" value="<%=vDiscrNo%>"/>
</form>

<form name="pbform" method="post" action="chungtak_proc.jsp">
	<input type="hidden" name="vDiscrNo" value="<%=vDiscrNo%>"/>
	<input type="hidden" name="type" value="2" />
	
	<!-- contents -->
	<div id="primaryContent">
	
		<p class="indicate"><span class="shHome">����</span><span>������</span><span>�Ű���</span>ûŹ������ ���� �Ű�</p>
		<h3>�Ű��ϱ�</h3>
		<div class="pdl20 pdr20">
			<p class="mgb10 mgl15">��� ��ȸ Ȯ�ν� �� �ʿ��� �������� *ǥ�ð� �Ǿ��ִ� �׸��� �ݵ�� ��Ȯ�ϰ� �Է��� �ּ���</p>
			<div class="mgl15">
				<table class="write mgb25" summary="�Ű����� ����">
					<caption>�Ű�����</caption>
					<colgroup>
						<col style="width:18%;"/>
						<col style="width:auto;"/>
					</colgroup>
					<tbody>
					<tr>
						<th scope="row">�Ű� ����</th>
						<td style="height:auto;">
							<input type="radio" name="register" class="radio mgr5 mgl10" id="register01" onclick="goView(1);" /><label for="register01">�����Ű��</label>
							<input type="radio" name="register" class="radio mgr5 mgl40" id="register02" checked onclick="goView(2);" /><label for="register02">��3�ڽŰ��</label>
						</td>
					</tr>
					</tbody>
				</table>
				
				<h4 class="title_dot_blue">�Ű��� ����</h4>
				<table class="write mgb25" summary="����, ����(�Ҽ�), ����ó, �ּ�, ��й�ȣ �Է� ���̺�">
					<caption>�Ű��� ����</caption>
					<colgroup>
						<col style="width:18%;"/>
						<col style="width:auto;"/>
					</colgroup>
					<tbody>
					<tr>
						<th scope="row"><span class="txt_request">*</span>����</th>
						<td>
								<input type="text" class="text" name="sg_name" value="<%=name%>" style="width:198px;" title="����" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>����(�Ҽ�)</th>
						<td>
							<input type="text" class="text" name="sg_job" style="width:198px;" title="����(�Ҽ�)" maxlength="15"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>����ó</th>
						<td>
							<input type="text" class="text" name="sg_tel1" style="width:68px;" title="����ó ù��°�ڸ�" maxlength="3"/><span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" name="sg_tel2" style="width:68px;" title="����ó �߰��ڸ�" maxlength="4"/><span class="txt_dash vAlignM">-</span>
							<input type="text"  class="text" name="sg_tel3" style="width:68px;" title="����ó ������ �ڸ�" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>�ּ�</th>
						<td>
							<input type="text" class="text" style="width:88px;" name="sg_zip1" title="�����ȣ" maxlength="3" readonly="readonly" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:88px;" name="sg_zip2" title="�����ȣ ���ڸ�" maxlength="3" readonly="readonly" />
							<a href="javascript:ZipSearch('1');" class="btn_blue_s01 mgl10" title="��â����"><span>�ּ�ã��</span></a><br />
							<input type="text" class="text mgt10 mgb10" name="sg_addr1" style="width:508px;" title="������ �Է�" maxlength="200" readonly="readonly" /><br />
							<input type="text" class="text" name="sg_addr2" style="width:508px;" title="���ּ�" maxlength="200"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>��й�ȣ</th>
						<td>
							<input type="password" name="sg_pass" value="" class="text" style="width:198px;" title="��й�ȣ" maxlength="6"/><p class="displayInB mgl5">��й�ȣ�� 4�ڸ� �̻� 6�ڸ� ���Ϸ� �ۼ��Ͽ��ּ���.</p>
						</td>
					</tr>
					</tbody>
				</table>
				
				<!-- �Ű��� �ʼ� -->
				<h4 class="title_dot_blue">�ǽŰ���(�Ű��� �ʼ�)</h4>
				<table class="write mgb25" summary="����, ����(�Ҽ�), ����ó, �ּ�, ����,��ü���� ��� ��Ī, ������, ��ǥ�ڼ��� �Է� ���̺�">
					<caption>����ûŹ�� �� �� �Ǵ� ��ǰ���� ������ ��</caption>
					<colgroup>
						<col style="width:18%;"/>
						<col style="width:auto;"/>
					</colgroup>
					<tbody>
					<tr>
						<th scope="row"><span class="txt_request">*</span>����</th>
						<td>
							<input type="text" class="text" name="ct_name" style="width:198px;" title="����" maxlength="15"/>
						</td>
					</tr>
					<tr>
						<th scope="row">����(�Ҽ�)</th>
						<td>
							<input type="text" class="text" name="ct_job" style="width:198px;" title="����(�Ҽ�)" maxlength="15"/>
						</td>
					</tr>
					<tr>
						<th scope="row">����ó</th>
						<td>
							<input type="text" class="text" style="width:68px;" name="ct_tel1" title="����ó ù��°�ڸ�" maxlength="3"/><span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:68px;" name="ct_tel2" title="����ó �߰��ڸ�" maxlength="4"/><span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:68px;" name="ct_tel3" title="����ó ������ �ڸ�" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>�ּ�</th>
						<td>
							<input type="text" class="text" style="width:88px;" name="ct_zip1" title="�����ȣ" maxlength="3" readonly="readonly"/>
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:88px;" name="ct_zip2" title="�����ȣ ���ڸ�" maxlength="3" readonly="readonly" />
								<a href="javascript:ZipSearch('2');" class="btn_blue_s01 mgl10" title="��â����"><span>�ּ�ã��</span></a><br />
							<input type="text" class="text mgt10 mgb10" name="ct_addr1" style="width:508px;" title="������ �Է�" maxlength="200" readonly="readonly" /><br />
							<input type="text" class="text" name="ct_addr2" style="width:508px;" title="���ּ�" maxlength="200"/>
						</td>
					</tr>
					<tr>
						<th scope="row">���Ρ���ü���� ���</th>
						<td>
							<div><label for="companyName_c" class="displayInB w70">��Ī</label>
								<input type="text" name="ct_corp_c" id="companyName_c" class="text" style="width:440px;" title="��Ī" maxlength="15"/>
							</div>
							<div class="mgt10 mgb10"><label for="companyPlace_c" class="displayInB w70">������</label>
								<input type="text" name="ct_corpaddr_c" id="companyPlace_c" class="text" style="width:440px;" title="������" maxlength="15"/>
							</div>
							<div><label for="ceoName_c" class="displayInB w70">��ǥ�ڼ���</label>
								<input type="text" name="ct_corpname_c" id="ceoName_c" class="text" style="width:440px;" title="��ǥ�ڼ���" maxlength="15"/>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
				<!-- //�Ű��� �ʼ� -->
				
				<!-- �Ű��� ���� -->
				<h4 class="title_dot_blue">�ǽŰ���(�Ű��� ����)</h4>
				<table class="write mgb25" summary="����, ����(�Ҽ�), ����ó, �ּ�, ����,��ü���� ��� ��Ī, ������, ��ǥ�ڼ��� �Է� ���̺�">
					<caption>����ûŹ�� �� �� �Ǵ� ��ǰ���� ������ ��</caption>
					<colgroup>
						<col style="width:18%;"/>
						<col style="width:auto;"/>
					</colgroup>
					<tbody>
					<tr>
						<th scope="row">����</th>
						<td>
							<input type="text" class="text" name="ct_name_c" style="width:198px;" title="����" maxlength="15"/>
						</td>
					</tr>
					<tr>
						<th scope="row">����(�Ҽ�)</th>
						<td>
							<input type="text" class="text" name="ct_job_c" style="width:198px;" title="����(�Ҽ�)" maxlength="15"/>
						</td>
					</tr>
					<tr>
						<th scope="row">����ó</th>
						<td>
							<input type="text" class="text" style="width:68px;" name="ct_tel1_c" title="����ó ù��°�ڸ�" maxlength="3"/><span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:68px;" name="ct_tel2_c" title="����ó �߰��ڸ�" maxlength="4"/><span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:68px;" name="ct_tel3_c" title="����ó ������ �ڸ�" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th scope="row">�ּ�</th>
						<td>
							<input type="text" class="text" style="width:88px;" name="ct_zip1_c" title="�����ȣ" maxlength="3" readonly="readonly" />
							<span class="txt_dash vAlignM">-</span>
							<input type="text" class="text" style="width:88px;" name="ct_zip2_c" title="�����ȣ ���ڸ�" maxlength="3" readonly="readonly" />
							<a href="javascript:ZipSearch('3');" class="btn_blue_s01 mgl10" title="��â����"><span>�ּ�ã��</span></a><br />
							<input type="text" class="text mgt10 mgb10" name="ct_addr1_c" style="width:508px;" title="������ �Է�" maxlength="200" readonly="readonly" /><br />
							<input type="text" class="text" name="ct_addr2_c" style="width:508px;" title="���ּ�" maxlength="200"/>
						</td>
					</tr>
					<tr>
						<th scope="row">���Ρ���ü���� ���</th>
						<td>
							<div><label for="companyName" class="displayInB w70">��Ī</label>
								<input type="text" name="ct_corp" id="companyName" class="text" style="width:440px;" title="��Ī" maxlength="15"/>
							</div>
							<div class="mgt10 mgb10"><label for="companyPlace" class="displayInB w70">������</label>
								<input type="text" name="ct_corpaddr" id="companyPlace" class="text" style="width:440px;" title="������" maxlength="15"/>
							</div>
							<div><label for="ceoName" class="displayInB w70">��ǥ�ڼ���</label>
								<input type="text" name="ct_corpname" id="ceoName" class="text" style="width:440px;" title="��ǥ�ڼ���" maxlength="15"/>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
				<!-- //�Ű��� ���� -->
				
				<h4 class="title_dot_blue">�� �������� ����</h4>
				<table class="write mgb25" summary="�Ͻ�, ���, ����, �Ű����� �� ���� �Է� ���̺�">
					<caption>����ûŹ �Ǵ� ��ǰ�� ���� ����</caption>
					<colgroup>
						<col style="width:18%;"/>
						<col style="width:auto;"/>
					</colgroup>
					<tbody>
					<tr>
						<th scope="row"><span class="txt_request">*</span>�Ͻ�</th>
						<td>
							<input type="text" class="text" name="ct_date" style="width:508px;" title="�Ͻ�" maxlength="20"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>���</th>
						<td>
							<input type="text" class="text" name="ct_place" style="width:508px;" title="���" maxlength="20"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>����</th>
						<td>
							<textarea style="width:508px; min-height:60px;" name="ct_content" title="�����Է�" onclick="this.value='';"></textarea>
							<br / >(��ǰ �� ������ ��� �� ���� �� ����)
						</td>
					</tr>
					<tr>
						<th scope="row"><span class="txt_request">*</span>�Ű����� �� <br />����</th>
						<td>
							<textarea style="width:508px; min-height:50px;" name="ct_reason" title="�Ű����� �� ���� �Է�"></textarea>
						</td>
					</tr>
					</tbody>
				</table>
				
				<div class="btnR mgt30">
					<a href="javascript:GoReg();" class="btn_blue_arrowB01 w150"><span>�ۿø���</span></a>
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