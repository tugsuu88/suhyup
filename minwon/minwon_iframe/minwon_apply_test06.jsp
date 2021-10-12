<%@ page import="java.util.*, util.*" contentType="text/html;charset=euc-kr"%>



<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>

<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>



<%@ include file="../inc/requestSecurity.jsp" %>

<% String pageNum = "5"; %>

<%



		String name = request.getParameter("name");

		if(name == null) name="";

		name = name.replaceAll("'", "");

		name = name.replaceAll("&", "");

		name = name.replaceAll("\'", "");

		name = name.replaceAll("<", "");

		name = name.replaceAll(">", "");

		name = name.replaceAll("-", "");

		name = name.replaceAll("%", "");

		

		String telephone = request.getParameter("telephone");

		if(telephone == null) telephone="";

		telephone = telephone.replaceAll("'", "");

		telephone = telephone.replaceAll("&", "");

		telephone = telephone.replaceAll("\'", "");

		telephone = telephone.replaceAll("<", "");

		telephone = telephone.replaceAll(">", "");

		telephone = telephone.replaceAll("-", "");

		telephone = telephone.replaceAll("%", "");



		String mobile = "";

		String sh_han_1 = request.getParameter("sh_han_1");

		if(sh_han_1 == null) sh_han_1="";

		sh_han_1 = sh_han_1.replaceAll("'", "");

		sh_han_1 = sh_han_1.replaceAll("&", "");

		sh_han_1 = sh_han_1.replaceAll("\'", "");

		sh_han_1 = sh_han_1.replaceAll("<", "");

		sh_han_1 = sh_han_1.replaceAll(">", "");

		sh_han_1 = sh_han_1.replaceAll("-", "");

		sh_han_1 = sh_han_1.replaceAll("%", "");



		String sh_han_2 = request.getParameter("sh_han_2");

		if(sh_han_2 == null) sh_han_2="";

		sh_han_2 = sh_han_2.replaceAll("'", "");

		sh_han_2 = sh_han_2.replaceAll("&", "");

		sh_han_2 = sh_han_2.replaceAll("\'", "");

		sh_han_2 = sh_han_2.replaceAll("<", "");

		sh_han_2 = sh_han_2.replaceAll(">", "");

		sh_han_2 = sh_han_2.replaceAll("-", "");

		sh_han_2 = sh_han_2.replaceAll("%", "");



		String sh_han_3 = request.getParameter("sh_han_3");

		if(sh_han_3 == null) sh_han_3="";

		sh_han_3 = sh_han_3.replaceAll("'", "");

		sh_han_3 = sh_han_3.replaceAll("&", "");

		sh_han_3 = sh_han_3.replaceAll("\'", "");

		sh_han_3 = sh_han_3.replaceAll("<", "");

		sh_han_3 = sh_han_3.replaceAll(">", "");

		sh_han_3 = sh_han_3.replaceAll("-", "");

		sh_han_3 = sh_han_3.replaceAll("%", "");

	

		if(sh_han_1.equals("")){

			mobile =  Converter.nullchk(request.getParameter("mobile"));

		}

		else{

			mobile = sh_han_1 + "-" + sh_han_2 + "-" + sh_han_3;

		}

		

		if(mobile == null) mobile ="";

		

		String passwd = request.getParameter("passwd");

		if(passwd == null) passwd="";

		passwd = passwd.replaceAll("'", "");

		passwd = passwd.replaceAll("&", "");

		passwd = passwd.replaceAll("\'", "");

		passwd = passwd.replaceAll("<", "");

		passwd = passwd.replaceAll(">", "");

		passwd = passwd.replaceAll("-", "");

		passwd = passwd.replaceAll("%", "");

		

		String ListPage = Converter.nullchk(request.getParameter("ListPage"));

		//String pageNum = request.getParameter("pageNum");

		String myPage = request.getRequestURI();

	

		int PAGE = 1;



	    String TableName = " sh_minwon ";

	    String SelectCondition = null;

	    String WhereCondition = null;

	    String OrderCondition = null;

			

		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){

			PAGE = 1;

	    }else{

			PAGE = Integer.parseInt(request.getParameter("PAGE"));

	    }

		        

	    SelectCondition = " mid, name, subject, status,fname, to_char(creation_date, 'YYYY-MM-DD') AS creation_date ";

	    OrderCondition  = " ORDER BY mid DESC ";

		

		if(telephone.equals("휴대폰")){

			WhereCondition = " where name = '"+name+"' and mobile = '"+mobile+"'";	

		}

		else if(telephone.equals("전화번호")){

			WhereCondition = " where name = '"+name+"' and phone = '"+mobile+"'";	

		}

		

		int StartRecord = 0;

		int EndRecord   = 0;

		int DefaultListRecord = 10;

		int DefaultPageBlock = 10;

	        

		int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);

		//out.print("TotalRecordCount : " + TotalRecordCount + "<br/><br/>");

		///////////////////////////////////////////////////////////////////////////



