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

<title>���� - �ٴٻ�� �����</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />

<!--[if IE 7]><link rel="stylesheet" type="text/css" href="../css/footer.css"     /><![endif]--> 

<!--[if IE 8]><link rel="stylesheet" type="text/css" href="../css/footer_IE8.css" /><![endif]--> 

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript">

<!--



	function MM_openBrWindow(theURL,winName,features) { //v2.0

	  window.open(theURL,winName,features);

	}



	//��� ���� ���� üũ

	function GoReg() {

			var d = document.pbform;

			

			if (d.sh_tel_1.value.length == 0){

				alert("�޴���/��ȭ��ȣ�� �Էµ��� �ʾҽ��ϴ�."); 

				d.sh_tel_1.focus();

				return;

			}else if(d.sh_tel_2.value.length == 0){

				alert("�޴���/��ȭ��ȣ�� �Էµ��� �ʾҽ��ϴ�."); 

				d.sh_tel_2.focus();

				return;

			}else if(d.sh_tel_3.value.length == 0){ 

				alert("�޴���/��ȭ��ȣ�� �Էµ��� �ʾҽ��ϴ�."); 

				d.sh_tel_3.focus();

				return;

			}	

					

			if (d.passwd.value.length == 0) {alert("�н����带 �Է��� �ֽʽÿ�"); d.passwd.focus(); return;}

			

			pbform.submit();

					

	}

	function GoCan(){

		history.go(-1);	

	}

//-->

</script>

</head>

<body id="shingo01">

<%@ include file="/include/shHeader.jsp" %>

<!-- start content table-->

<form name="pbform" method="post" action="../minwon/taxfree_list_my.jsp">

