<%@ page import="java.util.*, java.text.*, util.*" contentType="text/html;charset=euc-kr"%>





<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>


<jsp:useBean id="FrontDbUtil"  scope="request" class="Bean.Front.Common.FrontDbUtil"/>








<%


	try {


		//


	    // Object define : request.getParameter


	    //


	    String mid = request.getParameter("mid");


	    if (mid == null || mid.equals("")) mid = "";


	    


	


		String TableName2 = " sh_minwon ";


	   	String SelectCondition2 = " mid, sh_fileno, fname ";


		String WhereCondition2  = " where mid =  '" + mid + "'" ;


		String OrderCondition2  = " ORDER BY mid ";


		Vector ResultVector2 = FrontBoard.list(TableName2, SelectCondition2, WhereCondition2, OrderCondition2, 1, 0, 0);


	


%>


	    


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>


<head>


<title>÷������</title>


<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />


<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />


<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />


<style type="text/css">


A:link { text-decoration: none;} 


A:visited { text-decoration: none;}


A:hover { text-decoration:none; color: #104cc6; } 


A:active {text-decoration:none; }


</style>


</head>





<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">


<table width="300" border="0" cellspacing="0" cellpadding="0">


  <tr> 


    <td><img src="images/download_top.gif" alt="÷����������" width="300" height="50" /></td>


  </tr>


  <tr>


    <td><img src="images/download_text.gif" /></td>


  </tr>


  <tr> 


    <td background="images/download_bg.gif" align="center" style="padding:5px 0 5px 0;"> 


      <table width="280" border="0" cellspacing="0" cellpadding="0">


      	<%


      		if( ResultVector2.size() > 0){


				for (int i=0; i < ResultVector2.size(); i++){


					Hashtable h = (Hashtable)ResultVector2.elementAt(i);


		%>


					<tr> 


          				<td width="20" align="center" height="22">
          					<img src="../pub_img/download_arrow.gif" width="2" height="2"  alt=""/>
          				</td>


          				<td align="left">
	          				<a href="../minwon/download.jsp?mid=<%=mid%>&file_no=<%=(String)h.get("SH_FILENO")%>">
	          					<img src="images/file_icon.gif" alt="��������" border="0" align="absmiddle" />&nbsp;<%=(String)h.get("FNAME")%>
	          				</a>
          				</td>


        			</tr>


        			<tr bgcolor="ebebeb"> 


          				<td colspan="2" height="1"></td>


        			</tr>


		<%		


				}


			}


		%>


		<% 


			if( ResultVector2.size() < 5 ){ 


				int rowNum = ResultVector2.size();


				for (int j=rowNum; j < 5; j++){


		%>


					<tr> 


          				<td width="20" align="center" height="22">&nbsp;</td>


          				<td align="left">&nbsp;</td>


        			</tr>


					<tr bgcolor="ebebeb"> 


          				<td colspan="2" height="1"></td>


        			</tr>


		<% 


				} 


			}	


		%>


      </table>


    </td>


  </tr>


  <tr> 


    <td><img src="../pub_img/download_bottom.gif" alt="" width="300" height="10" /></td>


  </tr>


  <tr> 


    <td bgcolor="dfe9f4" height="30" align="right" style="padding-right:10px;"><a href="#" onClick="javascript:window.close();" style="cursor:pointer" ><img src="images/download_close.gif" alt="â�ݱ�" border="0" /></a></td>


  </tr>


</table>


</body>


</html>





<% 


	} catch(Exception e) {


		out.println("../minwon/file_popup.jsp : " + e.getMessage());


	} finally {





	}


%> 