%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>수협 - 바다사랑 고객사랑</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/main.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript">

<!--

	function goView(mid){

		f.mid.value=mid;

		f.action = "minwon_apply_test04.jsp";

		f.submit();

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

</SCRIPT>

</head>

<body id="minwon02">

<!-- start content table-->

<FORM METHOD=POST name="f" ACTION="">

<INPUT TYPE="hidden" NAME="telephone" value="<%=telephone%>" />

<table cellpadding="0" cellspacing="0" border="0">

  <tr>

    <td id="content"><!-- 본문영역 시작 -->

        <table cellpadding="0" cellspacing="0" border="0" class="list">

          <thead>

            <tr>

              <td class="number" align="center">번호</td>

              <td class="subject" align="center">제목</td>

              <td class="file" align="center">처리상태</td>

              <td  class="writer" align="center">작성자</td>

              <td class="file" align="center">파일</td>

              <td class="date" align="center">작성일</td>

            </tr>

          </thead>

          <thead>

          </thead>

          <tbody>

            <%

		Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);

	    

		String sh_mid = "";

	    String sh_name = "";

		String sh_status = "";

		String sh_date = "";

		String fname = "";

		

	    if( ResultVector.size() > 0){

			for (int i=0; i < ResultVector.size();i++){

				Hashtable h = (Hashtable)ResultVector.elementAt(i);

	

				String TITLE = (String)h.get("SUBJECT");	//제목

				if (TITLE.length() > 31){

					TITLE = TITLE.substring(0,31);

					TITLE += "...";

				}

				

				sh_mid = (String)h.get("MID");		

				sh_name = (String)h.get("NAME");

				sh_status = (String)h.get("STATUS");

				sh_date = (String)h.get("CREATION_DATE");

				fname = (String)h.get("FNAME");

								

				//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //글번호 계산 

				int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//글번호 계산(역순)

			

	%>

            <tr>

              <td  class="number" align="center"><%=listnum%></td>

              <td class="subject" align="center"><a href="javascript:goView('<%=sh_mid%>')"><%=TITLE%></td>

              <%if(sh_status.equals("반송") || sh_status.equals("이첩")){%>

              <td class="file" align="center">처리중</td>

              <% } else{ %>

              <td class="file" align="center"><%=sh_status%></td>

              <% } %>

              <td class="writer" align="center"><%=sh_name%></td>

              <%if(fname==null || fname.equals("")){%>

              <td class="file" align="center">&nbsp;</td>

              <%}else{%>

              <td class="file" align="center"><a href="javascript:DownloadPopup('<%=sh_mid%>');"><img src="images/file_icon.gif" border="0" align="absmiddle" /></a></td>

              <%} %>

              <td class="date" align="center"><%=sh_date%></td>

            </tr>

            <%	}

 %>

            <% }else{ %>

            <tr>

              <td>등록된 자료가 없습니다.</td>

            </tr>

            <% } %>

          </tbody>

        </table>

      <!-- 페이지 수 -->

        <table cellpadding="0" cellspacing="0" border="0" class="search">

          <tr>

            <td class="cols01"></td>

          </tr>

        </table>

      <!-- 페이지 수 -->    </td>

  </tr>

</table>

<INPUT TYPE="hidden" NAME="mid" />

</FORM>

<!-- end content table-->

</body>

</html>