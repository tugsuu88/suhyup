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
   		alert("이름이 등록되지 않았습니다.\n이름을 확인해 주세요");
   		history.back(-1);
	</script>
<%
		return;
	}

	String sg_tel1 = Converter.nullchk(request.getParameter("sg_tel1"));
	if(sg_tel1 == null || "".equals(sg_tel1)){
%>
	<script type="text/javascript">
   		alert("연락처 첫번째자리를 입력해 주세요.");
   		history.back(-1);
	</script>
<%
		return;
	}

	String sg_tel2 = Converter.nullchk(request.getParameter("sg_tel2"));
	if(sg_tel2 == null || "".equals(sg_tel2)){
%>
	<script type="text/javascript">
   		alert("번호 중간자리를 입력해 주세요.");
   		history.back(-1);
	</script>
<%
		return;
	}

	String sg_tel3 = Converter.nullchk(request.getParameter("sg_tel3"));
	if(sg_tel3 == null || "".equals(sg_tel3)){
%>
	<script type="text/javascript">
   		alert("번호 마지막자리를 입력해 주세요.");
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
	<title>비밀번호 찾기 &gt; 수협</title>
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
		<h1 class="dpNone">수협</h1>
		<h2><span>비밀번호 찾기</span></h2>
		<div class="innerBox">
			<p class="mgb25">* 고객님의 비밀번호는 다음과 같습니다.</p>
			<table class="write mgb10" summary="비밀번호 공개">
				<caption>비밀번호 공개</caption>
				<colgroup>
					<col style="width:25%;" />
					<col style="width:auto;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">비밀번호</th>
						<td>
							<% 
								if(passwd != null && !passwd.equals("")) { 
									String tmp = "";
									
									tmp = passwd.substring(0,passwd.length()-2);
							%>
								<%=tmp %>**
							<% } else {%>
								일치하는 정보가 없습니다.
							<% } %>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btnCenter">
			<a href="javascript:self.close();" class="btn_blue_s01"><span>확인</span></a>
			<!-- <a href="#" class="btn_dGray_s01"><span>취소</span></a> -->
		</div>
	</div>

</form>

</body>
</html>