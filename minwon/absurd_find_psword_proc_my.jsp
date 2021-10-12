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


	String name = request.getParameter("name");


		if(name == null) name="";


		String telephone = request.getParameter("telephone");





		String sh_han_1 = request.getParameter("sh_han_1");


		if(sh_han_1 == null) sh_han_1="";





		String sh_han_2 = request.getParameter("sh_han_2");


		if(sh_han_2 == null) sh_han_2="";





		String sh_han_3 = request.getParameter("sh_han_3");


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


		if(telephone.equals("휴대폰")){


		sql  = " SELECT PASSWORD FROM SH_FINANCETROUBLE  ";


		sql += " WHERE NAME = '"+name+"' AND TEL = '"+mobile+"'AND PARCODE = 2";


		}else if(telephone.equals("전화번호")){


			sql  = " SELECT PASSWORD FROM SH_FINANCETROUBLE  ";


		sql += " WHERE NAME = '"+name+"' AND TEL1 = '"+mobile+"'AND PARCODE = 2";


		}





 


		stmt=conn.createStatement();


		rs = stmt.executeQuery(sql);


		


		if(rs.next()){


			passwd = rs.getString("PASSWORD");


		}





		rs.close();


		conn.close();		


		


	}catch (Exception e){


		out.println(e.toString());


	}


	/*


	try {	





		DataSource ds = null;


		Connection conn = null;


		ResultSet rs = null;


		ResultSetMetaData meta = null;


		PreparedStatement pstmt=null;





			


		


		





		Context ic = new InitialContext();


		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");


		conn = ds.getConnection();


		String sql = "";	


		





		sql = " SELECT PASSWD FROM FINANCETROUBLE " ;


		sql += " WHERE NAME = '"+name+"' AND TEL = '"+mobile+"'";





		stmt=conn.createStatement();


		rs = stmt.executeQuery(sql);


		if(rs.next()){


			passwd = rs.getString("PASSWD");


		}





		rs.close();


		conn.close();


		


	}


	catch(Exception e){


		out.println(e.toString());


	}


	*/


 %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">


<head>


<title>수협 - 바다사랑 고객사랑</title>


<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />


<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />


<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />


<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />


<body leftmargin="0" topmargin="0">


<form name="pbform" method="post" action="">


<table border="0" cellspacing="0" cellpadding="0" style="width:360px; border:0px solid #E9E9E9; background-color:#FFFFFF;" width="360">


  <tr> 


    <td align="center" style="padding-top:10px;"> 


      <table border="0" cellspacing="0" cellpadding="0">


        <tr> 


          <td align="center"><img src="images/minwon_passtop.gif" width="345" height="63" /></td>


        </tr>


        <tr> 


          <td align="left" height="50" style="padding-left:15px;"><b>고객님의 비밀번호는 다음과같습니다.</b></td>


        </tr>


      </table>


      <table cellspacing="0" style="width:345px; background:url(images/minwon_passbdtop.gif) no-repeat; ">


        <thead> 


		<tr> 


          <th style="width:100px; height:32px;" >비밀번호</th>


          <td style="padding-left:10px;" align="left">				


					<% 


						if(passwd != null && !passwd.equals("")) { 


							String tmp = "";


							passwd= aes.aesDecode(passwd);


							tmp = passwd.substring(0,passwd.length()-2);


					%>


						<%=tmp %>**


					<% } else {%>


						일치하는 정보가 없습니다.


					<% } %></td>


  		</tr>


		</thead> 


		<tbody> 


       </table>


      <table cellspacing="0" style="width:357px;">


        <tr> 


          <td align="center" style="margin-top:10px;" height="50"> <a href="javascript:self.close();"><img src="../pub_img/btT01Confirm.gif" title="확인" /></td>


        </tr>


      </table>


    </td>


  </tr>


</table>


</body>


</html>


