<%@ page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>��й�ȣ ã�� &gt; ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/js/public.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
<!--	
	function GoReg() {

		var d = document.pbform;

		if (d.name.value.length == 0) {alert("������ �Է��� �ֽʽÿ�"); d.name.focus(); return;}
		if (d.sh_han_1.value.length == 0 || d.sh_han_2.value.length == 0 || d.sh_han_3.value.length == 0) { alert("�޴���/��ȭ��ȣ�� �Է����ֽʽÿ�"); return;}

		d.submit();
	}

	function resizeWindowHeight(wValue, hValue) {
	    var popUpWinSize = document.getElementById("popUpWinHeight");
	    var windowHeight = popUpWinSize.offsetHeight + hValue;
		window.resizeTo(wValue, windowHeight);
	}

//-->
</script>
</head>
<body onload="resizeWindowHeight(500,20);">
<form name="pbform" method="post" action="taxfree_find_psword_proc.jsp">
	<!-- 400*330 -->
	<div id="popUpWinHeight" class="wrapPopup">
		<h1 class="dpNone">����</h1>
		<h2><span>��й�ȣ ã��</span></h2>
		<div class="innerBox">
			<p class="mgb25">* �鼼���� �������� �Ű� ��, ����Ǿ��� �׸��� ��Ȯ�ϰ� �����Ͽ� �ּ���.</p>
			<table class="write mgb10" summary="��й�ȣ ã��">
				<caption>��й�ȣ ã��</caption>
				<colgroup>
					<col style="width:25%;" />
					<col style="width:auto;" />
				</colgroup>
				<tr>
					<th scope="row">�� ��</th>
					<td><input type="text" name="name" class="text w100p" title="�� ��" /></td>
				</tr>
				<tr>
					<th scope="row" class="pdl0 textC">����ó</th>
					<td>
						<select title="����ó ����" name="telephone" class="mgr5 mgb5" >
							<option value="�޴���">�޴���</option>
							<option value="��ȭ��ȣ">��ȭ��ȣ</option>
						</select><br />
						<input type="text" maxlength="3" name="sh_han_1" class="text" style="width:70px;" title="��ȭ��ȣ1" /><span class="txt_dash vAlignM">-</span><input type="text" maxlength="4" name="sh_han_2" class="text" style="width:70px;" title="��ȭ��ȣ2" /><span class="txt_dash vAlignM">-</span><input type="text" maxlength="4" name="sh_han_3"  class="text" style="width:70px;" title="��ȭ��ȣ3" />
					</td>
				</tr>
			</table>
		</div>
		<div class="btnCenter">
			<a href="javascript:GoReg();"  class="btn_blue_s01"><span>Ȯ��</span></a><a href="javascript:self.close();"  class="btn_dGray_s01"><span>���</span></a>
		</div>
	</div>
</form>
</body>
</html>