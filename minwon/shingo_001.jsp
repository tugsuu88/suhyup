<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, util.*" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<%
	//����ĺ��� �ʿ��� ����ũ�� ������
	String member01 = DateTime.getCurrentDateTime();
	//out.println("member01 : " + member01 + "<br/>");
%>
<%
	String pageNum = "5";
	String incPage = request.getParameter("incPage");

	String myPage = request.getRequestURI();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>�������/���������� &gt; �Ű����� &gt; �������� &gt; ����</title><!-- 20150224 -->
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
<!--//-->
	window.name ="join_window";
	var CBA_window;

	function openCBAWindow() {
		document.reqCBAForm.retUrl.value = "/minwon/shingo_write.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops);

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}
	function openCBAWindow1() {
		document.reqCBAForm.retUrl.value = "/minwon/shingo_psword.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops)

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}
	function openCBAWindow2() {
		document.reqCBAForm.retUrl.value = "/minwon/absurd_write.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops); 

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}
	function openCBAWindow3() {
		document.reqCBAForm.retUrl.value = "/minwon/absurd_psword.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops);

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}

</script>

</head>
<body>
	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->
	<form name="reqCBAForm" method="post" action="">
		<input type="hidden" name="retUrl" value="" />
	</form>
	<form name="vnoform" method="post">
		<input type="hidden" name="enc_data" />
		<!-- ��ü���� ����ޱ� ���ϴ� ����Ÿ�� �����ϱ� ���� ����� �� ������, ������� ����� �ش� ���� �״�� �۽��մϴ�. �ش� �Ķ���ʹ� �߰��Ͻ� �� �����ϴ�. -->
	    <input type="hidden" name="param_r1" value="" />
	    <input type="hidden" name="param_r2" value="" />
	    <input type="hidden" name="param_r3" value="" />
	</form>

	<!-- container -->
	<div id="ContentLayer">
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->
		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">����</span><span>��������</span><span>�Ű�����</span>�������/����������/�ε������� ���� �ҹ����� �Ű�</p>
			<h3>�������/����������/�ε������� ���� �ҹ����� �Ű�</h3>
			<div class="pdl20 pdr20">
				<!-- <h4 class="dpNone">�����������</h4>
				<p class="notify_alert mgb35">
					�� ���� ������ ������� ���ǰ� ������, ������ �� �繫�ҳ� ���� �������� ���������� �����Ͽ� �������δ��� ������ �����ν� ���� �Ǵ� ������ �ս��� �ʷ��ϰų� ���������� �����ϰ� �� ����� �ִ� ������ ���Ͽ� ������ �����ް� �ֽ��ϴ�.
				</p> -->
				<h5 class="title_arrow_green01 mgb15">��������</h5>
				<ul class="list_dot_sky mgl25 mgb35">
				<li>������ : ���Ѿ���</li>
				<li>������� : ���� �繫�� �� ���� ������.</li>
				<li>
					��������(����) : 
					<ul style="margin-left:5px;"> 
						<li>- ������� : Ⱦ��, ����, ����, ��ǰ����, ������˼�, ������úδ�����, �����Ǹ�������, ��Ģ���� �� <br>�������� ���� �δ�����</li>
						<li>- ���������� ���� : </li>
						<li>
							<ul style="margin-left:20px;">
								<li>�� ��ǰ, ��ǰ��, ���� ���� �䱸 �� ��������</li>
								<li>��  ���� ���� �䱸 �� ���� ����</li>
								<li>�� ���� �� �λ� ���� ûŹ ����</li>
								<li>�� �߼ұ������ ���� ���⳪ Ŀ�̼� �䱸 ����</li>
								<li>�� �������� �� �ٹ��Ⱝ���� ��</li>
						</ul>
						</li>
					</ul>
				</li>
				</ul>
				<h5 class="title_arrow_green01 mgb15">��Ÿ����</h5>
				<ul class="list_dot_sky mgl25 mgb35">
				<li>������� �����ڿ� ���� ����� ��ȣ�ǿ��� ��������� �Ǹ����� �Ͻñ� �ٶ��ϴ�.</li>
				<li>â�� ��ģ��, ����, �Ҹ� �� �����������ڹο�â������ �̿��Ͽ� �ֽñ� �ٶ��, �̷� ����<br>����������������� �� �� ���� �������� ��ġ �� ȸ���� �� �帱 �� ������ �˷��帳�ϴ�</li>
				</ul>
				<h5 class="title_arrow_green01 mgb15">����ó</h5>
				<ul class="list_dot_sky mgl25 mgb35">
				<li>�����ּ� : ����� ���ı� ���ݷ� 62 �������� �����, �����߾�ȸ ���հ����(�� 05510)</li>
				<li>�� ȭ (��): �������� �����(02-2240-3321), �����߾�ȸ ���հ����(02-2240-3424)</li> <!-- 20201211 ����� �ν��ذ��� ��û -->
				<li>FAX : 02) 2240-3076</li>
				</ul>
				<!-- <h4 class="dpNone">���������� �Ű�</h4>
				<p class="notify_alert pdt33 pdb33 mgb35">
					���� ������ �������� �������� �����Ͽ� �����ϰ� ������ ���������� Ȯ���ϰ���<br />
					���� �������� ������ �Ű��� ���� �� ó���ϰ� �ֽ��ϴ�.
				</p> -->
				<div class="btnL mgt30 mgl25">
					<a href="javascript:openCBAWindow2();" title="��â����" class="btn_blue_arrowB01 w150"><span>�ۿø��� </span></a>
					<a href="javascript:openCBAWindow3();" title="��â����" class="btn_green_arrowB01 w150"><span>�Ű�������ȸ</span></a>
				</div>
				<p style="margin:10px;"><br></p>
				
				<h3>�ε��� ���� ���� �ҹ����� �Ű� ����</h3>
				<h5 class="title_arrow_green01 mgb15">��������</h5>
				<ul class="list_dot_sky mgl25 mgb35">
				<li>������ : ���� ������</li>
				<li>������� : ���� ������</li>
				<li>
					�������� : �ε��� ���� ���� �ҹ� �� �δ� ���� ��
				</li>
				</ul>
					
				<div class="plus">
				<div class="boxGray mgb40 mgl25" style="border:1px solid #ccc;line-height:1.8;">
				<span style="font-weight:bold;font-size:20px;">��  �ҹ����� �����Ű� �ȳ�</span>
				<p style="margin:10px;">���� ������ �� �ε��� ���� ���� �ҹ�, �δ��� ������ <span style="font-weight:bold;">�����Ű�</span>�ϴ� ��� �ش� ���� ���� <br><span style="font-weight:bold;">�������縦 ����</span>
				���ְų� <span style="font-weight:bold;">���·ᰡ �ִ� 50%���� ����</span>�˴ϴ�.</p>
				<ul class="list_dot_sky mgl25">
				<li>�����Ű� �Ⱓ : 2021. 4. 6 ~ 4. 30</li>
				<li>�����Ű� ��� : �ݰ��� �ݼ��� (��1332) �Ǵ� �����߾�ȸ Ȩ������ '�ε������� ���� �ҹ����� �Ű� ����'</li>
				</ul>
				<p style="margin:10px;">�� �����Ű��Ⱓ ���� ���� �ε��� ���� ���� �ҹ�, �δ��� ������ Ȯ�εǴ� ��쿡��<br>    ����ó��, ���·� �� ���ɻ� ��Ģ�� ������ �����.</p>
				</div>
				</div>
				
								
				<!-- <h5 class="title_arrow_green01 mgb15">�Ű�����</h5>
				<ul class="list_dot_sky mgl25 mgb35">
				<li>�Ű��� : ���Ѿ���</li>
				<li>�Ű���� : ���� ������</li>
				</ul>
				<h5 class="title_arrow_green01 mgb15">������ ���� ����</h5>
						
				
				<ul class="list_dot_sky mgl25 mgb10">
				<li>��ǰ����ǰ�ǡ����� ���� �䱸 �� ���� ����</li>
				<li>���� ���� �䱸 �� ���� ����</li>
				<li>���� �� �λ� ���� ûŹ ����</li>
				<li>�߼ұ������ ���� ���⳪ Ŀ�̼� �䱸 ����</li>
				<li>�������� �� �ٹ��Ⱝ���� ��</li>
				</ul> -->
				<p class="boxGray mgb40 mgl25">
					���⿡ �Ű��Ǵ� ������ ��ȸ ����ǿ����� ������ �� �����Ƿ� �Ű��� �� �Ű����뿡 ���Ͽ��� ���� ����� ����Ǹ�, ������ ������ ���� ó���� �� ȸ���� �����帳�ϴ�. 
					�Ű� �Ͻ� ������ �Ǹ��� ��Ģ���� �ϹǷ�<br> �� ��ϻ����� ��Ȯ�� �Է��Ͽ� �ֽñ� �ٶ��, �͸������� �ּ��� ��쿡�� ���뿡 ������� �������� �˷��帳�ϴ�.
				</p>
				
				<h5 class="title_arrow_green01 mgb15">����ó</h5>
				<ul class="list_dot_sky mgl25 mgb35">
				<li>�� ȭ (��): �����߾�ȸ ���հ����(02-2240-3459), ���������� �ݼ���(��1332)</li> <!-- 20201211 ����� �ν��ذ��� ��û -->
				</ul>
				
				<div class="btnL mgt30 mgl25">
					<a href="javascript:openCBAWindow2();" title="��â����" class="btn_blue_arrowB01 w150"><span>�ۿø��� </span></a>
					<a href="javascript:openCBAWindow3();" title="��â����" class="btn_green_arrowB01 w150"><span>�Ű�������ȸ</span></a>
				</div>
			</div>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->
</body>
</html>