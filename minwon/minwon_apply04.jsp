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
	
	// 191119 웹 취약점 수정 : 세션에 저장한 인증된 mid값 파라미터랑 비교
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
		out.print("alert('잘못된 접근 입니다.');");
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
			
			/* 20180314추가  관리자가 민원 답변시 업로드한 파일이 저장된 컬럼 이름 */
			sh_file_name = rs.getString("sh_file_name");
			if(sh_file_name == null) sh_file_name="";
			
			bupin = rs.getString("bupin");
			if(bupin == null) bupin="";
			
// 			bupinNm = ("1".equals(rs.getString("bupin"))?"수협중앙회-회원조합-자회사":"수협은행");
			
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
	<title>민원 내용 확인 &gt; 민원처리결과 조회 &gt; 전자민원창구 &gt; 고객지원 &gt; 수협</title>
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
		
		if (confirm("철회하시겠습니까?")) {
			/* document.f.encoding = "multipart/form-data"; */
			/* f.minwon_type.value = "E"; */
			$('#minwon_type').val('E');
			f.action = "minwon_apply04_proc.jsp";
			f.submit();
		}
	}



	function goCancel(){

		if (confirm("접수를 취소하시겠습니까?")) {

			document.f.encoding = "multipart/form-data";

			f.minwon_type.value = "C";

			f.action = "minwon_apply04_proc.jsp";

			f.submit();

		}

		else {

			alert("취소되었습니다!");

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
	
	/* 20180314추가  관리자가 민원 답변시 업로드한 파일을 다운로드 하기위한 팝업 */
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
			<p class="indicate"><span class="shHome">수협</span><span>고객지원</span><span>전자민원창구</span>민원처리결과조회</p>
			<h3>민원처리결과 조회</h3>
					
			<table class="list02" cellpadding="0" cellspacing="0" summary="민원처리결과 조회의 상세내용을 보여주며 번호, 제목, 처리상태, 작성자, 파일, 작성일, 답변일 순서로 나열되어 있습니다.">
				<caption>민원처리결과 조회 상세내용</caption>
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
						<th id="t01">번호</th>
						<th id="t02">제목</th>
						<th id="t03">처리상태</th>
						<th id="t04">작성자</th>
						<th id="t05">파일</th>
						<th id="t06">작성일</th>
						<th id="t07" class="last">답변일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td headers="t01"><%=mid%></td>
						<td headers="t02">
							<!-- 191119 웹 취약점 수정 -->
							<%=XSSUtil.cleanXSS(subject)%>
						</td>
						<td headers="t03">
						<%if(status.equals("반송") || status.equals("이첩")){%>
							처리중
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
								<img src="/pub_img/icon_file01.gif" alt="파일첨부" />
							</a>
						<%} %>
						</td>
						<td headers="t06"><%=creation_date%></td>
						<td headers="t07">
						<%if("철회완료".equals(status)){ %>
							<%=abandon_date%>
						<%}else{ %>
							<%=answer_date%>
						<%} %>
						</td>
					</tr>
					<tr>
						<td colspan="7" class="textFrom">
							<dl class="q_text">
								<dt>질문</dt>
								<dd>
									<ul>
<%-- 										<li>법인 구분 : <%=bupinNm %></li> --%>
										<li>대상영업점 : <%=yongup %></li>
									</ul>
									<p><%=content%></p>
								</dd>
							</dl>
							<dl class="a_text mgt30">
								<dt>답변</dt>
								<dd>
								<%if(answer==null || answer.equals("")){%>
								  처리중입니다.
								<%}else{%>
								    <%=answer%>
								<%} %>
								</dd>
							</dl>
							<dl><!-- 20180314 관리자 답변 파일  -->
							<% if(answer != null && !answer.equals("")) {%>
								<%if(sh_file_name == null && sh_file_name == "") { %>
									<dd></dd>
								<%} else { %>
									<dd>첨부파일 : 
										<a href="javascript:DownloadPopup1('<%=mid%>');">
											<img src="/pub_img/icon_file01.gif" alt="파일첨부" />
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
				<a class="btn_gray_b01" href="javascript:goReg();"><span>확인</span></a>
				<a class="btn_dGray_b01 mgl10" href="javascript:goEdit();"><span>민원철회</span></a>
			</div>
		</div>
		<!-- //contents -->
</form>
<% } else { %>
		<form name="pbform" method="post" enctype="" action="">

			<!-- contents -->
			<div id="primaryContent">
				<p class="indicate">
					<span class="shHome">수협</span><span>고객지원</span><span>전자민원창구</span>민원신청
				</p>
				<h3>민원신청</h3>
				<div class="pdl20 pdr30">
					<div class="mgl15">
						<div class="box_upperNotify mgb40">
							<ul>
								<li><strong>잘못된 액세스</strong><br />이전 페이지로 돌아가려면 뒤로 버튼을 누르십시오</li>
							</ul>
						</div>
					</div>
					<div class="btnR mgt30">
						<a href="javascript:BackToApply3();" class="btn_blue_arrowB01 w150"><span>뒤로</span></a>
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