<% String pageNum = "5"; %>


<%@ page contentType="text/html;charset=euc-kr" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">


<head>


<title>���� - �ٴٻ�� �����</title>


<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />


<link rel='stylesheet' type='text/css' media='all' href='../css/main.css' />


<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />


<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />


<script type="text/javascript" src="../js/quickMenu.js"></script>


<script type="text/javascript" src="../js/public.js"></script>


<script type="text/javascript">


<!--


function GoReg() {


	


		var d = document.pbform;





		if (d.name.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.name.focus(); return;}


		


		if (pbform.sh_han_1.value.length == 0){


			alert("�޴���/��ȭ��ȣ�� �Է����ֽʽÿ�"); 


			d.sh_han_1.focus(); 


			return;


		}else if(pbform.sh_han_2.value.length == 0){


			alert("�޴���/��ȭ��ȣ�� �Է����ֽʽÿ�"); 


			d.sh_han_2.focus(); 


			return;


		}else if(pbform.sh_han_3.value.length == 0){ 


			alert("�޴���/��ȭ��ȣ�� �Է����ֽʽÿ�"); 


			d.sh_han_3.focus(); 


			return;


		}





		if (d.passwd.value.length == 0) {alert("��й�ȣ�� �Է��� �ֽʽÿ�"); d.passwd.focus(); return;}





		pbform.submit();


	}


	function EnterCheck9() {


		if(event.keyCode == 13)		//�ͽ��÷η�����.


		{


			GoReg();


		} else {


			


		}


	}


function MM_openBrWindow(theURL,winName,features) { //v2.0


  window.open(theURL,winName,features);


}


//-->


</script>


</head>


<body id="minwon02">


<!-- start content table-->


<form name="pbform" method="post" action="minwon_apply_test06.jsp">


<table cellpadding="0" cellspacing="0" border="0">


  <tr>


    <td id="content"><!-- �������� ���� -->


        <table cellspacing="0" style="width:745px; background:url(images/result_bg_01.gif) no-repeat; border-bottom:2px solid #CFCFCF;">


          <thead>


            <tr>


              <th style="width:130px; height:32px;">�̸�</th>


              <td style="width:615px; padding-left:10px;"><input type="text" onkeydown="EnterCheck9();" class="typeText" name="name" value="" />              </td>


            </tr>


          </thead>


          <tbody>


            <tr>


              <th style="height:25px; background-color:#F4F4F4;"> <select name="telephone">


                  <option value="�޴���" >�޴���</option>


                  <option value="��ȭ��ȣ" >��ȭ��ȣ</option>


              </select></th>


              <td style="padding-left:10px;"><input type="text" maxlength="3" name="sh_han_1" value="" class="typeText input_mini" />


                  <span class="sp_txt">-</span>


                  <input type="text" maxlength="4" name="sh_han_2" value="" class="typeText input_mini" />


                  <span class="sp_txt">-</span>


                  <input type="text" maxlength="4" name="sh_han_3" value="" class="typeText input_mini" />              </td>


            </tr>


            <tr>


              <th style="height:25px; background-color:#F4F4F4;">��й�ȣ</th>


              <td style="padding-left:10px;"><input type="password" onkeydown="EnterCheck9();" class="typeText input_txt" name="passwd" value="" />


                <a href="javascript:;" onclick="MM_openBrWindow('minwon_psword.jsp','','width=360,height=260')"><img src="../pub_img/btminwon_searchpass.gif" width="85" height="20" align="absmiddle" border="0" title="��й�ȣã���ư" /></a> </td>


            </tr>


          </tbody>


        </table>


      <br />


        <!-- button table start -->


        <table cellspacing="0" class="button">


          <tr>


            <td><a href="javascript:GoReg()"><img src="../pub_img/btminwon_result.gif" title="��ȸ��ư" width="68" height="18" /></a></td>


          </tr>


        </table>


      <!-- button table end-->    </td>


  </tr>


</table>


<br />


<br />





<!-- end content table-->


</body>


</html>