<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, SafeNC.kisinfo.*, Kisinfo.Check.IPINClient"%>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>



<% String pageNum = "5"; %>
<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
    String sSiteCode = "G5890";				// NICE�κ��� �ο����� ����Ʈ �ڵ�
    String sSitePassword = "VN2VPY5TTKBU";
    
    String sRequestNumber = "REQ0000000001";        	// ��û ��ȣ, �̴� ����/�����Ŀ� ���� ������ �ǵ����ְ� �ǹǷ� 
                                                    	// ��ü���� �����ϰ� �����Ͽ� ���ų�, �Ʒ��� ���� �����Ѵ�.
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// ��ŷ���� ������ ���Ͽ� ������ ���ٸ�, ���ǿ� ��û��ȣ�� �ִ´�.
  	
   	String sAuthType = "";      	// ������ �⺻ ����ȭ��, M: �ڵ���, C: �ſ�ī��, X: ����������
   	
   	String popgubun 	= "N";		//Y : ��ҹ�ư ���� / N : ��ҹ�ư ����
		String customize 	= "";			//������ �⺻ �������� / Mobile : �����������
		
    // CheckPlus(��������) ó�� ��, ��� ����Ÿ�� ���� �ޱ����� ���������� ���� http���� �Է��մϴ�.
    String sReturnUrl = "http://www.suhyup.co.kr/member/checkplus_success.jsp";      // ������ �̵��� URL
    String sErrorUrl = "http://www.suhyup.co.kr/member/checkplus_fail.jsp";          // ���н� �̵��� URL

    // �Էµ� plain ����Ÿ�� �����.
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
        sMessage = "��ȣȭ �ý��� �����Դϴ�.";
    }    
    else if( iReturn == -2)
    {
        sMessage = "��ȣȭ ó�������Դϴ�.";
    }    
    else if( iReturn == -3)
    {
        sMessage = "��ȣȭ ������ �����Դϴ�.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "�Է� ������ �����Դϴ�.";
    }    
    else
    {
        sMessage = "�˼� ���� ���� �Դϴ�. iReturn : " + iReturn;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>���� - �ٴٻ�� �����</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/member.css' />

<!--[if IE 7]><link rel="stylesheet" type="text/css" href="../css/footer.css"     /><![endif]-->

<!--[if IE 8]><link rel="stylesheet" type="text/css" href="../css/footer_IE8.css" /><![endif]-->

<script type="text/javascript" src="../js/common.js"></script>

<script type="text/javascript">

<!--

	//��� ���� ���� üũ

	function GoReg() {


		if(document.vnoform.param_r1.value!="1"){
			alert("�Ǹ������� ���ֽñ�ٶ��ϴ�.");
		}
		else{
		if (document.all.agree.checked == true && document.all.agree2.checked == true){
			
			var d = document.pbform;



			if (d.name.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.name.focus(); return;}

			if(d.Year.value==""){				alert("���� ������ �ֽʽÿ�.");				d.Year.focus();				return;			}
			if(d.Month.value==""){				alert("���� ������ �ֽʽÿ�.");				d.Month.focus();				return;			}			if(d.Day.value==""){				alert("���� �������ֽʽÿ�.");				d.Day.focus();				return;			}
			if (pbform.sh_post_1.value.length == 0 || pbform.sh_post_2.value.length == 0){

				alert("�ּҰ� �Էµ��� �ʾҽ��ϴ�.");

				return;

			}else if(pbform.sh_address_1.value.length == 0 || pbform.sh_address_2.value.length == 0  ){

				alert("�ּҰ� �Էµ��� �ʾҽ��ϴ�."); d.sh_address_2.focus(); return;

			}



			if (pbform.sh_tel_1.value.length == 0){

				alert("��ȭ��ȣ�� �Էµ��� �ʾҽ��ϴ�.");

				d.sh_tel_1.focus();

				return;

			}else if(pbform.sh_tel_2.value.length == 0){

				alert("��ȭ��ȣ�� �Էµ��� �ʾҽ��ϴ�.");

				d.sh_tel_2.focus();

				return;

			}else if(pbform.sh_tel_3.value.length == 0){

				alert("��ȭ��ȣ�� �Էµ��� �ʾҽ��ϴ�.");

				d.sh_tel_3.focus();

				return;

			}



			if (pbform.sh_han_1.value.length == 0){

				alert("�ڵ�����ȣ�� �Էµ��� �ʾҽ��ϴ�.");

				d.sh_han_1.focus();

				return;

			}else if(pbform.sh_han_2.value.length == 0){

				alert("�ڵ�����ȣ�� �Էµ��� �ʾҽ��ϴ�.");

				d.sh_han_2.focus();

				return;

			}else if(pbform.sh_han_3.value.length == 0){

				alert("�ڵ�����ȣ�� �Էµ��� �ʾҽ��ϴ�.");

				d.sh_han_3.focus();

				return;

			}

			if(pbform.sh_email_1.value !== ""){

			//���������� �˻�

				if(!chkEmail2(pbform.sh_email_1,pbform.sh_email_2))  return;

			}else if(pbform.sh_email_3.value !== ""){

				//�����Է½� �˻�

				if(!chkEmail2(pbform.sh_email_3,pbform.sh_email_4))  return;

			}else{

				if (!isInput(pbform.sh_email_1,"������ �Է��� �ּ���")){ 	return; }

				else if(!isInput(pbform.sh_email_3,"������ �Է��� �ּ���")){	return;}

			}



			if (d.psword.value.length == 0) {alert("�н����带 �Է��� �ֽʽÿ�"); d.psword.focus(); return;}

			if(!chkPWD(d.psword)) return;

			//20140820			if(d.sh_center[0].checked==false && d.sh_center[1].checked==false){							alert("�ο������ ������ �ֽʽÿ�.");				return;			}			
			if(d.self_text.value=='���ڼ� 15�ڸ�����'){					alert("��󿵾����� �Է��� �ֽʽÿ�.");				d.self_text.focus();				return;			}			//20140820
			if(d.sh_cata.value == 'cho') {

				alert("�о߸� ������ �ֽʽÿ�");

				d.sh_cata.focus();

				return;

			}



			if(d.sh_reply_type.value == "") {

				alert("ȸ�Ź���� ������ �ֽʽÿ�");

				d.sh_reply_type.focus();

				return;

			}



			pbform.action = "minwon_apply02_test.jsp";

			pbform.submit();



		}else if(document.all.agree.checked == false && document.all.agree2.checked == false){

			alert("������������ �� �̿뵿�Ǽ��� ���������� ��3��(�ش����)���� ���Ǽ��� �����ϼž� �ο���û�̰����մϴ�.");

		}		else if(document.all.agree.checked == false){							alert("�������� ���� �� �̿뵿�Ǽ��� �����ϼž� �ο���û�� �����մϴ�");								}
		else if(document.all.agree2.checked == false){							alert("���������� ��3��(�ش����) ���� ���Ǽ��� �����ϼž� �ο���û�� �����մϴ�.");								}
		}

	}



	//�����ȣ �˻�

	function ZipSearch(){

		var wint = (screen.height - 350) / 2;

		var winl = (screen.width - 400) / 2;

		winprops = 'height=402,width=383,top='+wint+',left='+winl+',status=no,scrollbars=yes,resize=no'

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
		<input type="hidden" name="m" value="checkplusSerivce">						<!-- �ʼ� ����Ÿ��, �����Ͻø� �ȵ˴ϴ�. -->
		<input type="hidden" name="EncodeData" value="<%= sEncData %>">		<!-- ������ ��ü������ ��ȣȭ �� ����Ÿ�Դϴ�. -->
	    
	    <!-- ��ü���� ����ޱ� ���ϴ� ����Ÿ�� �����ϱ� ���� ����� �� ������, ������� ����� �ش� ���� �״�� �۽��մϴ�.
	    	 �ش� �Ķ���ʹ� �߰��Ͻ� �� �����ϴ�. -->
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

		<td width="180" height="125" valign="top"><img src="images/left_large_tit.gif" alt="���ڹο����нŰ�" width="180" height="170" /></td>

	</tr>

	<tr>

		<td height="10"></td>

	</tr>

	<tr>

		<td><img src="images/sc_bt_on_01.gif" alt="���ڹο�â��" /></td>

	</tr>

  	<tr>

		<td height="3"></td>

	</tr>

	<tr>

		<td><a href="minwon_03.jsp"><img src="images/sc_bt_off_013.gif" /></a></td>

	</tr>

	<tr>

		<td><a href="minwon_apply01.jsp"><img src="images/sc_bt_on_011.gif" alt="�ο���û"/></a></td>

	</tr>

	<tr>

		<td><a href="minwon_apply03.jsp"><img src="images/sc_bt_off_012.gif" alt="�ο�ó�������ȸ" /></a></td>

	</tr>

	<tr>

		<td><a href="minwon_result.jsp"><img src="images/sc_bt_off_014.gif" alt="�ο�ó���������" /></a></td>

	</tr>

	<tr>

		<td height="15"></td>

	</tr>

	<tr>

		<td><a href="shingo_001.jsp"><img src="images/sc_bt_off_02.gif" alt="�������Ű�" /></a></td>

	</tr>

	<tr>

		<td><a href="taxfree.jsp"><img src="images/sc_bt_off_03.gif" alt="�鼼����������Ű�" /></a></td>

	</tr>

		  <tr>

		  <td><a href="corruption.jsp"><img src="images/sc_bt_off_04.gif" alt="��㼾��" border="0" /></a></td>

	</tr>
	<tr>
		  <td><a href="budget.jsp"><img src="images/sc_bt_off_05.gif" alt="���곶��Ű���" border="0" /></a></td>
	</tr>
	<tr>
		<td><a href="shingo_004.jsp"><img src="images/sc_bt_off_06.gif" alt="���ͽŰ����� �ȳ�" border="0" /></a></td>
	</tr>
	</table>

    </td>

    <td id="primaryContent" valign="top">

      <table cellpadding="0" cellspacing="0">

        <tr>

          <td >

            <table cellpadding="0" cellspacing="0" border="0">

              <tr>

                <td id="navigator"><a href="/">Home</a> &gt; <a href="minwon_apply01.jsp">���ڹο�</a>

                  > ���ڹο�â��</td>

              </tr>

              <tr>

                <td id="title"><img src="../images/pcTitle050101.gif" /></td>

              </tr>

              <tr>

                <td id="content">

                  <!-- �������� ���� -->

				  <table cellpadding="0" cellspacing="0">

                    <tr>

                      <td>

                        <!-- ������������ ���Ǽ� ���� -->

                        <table cellspacing="0" style="width:745px; border:1px solid #E9E9E9; background-color:#F8F8F7;">

                          <tr>

                            <td style="padding-left:10px; padding-top:10px;"><b><font color="#0033CC">::

                              �������� ���� �� �̿� ���Ǽ� ::</font></b></td>

                          </tr>

                          <tr>

                            <td style="padding:10px;">



                              <table width="100%" border="0" cellspacing="0" cellpadding="10px" style="border:1px solid #E9E9E9; background-color:#FFFFFF;">

                                <tr>

                                  <td>

								   <!-- ��� ���� ���� -->
									<br/>									&nbsp;<strong>�� �������� ���� �� �̿����</strong> <br/>									&nbsp;&nbsp;�����Ͻ� ���������� �ż��ϰ� ������ �ο���� &middot; ó��(���νĺ�, �ο� ��ǰ��� Ȯ�� �� �ο�ó����� ���� ��)�� ���� �뵵�� <br/>&nbsp;&nbsp;���� &middot; �̿�˴ϴ�.<br/>									<br/>									&nbsp;<strong>�� �����Ϸ��� ���������� �׸�</strong><br/>									&nbsp;&nbsp;����, �������, �ּ�, ��ȭ(�ڵ���)��ȣ, �̸��� �ּ�, ���ΰŷ�����, �ο����� ��<br/>									<br/>									&nbsp;<strong>�� ���������� ���� �� �̿�Ⱓ</strong><br/>									&nbsp;&nbsp;�� ���������� ���� &middot; �̿뿡 ���� �����Ϸκ��� ó�� �����ϱ��� �ο��繫ó���� ���Ͽ� ���� &middot; �̿�Ǹ�, �ο� ���� �Ŀ��� <br/> &nbsp;&nbsp;��Ÿ ���� �� �ǹ����� �� �Һ��ں�ȣ ���������� ���� ���� &middot; �̿�˴ϴ�. <br/>									<br/>									&nbsp;<strong>�� ���Ǹ� �ź��� �Ǹ� �� ���� �źο� ���� ������</strong></br> 									&nbsp;&nbsp;���ϲ��� ���������� ���� &middot; �̿� ���ǿ� �ź��� �Ǹ��� ������, �� ������ ���� �ĺ� �� �ο��� ���� ��ǰ��� Ȯ�ο� �ʼ����� <br/> &nbsp;&nbsp;������ ���� &middot; �̿뿡 �����ϼž߸� �ο�ó���� �����մϴ�. 
									<br/><br/>
                              <!-- ��� ���� �� -->

								  </td>

                                </tr>

                              </table>

                            </td>

                          </tr>

                          <!-- üũ ��ư -->

                          <tr>

                            <td style="padding-left:10px; padding-bottom:10px;">

                              <input type="checkbox" name="agree" value="ok" />

                              ���� ������ ����� �����ϰ� �������� ���� &middot; �̿뿡 �����մϴ�.</td>

                          </tr>

                        </table><br/>

                        <!-- ������������ ���Ǽ� �� -->						<!-- ���������� ��3��(�ش����)���� ���� ���� -->                        <table cellspacing="0" height="" style="width:745px; border:1px solid #E9E9E9; background-color:#F8F8F7;">                          <tr>                            <td style="padding-left:10px; padding-top:10px;"><b><font color="#0033CC">::                              ���������� ��3��(�ش����)���� ���Ǽ� ::</font></b></td>                          </tr>                          <tr>                            <td style="padding:10px;">                              <table width="100%" border="0" cellspacing="0" cellpadding="10px" style="border:1px solid #E9E9E9; background-color:#FFFFFF;">                                <tr>                                  <td>								   <!-- ��� ���� ���� -->								<br/>								&nbsp;<strong>�� ���������� �����޴� ��</strong> <br/>								&nbsp;&nbsp;�ο��� ����� �Ǵ� �����߾�ȸ(���繫�� ����), ȸ������, ��ȸ��<br/>								<br/>								&nbsp;<strong>�� ���������� �����޴� ���� �̿����</strong><br/>								&nbsp;&nbsp;����� �ο��� ������ ��ǰ��� Ȯ�� �����ڷ� ����<br/>								<br/>								&nbsp;<strong>�� �����ϴ� ���������� �׸�</strong><br/>								&nbsp;&nbsp;�ο����� ������ ����, �������, �ּ�, ��ȭ(�ڵ���)��ȣ, �̸��� �ּ�, ���ΰŷ�����, �ο����� ��<br/>								<br/>								&nbsp;<strong>�� ���������� �����޴� ���� ���������� ���� �� �̿�Ⱓ</strong><br/>								&nbsp;&nbsp;�ش������ �ο�(��������)�繫�� ó�� ���� �������� ���������� �̿��� �� ������ �� ���������� ������� ���� ������ ���Ͽ� <br/>&nbsp;&nbsp;��� &middot; �����ǰ� �Ⱓ�� ����� ��� ������������ȣ������� ���ϴ� �ٿ� ���� �ı�˴ϴ�. <br/>								<br/>								&nbsp;<strong>�� ���Ǹ� �ź��� �Ǹ� �� ���� �źο� ���� ������</strong> <br/>								&nbsp;&nbsp;���ϲ��� ���������� �ش���� ������ �������� ���� �� ������, �̵��Ƿ� ���� �ĺ� �� �ο��� ���� ��ǰ��� Ȯ���� ����� ��� <br/>&nbsp;&nbsp;�ο�ó���� �Ұ����� �� �ֽ��ϴ�. 								<br/>								<br/>                              <!-- ��� ���� �� -->								  </td>                                </tr>                              </table>                            </td>                          </tr>                          <!-- üũ ��ư -->                          <tr>                            <td style="padding-left:10px; padding-bottom:10px;">                              <input type="checkbox" name="agree2" value="ok" />                              �� ������ ����� �����ϰ� �������� ��3��(�ش����) ������ �����մϴ�.</td>                          </tr>                        </table><br/>                        <!-- ���������� ��3��(�ش����)���� ���� �� -->

                        <!-- �ο���û �Է� â ���� -->

                        <table cellspacing="0" class="join_form">

                          <caption class="basic">:: �ο� ��� ��ȸ Ȯ�ν� �� �ʿ��� �������� *ǥ�ð�

                          �Ǿ��ִ� �׸��� �ݵ�� ��Ȯ�ϰ� �Է��� �ּ��� ::</caption>

                          <tr>

                            <th class="essential">�̸�</th>

                            <td>

                              <input type="text" class="typeText" name="name" onKeyDown="" value="">
                              <a href="javascript:fnPopup();"><img src="../pub_img/btn_name.gif" title="�Ǹ�����" /></a>
                               ( �̸��� �Ǹ����� ������� �Է��ϼ���.)
								
                            </td>

                          </tr>						  <tr>                            <th class="essential">�������</th>
							<!-- �� -->							<td>							<select name="Year">								<option value="">��</option>								 <%								 								//String strYear = Integer.toString(currentCalendar.get(Calendar.YEAR));																	  for(int yyyy=2014; yyyy>=1925; yyyy--){								 %>								   <option value="<%=yyyy%>"><%=yyyy%>��</option>								 <%								  }								 %>							</select>													<select name="Month">								<option value="">��</option>								<option value="01">1��</option><option value="02">2��</option><option value="03">3��</option>								<option value="04">4��</option><option value="05">5��</option><option value="06">6��</option>								<option value="07">7��</option><option value="08">8��</option><option value="09">9��</option>								<option value="10">10��</option><option value="11">11��</option><option value="12">12��</option>							</select>														<!-- �� -->							<select name="Day">								<option value="">��</option>									<option value="01">1��</option><option value="02">2��</option><option value="03">3��</option>								<option value="04">4��</option><option value="05">5��</option><option value="06">6��</option>								<option value="07">7��</option><option value="08">8��</option><option value="09">9��</option>								<option value="10">10��</option><option value="11">11��</option><option value="12">12��</option>								<option value="13">13��</option><option value="14">14��</option><option value="15">15��</option>								<option value="16">16��</option><option value="17">17��</option><option value="18">18��</option>								<option value="19">19��</option><option value="20">20��</option><option value="21">21��</option>								<option value="22">22��</option><option value="23">23��</option><option value="24">24��</option>										<option value="25">25��</option><option value="26">26��</option><option value="27">27��</option><option value="28">28��</option>								<option value="29">29��</option><option value="30">30��</option><option value="31">31��</option>																	</select>							</td>						</tr>
                          <tr>

                            <th class="essential">�ּ�</th>

                            <td>

                              <input type="text" size="4" name="sh_post_1" value="" readonly class="typeText input_mini" />

                              <span class="sp_txt">-</span>

                              <input type="text" size="4" name="sh_post_2" value="" readonly class="typeText input_mini" />

                              <a href="javascript:ZipSearch();"><img src="../pub_img/mb_bt_addr.gif" title="�ּ�ã��" /></a>

                              <br />

                              <input type="text" name="sh_address_1" readonly value="" class="typeText input_addr_01"/><br />

                              <input type="text" name="sh_address_2" value="" class="typeText input_addr_02">

                            </td>

                          </tr>

                          <tr>

                            <th class="essential">��ȭ��ȣ</th>

                            <td>

                              <input type="text" maxlength="3" name="sh_tel_1" value="" class="typeText input_mini" />

                              <span class="sp_txt">-</span>

                              <input type="text" maxlength="4" name="sh_tel_2" value="" class="typeText input_mini" />

                              <span class="sp_txt">-</span>

                              <input type="text" maxlength="4" name="sh_tel_3" value="" class="typeText input_mini" />

                            </td>

                          </tr>

                          <tr>

                            <th class="essential">�޴���</th>

                            <td>

                              <input type="text" maxlength="3" name="sh_han_1" value="" class="typeText input_mini" />

                              <span class="sp_txt">-</span>

                              <input type="text" maxlength="4" name="sh_han_2" value="" class="typeText input_mini" />

                              <span class="sp_txt">-</span>

                              <input type="text" maxlength="4" name="sh_han_3" value="" class="typeText input_mini" />

                            </td>

                          </tr>

                          <tr>

                            <th class="essential">�̸���</th>

                            <td>

                              <input type="text" name="sh_email_1" onBlur="checkInput(this)" value="" class="typeText input_txt" />

                              <span class="sp_txt">@</span>

                              <input type="text" name="sh_email_2" value="" class="typeText input_txt" />

                              <select name="sh_email_3" onChange="mail_change()">

                                <option value="">�����ϼ��� </option>

                                <option value='naver.com'>���̹�</option>

                                <option value='hanmail.net'>�Ѹ���</option>

                                <option value='nate.com'>����Ʈ</option>

                								<option value="">�����Է�</option>

                              </select>

                            </td>

                          </tr>

                          <tr>

                            <th class="essential">��й�ȣ</th>

                            <td>

                              <input type="password" name="psword" value=""class="typeText input_txt" />&nbsp;��й�ȣ�� 4�ڸ� �̻� 6�ڸ� ���Ϸ� �ۼ��Ͽ��ּ���.



                            </td>

                          </tr>												<tr>                            <th class="essential">�ο����</th>
							<td>							<input type="radio" name="sh_center" value="�����߾�ȸ"/> �����߾�ȸ <input type="radio" name="sh_center" value="ȸ������"/> ȸ������ <br/>							��󿵾��� <input style="color:#BDBDBD" size="30" type="text" name="self_text" maxlength="15" value="���ڼ� 15�ڸ�����" onfocus="this.value=''" onblur="if(this.value =='') this.value='���ڼ� 15�ڸ�����';"/> (�����Է�)							<td>																				</tr>												
                          <tr>

                            <th class="essential">�о߼���</th>

                            <td>

                              <select name="sh_cata">

                                <option value='cho'>�����ϼ��� </option>

                                <option value='��������'>��������</option>

                                <option value='�ݵ��ǸŰ���' >�ݵ��ǸŰ���</option>

                                <option value='��������'>��������</option>

                                <option value='�ٴٸ�Ʈ'>�ٴٸ�Ʈ</option>

                                <option value='������(���)'>������(���)</option>

                                <option value='�鼼����'>�鼼����</option>

                                <option value='ȸ������/���̰�'>ȸ������/���̰�</option>

                                <option value='��������ģö'>��������ģö</option>

                                <option value='��Ÿ����'>��Ÿ����</option>

                              </select>

                            </td>

                          </tr>

                          <tr>

                            <th class="essential">ȸ�Ź��</th>

                            <td>

                              <select name="sh_reply_type">

                                <option value="">�����ϼ��� </option>

                                <option value="Ȩ������">Ȩ������</option>

                                <option value="�̸���" >�̸���</option>

                                <option value="�޴���">�޴���</option>

                              </select>

                            </td>

                          </tr>

                        </table>

                        <p class="essential">�ʼ� �Է»���</p>

                        <table cellspacing="0" class="button">

                          <tr>

                            <td> <a href="javascript:GoReg();"><img src="../pub_img/btminwon_ok.gif" title="�ο���û��ư" width="68" height="18" /></a>

                              <a href="javascript:pbform.reset();"><img src="../pub_img/btminwon_cancel.gif" title="�ٽ��Է¹�ư" width="68" height="18" /></a>

                            </td>

                          </tr>

                        </table>

                        <!-- �ο���û �Է� â ���� -->

                      </td>

                    </tr>

                  </table>





                  <!-- �������� ��-->

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