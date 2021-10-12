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

		String telephone = Converter.nullchk(request.getParameter("telephone"));



		String sh_tel_1 = request.getParameter("sh_tel_1");

		if(sh_tel_1 == null) sh_tel_1="";

		sh_tel_1 = sh_tel_1.replaceAll("'", "");

		sh_tel_1 = sh_tel_1.replaceAll("&", "");

		sh_tel_1 = sh_tel_1.replaceAll("\'", "");

		sh_tel_1 = sh_tel_1.replaceAll("<", "");

		sh_tel_1 = sh_tel_1.replaceAll(">", "");

		sh_tel_1 = sh_tel_1.replaceAll("-", "");

		sh_tel_1 = sh_tel_1.replaceAll("%", "");

		

		String sh_tel_2 = request.getParameter("sh_tel_2");

		if(sh_tel_2 == null) sh_tel_2="";

		sh_tel_2 = sh_tel_2.replaceAll("'", "");

		sh_tel_2 = sh_tel_2.replaceAll("&", "");

		sh_tel_2 = sh_tel_2.replaceAll("\'", "");

		sh_tel_2 = sh_tel_2.replaceAll("<", "");

		sh_tel_2 = sh_tel_2.replaceAll(">", "");

		sh_tel_2 = sh_tel_2.replaceAll("-", "");

		sh_tel_2 = sh_tel_2.replaceAll("%", "");



		String sh_tel_3 = request.getParameter("sh_tel_3");

		if(sh_tel_3 == null) sh_tel_3="";

		sh_tel_3 = sh_tel_3.replaceAll("'", "");

		sh_tel_3 = sh_tel_3.replaceAll("&", "");

		sh_tel_3 = sh_tel_3.replaceAll("\'", "");

		sh_tel_3 = sh_tel_3.replaceAll("<", "");

		sh_tel_3 = sh_tel_3.replaceAll(">", "");

		sh_tel_3 = sh_tel_3.replaceAll("-", "");

		sh_tel_3 = sh_tel_3.replaceAll("%", "");



		String tel ="";

		if(sh_tel_1.equals("")){

			tel =  request.getParameter("tel");

		}

		else{

			tel = sh_tel_1 + "-" + sh_tel_2 + "-" + sh_tel_3;

		}

		

		if(tel == null) tel ="";



		String passwd = request.getParameter("passwd");

		if(passwd == null) passwd="";

		passwd = passwd.replaceAll("'", "");

		passwd = passwd.replaceAll("&", "");

		passwd = passwd.replaceAll("\'", "");

		passwd = passwd.replaceAll("<", "");

		passwd = passwd.replaceAll(">", "");

		passwd = passwd.replaceAll("-", "");

		passwd = passwd.replaceAll("%", "");



		String ListPage = request.getParameter("ListPage");

		//String pageNum = request.getParameter("pageNum");

		String myPage = request.getRequestURI();

	

		int PAGE = 1;

	

	    String TableName = " sh_financetrouble ";

	    String SelectCondition = null;

	    String WhereCondition = null;

	    String OrderCondition = null;

			

		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){

			PAGE = 1;

	    }else{

			PAGE = Integer.parseInt(request.getParameter("PAGE"));

	    }

		        

	    SelectCondition = " thid, name, title, code, to_char(time1, 'YYYY-MM-DD') AS time1 ";

	    OrderCondition  = " ORDER BY thid DESC ";

		

		if(telephone.equals("휴대폰")){

			WhereCondition = " where name = '"+name+"' and tel = '"+tel+"' and parcode = 1";	

		}else if(telephone.equals("전화번호")){

			WhereCondition = " where name = '"+name+"' and tel1 = '"+tel+"' and parcode = 1";	

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

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript">

<!--

	function goView(mid){

		d.mid.value=mid;

		d.action = "../minwon/shingo_view_my.jsp";

		d.submit();

	}



//-->

</SCRIPT>

</head>

<body id="shingo01">

<%@ include file="/include/shHeader.jsp" %>

<!-- start content table-->

<form method=post name="d" action="">

<INPUT TYPE="hidden" NAME="mid" />

<INPUT TYPE="hidden" NAME="telephone" value="<%=telephone%>" />

<table id="contentTable" cellpadding="0" cellspacing="0">

  <tr> 

    <td id="sideContent" valign="top"> 

      <table cellpadding="0" cellspacing="0">

        <tr> 

          <td><img src="../member/images/sc_title_bn_mypage.gif" width="180" height="60" /></td>

        </tr>

        <tr> 

          <td height="10"></td>

        </tr>

        <tr> 

          <td><a href="../member/modify.jsp"><img src="../member/images/sc_bt_off_09.gif" width="190" height="21" border="0" /></a></td>

        </tr>

        <tr> 

          <td><a href="../member/change_pw.jsp"><img src="../member/images/sc_bt_off_10.gif" width="190" height="21" border="0" /></a></td>

        </tr> <tr> 

          <td><a href="../member/delete_main.jsp"><img src="../member/images/sc_bt_off_12.gif" width="190" height="21" border="0" /></a></td>

        </tr>

        <tr> 

          <td height="3"></td>

        </tr>

        <tr> 

          <td><a href="../member/join_list.jsp"><img src="../member/images/sc_bt_off_11.gif" width="190" height="21" border="0" /></a></td>

        </tr>

       

	<tr>

		<td><a href="../minwon/minwon_apply03_my.jsp"><img src="../member/images/sc_bt_on_13.gif" width="190" height="21" /></a></td>

	</tr>

	<tr>

		<td height="3"></td>

	</tr>

	<tr>

		<td><a href="../minwon/minwon_apply03_my.jsp"><img src="../member/images/sc_bt_off_13_01.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td><a href="../minwon/shingo_001_my.jsp"><img src="../member/images/sc_bt_on_13_02.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td><a href="../minwon/taxfree_my.jsp"><img src="../member/images/sc_bt_off_13_03.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td height="3"></td>

	</tr>

   

        

        <tr> 

          <td height="15"></td>

        </tr>

      </table>

    </td>

    <td id="primaryContent" valign="top"> 

      <table cellpadding="0" cellspacing="0">

        <tr> 

          <td><IMG SRC="../images/pc_bg_topline.gif" WIDTH="795" HEIGHT="5" BORDER="0" alt="" /></td>

        </tr>

        <tr> 

          <td style="background:url(../images/pc_middle_line.gif); padding-left:30px;" valign="top"> 

            <table cellpadding="0" cellspacing="0" border="0">

              <tr> 

                <td id="navigator"><a href="/">Home</a> &gt; 마이페이지 > <a href="../minwon/shingo_001_my.jsp">나의민원/신고</a> 

			> 금융사고/금융부조리신고</td>

              </tr>

              <tr> 

                <td id="title"><img src="images/pcTitle050203.gif" /></td>

              </tr>

              <tr> 

                <td height="500" valign="top" id="content"> 

                  <!-- 리스트 시작 -->

                  <table cellpadding="0" cellspacing="0" border="0" class="list">

                    <thead> 

                    <tr> 

                      <td class="number" width="70">번호</td>

                      <td class="subject" width="300">제목</td>

					  <td  class="writer" width="100">처리상태</td>

                      <td  class="writer" width="100">작성자</td>

                      <td class="date" width="80">작성일</td>

                    </tr>

			</thead> <tbody>

	<%

		Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);

	    

		String sh_mid = "";

	    String sh_name = "";

		String sh_date = "";

		String sh_code = ""; 

		

	    if( ResultVector.size() > 0){

			for (int i=0; i < ResultVector.size();i++){

				Hashtable h = (Hashtable)ResultVector.elementAt(i);

	

				String TITLE = (String)h.get("TITLE");	//제목

				if (TITLE.length() > 31){

					TITLE = TITLE.substring(0,31);

					TITLE += "...";

				}



				sh_mid = (String)h.get("THID");

				sh_name = (String)h.get("NAME");

				sh_date = (String)h.get("TIME1");

				sh_code = (String)h.get("CODE");

								

				//int listnum = DefaultListRecord * (PAGE - 1) + i + 1;	 //글번호 계산 

				int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));	//글번호 계산(역순)

			

	%>

					

                    <tr> 

                      <td  class="number" width="70"><%=listnum%></td>

                      <td class="subject" width="300"><a href="javascript:goView('<%=sh_mid%>')"><%=TITLE%></td>

					   <%if(sh_code.equals("반송") || sh_code.equals("이첩")){%>

					  <td  class="writer" width="100">처리중</td>

					  <% } else{ %>

					  <td  class="writer" width="100"><%=sh_code%></td>

					  <% } %>

                      <td  class="writer" width="100"><%=sh_name%></td>

                      <td class="date" width="80"><%=sh_date%></td>

                    </tr>

		 <%

					}

				} else {

			%>

					<tr>

						<td class="no" align="center" colspan="9">등록 자료가 없습니다.</td>

					</tr>

			<% 

				} 

			%>			

                    </tbody> 

                  </table>

                  </td>

              </tr>

            </table>

          </td>

        </tr>

        <tr> 

          <td><IMG SRC="../images/pc_bg_bottomline.gif" WIDTH="795" HEIGHT="4" BORDER="0" alt="" /></td>

        </tr>

        <tr> 

          <td height="20"></td>

        </tr>

      </table>

    </td>

  </tr>

</table>

</form>

<!-- end content table-->

<%@ include file="/include/shFooter.jsp" %>

</body>

</html>