<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="../inc/requestSecurity.jsp" %>

<%@ include file="../inc/requestNameCheck.jsp" %>

<%

    String vDiscrNo   = jumin;

	if (iRtn != 1) {

%>

	<script type=text/javascript>

       	alert(sRtnMsg);

       	history.go(-1);

	</script>

<%

		return;

	}

%>

<% String pageNum = "6"; %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>���곶��Ű��� &gt; �Ű��� &gt; ������ &gt; ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript" src="../js/quickMenu.js"></script>

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
	
	function EnterCheck9() {
		if(event.keyCode == 13)		//�ͽ��÷η�����.
		{
			GoReg();
		} else {

		}
	}

//-->

</script>

</head>

<body id="shingo01">

	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

<form name="pbform" method="post" action="budget_list.jsp">

	<!-- container -->
	<div id="ContentLayer">
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->
		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">����</span><span>������</span><span>�Ű���</span>���곶��Ű���</p>
			<h3>���곶��Ű���</h3>
			<div class="pdl20 pdr20">
				<div class="mgl15">
					<div class="shingo_txt mgb28">
						<p class="p_text_bul pdl10 mgb10">�Է��Ͻ� �ֹι�ȣ�� �ش�Ǵ� ���Է��ڷḸ ���� �� �ֽ��ϴ�.</p>
						<p class="pdl10">(�Է��Ͻ� ������ �ܺηδ� ���� ������� �ʽ��ϴ�.)</p>
					</div>
					<table class="write01" summary="">
						<caption></caption>
						<colgroup>
							<col style="width:20%;" />
							<col style="width:auto;" />
						</colgroup>
						<tr>
							<th scope="row" class="vAlignM"><label for="name01">�̸�</label></th>
							<td>
								<input type="text" class="text" style="width:198px;" title="�̸�" id="name01" name="name" value="" />
							</td>
						</tr>
						<tr>
							<th scope="row" class=""><label for="tel">����ó</label></th>
							<td>
							  	<select name="telephone" title="��ȭ����">
			                       <option value="�޴���" >�޴���</option>
								   <option value="��ȭ��ȣ" >��ȭ��ȣ</option>
								</select>
							
								<select title="��ȣ ���Ǽ���" style="width:68px" id="tel" name="sh_tel_1">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="019">019</option>
									<option value="02">02</option>
									<option value="031">031</option>
									<option value="032">032</option>
									<option value="033">033</option>
									<option value="041">041</option>
									<option value="042">042</option>
									<option value="043">043</option>
									<option value="044">044</option>
									<option value="051">051</option>
									<option value="052">052</option>
									<option value="053">053</option>
									<option value="054">054</option>
									<option value="055">055</option>
									<option value="061">061</option>
									<option value="062">062</option>
									<option value="063">063</option>
									<option value="064">064</option>
									<option value="070">070</option>
								</select>
								<span class="txt_dash">-</span>
								<input type="text" class="text" style="width:68px;" title="�޴�����ȣ2" maxlength="4" name="sh_tel_2"  value="" />
								<span class="txt_dash vAlignM">-</span>
								<input type="text" class="text" style="width:68px;" title="�޴�����ȣ3" maxlength="4" name="sh_tel_3"  value="" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="pass">��й�ȣ</label></th>
							<td>
								<input type="password" id="pass" name="passwd" onKeyDown="EnterCheck9();" class="text" style="width:198px;" title="��й�ȣ" />
								<a href="javascript:NewPopUp('budget_find_psword.jsp','360','260');" class="btn_blue_s01 mgl10" title="��â����"><span>��й�ȣ ã��</span></a>
							</td>
						</tr>
					</table>
					<div class="btnC mgt65">
						<a class="btn_blue_arrowB01 w150" href="javascript:GoReg();">
							<span>Ȯ��</span>
						</a>
						<a class="btn_gray_arrowB01 w150" href="javascript:GoCan();">
							<span>���</span>
						</a>
					</div>
				</div>
			</div>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->

</form>

	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->
</body>
</html>