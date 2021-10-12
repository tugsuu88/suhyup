<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<%@ page import="oracle.jdbc.driver.OracleResultSet" %>
<%@ page import="oracle.sql.CLOB" %>
<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>

<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="/inc/requestSecurity.jsp" %>

<%

	DataSource ds = null;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	//PreparedStatement pstmt = null;
	int returnUpdate = 1;

	try{
		
		String vDiscrNo = request.getParameter("vDiscrNo");
// 		String vDiscrNo = "8303181000000";

		String title = "청탁금지법 위반 신고";
		
		//신고자 정보
		String sg_type = Converter.nullchk(request.getParameter("type")); //신고형식
		String sg_name = Converter.nullchk(request.getParameter("sg_name")); //신고자성명
		String sg_job = Converter.nullchk(request.getParameter("sg_job")); //신고자직업
		String sg_tel = ""; //신고자연락처
		if("".equals(Converter.nullchk(request.getParameter("sg_tel1"))) || "".equals(Converter.nullchk(request.getParameter("sg_tel2"))) || "".equals(Converter.nullchk(request.getParameter("sg_tel3"))) ){
			sg_tel = "";
		}else{
			sg_tel = Converter.nullchk(request.getParameter("sg_tel1")) +"-"+ Converter.nullchk(request.getParameter("sg_tel2")) +"-"+ Converter.nullchk(request.getParameter("sg_tel3"));
		}
		
		String sg_zip = ""; //신고자우편번호
		if("".equals(Converter.nullchk(request.getParameter("sg_zip1"))) || "".equals(Converter.nullchk(request.getParameter("sg_zip2"))) ){
			sg_zip = "";
		}else{
			sg_zip = Converter.nullchk(request.getParameter("sg_zip1")) +"-"+ Converter.nullchk(request.getParameter("sg_zip2"));
		}
		
		String sg_addr1 = Converter.nullchk(request.getParameter("sg_addr1")); //신고자주소
		String sg_addr2 = Converter.nullchk(request.getParameter("sg_addr2")); //신고자상세주소
		String sg_pass = Converter.nullchk(request.getParameter("sg_pass")); //신고자비밀번호소
		
		
		//청탁자 정보
		String ct_name = Converter.nullchk(request.getParameter("ct_name")); //청탁자성명(필수)
		String ct_job = Converter.nullchk(request.getParameter("ct_job")); //청탁자직업(필수)
		if(ct_job == null) ct_job = "";
		String ct_tel = ""; //청탁자연락처(필수)
		if("".equals(Converter.nullchk(request.getParameter("ct_tel1"))) || "".equals(Converter.nullchk(request.getParameter("ct_tel2"))) || "".equals(Converter.nullchk(request.getParameter("ct_tel3"))) ){
			ct_tel = "";
		}else{
			ct_tel = Converter.nullchk(request.getParameter("ct_tel1")) +"-"+ Converter.nullchk(request.getParameter("ct_tel1")) +"-"+ Converter.nullchk(request.getParameter("ct_tel1"));
		}
		String ct_zip = ""; //청탁자우편번호(필수)
		if("".equals(Converter.nullchk(request.getParameter("ct_zip1"))) || "".equals(Converter.nullchk(request.getParameter("ct_zip2"))) ){
			ct_zip = "";
		}else{
			ct_zip = Converter.nullchk(request.getParameter("ct_zip1")) +"-"+ Converter.nullchk(request.getParameter("ct_zip2"));
		}
		String ct_addr1 = Converter.nullchk(request.getParameter("ct_addr1")); //청탁자주소(필수)
		String ct_addr2 = Converter.nullchk(request.getParameter("ct_addr2")); //청탁자상세주소(필수)
		String ct_corp = Converter.nullchk(request.getParameter("ct_corp")); //청탁자법인명칭(필수)
		if(ct_corp == null) ct_corp = "";
		String ct_corpaddr = Converter.nullchk(request.getParameter("ct_corpaddr")); //청탁자법인소재지(필수)
		if(ct_corpaddr == null) ct_corpaddr = "";
		String ct_corpname = Converter.nullchk(request.getParameter("ct_corpname")); //청탁자법인대표성명(필수)
		if(ct_corpname == null) ct_corpname = "";
		
		String ct_name_c = Converter.nullchk(request.getParameter("ct_name_c")); //청탁자성명(선택)
		if(ct_name_c == null) ct_name_c = "";
		String ct_job_c = Converter.nullchk(request.getParameter("ct_job_c")); //청탁자직업(선택)
		if(ct_job_c == null) ct_job_c = "";
		
		String ct_tel_c = ""; //청탁자연락처(선택)
		if("".equals(Converter.nullchk(request.getParameter("ct_tel1_c"))) || "".equals(Converter.nullchk(request.getParameter("ct_tel2_c"))) || "".equals(Converter.nullchk(request.getParameter("ct_tel3_c"))) ){
			ct_tel_c = "";
		}else{
			ct_tel_c = Converter.nullchk(request.getParameter("ct_tel1_c")) +"-"+ Converter.nullchk(request.getParameter("ct_tel2_c")) +"-"+ Converter.nullchk(request.getParameter("ct_tel3_c"));
		}
		
		String ct_zip_c = ""; //청탁자우편번호(선택)
		if("".equals(Converter.nullchk(request.getParameter("ct_zip1_c"))) || "".equals(Converter.nullchk(request.getParameter("ct_zip2_c"))) ){
			ct_zip_c = "";
		}else{
			ct_zip_c = Converter.nullchk(request.getParameter("ct_zip1_c")) +"-"+ Converter.nullchk(request.getParameter("ct_zip2_c"));
		}
		
		String ct_addr1_c = Converter.nullchk(request.getParameter("ct_addr1_c")); //청탁자주소(선택)
		if(ct_addr1_c == null) ct_addr1_c = "";
		String ct_addr2_c = Converter.nullchk(request.getParameter("ct_addr2_c")); //청탁자상세주소(선택)
		if(ct_addr2_c == null) ct_addr2_c = "";
		String ct_corp_c = Converter.nullchk(request.getParameter("ct_corp_c")); //청탁자법인명칭(선택)
		if(ct_corp_c == null) ct_corp_c = "";
		String ct_corpaddr_c = Converter.nullchk(request.getParameter("ct_corpaddr_c")); //청탁자법인소재지(선택)
		if(ct_corpaddr_c == null) ct_corpaddr_c = "";
		String ct_corpname_c = Converter.nullchk(request.getParameter("ct_corpname_c")); //청탁자법인대표성명(선택)
		if(ct_corpname_c == null) ct_corpname_c = "";
		
		String ct_date = Converter.nullchk(request.getParameter("ct_date")); //청탁일시
		ct_date = ct_date.replaceAll("'", "\'");
		ct_date = ct_date.replaceAll("&", "&amp;");
		ct_date = ct_date.replaceAll("\'", "&quot;");
		ct_date = ct_date.replaceAll("<", "&lt;");
		ct_date = ct_date.replaceAll(">", "&gt;");
		ct_date = ct_date.replaceAll("-", "");
		String ct_place = Converter.nullchk(request.getParameter("ct_place")); //청탁장소
		ct_place = ct_place.replaceAll("'", "\'");
		ct_place = ct_place.replaceAll("&", "&amp;");
		ct_place = ct_place.replaceAll("\'", "&quot;");
		ct_place = ct_place.replaceAll("<", "&lt;");
		ct_place = ct_place.replaceAll(">", "&gt;");
		ct_place = ct_place.replaceAll("-", "");
		String ct_content = Converter.nullchk(request.getParameter("ct_content")); //청탁내용
		ct_content = ct_content.replaceAll("'", "\'");
		ct_content = ct_content.replaceAll("&", "&amp;");
		ct_content = ct_content.replaceAll("\'", "&quot;");
		ct_content = ct_content.replaceAll("<", "&lt;");
		ct_content = ct_content.replaceAll(">", "&gt;");
		ct_content = ct_content.replaceAll("-", "");
		String ct_reason = Converter.nullchk(request.getParameter("ct_reason")); //청탁신고이유
		ct_reason = ct_reason.replaceAll("'", "\'");
		ct_reason = ct_reason.replaceAll("&", "&amp;");
		ct_reason = ct_reason.replaceAll("\'", "&quot;");
		ct_reason = ct_reason.replaceAll("<", "&lt;");
		ct_reason = ct_reason.replaceAll(">", "&gt;");
		ct_reason = ct_reason.replaceAll("-", "");
		
		String bh_yn = Converter.nullchk(request.getParameter("bh_yn")); //금품반환여부
		if(bh_yn == null) bh_yn = "";
		String bh_place = Converter.nullchk(request.getParameter("bh_place")); //금품반환장소
		if(bh_place == null) bh_place = "";
		String etc = Converter.nullchk(request.getParameter("etc")); //비고
		if(etc == null) etc = "";
// 		String regdate = Converter.nullchk(request.getParameter("regdate")); //최초등록일
// 		f(regdate == null) regdate = "";

		String status = "";
		String buse = "";
		String answer_date = "";
		String answer_contents = "";

		/* System.out.println("sg_name = " + request.getParameter("sg_name"));
		System.out.println("sg_job = " + request.getParameter("sg_job"));
		System.out.println("sg_tel1 = " + request.getParameter("sg_tel1"));
		System.out.println("sg_tel2 = " + request.getParameter("sg_tel2"));
		System.out.println("sg_tel3 = " + request.getParameter("sg_tel3"));
		System.out.println("sg_zip1 = " + request.getParameter("sg_zip1"));
		System.out.println("sg_zip2 = " + request.getParameter("sg_zip2"));
		System.out.println("sg_addr1 = " + request.getParameter("sg_addr1"));
		System.out.println("sg_addr2 = " + request.getParameter("sg_addr2"));
		System.out.println("sg_pass = " + request.getParameter("sg_pass"));
		System.out.println("ct_name = " + request.getParameter("ct_name"));
		System.out.println("ct_job = " + request.getParameter("ct_job"));
		System.out.println("ct_tel1 = " + request.getParameter("ct_tel1"));
		System.out.println("ct_tel2 = " + request.getParameter("ct_tel2"));
		System.out.println("ct_tel3 = " + request.getParameter("ct_tel3"));
		System.out.println("ct_zip1 = " + request.getParameter("ct_zip1"));
		System.out.println("ct_zip2 = " + request.getParameter("ct_zip2"));
		System.out.println("ct_addr1 = " + request.getParameter("ct_addr1"));
		System.out.println("ct_addr2 = " + request.getParameter("ct_addr2"));
		System.out.println("ct_corp = " + request.getParameter("ct_corp"));
		System.out.println("ct_corpaddr = " + request.getParameter("ct_corpaddr"));
		System.out.println("ct_corpname = " + request.getParameter("ct_corpname"));
		System.out.println("ct_name_c = " + request.getParameter("ct_name_c"));
		System.out.println("ct_job_c = " + request.getParameter("ct_job_c"));
		System.out.println("ct_tel1_c = " + request.getParameter("ct_tel1_c"));
		System.out.println("ct_tel2_c = " + request.getParameter("ct_tel2_c"));
		System.out.println("ct_tel3_c = " + request.getParameter("ct_tel3_c"));
		System.out.println("ct_zip1_c = " + request.getParameter("ct_zip1_c"));
		System.out.println("ct_zip2_c = " + request.getParameter("ct_zip2_c"));
		System.out.println("ct_addr1_c = " + request.getParameter("ct_addr1_c"));
		System.out.println("ct_addr2_c = " + request.getParameter("ct_addr2_c"));
		System.out.println("ct_corp_c = " + request.getParameter("ct_corp_c"));
		System.out.println("ct_corpaddr_c = " + request.getParameter("ct_corpaddr_c"));
		System.out.println("ct_corpname_c = " + request.getParameter("ct_corpname_c"));
		System.out.println("ct_date = " + request.getParameter("ct_date"));
		System.out.println("ct_place = " + request.getParameter("ct_place"));
		System.out.println("ct_content = " + request.getParameter("ct_content"));
		System.out.println("ct_reason = " + request.getParameter("ct_reason"));
		System.out.println("bh_yn = " + request.getParameter("bh_yn")); */
		
		
		if(vDiscrNo == null || "".equals(vDiscrNo)){
%>
		<script type="text/javascript">
       		alert("아이핀 인증을 다시 하여 주십시오.");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(sg_type == null || "".equals(sg_type)){
%>
		<script type="text/javascript">
       		alert("신고형식이 등록되지 않았습니다.\n신고형식을 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(sg_name == null || "".equals(sg_name)){
%>
		<script type="text/javascript">
       		alert("신고자 성명이 등록되지 않았습니다.\n신고자 성명을 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(sg_job == null || "".equals(sg_job)){
%>
		<script type="text/javascript">
       		alert("신고자 직업(소속)이 등록되지 않았습니다.\n신고자 직업(소속)을 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(sg_tel == null || "".equals(sg_tel)){
%>
		<script type="text/javascript">
       		alert("신고자 연락처가 등록되지 않았습니다.\n신고자 연락처를 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(sg_zip == null || "".equals(sg_zip)){
%>
		<script type="text/javascript">
       		alert("신고자 우편번호가 등록되지 않았습니다.\n신고자 우편번호를 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(sg_addr1 == null || "".equals(sg_addr1)){
%>
		<script type="text/javascript">
       		alert("신고자 주소가 등록되지 않았습니다.\n신고자 주소를 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(sg_addr2 == null || "".equals(sg_addr2)){
%>
		<script type="text/javascript">
       		alert("신고자 상세주소가 등록되지 않았습니다.\n신고자 상세주소를 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(sg_pass == null || "".equals(sg_pass)){
%>
		<script type="text/javascript">
       		alert("비밀번호가 등록되지 않았습니다.\n비밀번호를 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(ct_name == null || "".equals(ct_name)){
%>
		<script type="text/javascript">
       		alert("청탁자 이름이 등록되지 않았습니다.\n청탁자 이름을 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(ct_zip == null || "".equals(ct_zip)){
%>
		<script type="text/javascript">
       		alert("청탁자 우편번호가 등록되지 않았습니다.\n청탁자 우편번호를 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(ct_addr1 == null || "".equals(ct_addr1)){
%>
		<script type="text/javascript">
       		alert("청탁자 주소가 등록되지 않았습니다.\n청탁자 주소를 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(ct_addr2 == null || "".equals(ct_addr2)){
%>
		<script type="text/javascript">
       		alert("청탁자 상세주소가 등록되지 않았습니다.\n청탁자 상세주소를 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(ct_date == null || "".equals(ct_date)){
%>
		<script type="text/javascript">
       		alert("일시가 등록되지 않았습니다.\n일시를 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(ct_place == null || "".equals(ct_place)){
%>
		<script type="text/javascript">
       		alert("장소가 등록되지 않았습니다.\n장소를 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(ct_content == null || "".equals(ct_content)){
%>
		<script type="text/javascript">
       		alert("내용이 등록되지 않았습니다.\n내용을 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		if(ct_reason == null || "".equals(ct_reason)){
%>
		<script type="text/javascript">
       		alert("신고취지 및 이유가 등록되지 않았습니다.\n신고취지 및 이유를 확인해 주세요");
       		history.back(-1);
		</script>
<%
			return;
		}
		
		String midstr = FrontBoard.OnlyOne("Select nvl(Max(thid),0)+1 from SH_CHUNGTAK");
		
		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		
		String sql = "";
		sql = "insert into sh_chungtak(";
		sql += " thid, type, sg_publication, sg_name, sg_job, sg_tel, sg_zip, sg_addr1, sg_addr2, sg_pass, ";
		sql += " title, ct_name, ct_job, ct_tel, ct_zip, ct_addr1, ct_addr2, ct_corp, ct_corpaddr, ct_corpname, ";
		sql += " ct_name_c, ct_job_c, ct_tel_c, ct_zip_c, ct_addr1_c, ct_addr2_c, ct_corp_c, ct_corpaddr_c, ct_corpname_c, ";
		sql += " ct_date, ct_content, ct_reason, ct_place, ";
		sql += " bh_yn, bh_place, etc, regdate, ";
		sql += " status, buseo, code , result, time, time1, time2, parcode ";
		sql += " ) values ( "+midstr+", '"+sg_type+"', '"+vDiscrNo+"', '"+sg_name+"', '"+sg_job+"', '"+sg_tel+"', '"+sg_zip+"', '"+sg_addr1+"', '"+sg_addr2+"', '"+sg_pass+"',";
		sql += "'"+title+"', '"+ct_name+"', '"+ct_job+"', '"+ct_tel+"', '"+ct_zip+"', '"+ct_addr1+"', '"+ct_addr2+"', '"+ct_corp+"', '"+ct_corpaddr+"', '"+ct_corpname+"', ";
		sql += "'"+ct_name_c+"', '"+ct_job_c+"', '"+ct_tel_c+"', '"+ct_zip_c+"', '"+ct_addr1_c+"', '"+ct_addr2_c+"', '"+ct_corp_c+"', '"+ct_corpaddr_c+"', '"+ct_corpname_c+"', ";
		sql += "'"+ct_date+"', '"+ct_content+"', '"+ct_reason+"', '"+ct_place+"', ";
		sql += "'"+bh_yn+"', '"+bh_place+"', '"+etc+"', sysdate, ";
		sql += "0, '준법감시실', '신청', '', sysdate, sysdate, '' , 6) ";
						
		rs = stmt.executeQuery(sql);
		
	}catch (Exception e){
		if(conn != null){
			conn.rollback();
		}
		returnUpdate = 0;
		System.out.println("# E toString : "+e.toString());
		System.out.println("# E message : "+e.getMessage());
	}finally{
		try{
			/* if(pstmt != null){
				pstmt.close();
			} */
			if(rs != null){
				rs.close();
			}
			if(stmt != null){
				stmt.close();
			}
			if(conn != null){
				conn.close();
			}
		}catch(SQLException e){
			System.out.println("# close Error : SQLException");
		}catch(Exception e){
			System.out.println("# close Error : Exception");
		}
	}
	

	if(returnUpdate == 1){
%>
	<script type="text/javascript">
		alert("등록 되었습니다.");
// 		self.location = "chungtak_write1.jsp";
		self.location = "shingo_006.jsp";
	</script>
<%
	}else if(returnUpdate == 0){
%>
	<script type="text/javascript">
		alert("등록에 실패하였습니다. 다시 등록하여 주세요.");
		self.location = "chungtak_write.jsp";
	</script>
<%
	}
%>
