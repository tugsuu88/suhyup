<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="text/html;charset=euc-kr" %>

<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />
<%@ include file="../inc/requestSecurity.jsp" %>

<% String pageNum = "5"; %>
<%	
	String mid = request.getParameter("mid");
	if(mid == null) mid="0";
	int sh_mid = Integer.parseInt(mid);
	
	// 191119 �� ����� ���� : ���ǿ� ������ ������ mid�� �Ķ���Ͷ� ��
	boolean isAllow = true;
	String sesMid = (String) session.getAttribute("minwonMids");
	if(sesMid == null || "".equals(sesMid)) {
		isAllow = false;
	} else {
		String compareStr = "," + mid + ",";
		if(!sesMid.contains(compareStr)) {
			isAllow = false;
		}
	}
	/*if(!isAllow) {
		out.println("<script language='javascript'>");
		out.print("alert('�߸��� ���� �Դϴ�.');");
		out.println("window.location.href = '/minwon/minwon_apply03.jsp'");
		out.println("</script>");
	}*/
	String telephone = Converter.nullchk(request.getParameter("telephone"));

	String name = "";
	String subject = "";
	String content = "";
	String bupin ="";
	String bupinNm ="";
	String yongup ="";
	String creation_date = "";
	String answer_date = "";
	String abandon_date = "";
	String status = "";
	String phone = "";
	String passwd = "";
	String answer = "";
	String mobile = "";
	String fname ="";
	String sh_file_name ="";

	try {
		DataSource ds = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		PreparedStatement pstmt=null;

		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();
		String sql = "";

		sql = " select mid, name, subject, status, phone, passwd,mobile, content,answer,fname,sh_file_name, to_char(creation_date, 'YYYY-MM-DD') AS creation_date, to_char(answer_date, 'YYYY-MM-DD') AS answer_date, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date ,bupin,yongup from sh_minwon " ;
		sql += " where mid = '"+mid+"'";
		stmt=conn.createStatement();
		rs = stmt.executeQuery(sql);

		if(rs.next()){
			name = rs.getString("name");
			if(name == null) name="";

			subject = rs.getString("subject");
			if(subject == null) subject="";

			content = rs.getString("content");
			if(content == null) content="";

			answer = rs.getString("answer");
			if(answer == null) answer="";

			creation_date = rs.getString("creation_date");
			if(creation_date == null) creation_date="";

			answer_date = rs.getString("answer_date");
			if(answer_date == null) answer_date="";

			abandon_date = rs.getString("abandon_date");
			if(abandon_date == null) abandon_date="";

			status = rs.getString("status");
			if(status == null) status="";

			phone = rs.getString("phone");
			if(phone == null) phone="";

			passwd = rs.getString("passwd");
			if(passwd == null) passwd="";
			
			mobile = rs.getString("mobile");
			if(mobile == null) mobile="";

			fname = rs.getString("fname");
			if(fname == null) fname="";
			
			/* 20180314�߰�  �����ڰ� �ο� �亯�� ���ε��� ������ ����� �÷� �̸� */
			sh_file_name = rs.getString("sh_file_name");
			if(sh_file_name == null) sh_file_name="";
			
			bupin = rs.getString("bupin");
			if(bupin == null) bupin="";
			
// 			bupinNm = ("1".equals(rs.getString("bupin"))?"�����߾�ȸ-ȸ������-��ȸ��":"��������");
			
			yongup = rs.getString("yongup");
			if(yongup == null) yongup="";

			StringTokenizer stk = new StringTokenizer(content, "\r\n");
			content="";
			while(stk.hasMoreElements()){
				content += stk.nextToken();
				answer = answer.replaceAll("\'", "'");
				answer = answer.replaceAll("&amp;", "&");
				answer = answer.replaceAll("&quot;'", "\'");
				answer = answer.replaceAll("&lt;", "<");
				answer = answer.replaceAll("&gt;", ">");
				answer = answer.replaceAll("\n\r", "<br>");
				content += "<br/>";
			}

			StringTokenizer stk1 = new StringTokenizer(answer, "\r\n");
			
			answer="";
			while(stk1.hasMoreElements()){
				answer += stk1.nextToken();
				
				answer = answer.replaceAll("\'", "'");
				answer = answer.replaceAll("&amp;", "&");
				answer = answer.replaceAll("&quot;'", "\'");
				answer = answer.replaceAll("&lt;", "<");
				answer = answer.replaceAll("&gt;", ">");
				answer = answer.replaceAll("\n\r", "<br>");
				answer += "<br/>";
			}
		}
		
		passwd = aes.aesDecode(passwd);
		rs.close();
		conn.close();
	}

	catch(Exception e){
		out.println(e.toString());
	}

 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>�ο� ���� Ȯ�� &gt; �ο�ó����� ��ȸ &gt; ���ڹο�â�� &gt; ������ &gt; ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/board.css" />