<table id="contentTable" cellpadding="0" cellspacing="0">

  <tr> 

    <td id="sideContent" valign="top"> 

      <table cellpadding="0" cellspacing="0">

        <tr> 

          <td><img src="../member/images/sc_title_bn_mypage.gif" width="180" height="60" /></td>

        </tr>

        <tr> 

          <td height="10"></td>

        </tr>

        <tr> 

          <td><a href="../member/modify.jsp"><img src="../member/images/sc_bt_off_09.gif" width="190" height="21" border="0" /></a></td>

        </tr>

        <tr> 

          <td><a href="../member/change_pw.jsp"><img src="../member/images/sc_bt_off_10.gif" width="190" height="21" border="0" /></a></td>

        </tr> <tr> 

          <td><a href="../member/delete_main.jsp"><img src="../member/images/sc_bt_off_12.gif" width="190" height="21" border="0" /></a></td>

        </tr>

        <tr> 

          <td height="3"></td>

        </tr>

        <tr> 

          <td><a href="../member/join_list.jsp"><img src="../member/images/sc_bt_off_11.gif" width="190" height="21" border="0" /></a></td>

        </tr>

       

	<tr>

		<td><a href="../minwon/minwon_apply03_my.jsp"><img src="../member/images/sc_bt_on_13.gif" width="190" height="21" /></a></td>

	</tr>

	<tr>

		<td height="3"></td>

	</tr>

	<tr>

		<td><a href="../minwon/minwon_apply03_my.jsp"><img src="../member/images/sc_bt_off_13_01.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td><a href="../minwon/shingo_001_my.jsp"><img src="../member/images/sc_bt_off_13_02.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td><a href="../minwon/taxfree_my.jsp"><img src="../member/images/sc_bt_on_13_03.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td height="3"></td>

	</tr>

   

        

        <tr> 

          <td height="15"></td>

        </tr>

      </table>

    </td>

    <td id="primaryContent" valign="top"> 

      <table cellpadding="0" cellspacing="0">

        <tr> 

          <td><IMG SRC="../images/pc_bg_topline.gif" WIDTH="795" HEIGHT="5" BORDER="0" alt="" /></td>

        </tr>

        <tr> 

          <td style="background:url(../images/pc_middle_line.gif); padding-left:30px;" valign="top"> 

            <table cellpadding="0" cellspacing="0" border="0">

              <tr> 

                <td id="navigator"><a href="/">Home</a> &gt; ���������� > <a href="../minwon/taxfree_my.jsp">���ǹο�/�Ű�</a> 

			> �鼼���� �������� �Ű�</td>

              </tr>

              <tr> 

                <td id="title"><img src="../images/pcTitle050202.gif" /></td>

              </tr>

              <tr> 

                <td id="content"> 

                   <!-- ��й�ȣ �Է� â ���� -->

                  <table cellspacing="0" style="border:2px solid #E9E9E9; margin:0 0 0 0px; width:716px;">

                    <tr> 

                      <td height="60" align="center"> <b> <font color="#154EB7">�Է��Ͻ�

                        �ֹι�ȣ�� �ش�Ǵ� ���Է��ڷḸ ���� �� �ֽ��ϴ�.<br/>

                        (�Է��Ͻ� ������ �ܺηδ� ���� ������� �ʽ��ϴ�.) </font></b> </td>

                    </tr>

					<tr> 

                      <td align="center"> 

                        <table width="96%" border="0" cellspacing="0" cellpadding="0" height="45">

                          <tr> 

                            <td align="center" bgcolor="F9F9F9"><font color="323232"><b>�̸�</b></font> 

                              <input type="text" class="typeText input_txt" name="name" value="" />

                            </td>

                          </tr>

                        </table>

                      </td>

                    </tr>

					<tr> 

                      <td align="center"> 

                        <table width="96%" border="0" cellspacing="0" cellpadding="0" height="45">

                          <tr>

						  <td align="center" bgcolor="F9F9F9"><font color="323232">

						  <select name="telephone">

		                       <option value="�޴���" >�޴���</option>

							   <option value="��ȭ��ȣ" >��ȭ��ȣ</option>

							</select>

                             <input type="text" maxlength="3" name="sh_tel_1"  value="" class="typeText input_mini" />

                        <span class="sp_txt">-</span> 

                        <input type="text" maxlength="4" name="sh_tel_2"  value="" class="typeText input_mini" />

                        <span class="sp_txt">-</span> 

                        <input type="text" maxlength="4" name="sh_tel_3"  value="" class="typeText input_mini" />

						</td>

                          </tr>

                        </table>

                      </td>

                    </tr>

					<tr> 

                      <td align="center"> 

                        <table width="96%" border="0" cellspacing="0" cellpadding="0" height="45">

                          <tr> 

                            <td align="center" bgcolor="F9F9F9"><font color="323232"><b>��й�ȣ</b></font> 

                              <input type="password" class="typeText input_txt" name="passwd" value="" />

							  <a href="javascript:;" onClick="MM_openBrWindow('../minwon/taxfree_find_psword_my.jsp','','width=360,height=260')"><img src="../pub_img/btminwon_searchpass.gif" width="85" height="20" align="absmiddle" border="0" title="��й�ȣã���ư" /></a>

                            </td>

                          </tr>

                        </table>

                      </td>

                    </tr>

                    <tr> 

                      <td align="center"> 

                        <table cellspacing="0" style="width:745px; margin-top:10px;">

                          <tr> 

                            <td align="center" height="50"> 

                              <!-- a href="join_step03.jsp" -->

                              <a href="javascript:GoReg();"> <img src="../pub_img/btT01Confirm.gif" title="Ȯ��" /></a> 

                              <a href="javascript:GoCan();"> <img src="../pub_img/btT01Cancle.gif" title="���" /></a></td>

                          </tr>

                        </table>

                      </td>

                    </tr>

                  </table>

				  <!-- ��й�ȣ �Է� â �� -->

                </td>

              </tr>

            </table>

          </td>

        </tr>

        <tr> 

          <td><IMG SRC="../images/pc_bg_bottomline.gif" WIDTH="795" HEIGHT="4" BORDER="0" alt="" /></td>

        </tr>

        <tr> 

          <td height="20"></td>

        </tr>

      </table>

    </td>

  </tr>

</table>

<!-- end content table-->

<%@ include file="/include/shFooter.jsp" %>

</body>

</html>