<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>���� - �ٴٻ�� �����</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />

<!--[if IE 7]><link rel="stylesheet" type="text/css" href="../css/footer.css"     /><![endif]--> 

<!--[if IE 8]><link rel="stylesheet" type="text/css" href="../css/footer_IE8.css" /><![endif]--> 

<script type="text/javascript">

<!--	

	function GoReg() {

	

		var d = document.pbform;



		if (d.name.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.name.focus(); return;}

		if (d.sh_han_1.value.length == 0 || d.sh_han_2.value.length == 0 || d.sh_han_3.value.length == 0) { alert("�޴���/��ȭ��ȣ�� �Է����ֽʽÿ�"); return;}



		pbform.submit();

		}

//-->

</script>

<body leftmargin="0" topmargin="0">

<form name="pbform" method="post"  action="../minwon/taxfree_find_psword_proc_my.jsp">

<table border="0" cellspacing="0" cellpadding="0" style="width:360px; border:0px solid #E9E9E9; background-color:#FFFFFF;" width="360">

  <tr> 

    <td align="center" style="padding-top:10px;"> 

      <table border="0" cellspacing="0" cellpadding="0">

        <tr> 

          <td align="center"><img src="images/minwon_passtop.gif" width="345" height="63" /></td>

        </tr>

        <tr> 

          <td align="left" height="50" style="padding-left:15px;"><b>�ο���û��,<br/>

            ����Ǿ��� �׸��� ��Ȯ�ϰ� �����Ͽ� �ּ���.</b></td>

        </tr>

      </table>

      <table cellspacing="0" style="width:345px; background:url(images/minwon_passbdtop.gif) no-repeat; ">

        <thead> 

		<tr> 

          <th style="width:100px; height:32px;">�̸�</th>

          <td style="padding-left:10px;" align="left"><input type="text" name="name" class="typeText" value="" /></td>

        </tr>

		</thead> 

		<tbody> 

        <tr>

		

          <th style="width:102px; height:25px; background-color:#F4F4F4;">

		  <select name="telephone">

		                       <option value="�޴���" >�޴���</option>

							   <option value="��ȭ��ȣ" >��ȭ��ȣ</option>

							</select></th>

          <td style="padding-left:10px;" align="left">

			<input type="text" maxlength="3" name="sh_han_1"  value="" class="typeText input_mini" />

		    <span class="sp_txt">-</span> 												

            <input type="text" maxlength="4" name="sh_han_2"  value="" class="typeText input_mini" />

			<span class="sp_txt">-</span>

			<input type="text" maxlength="4" name="sh_han_3"  value="" class="typeText input_mini" />

          </td>

        </tr>

		</tbody> 

      </table>

      <table cellspacing="0" style="width:357px;">

        <tr> 

          <td align="center" style="margin-top:10px;" height="50"> <a href="javascript:GoReg();" ><img src="../pub_img/btT01Confirm.gif" title="Ȯ��" /></a> 

            <a href="javascript:self.close();" ><img src="../pub_img/btT01Cancle.gif" title="���" /></a></td>

        </tr>

      </table>

    </td>

  </tr>

</table>

</body>

</html>

