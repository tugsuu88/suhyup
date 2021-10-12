<%@ page language="java" import="java.util.*, java.lang.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*"%>

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
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	<script type="text/javascript" src="/js/quickMenu.js"></script>

	<script type="text/javascript">
	<!--
	
		function MM_openBrWindow(theURL,winName,features) { //v2.0
		  window.open(theURL,winName,features);
		}
	
		//��� ���� ���� üũ
		function GoReg() {
	
			var d = document.pbform;
	
			if (d.sg_tel1.value.length == 0){
				alert("����ó�� �Էµ��� �ʾҽ��ϴ�.");
				d.sg_tel1.focus();
				return;
			}else if(d.sg_tel2.value.length == 0){
				alert("����ó�� �Էµ��� �ʾҽ��ϴ�.");
				d.sg_tel2.focus();
				return;
			}else if(pbform.sg_tel3.value.length == 0){
				alert("����ó�� �Էµ��� �ʾҽ��ϴ�.");
				d.sg_tel3.focus();
				return;
			}
	
			if (d.sg_pass.value.length == 0) {alert("�н����带 �Է��� �ֽʽÿ�"); d.sg_pass.focus(); return;}
	
			d.submit();
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

	<!-- container -->
	<div id="ContentLayer">
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->
		
		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">����</span><span>������</span><span>�Ű���</span>ûŹ������ ���� �Ű�</p>
			<h3>ûŹ������ ���� �Ű�</h3>

			<form name="pbform" method="post" action="chungtak_list.jsp">

			<div class="pdl20 pdr20">
				<h4 class="dpNone">�����������</h4>
				<div class="mgl15">
					<div class="shingo_txt mgb28">
						<p class="p_text_bul pdl10 mgb10">�Է��Ͻ� �ֹι�ȣ�� �ش�Ǵ� ���Է��ڷḸ ���� �� �ֽ��ϴ�.</p>
						<p class="pdl10">(�Է��Ͻ� ������ �ܺηδ� ���� ������� �ʽ��ϴ�.)</p>
					</div>
					<!-- 20150226 :: START -->
					<table class="write01" summary="�������/���������� �Ű� ���� �������� �Է� ���̺��Դϴ�.">
						<caption>�ο�ó����� ��ȸ</caption>
						<colgroup>
							<col style="width:20%;" />
							<col style="width:auto;" />
						</colgroup>
						<tr>
							<th scope="row" class="vAlignM"><label for="sg_name01">�̸�</label></th>
							<td>
								<input type="text" class="text" style="width:198px;" title="�̸�" id="sg_name01" name="sg_name" value="<%=name%>" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<th scope="row" class=""><label for="tel">����ó</label></th>
							<td>
								
								<input type="text" name="sg_tel1" class="text" style="width:68px;"  title="����ó ù��°�ڸ�" maxlength="4" /><span class="txt_dash vAlignM">-</span>
								<input type="text" name="sg_tel2" class="text" style="width:68px;" title="��ȣ �߰��ڸ� �Է�" maxlength="4" />	<span class="txt_dash vAlignM">-</span>
								<input type="text" name="sg_tel3" class="text" style="width:68px;" title="��ȣ �������ڸ� �Է�" maxlength="4" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="sg_pass01">��й�ȣ</label></th>
							<td>
								
								<input type="password" id="sg_pass01" name="sg_pass" onKeyDown="EnterCheck9();" class="text" style="width:198px;" title="��й�ȣ" /><a href="javascript:NewPopUp('chungtak_find_psword.jsp','360','315');" class="btn_blue_s01 mgl10" title="��â����" ><span>��й�ȣ ã��</span></a>
							</td>
						</tr>
					</table>
					<!-- 20150226 :: END -->
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
				
</form>

		</div>
		<!-- //contents -->

	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->
</body>
</html>