<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, util.*" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>���ͽŰ������ȳ� &gt; �Ű����� &gt; �������� &gt; ����</title><!-- 20150216 -->
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
<!--
	window.name ="join_window";
	var CBA_window;

	function openCBAWindow() {
		document.reqCBAForm.retUrl.value = "/minwon/chungtak/chungtak_write.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops);

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}
	function openCBAWindow1() {
		document.reqCBAForm.retUrl.value = "/minwon/chungtak/chungtak_psword.jsp";

		var wint = (screen.height - 450) / 2;
		var winl = (screen.width - 410) / 2;
		winprops = 'height=450,width=410,top='+wint+',left='+winl+',resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0';
		CBA_window = window.open('', "CbaWindow", winprops)

		document.reqCBAForm.action='/member/namecheck.jsp';
		document.reqCBAForm.target='CbaWindow';
		document.reqCBAForm.submit();
	}
//-->
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
			
			<p class="indicate"><span class="shHome">����</span><span>��������</span><span>�Ű�����</span>ûŹ������ ���� �Ű�</p>
			<h3>ûŹ������ ���� �Ű�</h3>
			<div class="pdl20 pdr20">
				<h4 class="title_arrow_green01 mgb15">�Ű����</h4>
				<ul class="list_dot_sky mgl20 mgb10">
					<li>�����߾�ȸ �������� ������ûŹ �� ��ǰ�� ������ ������ ���� �������� ���� ����ûŹ�� �޾Ұų� ���� ����� �˰� �� ���</li>
					<li>�����߾�ȸ �������� ������ûŹ �� ��ǰ�� ������ ������ ���� �������� ���� ����ûŹ�� �޾� �� ������ ������ ����� �˰� �� ���</li>
					<li>�����߾�ȸ �������� ������ûŹ �� ��ǰ�� ������ ������ ���� �������� ���� ���� ���� ��ǰ���� �޾Ұų� ���� ����� �˰� �� ���</li>
					<li>�����߾�ȸ �������� ������ûŹ �� ��ǰ�� ������ ������ ���� �������� ���� �ܺΰ��ǵ ���� �ʰ���ʱ��� �Ű����� �ʾҰų� �Ű����� ���� ����� �˰� �� ��� </li>
					<li>��Ÿ �����߾�ȸ �������� ������ûŹ �� ��ǰ�� ������ ������ ���� �������� ������ ����� �˰� �� ���</li>
				</ul>
				<div class="btnL mgt30 mgl20 mgb40">
					<a href="download_mw.jsp?file_name=shingo_006_poster_01.pdf"  target="_blank"  class="btn_gray_arrowB01 w180" title="ûŹ������ ���� Ȯ�� pdf �ٿ�ε�"><span>ûŹ������ ���� Ȯ��</span></a>
					<a href="download_mw.jsp?file_name=shingo_006_write01.pdf"  target="_blank"  class="btn_gray_arrowB01 w180" title="�Ű���(�����Ű���) hwp �ٿ�ε�"><span>�����Ű��� �Ű���</span></a>
					<a href="download_mw.jsp?file_name=shingo_006_write02.pdf"  target="_blank"  class="btn_gray_arrowB01 w180" title="�Ű���(��3�ڽŰ���) hwp �ٿ�ε�"><span>��3�ڿ� �Ű���</span></a>
				</div>
				<h4 class="title_arrow_green01 mgb15">�Ű� ���� �� ó�� ����</h4>
				<ul class="list_dot_sky mgl20 mgb35">
					<li>�����߾�ȸ�� ������ûŹ �� ��ǰ�� ������ ������ ���� ������ ���ݽŰ��� �����Ǹ� ��� Ȯ�� ������ ���� ���簡 �ʿ��� ��� �����, ������ �Ǵ� �����߾�ȸ�� ��������� �ۺ��ϰ� �� �������� �뺸�޾� �Ű��ڿ��� �˷� �帳�ϴ�.</li>
					<li>���α�������ȸ�¡�����ûŹ �� ��ǰ�� ������ ������ ���� ������ ���ݽŰ��� ���Ͽ� �����߾�ȸ�� �������� ���� ȸ�������� �Ǵ� ����� ���� ���� ������ ���, �Ű��ڿ��� �Ű��� ���� ����� ���� �����մϴ�.</li>
					<li>���α�������ȸ�� ������ûŹ �� ��ǰ�� ������ ������ ���� ���������ݽŰ��� ���Ͽ� �����߾�ȸ�� ���� ������ �������ų� �ս���  ������ ��� �Ǵ� ������ ������ ������ ��� �Ű��ڿ��� ������� ������ �� �ֽ��ϴ�.</li>
					<li>�����߾�ȸ�� �Ű��ڰ� �Ƚ��ϰ� ������ûŹ �� ��ǰ�� ������ ������ ���� �������������� �Ű��� �� �� �ֵ��� �Ű���, ������ � ���� �źк��塤�ź���ȣ����к��� ������ ��ϰ� �ֽ��ϴ�.</li>
				</ul>
				<h4 class="title_arrow_green01 mgb15">�Ű����</h4>
				<ul class="list_dot_sky mgl20 mgb35">
					<li>�������� �����߾�ȸ �������� ������ûŹ �� ��ǰ�� ������ ������ ���� �������� ������ ����� �˰� �� ���� �����߾�ȸ�� �Ű��� �� �ֽ��ϴ�.</li>
					<li>������������ �����湮���������ѽ�����ȭ ������ �Ű��� �� �ֽ��ϴ�.</li>
					<li>�����ȭ : 02-2240-2483</li>
					<li>�����Ű� �Ǵ� �����湮 �Ű� : (05510) ����Ư���� ���ı� ���ݷ� 62 �����߾�ȸ 8�� �ع����ý�</li>
					<li>�ѽ��Ű� : 02-2240-2569 <br />�� �����߾�ȸ�� �Ű��ڰ� ���������� ��û�� ��� ���� �湮�Ͽ� �Ű��� ������ �� �ֽ��ϴ�.</li>
				</ul>
				<div class="btnL mgt30 mgl20 mgb40">
					<a title="��â����" class="btn_blue_arrowB01 w150" href="javascript:openCBAWindow();"><span>�ۿø��� </span></a>
					<a title="��â����" class="btn_green_arrowB01 w150" href="javascript:openCBAWindow1();"><span>�Ű�������ȸ</span></a>
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