<script type="text/javascript">

<!--

	function goReg(){

		//alert(f.phone.value);

		f.action = "minwon_apply06.jsp";

		f.submit();

	}

	function goEdit(){

		//alert(f.phone.value);
		
		if (confirm("öȸ�Ͻðڽ��ϱ�?")) {
			/* document.f.encoding = "multipart/form-data"; */
			/* f.minwon_type.value = "E"; */
			$('#minwon_type').val('E');
			f.action = "minwon_apply04_proc.jsp";
			f.submit();
		}
	}



	function goCancel(){

		if (confirm("������ ����Ͻðڽ��ϱ�?")) {

			document.f.encoding = "multipart/form-data";

			f.minwon_type.value = "C";

			f.action = "minwon_apply04_proc.jsp";

			f.submit();

		}

		else {

			alert("��ҵǾ����ϴ�!");

		}

	}



	function DownloadPopup(mid){

		f.mid.value=mid;

		var wint = (screen.height - 245) / 2;

		var winl = (screen.width - 300) / 2;

		winprops = 'height=245,width=300,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = 'file_popup.jsp?mid='+mid;

		win = window.open(winurl, "file_popup1", winprops)

	}
	

//-->

	function DownloadPopup1(mid){

		f.mid.value=mid;

		var wint = (screen.height - 245) / 2;

		var winl = (screen.width - 300) / 2;

		winprops = 'height=245,width=300,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = 'file_popup.jsp?mid='+mid;

		win = window.open(winurl, "file_popup1", winprops)

	}
	
	/* 20180314�߰�  �����ڰ� �ο� �亯�� ���ε��� ������ �ٿ�ε� �ϱ����� �˾� */
	function DownloadPopup1(mid){

		f.mid.value=mid;

		var wint = (screen.height - 245) / 2;

		var winl = (screen.width - 300) / 2;

		winprops = 'height=245,width=300,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = '../Sh_RhksflwK/include/file_popup1.jsp?mid='+mid;

		win = window.open(winurl, "file_popup1", winprops)

	}
	function BackToApply3() {
		//window.location.href = '/minwon/minwon_apply03.jsp';
		history.back();
	}
</SCRIPT>

</head>

<body id="minwon02">

	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

	<!-- container -->
	<div id="ContentLayer">
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->

