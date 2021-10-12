<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="/inc/requestSecurity.jsp" %>

<%

	String passwd = "";

	String sg_name = Converter.nullchk(request.getParameter("sg_name"));
	if(sg_name == null || "".equals(sg_name)){
%>
	<script type="text/javascript">
   		alert("�̸��� ��ϵ��� �ʾҽ��ϴ�.\n�̸��� Ȯ���� �ּ���");
   		history.back(-1);
	</script>
<%
		return;
	}

	String sg_tel1 = Converter.nullchk(request.getParameter("sg_tel1"));
	if(sg_tel1 == null || "".equals(sg_tel1)){
%>
	<script type="text/javascript">
   		alert("����ó ù��°�ڸ��� �Է��� �ּ���.");
   		history.back(-1);
	</script>
<%
		return;
	}

	String sg_tel2 = Converter.nullchk(request.getParameter("sg_tel2"));
	if(sg_tel2 == null || "".equals(sg_tel2)){
%>
	<script type="text/javascript">
   		alert("��ȣ �߰��ڸ��� �Է��� �ּ���.");
   		history.back(-1);
	</script>
<%
		return;
	}

	String sg_tel3 = Converter.nullchk(request.getParameter("sg_tel3"));
	if(sg_tel3 == null || "".equals(sg_tel3)){
%>
	<script type="text/javascript">
   		alert("��ȣ �������ڸ��� �Է��� �ּ���.");
   		history.back(-1);
	</script>
<%
		return;
	}

	String sg_tel = sg_tel1 + "-" + sg_tel2 + "-" + sg_tel3;
	
try {	

	DataSource ds = null;

	Connection conn = null;

	Statement stmt = null;

	ResultSet rs = null;



	Context ic = new InitialContext();

	ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");

	conn = ds.getConnection();

	

	String sql = "";
	
	

	sql  = " select sg_pass from sh_chungtak  ";
	sql += " where sg_name = '"+sg_name+"' and sg_tel = '"+sg_tel+"'and parcode = 6";
	System.out.println(sql);
	
	stmt=conn.createStatement();

	rs = stmt.executeQuery(sql);
	
	if(rs.next()){

		passwd = rs.getString("sg_pass");

	}

	rs.close();

	conn.close();		

	

}catch (Exception e){

	System.out.println(e.toString());

}

 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>��й�ȣ ã�� &gt; ����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
</head>

<body>

<form name="pbform" method="post" action="">

	<!-- 400*330 -->
	<div class="wrapPopup">
		<h1 class="dpNone">����</h1>
		<h2><span>��й�ȣ ã��</span></h2>
		<div class="innerBox">
			<p class="mgb25">* ������ ��й�ȣ�� ������ �����ϴ�.</p>
			<table class="write mgb10" summary="��й�ȣ ����">
				<caption>��й�ȣ ����</caption>
				<colgroup>
					<col style="width:25%;" />
					<col style="width:auto;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">��й�ȣ</th>
						<td>
							<% 
								if(passwd != null && !passwd.equals("")) { 
									String tmp = "";
									
									tmp = passwd.substring(0,passwd.length()-2);
							%>
								<%=tmp %>**
							<% } else {%>
								��ġ�ϴ� ������ �����ϴ�.
							<% } %>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btnCenter">
			<a href="javascript:self.close();" class="btn_blue_s01"><span>Ȯ��</span></a>
			<!-- <a href="#" class="btn_dGray_s01"><span>���</span></a> -->
		</div>
	</div>

</form>

</body>
</html>