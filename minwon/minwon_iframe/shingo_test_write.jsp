<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*"%>


<%@ page contentType="text/html;charset=euc-kr" %>


<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>


<%@ include file="../inc/requestSecurity.jsp" %>


<%


	//2008-01-25 : ����ĺ� �Ǹ����� �����


	String retInfo = request.getParameter("retInfo").trim();


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


<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />


<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />


<script type="text/javascript" src="../js/quickMenu.js"></script>


<!--/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************/-->


<SCRIPT SRC="http://www.suhyup.co.kr/supervisor/js/ax_wdigm/default.js"></SCRIPT>


<!--/********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/-->


<script type="text/javascript" src="../js/public.js"></script>


<script type="text/javascript" src="../js/common.js"></script>


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





			if (d.title.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.title.focus(); return;}


			


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





			if (d.contents.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.contents.focus(); return;}


			if (d.psword.value.length == 0) {alert("�н����带 �Է��� �ֽʽÿ�"); d.psword.focus(); return;}


			


			if(!chkPWD(d.psword)) return;





			/********************************************���ʴ��� �۾� ���� 2008.03.13****************************************************/


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


			/********************************************���ʴ��� �۾� �� 2008.03.13******************************************************/				


			


			d.submit();


			//d.action();


		


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


<style type="text/css">


.smallfont{font-size:11px;letter-spacing: -1px}


</style>


</head>


<body id="shingo01">


<!-- start content table-->


<form name="pbform" method="post" action="shingo_proc_test.jsp">


<input type="hidden" name="vDiscrNo" value="<%=vDiscrNo%>">


<table cellpadding="0" cellspacing="0" border="0">


  <tr>


    <td id="content"><!-- �ο���û �Է� â ���� -->


        <table cellspacing="0" class="writeTable">


          <tr>


            <th class="essential"><span>�̸�</span></th>


            <td><input type="text" class="typeText" name="name" value="<%=name%>" />            </td>


          </tr>


          <tr>


            <th>�̸���</th>


            <td><input type="text"  name="sh_email_1" onblur="checkInput(this)" value="" class="typeText input_txt"/>


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


                  <option value="">�����Է� </option>


                </select>


                <span class="smallfont">(���� ȸ���� ���Ͽ� ������ ������ �ֽʽÿ�.)</span></td>


          </tr>


          <tr>


            <th class="essential"><span>&nbsp;&nbsp;�޴���</span></th>


            <td><input type="text" maxlength="3" name="sh_tel_1" value="" class="typeText input_mini" />


                <span class="sp_txt">-</span>


                <input type="text" maxlength="4" name="sh_tel_2" value="" class="typeText input_mini" />


                <span class="sp_txt">-</span>


                <input type="text" maxlength="4" name="sh_tel_3" value="" class="typeText input_mini" />            </td>


          </tr>


          <tr>


            <th>�ּ�</th>


            <td><input type="text" size="4" name="sh_post_1" value="" readonly="readonly" class="typeText input_mini" />


                <span class="sp_txt">-</span>


                <input type="text" size="4" name="sh_post_2" value="" readonly="readonly" class="typeText input_mini" />


                <a href="javascript:ZipSearch();"><img src="../pub_img/mb_bt_addr.gif" title="�ּ�ã��" /></a> <br />


                <input type="text" name="sh_address_1" readonly="readonly" value="" class="typeText input_addr_01"/>


              <br />


                <input type="text" name="sh_address_2" value="" class="typeText input_addr_02" />            </td>


          </tr>


          <tr>


            <th class="essential"><span>&nbsp;&nbsp;��ȭ��ȣ</span></th>


            <td><input type="text" maxlength="3" name="sh_tele_1" value="" class="typeText input_mini" />


                <span class="sp_txt">-</span>


                <input type="text" maxlength="4" name="sh_tele_2" value="" class="typeText input_mini" />


                <span class="sp_txt">-</span>


                <input type="text" maxlength="4" name="sh_tele_3" value="" class="typeText input_mini" />            </td>


          </tr>


          <tr>


            <th class="essential"><span>����</span></th>


            <td><input type="text" name="title" value="" class="typeText input_addr_01" />            </td>


          </tr>


          <tr>


            <th class="essential"><span>����</span></th>


            <td><textarea name="contents" value="" cols="25" rows="14" class="typeText content" wrap="virtual"></textarea>            </td>


          </tr>


          <tr>


            <th class="essential"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��й�ȣ</span></th>


            <td><input type="password" name="psword" value="" class="typeText input_txt" />


                <span class="sp_txt">(��й�ȣ�� 4�ڸ� ~ 6�ڸ��� �ۼ����ּ���)</span> </td>


          </tr>


        </table>


      <p class="essential">�ʼ� �Է»���</p>


      <!-- �ο���û �Է� â �� -->    </td>


  </tr>


</table>


<table cellspacing="0" style="width:745px; margin-top:20px;">


  <tr>


    <td align="center" height="25"><!-- a href="join_step03.jsp" -->


      <a href="javascript:GoReg();"> <img src="../pub_img/btT01Confirm.gif" title="Ȯ��" /></a> <a href="javascript:GoCan();"> <img src="../pub_img/btT01Cancle.gif" title="���" /></a> </td>


  </tr>


</table>


<p>


  <!-- end content table-->


</p>


</form>


</body>


</html>