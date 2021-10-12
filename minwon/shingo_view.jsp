<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>



<%@ page import="board.board2.DataFileInfo" %>

<%@ page import="com.oreilly.servlet.*" %>

<%@ page import="com.oreilly.servlet.multipart.*" %>



<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>



<%@ include file="../inc/requestSecurity.jsp" %>

<% String pageNum = "5"; %>

<%



	String mid = request.getParameter("mid");

	if(mid == null) mid="0";

	int sh_mid = Integer.parseInt(mid);



	String telephone = Converter.nullchk(request.getParameter("telephone"));



	String name = "";

	String subject = "";

	String content = "";

	String email = "";

	String tel = "";

	String passwd = "";

	String addr = "";

	String addr2 = "";

	String answer = "";

	String address = "";

	String time1 = "";

	String time2 = "";

	String abandon_date = "";

	String code = "";



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





		sql = " select thid, name, title,code, branch, tel, password, text,text1, addr,addr2, to_char(time1, 'YYYY-MM-DD') AS time1, to_char(time2, 'YYYY-MM-DD') AS time2, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date from sh_financetrouble " ;

		sql += " where thid = '"+mid+"'";



		stmt=conn.createStatement();

		rs = stmt.executeQuery(sql);



		if(rs.next()){

			name = rs.getString("name");

			if(name == null) name="";

			subject = rs.getString("title");

			if(subject == null) subject="";

			code = rs.getString("code");

			if(code == null) code="";

			content = rs.getString("text");

			if(content == null) content="";

			tel = rs.getString("tel");

			if(tel == null) tel="";

			email = rs.getString("branch");

			if(email == null) email="";

			addr = rs.getString("addr");

			if(addr == null) addr="";

			addr2 = rs.getString("addr2");

			if(addr2 == null) addr2="";

			address = addr + addr2;



			time1 = rs.getString("time1");

			if(time1 == null) time1="";

			time2 = rs.getString("time2");

			if(time2 == null) time2="";

			abandon_date = rs.getString("abandon_date");

			if(abandon_date == null) abandon_date="";



			passwd = rs.getString("password");

			if(passwd == null) passwd="";

			answer = rs.getString("text1");

			if(answer == null) answer="";



			StringTokenizer stk = new StringTokenizer(content, "\r\n");

			content="";

			while(stk.hasMoreElements()){

				content += stk.nextToken();

				content += "<br/>";

			}



			StringTokenizer stk1 = new StringTokenizer(answer, "\r\n");

			answer="";

			while(stk1.hasMoreElements()){

				answer += stk1.nextToken();

				answer += "<br/>";

			}

		}



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
	<title>�������/���������� �Ű� &gt; �Ű��� &gt; ������ &gt; ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript">

<!--

	function goReg(){

		//alert(f.phone.value);

		f.action = "shingo_list.jsp";

		f.submit();

	}

	function goEdit(){

		if (confirm("�����Ͻðڽ��ϱ�?")) {

			f.action = "shingo_test_edit.jsp";

			f.submit();

		}

		else {

		alert("��ҵǾ����ϴ�!");

		}

	}

	function goDel(){

		if (confirm("�����Ͻðڽ��ϱ�?")) {

			f.action = "shingo_del_proc.jsp";

			f.submit();

		}

		else {

		alert("��ҵǾ����ϴ�!");

		}

	}

	function goCode(){

		if (confirm("öȸ�Ͻðڽ��ϱ�?")) {

			f.minwon_type.value="E";

			f.action = "shingo_code_proc.jsp";

			f.submit();

		}

		else {

			alert("öȸ�Ǿ����ϴ�!");

		}

	}



	function goCancel(){

		if (confirm("������ ����Ͻðڽ��ϱ�?")) {

			f.minwon_type.value="C";

			f.action = "shingo_code_proc.jsp";

			f.submit();

		}

		else {

			alert("��ҵǾ����ϴ�!");

		}

	}

//-->

</SCRIPT>

</head>

<body id="shingo01">

	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

<form method=get name="f" enctype="" action="">

<input type="hidden" name="name" value="<%=name%>" />

<input type="hidden" name="passwd" value="<%=passwd%>" />

<input type="hidden" name="sh_mid" value="<%=sh_mid%>" />

<input type="hidden" name="tel" value="<%=tel%>">

<INPUT TYPE="hidden" NAME="telephone" value="<%=telephone%>" />

<input type="hidden" name="minwon_type" />

	<!-- container -->
	<div id="ContentLayer">
	
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->
		
		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">����</span><span>������</span><span>�Ű���</span>�������/���������� �Ű�</p>
			<h3>�������/���������� �Ű�</h3>
			<h4 class="dpNone">�����������</h4>

			<table class="write01" cellpadding="0" cellspacing="0" summary="">
				<caption></caption>
				<colgroup>
					<col width="11%" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>����</th>
						<td><%=name%></td>
					</tr>
					<tr>
						<th>�̸���</th>
						<td><%=email%></td>
					</tr>
					<tr>
						<th>����ó</th>
						<td><%=tel%></td>
					</tr>
					<tr>
						<th>�ּ�</th>
						<td><%=address%></td>
					</tr>
					<tr>
						<th>����</th>
						<td><%=subject%></td>
					</tr>
					<tr>
						<th>�亯��</th>
						<td><%="".equals(time2)? abandon_date : time2%></td>
					</tr>
					<tr>
						<td colspan="2" class="textFrom">
							<dl class="q_text">
								<dt>����</dt>
								<dd>
									<p><%=content%></p>
								</dd>
							</dl>
							<dl class="a_text mgt30">
								<dt>�亯</dt>
								<dd>
								  <%if(answer==null || answer.equals("")){%>ó�����Դϴ�.

								  <%}else{%>

								    <%=answer%>

								  <%} %>
								</dd>
							</dl>
							
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btnR mgt30">
				<a class="btn_gray_b01" href="javascript:goReg();"><span>���</span></a>
				<a class="btn_white_b01 mgl10" href="javascript:goCancel();"><span>�������</span></a>
				<a class="btn_dGray_b01 mgl10" href="javascript:goCode();"><span>�ο�öȸ</span></a>
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