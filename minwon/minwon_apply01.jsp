<%@ page language="java"
	import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, SafeNC.kisinfo.*, Kisinfo.Check.IPINClient"%>
<%@ page import="java.util.Calendar"%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%
	request.setCharacterEncoding("euc-kr");

	session.removeAttribute("sName");
	session.removeAttribute("sessname");
%>
<%
	response.setContentType("text/html; charset=euc-kr");
%>

<jsp:useBean id="FrontBoard" scope="request"
	class="Bean.Front.Common.FrontBoradType1" />
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />



<%
	String pageNum = "5";
%>
<%
	NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();

	String sSiteCode = "G5890"; // NICE�κ��� �ο����� ����Ʈ �ڵ�
	String sSitePassword = "VN2VPY5TTKBU";

	String sRequestNumber = "REQ0000000001"; // ��û ��ȣ, �̴� ����/�����Ŀ� ���� ������ �ǵ����ְ� �ǹǷ� 
												// ��ü���� �����ϰ� �����Ͽ� ���ų�, �Ʒ��� ���� �����Ѵ�.
												
	sRequestNumber = niceCheck.getRequestNO(sSiteCode);
	session.setAttribute("REQ_SEQ", sRequestNumber); // ��ŷ���� ������ ���Ͽ� ������ ���ٸ�, ���ǿ� ��û��ȣ�� �ִ´�.

	String sAuthType = ""; // ������ �⺻ ����ȭ��, M: �ڵ���, C: �ſ�ī��, X: ����������

	String popgubun = "N"; //Y : ��ҹ�ư ���� / N : ��ҹ�ư ����
	String customize = ""; //������ �⺻ �������� / Mobile : �����������

	// CheckPlus(��������) ó�� ��, ��� ����Ÿ�� ���� �ޱ����� ���������� ���� http���� �Է��մϴ�.
	String sReturnUrl = "https://www.suhyup.co.kr/member/checkplus_success.jsp"; // ������ �̵��� URL
	String sErrorUrl = "https://www.suhyup.co.kr/member/checkplus_fail.jsp"; // ���н� �̵��� URL
	
	//����
	//String sReturnUrl = "http://localhost:8080/member/checkplus_success.jsp"; // ������ �̵��� URL

	// �Էµ� plain ����Ÿ�� �����.
	String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber + "8:SITECODE"
			+ sSiteCode.getBytes().length + ":" + sSiteCode + "9:AUTH_TYPE" + sAuthType.getBytes().length + ":"
			+ sAuthType + "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl + "7:ERR_URL"
			+ sErrorUrl.getBytes().length + ":" + sErrorUrl + "11:POPUP_GUBUN" + popgubun.getBytes().length
			+ ":" + popgubun + "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;

	String sMessage = "";
	String sEncData = "";

	int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
	if (iReturn == 0) {
		sEncData = niceCheck.getCipherData();
	} else if (iReturn == -1) {
		sMessage = "��ȣȭ �ý��� �����Դϴ�.";
	} else if (iReturn == -2) {
		sMessage = "��ȣȭ ó�������Դϴ�.";
	} else if (iReturn == -3) {
		sMessage = "��ȣȭ ������ �����Դϴ�.";
	} else if (iReturn == -9) {
		sMessage = "�Է� ������ �����Դϴ�.";
	} else {
		sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>�ο���û &gt; ���ڹο�â�� &gt; �������� &gt; ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="/css/screen.css" />
<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/js/public.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
	
	function GoReg() {
		// 191119 �� ����� ���� : �Ǹ����� üũ(���� �ּ� ó���Ȱ� Ǯ��)
		if(document.vnoform.param_r1.value!="1"){
			if (document.all.agree.checked == true && document.all.agree2.checked == true){
				if(d.Month.value==""){
				if (pbform.sh_post_1.value.length == 0){
				
				
						&& d.sh_center[2].checked==false){
				if(d.self_text.value=='���ڼ� 15�ڸ�����'){
				if(d.sh_reply_type.value == "") {
				document.pbform.param_r1.value=document.vnoform.param_r1.value;
				pbform.action = "minwon_apply05.jsp";
				
			}else if(document.all.agree.checked == false && document.all.agree2.checked == false){
	    }  
	//������ȣ �˻�
		var pop = window.open("/minwon/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
		/*
		*/
	
	//������ȣ �ݹ�
	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
		
		var frm = document.pbform;
		
		frm.sh_post_1.value = zipNo;
		frm.sh_address_1.value = roadAddrPart1;
		frm.sh_address_2.value = addrDetail;
		frm.sh_address_2.focus();
	}
<script language='javascript'>
	window.name ="Parent_window";
	function fnPopup(){
		document.vnoform.param_r1.value = "";
		document.vnoform.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.vnoform.target = "popupChk";
		document.vnoform.submit();
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

		<form name="vnoform" method="post">
			<input type="hidden" name="m" value="checkplusSerivce">
			<!-- �ʼ� ����Ÿ��, �����Ͻø� �ȵ˴ϴ�. -->
			<input type="hidden" name="EncodeData" value="<%=sEncData%>">
			<!-- ������ ��ü������ ��ȣȭ �� ����Ÿ�Դϴ�. -->
			<!-- ��ü���� ����ޱ� ���ϴ� ����Ÿ�� �����ϱ� ���� ����� �� ������, ������� ����� �ش� ���� �״�� �۽��մϴ�.
			<input type="hidden" name="param_r1" value=""> <input
				type="hidden" name="param_r2" value=""> <input type="hidden"
				name="param_r3" value="">
		</form>
		<form name="pbform" method="post" action="">
			<input type="hidden" name="vDiscrNo" value="" />
			<input type="hidden" name="sh_cata" value="����" />
			<input type="hidden" name="param_r1" value="">
			<!-- contents -->
			<div id="primaryContent">
				<p class="indicate">
					<span class="shHome">����</span><span>��������</span><span>���ڹο�â��</span>�ο���û
				</p>
				<h3>�ο���û</h3>
				<div class="pdl20 pdr30">
					<h4 class="title_arrow_green01 mgb15">�������� ���� �� �̿� ���Ǽ�</h4>
					<dl class="box_line03 mgb20 mgl15" tabindex="0">
						<dt>�������� ���� �� �̿����</dt>
						<dd>�����Ͻ� ���������� �ż��ϰ� ������ �ο���� �� ó��(���νĺ�, �ο� ��ǰ��� Ȯ�� �� �ο�ó�����
							���� ��)�� ���� �뵵�� ���� �� �̿�˴ϴ�.</dd>
						<dt>�����Ϸ��� ���������� �׸�</dt>
						<dd>����, �������, �ּ�, ��ȭ(�ڵ���)��ȣ, �̸��� �ּ�, ���ΰŷ�����, �ο����� ��</dd>
						<dt>���������� ���� �� �̿�Ⱓ</dt>
						<dd>�� ���������� ���� �� �̿뿡 ���� �����Ϸκ��� ó�� �����ϱ��� �ο��繫ó���� ���Ͽ� ���� ��
							�̿�Ǹ�, �ο� ���� �Ŀ��� ��Ÿ ���� �� �ǹ����� �� �Һ��ں�ȣ ���������� ���� ���� �� �̿�˴ϴ�.</dd>
						<dt>���Ǹ� �ź��� �Ǹ� �� ���� �źο� ���� ������</dt>
						<dd>���ϲ��� ���������� ���� �� �̿� ���ǿ� �ź��� �Ǹ��� ������, �� ������ ���� �ĺ� �� �ο��� ����
							��ǰ��� Ȯ�ο� �ʼ����� ������ ���� �� �̿뿡 �����ϼž߸� �ο�ó���� �����մϴ�.</dd>
					</dl>
					<div class="mgb50 pdl25">
						<input type="checkbox" class="checkbox mgr5" id="agree1"
							name="agree" value="ok" /><label for="agree1">���� ������ �����
							�����ϰ� �������� ���� �� �̿뿡 �����մϴ�.</label>
					</div>

					<h4 class="title_arrow_green01 mgb15">���������� ��3��(�ش����)���� ���Ǽ�</h4>
					<dl class="box_line03 mgb20 mgl15" tabindex="0">
						<dt>���������� �����޴� ��</dt>
						<dd>�ο��� ����� �Ǵ� �����߾�ȸ(���繫�� ����), ȸ������, ��ȸ��, ��������</dd>
						<dt>���������� �����޴� ���� �̿����</dt>
						<dd>����� �ο��� ������ ��ǰ��� Ȯ�� �����ڷ� ����</dd>
						<dt>�����ϴ� ���������� �׸�</dt>
						<dd>�ο����� ������ ����, �������, �ּ�, ��ȭ(�ڵ���)��ȣ, �̸��� �ּ�, ���ΰŷ�����, �ο����� ��</dd>
						<dt>���������� �����޴� ���� ���������� ���� �� �̿�Ⱓ</dt>
						<dd>�ش������ �ο�(��������)�繫�� ó�� ���� �������� ���������� �̿��� �� ������ �� ���������� �������
							���� ������ ���Ͽ� ��� �� �����ǰ� �Ⱓ�� ����� ��� ������������ȣ������� ���ϴ� �ٿ� ���� �ı�˴ϴ�.</dd>
						<dt>���Ǹ� �ź��� �Ǹ� �� ���� �źο� ���� ������</dt>
						<dd>���ϲ��� ���������� �ش���� ������ �������� ���� �� ������, �̵��Ƿ� ���� �ĺ� �� �ο��� ����
							��ǰ��� Ȯ���� ����� ��� �ο�ó���� �Ұ����� �� �ֽ��ϴ�.</dd>
					</dl>
					<div class="mgb65 pdl25">
						<input type="checkbox" class="checkbox mgr5" id="agree2"
							value="ok" /><label for="agree2">�� ������ ����� �����ϰ� ��������
							��3��(�ش����) ������ �����մϴ�.</label>
					</div>

					<p class="mgb10 mgl20">�ο� ��� ��ȸ Ȯ�ν� �� �ʿ��� �������� *ǥ�ð� �Ǿ��ִ� �׸���
						�ݵ�� ��Ȯ�ϰ� �Է��� �ּ���</p>
					<div class="mgl15">
						<table class="write" summary="�ο� ��û�� ���� �̸�, �������, �ּ�, ��ȭ��ȣ, �޴���, �̸���, ��й�ȣ, �ο����, ȸ�Ź�� ��� �Է���">
							<caption>�ο� ��û ���</caption>
							<colgroup>
								<col style="width: 18%;" />
								<col style="width: auto;" />
							</colgroup>
							<tr>
								<th scope="row"> <label for="name"><span class="txt_request">*</span>�̸� </label></th>
								<td>
						 	<input type="text" name="name" class="text" style="width: 198px;" readonly="readonly" id="name" /> 
						 		<!-- <a href="#none" class="btn_blue_s01 mgl10" title="��â����"> <span>�Ǹ�����</span></a><p class="displayInB mgl5">( �̸��� �Ǹ����� ������� �Է��ϼ���.)</p> -->
 						 		<!--<a href="javascript:fnPopup();" class="btn_blue_s01 mgl10" title="��â����"> <span>�Ǹ�����</span></a><p class="displayInB mgl5">( �̸��� �Ǹ����� ������� �Է��ϼ���.)</p> 20201124 �ȳ����� ����-->
								<a href="javascript:fnPopup();" class="btn_blue_s01 mgl10" title="��â����"> <span>�Ǹ�����</span></a><p class="displayInB mgl5">( �Ǹ������� �������ּ���.)</p>
							</td>
							</tr>
							<tr>
								<th scope="row"><span class="txt_request">*</span>�������</th>
								<td>
								<label for="Year" class="tts">������� �⵵</label>
								<select name="Year" class="mgr10" id="Year">
										<option value="">��</option>
										<%
											//String strYear = Integer.toString(currentCalendar.get(Calendar.YEAR));
											for (int yyyy = 2014; yyyy >= 1914; yyyy--) {
										%>
										<option value="<%=yyyy%>"><%=yyyy%>��
										</option>
										<%
											}
										%>
								</select> 
								<label for="Month" class="tts">������� ��</label>
								<select name="Month" class="mgr10" id="Month">
										<option value="">��</option>
										<option value="01">1��</option>
										<option value="02">2��</option>
										<option value="03">3��</option>
										<option value="04">4��</option>
										<option value="05">5��</option>
										<option value="06">6��</option>
										<option value="07">7��</option>
										<option value="08">8��</option>
										<option value="09">9��</option>
										<option value="10">10��</option>
										<option value="11">11��</option>
										<option value="12">12��</option>
								</select> 
								
								<label for="Day" class="tts">������� ��</label>
								<select name="Day" class="mgr10" id="Day">
										<option value="">��</option>
										<option value="01">1��</option>
										<option value="02">2��</option>
										<option value="03">3��</option>
										<option value="04">4��</option>
										<option value="05">5��</option>
										<option value="06">6��</option>
										<option value="07">7��</option>
										<option value="08">8��</option>
										<option value="09">9��</option>
										<option value="10">10��</option>
										<option value="11">11��</option>
										<option value="12">12��</option>
										<option value="13">13��</option>
										<option value="14">14��</option>
										<option value="15">15��</option>
										<option value="16">16��</option>
										<option value="17">17��</option>
										<option value="18">18��</option>
										<option value="19">19��</option>
										<option value="20">20��</option>
										<option value="21">21��</option>
										<option value="22">22��</option>
										<option value="23">23��</option>
										<option value="24">24��</option>
										<option value="25">25��</option>
										<option value="26">26��</option>
										<option value="27">27��</option>
										<option value="28">28��</option>
										<option value="29">29��</option>
										<option value="30">30��</option>
										<option value="31">31��</option>
								</select>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span class="txt_request">*</span>�ּ�
								</th>
								<td>
								<label for="sh_post_1" class="tts">������ȣ</label>
									<input type="text" size="4" name="sh_post_1" value="" readonly class="text" style="width: 88px;" id="sh_post_1" />
									<!--<span class="txt_dash vAlignM">-</span><input type="text" size="4" name="sh_post_2" value="" readonly class="text" style="width:88px;" title="������ȣ ���ڸ�" />-->
									<a href="javascript:ZipSearch();" class="btn_blue_s01 mgl10" title="��â����">
										<span>�ּ�ã��</span>
									</a><br/>
								<label for="sh_address_1" class="tts">�⺻ �ּ�(������)</label>
									<input type="text" name="sh_address_1" readonly value="" class="text mgt10 mgb10" style="width: 508px;" id="sh_address_1"/><br/>
									
								<label for="sh_address_2" class="tts">���ּ�</label>
									<input type="text" name="sh_address_2" value="" class="text" style="width: 508px;" id="sh_address_2" />
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span class="txt_request">*</span>��ȭ��ȣ
								</th>
								<td>
								<label for="sh_tel_1" class="tts">��ȭ��ȣ ù��°�ڸ�</label>
									<input type="text" maxlength="3" name="sh_tel_1" value="" class="text" style="width: 68px;" id="sh_tel_1" />
									<span class="txt_dash vAlignM">-</span>
									
								<label for="sh_tel_2" class="tts">��ȭ��ȣ �߰��ڸ�</label>
									<input type="text" maxlength="4" name="sh_tel_2" value="" class="text" style="width: 68px;" id="sh_tel_2" />
									<span class="txt_dash vAlignM">-</span>
									
								<label for="sh_tel_3" class="tts">��ȭ��ȣ ������ �ڸ�</label>
									<input type="text" maxlength="4" name="sh_tel_3" value="" class="text" style="width: 68px;" id="sh_tel_3"  />
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span class="txt_request">*</span>�޴���
								</th>
								<td>
								<label for="sh_han_1" class="tts">�޴�����ȣ ���ڸ�</label>
									<input type="text" maxlength="3" name="sh_han_1" value="" class="text" style="width: 68px;" id="sh_han_1" />
									<span class="txt_dash vAlignM">-</span>
								<label for="sh_han_2" class="tts">�޴�����ȣ �߰��ڸ�</label>
									<input type="text" maxlength="4" name="sh_han_2" value="" class="text" style="width: 68px;" id="sh_han_2" />
									<span class="txt_dash vAlignM">-</span>
								<label for="sh_han_3" class="tts">�޴�����ȣ ������ �ڸ�</label>
									<input type="text" maxlength="4" name="sh_han_3" value="" class="text" style="width: 68px;" id="sh_han_3"  />
								</td>
							</tr>
							<tr>
								<th scope="row">
									<span class="txt_request">*</span>�̸���
								</th>
								<td>
								<label for="sh_email_1" class="tts">�̸��� �ּ� ���̵�</label>
									<input type="text" name="sh_email_1" id="sh_email_1" onBlur="checkInput(this)" value="" class="text" style="width: 148px;"  />
									<span class="txt_at vAlignM lineH170">@</span>
								<label for="sh_email_2" class="tts">�̸��� �ּ� ������ �����Է�</label>
									<input type="text" name="sh_email_2" id="sh_email_2" value="" class="text" style="width: 148px;" />
								<label for="sh_email_3" class="tts">�̸����ּ� ������ ����</label>
									<select name="sh_email_3" id="sh_email_3" onChange="mail_change();" class="mgl5" >
										<option value="">�����ϼ���</option>
										<option value='naver.com' selected="selected">���̹�</option>
										<option value='hanmail.net'>�Ѹ���</option>
										<option value='nate.com'>����Ʈ</option>
										<option value="etc">�����Է�</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">
								<label for="psword" class=""><span class="txt_request">*</span>��й�ȣ</label></th>
								<td><input type="password" name="psword" value="" class="text" style="width: 198px;" id="psword" />
								<p class="displayInB mgl5">��й�ȣ�� 4�ڸ� �̻� 6�ڸ� ���Ϸ� �ۼ��Ͽ��ּ���.</p></td>
							</tr>
							<tr>
								<th scope="row"><span class="txt_request">*</span>�ο����</th>
								<td>
									<ul>
										<li class="mgb25"><span class="displayInB w70">���α���:</span> 
											<!-- 
											2016.11.25 : sh_center ���� ũ�Ⱑ �ʹ� ŭ : �÷� ũ�Ⱚ �����ؾ��� 
											2017.03.23 : sh_center(bupin) ������ �ڵ�� ����. 1:�����߾�ȸ-ȸ������-��ȸ��, 2:��������
											-->
											<input type="radio" name="sh_center" value="1" class="radio mgr5" id="complaint1" />
										    <label for="complaint1">�����߾�ȸ-��ȸ��</label>
											<input type="radio" name="sh_center" value="3" class="radio mgr5" id="complaint3" />
											<label for="complaint3">ȸ������</label>
											<input type="radio" name="sh_center" value="2" class="radio mgr5 mgl10" id="complaint2" />
											<label for="complaint2">��������</label>
										</li>
										<li>
								<label for="self_text"><span class="displayInB w70">��󿵾���</span></label>
											<input type="text" name="self_text" id="self_text" size="30" maxlength="15" value="���ڼ� 15�ڸ�����" onfocus="this.value=''"onblur="if(this.value =='') this.value='���ڼ� 15�ڸ�����';"
											class="text mgr5" style="width: 198px;"/>(�����Է�)
										</li>
									</ul>
								</td>
							</tr>
							<!-- <tr>
							<tr>
								<th scope="row">
								<label for="sh_reply_type" class=""><span class="txt_request">*</span>ȸ�Ź��</label></th>
								<td><select name="sh_reply_type" id="sh_reply_type">
										<option value="">�����ϼ���</option>
										<option value="1">Ȩ������</option>
										<option value="2">�̸���</option>
										<option value="3">�޴���</option>
								</select></td>
							</tr>
						</table>
						<p class="pdl23 mgt18">
							<span class="txt_request mgr5">*</span>���� ǥ�õ� �κ��� �ʼ� �Է»���
						</p>
					</div>
					<div class="btnR mgt30">
						<a href="javascript:GoReg();" class="btn_blue_arrowB01 w150"><span>�ο���û</span></a><a
							href="javascript:pbform.reset();" class="btn_green_arrowB01 w150"><span>�ٽ��Է�</span></a>
					</div>
				</div>
			</div>
			<!-- //contents -->
		</form>
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/include/shFooter.jsp"%>
	<!-- //footer -->
</body>
</html>