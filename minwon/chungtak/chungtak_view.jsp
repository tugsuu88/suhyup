<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="/inc/requestSecurity.jsp" %>

<% String pageNum = "5"; %>

<%

	String mid = request.getParameter("mid");

	if(mid == null) mid="0";
	int sh_mid = Integer.parseInt(mid);

	String telephone = Converter.nullchk(request.getParameter("telephone"));
	String name = "";
	String subject = "";
	String content = "";
// 	String email = "";
	String tel = "";
	String passwd = "";
	String addr = "";
	String addr2 = "";
	String answer = "";
	String address = "";
// 	String time1 = "";
	String time2 = "";
	String abandon_date = "";
	String code = "";
	
	String atTxt = "";
	
// 	sql = " select seq, sg_name, code, sh_tel, sg_pass, ct_date, ct_place, ct_content, ct_reason, sg_addr1, sg_addr2, 

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
		
		sql = " select thid, sg_name, code, sg_tel, sg_pass, ct_date, ct_place, ct_content, title, text1, sg_addr1, sg_addr2, to_char(time2, 'YYYY-MM-DD') AS time2, to_char(abandon_date, 'YYYY-MM-DD') AS abandon_date from sh_chungtak " ;
		sql += " where thid = '"+mid+"'";

		stmt=conn.createStatement();

		rs = stmt.executeQuery(sql);



		if(rs.next()){

			name = rs.getString("SG_NAME");
			if(name == null) name="";

			subject = rs.getString("TITLE");
// 			subject = "ûŹ������ ���� �Ű�";
			if(subject == null) subject="";
			
			code = rs.getString("CODE");
			if(code == null) code="";
			
			atTxt = ("öȸ�Ϸ�".equals(code)?"öȸ�� �Ϸ�� ������ öȸ �Ͻ� �� �����ϴ�.":"�亯�� �Ϸ�� ������ öȸ�� �� �� �����ϴ�.");
			
			content = rs.getString("CT_CONTENT");
			if(content == null) content="";
			
			tel = rs.getString("SG_TEL");
			if(tel == null) tel="";

			addr = rs.getString("SG_ADDR1");
			if(addr == null) addr="";
			
			addr2 = rs.getString("SG_ADDR2");
			if(addr2 == null) addr2="";
			
			address = addr +"&nbsp;"+ addr2;

// 			time1 = rs.getString("TIME1");
// 			if(time1 == null) time1="";

			time2 = rs.getString("TIME2");
			if(time2 == null) time2="";

			abandon_date = rs.getString("ABANDON_DATE");
			if(abandon_date == null) abandon_date="";

			passwd = rs.getString("SG_PASS");
			if(passwd == null) passwd="";

			answer = rs.getString("TEXT1");
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
	<title>ûŹ������ ���� �Ű� &gt; �Ű��� &gt; ������ &gt; ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	<script type="text/javascript" src="/js/quickMenu.js"></script>

	<script type="text/javascript">
	<!--
	
		function goReg(){
			//alert(f.phone.value);
			f.action = "chungtak_list.jsp";
			f.submit();
		}
	
		function goCode(){
			if(f.answer.value == null || f.answer.value == ""){
				if (confirm("öȸ�Ͻðڽ��ϱ�?")) {
					f.minwon_type.value="E";
					f.action = "chungtak_code_proc.jsp";
					f.submit();
				} else {
					alert("��ҵǾ����ϴ�.!");
				}
			}else{
				alert('<%=atTxt%>');
			}
		}
	
		function goCancel(){
			if(f.answer.value == null || f.answer.value == ""){
				if (confirm("������ ����Ͻðڽ��ϱ�?")) {
					f.minwon_type.value="C";
					f.action = "chungtak_code_proc.jsp";
					f.submit();
				} else {
					alert("��ҵǾ����ϴ�!");
				}
			}else{
				alert("�亯�� �Ϸ�� ������ ������Ҹ� �� �� �����ϴ�.");
			}
		}
	
	//-->
	
	</script>

</head>

<body id="shingo01">

	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->

<form method="post" name="f" enctype="" action="">

<input type="hidden" name="sg_name" value="<%= name%>" />
<input type="hidden" name="sg_pass" value="<%=passwd%>" />
<input type="hidden" name="sh_mid" value="<%=sh_mid%>" />
<input type="hidden" name="sg_tel" value="<%=tel%>" />
<input type="hidden" name="telephone" value="<%=telephone%>" />
<input type="hidden" name="minwon_type" />
<input type="hidden" name="answer" value="<%= answer %>" />

	<!-- container -->
	<div id="ContentLayer">
	
		<!-- LNB -->
		<%@ include file="/include/lnbService.jsp" %>
		<!-- //LNB -->
		
		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">����</span><span>������</span><span>�Ű���</span>ûŹ������ ���� �Ű� �Ű�</p>
			<h3>ûŹ������ ���� �Ű� �Ű�</h3>
			<h4 class="dpNone">ûŹ��������������</h4>

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
								<dt>�Ű� ����</dt>
								<dd>
									<p><%=content%></p>
								</dd>
							</dl>
							<dl class="a_text mgt30">
								<dt>�亯</dt>
								<dd>
								  <%if(answer == null || answer.equals("")){%>
								  	ó�����Դϴ�.
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