<!-- <form method=get name="f" enctype="" action=""> -->
<% 
//System.out.println("isAllow="+isAllow);
if (isAllow ) { %>
<form method="post" name="f" enctype="" action="">
	<input type="hidden" name="name" value="<%=name%>" />
	<input type="hidden" name="mobile" value="<%=mobile%>" />
	<input type="hidden" name="passwd" value="<%=passwd%>" />
	<input type="hidden" name="sh_mid" value="<%=sh_mid%>" />
	<INPUT TYPE="hidden" NAME="telephone" value="<%=telephone%>" />
	<INPUT TYPE="hidden" NAME="mid" />
	<input type="hidden" id="minwon_type" name="minwon_type" value=""/>

		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">����</span><span>������</span><span>���ڹο�â��</span>�ο�ó�������ȸ</p>
			<h3>�ο�ó����� ��ȸ</h3>
					
			<table class="list02" cellpadding="0" cellspacing="0" summary="�ο�ó����� ��ȸ�� �󼼳����� �����ָ� ��ȣ, ����, ó������, �ۼ���, ����, �ۼ���, �亯�� ������ �����Ǿ� �ֽ��ϴ�.">
				<caption>�ο�ó����� ��ȸ �󼼳���</caption>
				<colgroup>
					<col width="7%" />
					<col width="*" />
					<col width="11%" />
					<col width="11%" />
					<col width="8%" />
					<col width="11%" />
					<col width="11%" />
				</colgroup>
				<thead>
					<tr>
						<th id="t01">��ȣ</th>
						<th id="t02">����</th>
						<th id="t03">ó������</th>
						<th id="t04">�ۼ���</th>
						<th id="t05">����</th>
						<th id="t06">�ۼ���</th>
						<th id="t07" class="last">�亯��</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td headers="t01"><%=mid%></td>
						<td headers="t02">
							<!-- 191119 �� ����� ���� -->
							<%=XSSUtil.cleanXSS(subject)%>
						</td>
						<td headers="t03">
						<%if(status.equals("�ݼ�") || status.equals("��ø")){%>
							ó����
						<% } else{ %>
							<%=status%>
						<% } %>
						</td>
						<td headers="t04"><%=name%></td>
						<td headers="t05">
						<%if(fname==null || fname.equals("")){%>
							&nbsp;
						<%}else{%>
							<a href="javascript:DownloadPopup('<%=mid%>');">
								<img src="/pub_img/icon_file01.gif" alt="����÷��" />
							</a>
						<%} %>
						</td>
						<td headers="t06"><%=creation_date%></td>
						<td headers="t07">
						<%if("öȸ�Ϸ�".equals(status)){ %>
							<%=abandon_date%>
						<%}else{ %>
							<%=answer_date%>
						<%} %>
						</td>
					</tr>
					<tr>
						<td colspan="7" class="textFrom">
							<dl class="q_text">
								<dt>����</dt>
								<dd>
									<ul>
<%-- 										<li>���� ���� : <%=bupinNm %></li> --%>
										<li>��󿵾��� : <%=yongup %></li>
									</ul>
									<p><%=content%></p>
								</dd>
							</dl>
							<dl class="a_text mgt30">
								<dt>�亯</dt>
								<dd>
								<%if(answer==null || answer.equals("")){%>
								  ó�����Դϴ�.
								<%}else{%>
								    <%=answer%>
								<%} %>
								</dd>
							</dl>
							<dl><!-- 20180314 ������ �亯 ����  -->
							<% if(answer != null && !answer.equals("")) {%>
								<%if(sh_file_name == null && sh_file_name == "") { %>
									<dd></dd>
								<%} else { %>
									<dd>÷������ : 
										<a href="javascript:DownloadPopup1('<%=mid%>');">
											<img src="/pub_img/icon_file01.gif" alt="����÷��" />
											<%=sh_file_name %>
										</a>
									</dd>
								<% } %>
							<% } %>	
							</dl>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btnR mgt30">
				<a class="btn_gray_b01" href="javascript:goReg();"><span>Ȯ��</span></a>
				<a class="btn_dGray_b01 mgl10" href="javascript:goEdit();"><span>�ο�öȸ</span></a>
			</div>
		</div>
		<!-- //contents -->
</form>
<% } else { %>
		<form name="pbform" method="post" enctype="" action="">

			<!-- contents -->
			<div id="primaryContent">
				<p class="indicate">
					<span class="shHome">����</span><span>������</span><span>���ڹο�â��</span>�ο���û
				</p>
				<h3>�ο���û</h3>
				<div class="pdl20 pdr30">
					<div class="mgl15">
						<div class="box_upperNotify mgb40">
							<ul>
								<li><strong>�߸��� �׼���</strong><br />���� �������� ���ư����� �ڷ� ��ư�� �����ʽÿ�</li>
							</ul>
						</div>
					</div>
					<div class="btnR mgt30">
						<a href="javascript:BackToApply3();" class="btn_blue_arrowB01 w150"><span>�ڷ�</span></a>
					</div>
				</div>
			</div>
			<!-- //contents -->
		</form>
<% } %>
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->
</body>
</html>