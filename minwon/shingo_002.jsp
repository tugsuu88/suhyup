<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, util.*" %>

	//����ĺ��� �ʿ��� ����ũ�� ������

	String member01 = DateTime.getCurrentDateTime();

	//out.println("member01 : " + member01 + "<br/>");

%>

<%

	String pageNum = "5";

	String incPage = request.getParameter("incPage");



	String myPage = request.getRequestURI();

%>
<script type="text/javascript">

<!--

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

//-->

</script>

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
