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
// 			subject = "청탁금지법 위반 신고";
			if(subject == null) subject="";
			
			code = rs.getString("CODE");
			if(code == null) code="";
			
			atTxt = ("철회완료".equals(code)?"철회가 완료된 내용은 철회 하실 수 없습니다.":"답변이 완료된 내용은 철회를 할 수 없습니다.");
			
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
	<title>청탁금지법 위반 신고 &gt; 신고센터 &gt; 고객지원 &gt; 수협</title>
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
				if (confirm("철회하시겠습니까?")) {
					f.minwon_type.value="E";
					f.action = "chungtak_code_proc.jsp";
					f.submit();
				} else {
					alert("취소되었습니다.!");
				}
			}else{
				alert('<%=atTxt%>');
			}
		}
	
		function goCancel(){
			if(f.answer.value == null || f.answer.value == ""){
				if (confirm("접수를 취소하시겠습니까?")) {
					f.minwon_type.value="C";
					f.action = "chungtak_code_proc.jsp";
					f.submit();
				} else {
					alert("취소되었습니다!");
				}
			}else{
				alert("답변이 완료된 내용은 접수취소를 할 수 없습니다.");
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
			<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>신고센터</span>청탁금지법 위반 신고 신고</p>
			<h3>청탁금지법 위반 신고 신고</h3>
			<h4 class="dpNone">청탁금지법위반제보</h4>

			<table class="write01" cellpadding="0" cellspacing="0" summary="">
				<caption></caption>
				<colgroup>
					<col width="11%" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>성명</th>
						<td><%=name%></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><%=tel%></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><%=address%></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><%=subject%></td>
					</tr>
					<tr>
						<th>답변일</th>
						<td><%="".equals(time2)? abandon_date : time2%></td>
					</tr>
					<tr>
						<td colspan="2" class="textFrom">
							<dl class="q_text">
								<dt>신고 내용</dt>
								<dd>
									<p><%=content%></p>
								</dd>
							</dl>
							<dl class="a_text mgt30">
								<dt>답변</dt>
								<dd>
								  <%if(answer == null || answer.equals("")){%>
								  	처리중입니다.
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
				<a class="btn_gray_b01" href="javascript:goReg();"><span>목록</span></a>
				<a class="btn_white_b01 mgl10" href="javascript:goCancel();"><span>접수취소</span></a>
				<a class="btn_dGray_b01 mgl10" href="javascript:goCode();"><span>민원철회</span></a>
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