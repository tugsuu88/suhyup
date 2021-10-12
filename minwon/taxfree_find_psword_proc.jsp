<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />


<%@ include file="../inc/requestSecurity.jsp" %>



<%

	String passwd = "";

	String name = Converter.nullchk(request.getParameter("name"));
// String name = "��ȫ��";

	if(name == null) name="";

	String telephone = Converter.nullchk(request.getParameter("telephone"));
// String telephone = "�޴���";



	String sh_han_1 = Converter.nullchk(request.getParameter("sh_han_1"));

	if(sh_han_1 == null) sh_han_1="";



	String sh_han_2 = Converter.nullchk(request.getParameter("sh_han_2"));

	if(sh_han_2 == null) sh_han_2="";



	String sh_han_3 = Converter.nullchk(request.getParameter("sh_han_3"));

	if(sh_han_3 == null) sh_han_3="";



	String mobile = sh_han_1 + "-" + sh_han_2 + "-" + sh_han_3;

	if(mobile == null) mobile ="";

try {	



	DataSource ds = null;

	Connection conn = null;

	Statement stmt = null;

	ResultSet rs = null;



	Context ic = new InitialContext();

	ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");

	conn = ds.getConnection();

	

	String sql = "";	

	
	
	if(telephone.equals("�޴���")){

	sql  = " SELECT PASSWORD FROM SH_FINANCETROUBLE  ";

	sql += " WHERE NAME = '"+name+"' AND TEL = '"+mobile+"'AND PARCODE = 3";

	}else if(telephone.equals("��ȭ��ȣ")){

		sql  = " SELECT PASSWORD FROM SH_FINANCETROUBLE  ";

	sql += " WHERE NAME = '"+name+"' AND TEL1 = '"+mobile+"'AND PARCODE = 3";

	}
	





	stmt=conn.createStatement();

	rs = stmt.executeQuery(sql);

	

	if(rs.next()){

		passwd = rs.getString("PASSWORD");

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
									passwd = aes.aesDecode(passwd); 
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