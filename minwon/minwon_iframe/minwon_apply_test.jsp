<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="../inc/requestSecurity.jsp" %>

<%

	//2008-01-25 : ����ĺ� �Ǹ����� �����

	String retInfo = Converter.nullchk(request.getParameter("retInfo")).trim();

	// ��ȣȭ ��� (jar)

    com.sci.vname.secu.aes.SciPacketConversion sciSecu = new com.sci.vname.secu.aes.SciPacketConversion();



    com.sci.vname.secu.SciSecuManager sciSecuMg = new com.sci.vname.secu.SciSecuManager();



    com.sci.vname.secu.hmac.SciHmac hmac     = new com.sci.vname.secu.hmac.SciHmac();



    StringBuffer retInfoTemp    = new StringBuffer("");



    retInfoTemp = sciSecu.RecvWritePacket(retInfo);

    retInfo = retInfoTemp.toString();



    int info1 = retInfo.indexOf("/",0);

    int info2 = retInfo.indexOf("/",info1+1);

    int info3 = retInfo.indexOf("/",info2+1);

    int info4 = retInfo.indexOf("/",info3+1);

	int info5 = retInfo.indexOf("/",info4+1);

    int info6 = retInfo.indexOf("/",info5+1);



	String reqNum     = retInfo.substring(0,info1);

    String vDiscrNo   = retInfo.substring(info1+1,info2);

    String name       = retInfo.substring(info2+1,info3);

    String result     = retInfo.substring(info3+1,info4);

    String discrHash  = retInfo.substring(info4+1,info5);

    String msg        = retInfo.substring(info5+1,info6);

%>

<% String pageNum = "5"; %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>���� - �ٴٻ�� �������</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/main.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/member.css' />

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript" src="../js/common.js"></script>

<script type="text/javascript">

