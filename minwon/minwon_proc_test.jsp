<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>



<%@ page import="board.board2.DataFileInfo" %>

<%@ page import="com.oreilly.servlet.*" %>

<%@ page import="com.oreilly.servlet.multipart.*" %>



<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>

<jsp:useBean id="DataMgr" scope="request" class="board.board2.DataMgr"/>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="../inc/requestSecurity.jsp" %>

<%

	try {



		DataSource ds = null;

		Connection conn = null;

		ResultSet rs = null;

		ResultSetMetaData meta = null;

		PreparedStatement pstmt=null;



		String savePath = application.getRealPath("/upload/minwon"); //폴더 얻기

	 	int sizeLimit = 20 * 1024 * 1024 ; // 5메가까지 제한 넘어서면 예외발생



		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());



		String vDiscrNo = multi.getParameter("vDiscrNo");



	    String name = multi.getParameter("name");

		if(name == null || name.equals("")){

			name = "";

		}
		
		String Month = multi.getParameter("Month");

		if(Month == null) Month = "";
		
		String Year = multi.getParameter("Year");

		if(Year == null) Year = "";
		
		String Day = multi.getParameter("Day");

		if(Day == null) Day = "";
		
		String sh_center  = multi.getParameter("sh_center");

		if(sh_center  == null) sh_center = "";
		
		String self_text = multi.getParameter("self_text");

		if(self_text == null) self_text = "";
		
		
		String admintel="02-2240-3383";

		//out.println(name + "adsasdsda<p>");

		String sh_reply_type = multi.getParameter("sh_reply_type");

		if(sh_reply_type == null) sh_reply_type = "";

		String sh_post_1 = multi.getParameter("sh_post_1");

 		if(sh_post_1 == null) sh_post_1 = "";

		String sh_post_2 = multi.getParameter("sh_post_2");

		if(sh_post_2 == null) sh_post_2 = "";

		String addr = multi.getParameter("sh_address_1");

		if(addr == null) addr = "";

		String addr2 = multi.getParameter("sh_address_2");

		if(addr2 == null) addr2 = "";

		String sh_tel_1 = multi.getParameter("sh_tel_1");

		if(sh_tel_1 == null) sh_tel_1 = "";

		String sh_tel_2 = multi.getParameter("sh_tel_2");

		if(sh_tel_2 == null) sh_tel_2 = "";

		String sh_tel_3 = multi.getParameter("sh_tel_3");

		if(sh_tel_3 == null) sh_tel_3 = "";

		String sh_han_1 = multi.getParameter("sh_han_1");

		if(sh_han_1 == null) sh_han_1 = "";

		String sh_han_2 = multi.getParameter("sh_han_2");

		if(sh_han_2 == null) sh_han_2 = "";

		String sh_han_3 = multi.getParameter("sh_han_3");

		if(sh_han_3 == null) sh_han_3 = "";

		String sh_email_1 = multi.getParameter("sh_email_1");

		if(sh_email_1 == null) sh_email_1 = "";

		String sh_email_2 = multi.getParameter("sh_email_2");

		if(sh_email_2 == null) sh_email_2 = "";

		String category = multi.getParameter("sh_cata");

		if(category == null) category = "";

		String passwd = multi.getParameter("psword");

		if(passwd == null) passwd = "";

		String subject = multi.getParameter("sh_title");

		if(subject == null) subject = "";

		String content = multi.getParameter("contents");

		if(content == null) content = "";
		
		
		
		content = content.replaceAll("'", "\'");

		content = content.replaceAll("&", "&amp;");

		content = content.replaceAll("\'", "&quot;");

		content = content.replaceAll("<", "&lt;");

		content = content.replaceAll(">", "&gt;");

		content = content.replaceAll("-", "");





		String file_no1 = "";

		file_no1 = multi.getParameter("file1");



		String file1 = multi.getFilesystemName("file1");

  		String ofile1 = multi.getOriginalFileName("file1");







		String midstr=FrontBoard.OnlyOne("Select Max(mid) from SH_MINWON");

		int mid = Integer.parseInt(midstr) + 1;



		String midstr1=FrontBoard.OnlyOne("Select Max(sh_fileno) from SH_MINWON");

		if(midstr1 == null || midstr1.equals("")){

			midstr1 = "0";

		}

		int fileno = Integer.parseInt(midstr1) + 1;



		String zipcode = sh_post_1 + "-" + sh_post_2;

		if(zipcode == null) zipcode ="";

		String phone = sh_tel_1 + "-" + sh_tel_2 + "-" + sh_tel_3;

		if(phone == null) phone ="";

		String email = sh_email_1 + "@" + sh_email_2;

		if(email == null) email ="";
		//20140820
		String birthdate = Year + Month + Day;
		
		String mobile = sh_han_1 + "-" + sh_han_2 + "-" + sh_han_3;

		if(mobile == null) mobile ="";
		
		SmsMgr sm=new SmsMgr();

		boolean issms=sm.exqute(admintel,mobile,"귀하께서 제기하신 민원이 접수되어 처리중입니다.");

		

		//2007-12-24 추가

		String[] no_ext = { "asp", "php", "cgi", "sh", "php3", "php4", "html", "htm", "inc", "jsp", "exe", "com", "bat", "htc", "hta" };



 		if(file1 != null && !file1.equals("")){

	 		String ext_1 = file1.substring(file1.lastIndexOf('.') + 1);

	 		ext_1 = ext_1.toLowerCase();

	 		for(int i=0; i<no_ext.length; i++){

	 			if( ext_1.equals(no_ext[i]) ){

	 				out.println("<script language='javascript'>");

					out.print("alert('업로드 금지 파일입니다.\\n\\n확인하여 주시기 바랍니다.');");

					out.println("history.go(-1);");

					out.println("</script>");

					if ( true ) return;

	 			}

	 		}

 		}



		Enumeration  e = multi.getFileNames();

		e.hasMoreElements() ;

		String strName = (String) e.nextElement();

		String fileName = multi.getFilesystemName(strName);

	 	if(fileName == null) fileName ="";



		Context ic = new InitialContext();

		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");

		conn = ds.getConnection();

		String sql = "";

		sql  = " insert into sh_minwon( ";

		sql += " mid,name,zipcode,addr,addr2,phone,email,passwd,category,mailing,subject,content,";

		sql += " answer,rejection,status,fname,faq,buse,minwon_gubun,creation_date,hit,";

		sql += " buse_name,mobile,juminnum,answer_fname,result03,result02,result04,result01,result,sh_fileno,junbuseo,reply_type";
		
		sql += " , birthdate,bupin,yongup";
		
		sql += " ) values ( ";

		sql += " ?,?,?,?,?,?,?,?,?,?,";

		sql += " ?,?,?,?,?,?,?,?,?,sysdate,";

		sql += " ?,?,?,?,?,?,?,?,?,?,?,?,?";
		
		sql += " ,?,?,?";
		
		sql += " )";



		pstmt=conn.prepareStatement(sql);



		pstmt.setInt(1,mid);

		pstmt.setString(2,name);

		pstmt.setString(3,zipcode);

		pstmt.setString(4,addr);

		pstmt.setString(5,addr2);

		pstmt.setString(6,phone);

		pstmt.setString(7,email);

		pstmt.setString(8,passwd);

		pstmt.setString(9,category);

		pstmt.setString(10,"");

		pstmt.setString(11,subject);

		pstmt.setString(12,content);

		pstmt.setString(13,"");

		pstmt.setString(14,"");

		pstmt.setString(15,"신청");

		pstmt.setString(16,fileName);

		pstmt.setString(17,"N");

		pstmt.setString(18,"");

		pstmt.setString(19,"");

		pstmt.setInt(20,0);

		pstmt.setString(21,"감사실");

		pstmt.setString(22,mobile);

		pstmt.setString(23,"");

		pstmt.setString(24,"");

		pstmt.setString(25,"");

		pstmt.setString(26,"");

		pstmt.setString(27,"");

		pstmt.setString(28,"");

		pstmt.setString(29,"");

		pstmt.setInt(30,fileno);

		pstmt.setString(31,"");

		pstmt.setString(32,sh_reply_type);

		pstmt.setString(33,birthdate);
		pstmt.setString(34,sh_center);
		pstmt.setString(35,self_text);
		

		pstmt.executeUpdate();



		pstmt.close();

		conn.close();

	}catch (IOException e){

%>

	<script type="text/javascript">

      	alert("파일제한용량 20MB를 초과하였습니다.");

		history.back();

    </script>

<%

	if(true) return;



	}catch (Exception e){

		out.println(e.toString());

	}

%>

	        <script type="text/javascript">

	        <!--

	        	alert("등록 되었습니다.");

				self.location = "minwon_apply03.jsp";



	        //-->

	        </script>

