<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="ct_content/html;charset=euc-kr" %>
<%@ page import="oracle.jdbc.driver.OracleResultSet" %>
<%@ page import="oracle.sql.CLOB" %>
<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<%@ include file="/inc/requestSecurity.jsp" %>
<%
	try {	

		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		PreparedStatement pstmt=null;
		String admintel="02-2240-3383";
// 		String vDiscrNo = request.getParameter("vDiscrNo");
		String vDiscrNo = "aaaaaaaaaaaaaa";
		
		System.out.println("register = " + request.getParameter("sg_type"));
		
		
		
		System.out.println("vDiscrNo == " + vDiscrNo);
		System.out.println("sg_type == " + request.getParameter("sg_type"));
		System.out.println("sg_name == " + request.getParameter("sg_name"));
		System.out.println("sg_job == " + request.getParameter("sg_job"));
		System.out.println("sg_tel1 == " + request.getParameter("sg_tel1"));
		System.out.println("sg_tel2 == " + request.getParameter("sg_tel2"));
		System.out.println("sg_tel3 == " + request.getParameter("sg_tel3"));
		System.out.println("sg_addr1 == " + request.getParameter("sg_addr1"));
		System.out.println("sg_addr2 == " + request.getParameter("sg_addr2"));
		System.out.println("sg_zip1 == " + request.getParameter("sg_zip1"));
		System.out.println("sg_zip2 == " + request.getParameter("sg_zip2"));
		System.out.println("sg_pass == " + request.getParameter("sg_pass"));
		System.out.println("ct_name == " + request.getParameter("ct_name"));
		System.out.println("ct_job == " + request.getParameter("ct_job"));
		System.out.println("ct_tel1 == " + request.getParameter("ct_tel1"));
		System.out.println("ct_tel2 == " + request.getParameter("ct_tel2"));
		System.out.println("ct_tel3 == " + request.getParameter("ct_tel3"));
		System.out.println("ct_addr1 == " + request.getParameter("ct_addr1"));
		System.out.println("ct_addr2== " + request.getParameter("ct_addr2"));
		System.out.println("ct_zip1 == " + request.getParameter("ct_zip1"));
		System.out.println("ct_zip2 == " + request.getParameter("ct_zip1"));
		System.out.println("ct_corp == " + request.getParameter("ct_corp"));
		System.out.println("ct_corpaddr == " + request.getParameter("ct_corpaddr"));
		System.out.println("ct_corpname == " + request.getParameter("ct_corpname"));
		System.out.println("ct_date == " + request.getParameter("ct_date"));
		System.out.println("ct_place == " + request.getParameter("ct_place"));
		System.out.println("ct_content == " + request.getParameter("ct_content"));
		

		if (vDiscrNo == null || "".equals(vDiscrNo)){
%>
			<script type="text/javascript">
	       		alert("아이핀 인증을 다시 하여 주십시오.");
	       		history.go(-1);
			</script>
<%
			return;
		}
		
		String sg_type = Converter.nullchk(request.getParameter("sg_type"));
		if (sg_type == null || sg_type.equals("")) sg_type = "";

	    String sg_name = Converter.nullchk(request.getParameter("sg_name"));
		if(sg_name == null || sg_name.equals("")) sg_name = "";
		
		String sg_job = Converter.nullchk(request.getParameter("sg_job"));
		if(sg_job == null || sg_job.equals("")) sg_job = "";
		
		String sg_tel1 = Converter.nullchk(request.getParameter("sg_tel1"));
		if (sg_tel1 == null || sg_tel1.equals("")) sg_tel1 = "";

		String sg_tel2 = Converter.nullchk(request.getParameter("sg_tel2"));
		if (sg_tel2 == null || sg_tel2.equals("")) sg_tel2 = "";

		String sg_tel3 = Converter.nullchk(request.getParameter("sg_tel3"));
		if (sg_tel3 == null || sg_tel3.equals("")) sg_tel3 = "";

		String sg_tel = sg_tel1 + "-" + sg_tel2 + "-" + sg_tel3;
		if (sg_tel == null || sg_tel.equals("")) sg_tel = "";
		
		String sg_addr1 = request.getParameter("sg_addr1");	
		if (sg_addr1 == null || sg_addr1.equals("")) sg_addr1 = "";

		String sg_addr2 = request.getParameter("sg_addr2");
		if (sg_addr2 == null || sg_addr2.equals("")) sg_addr2 = "";
		
		String sg_zip1 = request.getParameter("sg_zip1");	
 		if (sg_zip1 == null || sg_zip1.equals("")) sg_zip1 = "";

		String sg_zip2 = request.getParameter("sg_zip2");	
		if (sg_zip2 == null || sg_zip2.equals("")) sg_zip2 = "";
		
		String sg_zip = sg_zip1 + "-" + sg_zip2;
		if (sg_zip == null || sg_zip.equals("")) sg_zip = "";
		
		String sg_pass = request.getParameter("sg_pass");	
		if (sg_pass == null || sg_pass.equals("")) sg_pass = "";
		
		String ct_name = Converter.nullchk(request.getParameter("ct_name"));
		if(ct_name == null || ct_name.equals("")) ct_name = "";
		
		String ct_job = Converter.nullchk(request.getParameter("ct_job"));
		if(ct_job == null || ct_job.equals("")) ct_job = "";
		
		String ct_tel1 = Converter.nullchk(request.getParameter("ct_tel1"));
		if (ct_tel1 == null || ct_tel1.equals("")) ct_tel1 = "";

		String ct_tel2 = Converter.nullchk(request.getParameter("ct_tel2"));
		if (ct_tel2 == null || ct_tel2.equals("")) ct_tel2 = "";

		String ct_tel3 = Converter.nullchk(request.getParameter("ct_tel3"));
		if (ct_tel3 == null || ct_tel3.equals("")) ct_tel3 = "";

		String ct_tel = ct_tel1 + "-" + ct_tel2 + "-" + ct_tel3;
		if (ct_tel == null || ct_tel.equals("")) ct_tel = "";
		
		String ct_addr1 = request.getParameter("ct_addr1");	
		if (ct_addr1 == null || ct_addr1.equals("")) ct_addr1 = "";

		String ct_addr2 = request.getParameter("ct_addr2");
		if (ct_addr2 == null || ct_addr2.equals("")) ct_addr2 = "";
		
		String ct_zip1 = request.getParameter("ct_zip1");	
 		if (ct_zip1 == null || ct_zip1.equals("")) ct_zip1 = "";

		String ct_zip2 = request.getParameter("ct_zip2");	
		if (ct_zip2 == null || ct_zip2.equals("")) ct_zip2 = "";
		
		String ct_zip = ct_zip1 + "-" + ct_zip2;
		if (ct_zip == null || ct_zip.equals("")) ct_zip = "";
		
		String ct_corp = request.getParameter("ct_corp");	
 		if (ct_corp == null || ct_corp.equals("")) ct_corp = "";

		String ct_corpaddr = request.getParameter("ct_corpaddr");	
		if (ct_corpaddr == null || ct_corpaddr.equals("")) ct_corpaddr = "";
		
		String ct_corpname = request.getParameter("ct_corpname");	
		if (ct_corpname == null || ct_corpname.equals("")) ct_corpname = "";
		
		String ct_date = Converter.nullchk(request.getParameter("ct_date"));
		if(ct_date == null || ct_date.equals("")) ct_date = "";
		
		String ct_place = Converter.nullchk(request.getParameter("ct_place"));
		if(ct_place == null || ct_place.equals("")) ct_place = "";
		
		String ct_content = Converter.nullchk(request.getParameter("ct_content"));//clob
		if(ct_content == null || ct_content.equals("")) ct_content = "";
		
		ct_content = ct_content.replaceAll("'", "\'");
		ct_content = ct_content.replaceAll("&", "&amp;");
		ct_content = ct_content.replaceAll("\'", "&quot;");
		ct_content = ct_content.replaceAll("<", "&lt;");
		ct_content = ct_content.replaceAll(">", "&gt;");
		ct_content = ct_content.replaceAll("-", "");
		
		String ct_reason = Converter.nullchk(request.getParameter("ct_reason"));//clob
		if(ct_reason == null || ct_reason.equals("")) ct_reason = "";
		
		ct_reason = ct_reason.replaceAll("'", "\'");
		ct_reason = ct_reason.replaceAll("&", "&amp;");
		ct_reason = ct_reason.replaceAll("\'", "&quot;");
		ct_reason = ct_reason.replaceAll("<", "&lt;");
		ct_reason = ct_reason.replaceAll(">", "&gt;");
		ct_reason = ct_reason.replaceAll("-", "");
		
		String bh_yn = Converter.nullchk(request.getParameter("bh_yn"));
		if(bh_yn == null || bh_yn.equals("")) bh_yn = "";
		
		String bh_place = Converter.nullchk(request.getParameter("bh_place"));//clob
		if(bh_place == null || bh_place.equals("")) bh_place = "";
		
		bh_place = bh_place.replaceAll("'", "\'");
		bh_place = bh_place.replaceAll("&", "&amp;");
		bh_place = bh_place.replaceAll("\'", "&quot;");
		bh_place = bh_place.replaceAll("<", "&lt;");
		bh_place = bh_place.replaceAll(">", "&gt;");
		bh_place = bh_place.replaceAll("-", "");
		
		String etc = Converter.nullchk(request.getParameter("etc"));//clob
		if(etc == null || etc.equals("")) etc = "";
		
		etc = etc.replaceAll("'", "\'");
		etc = etc.replaceAll("&", "&amp;");
		etc = etc.replaceAll("\'", "&quot;");
		etc = etc.replaceAll("<", "&lt;");
		etc = etc.replaceAll(">", "&gt;");
		etc = etc.replaceAll("-", "");

		String seq = FrontBoard.OnlyOne("Select Max(seq) from sh_chungtak");

		int intSeq = Integer.parseInt(seq) + 1;
		
		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();
		String sql = "";	
		
		sql += "insert into sh_chungtak("+
				"sg_type,sg_name, sg_job, sg_tel, sg_addr1, sg_addr2, sg_zip1, sg_zip2, sg_zip, sg_pass" +
				"ct_name, ct_job, ct_tel, ct_addr1, ct_addr2, ct_zip, ct_corp, ct_corpaddr, ct_corpname, ct_date, ct_place, ct_content" +
				") values (" +
				"?,?,?,?,?,?,?,?,?,?" +
				",?,?,?,?,?,?,?,?,?,sysdate,?,?" +
				")";
		/* 
		sql  = " insert into sh_financetrouble( ";
		sql += " parcode,thid,name,replyname,title,publication,branch,tel,tel1,zipcode,addr,"; 
		sql += " addr2,text,text1,hit,time,time1,time2,password,deeps,status,";
		sql += " status1,code,result,buseo,junbuseo, userip";
		sql += " ) values ( ";
		sql += " ?,?,?,?,?,?,?,?,?,?,?,";
		sql += " ?,?,?,?,?,sysdate,?,?,?,?,";
		sql += " ?,?,?,?,?,?";
		sql += " )";
 		*/
		pstmt=conn.prepareStatement(sql);
 		

		pstmt.setInt(1,intSeq);
		pstmt.setString(2,sg_type);
		pstmt.setString(3,sg_name);
		pstmt.setString(4,sg_job);
		pstmt.setString(5,sg_tel);
		pstmt.setString(6,sg_addr1);
		pstmt.setString(7,sg_addr2);
		pstmt.setString(8,sg_zip1);
		pstmt.setString(9,sg_zip2);
		pstmt.setString(10,sg_zip);
		pstmt.setString(11,sg_pass);
		pstmt.setString(12,ct_name);
		pstmt.setString(13,ct_job);
		pstmt.setString(14,ct_tel);
		pstmt.setString(15,ct_addr1);
		pstmt.setString(16,ct_addr2);
		pstmt.setString(17,ct_zip);
		pstmt.setString(18,ct_corp);
		pstmt.setString(19,ct_corpaddr);
		pstmt.setString(20,ct_corpname);
		pstmt.setString(21,ct_date);
		pstmt.setString(22,ct_place);
		pstmt.setString(23,ct_content);
		
 		/* 
		pstmt.setInt(1,1);
		pstmt.setInt(2,intSeq);
		pstmt.setString(3,name);
		pstmt.setString(4,"");
		pstmt.setString(5,title);
		pstmt.setString(6,vDiscrNo);
		pstmt.setString(7,email);
		pstmt.setString(8,tel);
		pstmt.setString(9,tel);
		pstmt.setString(10,zipcode);
		pstmt.setString(11,addr);
		pstmt.setString(12,addr2);
		pstmt.setString(13,text);
		pstmt.setString(14,"");
		pstmt.setInt(15,0);
		pstmt.setString(16,"");	
		pstmt.setString(17,"");
		pstmt.setString(18,password);
		pstmt.setInt(19,0);
		pstmt.setInt(20,0);
		pstmt.setString(21,"");
		pstmt.setString(22,"신청");
		pstmt.setString(23,"");
		pstmt.setString(24,"감사실");
		pstmt.setString(25,"");
		pstmt.setString(26,sUserIp);
 		*/
		pstmt.executeUpdate();
 		

 		/* 
		sql = " update sh_financetrouble set text = empty_clob() where thid = " + thid;

		pstmt = conn.prepareStatement(sql);

		pstmt.executeUpdate();

		sql = " select text from sh_financetrouble where thid = " + thid +" for update ";

		pstmt = conn.prepareStatement(sql);

//		pstmt.executeUpdate();		
 		*/
 		
		rs = pstmt.executeQuery();
		

 		/* 
		while (rs.next()){

			CLOB clob = ((OracleResultSet)rs).getCLOB(1);
	    	Board.writeClob( clob ,text);
		}
		 */
		
		pstmt.close();
		conn.close();

	}catch (Exception e){
		out.println(e.toString());
	}
%>
      <script type="text/javascript">
      	<!--
     	//document.location.href = "cal.jsp";
		alert("등록 되었습니다.");	
		self.location = "shingo_001.jsp";
      	//-->
      </script>