<!--

	//��� ���� ���� üũ

	function GoReg() {

	

		if (document.all.agree.checked == true){

			var d = document.pbform;



			if (d.name.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.name.focus(); return;}



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

			

			if(d.sh_cata.value == 'cho') {

				alert("�о߸� ������ �ֽʽÿ�");

				d.sh_cata.focus();

				return;

			}

			//select_change();

			pbform.action = "minwon_apply_test02.jsp";

			pbform.submit();



		}else {

			alert("����� �����ϼž� �ο���û�� �����մϴ�");

		}

	

	}



	//������ȣ �˻�

	function ZipSearch(){

		var wint = (screen.height - 350) / 2;

		var winl = (screen.width - 400) / 2;

		winprops = 'height=402,width=383,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = 'find_addr.jsp?return1=pbform.sh_post_1&amp;return2=pbform.sh_post_2&amp;return3=pbform.sh_address_1';

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



	/*

		function select_change() {

		var A = document.pbform;

	

		if(A.sh_cata.value == 'cho') {

			alert("�о߸� ������ �ֽʽÿ�");

			d.sh_cata.focus();

			return;

		}

		

	}

*/



//-->

</script>

</head>

<body id="minwon01"> 

<!-- start content table-->

<form name="pbform" method="post" action="">

<input type="hidden" name="vDiscrNo" value="<%=vDiscrNo%>">

<table width="745" cellpadding="0" cellspacing="0">

  <tr>

    <td width="835"><!-- ������������ ���Ǽ� ���� -->

        <table cellspacing="0" style="width:745px; border:1px solid #E9E9E9; background-color:#F8F8F7;">

          <tr>

            <td style="padding-left:10px; padding-top:10px;"><b><font color="#0033CC">:: 

              ������������ �� Ȱ�� ���Ǽ� ::</font></b></td>

          </tr>

          <tr>

            <td style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="10px" style="border:1px solid #E9E9E9; background-color:#FFFFFF;">

                <tr>

                  <td><!-- ��� ���� ���� -->

                    ���ϰ� ������ �ο��� ��� Ȯ���� ���Ͽ� �ο����� �� ������ ���������� ��ȸ�� ���� �� Ȱ���ϴ� �Ϳ� ���� �����ϴ��� ���θ� ǥ���Ͽ� �ֽñ� �ٶ��ϴ�. <br />

                    ���� ���ϰ� ��ȸ�� �ο�ó�������� �������� �ʾ� ��� Ȯ���� �� �� ���� ��쿡�� ������ 

                    �ο�ó���� ������ �� ������ �˷��帳�ϴ�.

                    <!-- ��� ���� �� -->

                  </td>

                </tr>

            </table></td>

          </tr>

          <!-- üũ ��ư -->

          <tr>

            <td style="padding-left:10px; padding-bottom:10px;"><input type="checkbox" name="agree" value="ok" />

              ���� ���뿡 �����մϴ�.</td>

          </tr>

        </table>

      <br />

        <!-- ������������ ���Ǽ� �� -->

        <!-- �ο���û �Է� â ���� -->

        <table cellspacing="0" class="join_form">

          <caption class="basic">

            :: �ο� ��� ��ȸ Ȯ�ν� �� �ʿ��� �������� *ǥ�ð� 

            �Ǿ��ִ� �׸��� �ݵ�� ��Ȯ�ϰ� �Է��� �ּ��� ::

          </caption>

          <tr>

            <th class="essential">�̸�</th>

            <td><input type="text" class="typeText" name="name" onkeydown="" value="<%=name%>" />

              ( �̸��� �Ǹ����� ������� �Է��ϼ���.) </td>

          </tr>

          <tr>

            <th class="essential">�ּ�</th>

            <td><input type="text" size="4" name="sh_post_1" value="" readonly="readonly" class="typeText input_mini" />

                <span class="sp_txt">-</span>

                <input type="text" size="4" name="sh_post_2" value="" readonly="readonly" class="typeText input_mini" />

                <a href="javascript:ZipSearch();"><img src="../pub_img/mb_bt_addr.gif" title="�ּ�ã��" /></a> <br />

                <input type="text" name="sh_address_1" readonly="readonly" value="" class="typeText input_addr_01"/>

              <br />

                <input type="text" name="sh_address_2" value="" class="typeText input_addr_02" />

            </td>

          </tr>

          <tr>

            <th class="essential">��ȭ��ȣ</th>

            <td><input type="text" maxlength="3" name="sh_tel_1" value="" class="typeText input_mini" />

                <span class="sp_txt">-</span>

                <input type="text" maxlength="4" name="sh_tel_2" value="" class="typeText input_mini" />

                <span class="sp_txt">-</span>

                <input type="text" maxlength="4" name="sh_tel_3" value="" class="typeText input_mini" />

            </td>

          </tr>

          <tr>

            <th class="essential">�޴���</th>

            <td><input type="text" maxlength="3" name="sh_han_1" value="" class="typeText input_mini" />

                <span class="sp_txt">-</span>

                <input type="text" maxlength="4" name="sh_han_2" value="" class="typeText input_mini" />

                <span class="sp_txt">-</span>

                <input type="text" maxlength="4" name="sh_han_3" value="" class="typeText input_mini" />

            </td>

          </tr>

          <tr>

            <th class="essential">�̸���</th>

            <td><input type="text" name="sh_email_1" onblur="checkInput(this)" value="" class="typeText input_txt" />

                <span class="sp_txt">@</span>

                <input type="text" name="sh_email_2" value="" class="typeText input_txt" />

                <select name="sh_email_3" onchange="mail_change()">

                  <option value="">�����ϼ��� </option>

                  <option value='suhyup.co.kr'>����</option>

                  <option value='empas.com'>���Ľ�</option>

                  <option value='hanmail.net'>�Ѹ���</option>

                  <option value='korea.com'>�ڸ���</option>

                  <option value='nate.com'>����Ʈ</option>

                  <option value='naver.com'>���̹�</option>

                  <option value='yahoo.co.kr'>����</option>

                  <option value='paran.com'>�Ķ�</option>

                  <option value="">�����Է�</option>

                </select>

            </td>

          </tr>

          <tr>

            <th class="essential">��й�ȣ</th>

            <td><input type="password" name="psword" value=""class="typeText input_txt" />

              &nbsp;��й�ȣ�� 4�ڸ� �̻� 6�ڸ� ���Ϸ� �ۼ��Ͽ��ּ���. </td>

          </tr>

          <tr>

            <th class="essential">�о߼���</th>

            <td><select name="sh_cata">

                <option value='cho'>�����ϼ��� </option>

                <option value='��������'>��������</option>

                <option value='�ݵ��ǸŰ���' >�ݵ��ǸŰ���</option>

                <option value='��������'>��������</option>

                <option value='�ٴٸ�Ʈ'>�ٴٸ�Ʈ</option>

                <option value='������(���)'>������(���)</option>

                <option value='�鼼����'>�鼼����</option>

                <option value='ȸ������/���̰�'>ȸ������/���̰�</option>

                <option value='����������ģö'>����������ģö</option>

                <option value='��Ÿ����'>��Ÿ����</option>

              </select>

            </td>

          </tr>

        </table>

      <p class="essential">�ʼ� �Է»���</p>

      <table cellspacing="0" class="button">

          <tr>

            <td><a href="javascript:GoReg();"><img src="../pub_img/btminwon_ok.gif" title="�ο���û��ư" width="68" height="18" /></a> <a href="javascript:pbform.reset();"><img src="../pub_img/btminwon_cancle.gif" title="�ٽ��Է¹�ư" width="68" height="18" /></a> </td>

          </tr>

        </table>

      <!-- �ο���û �Է� â ���� -->

    </td>

  </tr>

</table>

<!-- end content table-->

</form>

</body>

</html>