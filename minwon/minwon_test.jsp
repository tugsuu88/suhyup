<% String pageNum = "5"; %>

<%@ page import="java.util.*, java.text.*, util.*" contentType="text/html;charset=euc-kr" %>



<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>

<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>





<%

		String TableName = " sh_minwon_result ";

	    String SelectCondition = null;

	    String OrderCondition = null;

		

		int PAGE = 1;				



		if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){

			PAGE = 1;

	    }else{

			PAGE = Integer.parseInt(request.getParameter("PAGE"));

	    }

		String midstr=FrontBoard.OnlyOne("Select Max(sh_no) from sh_minwon_admin");



		SelectCondition = " sh_no, sh_name, sh_content, sh_file_name, to_char(sh_indate, 'YYYY-MM-DD') AS sh_indate ";

	    OrderCondition  = " ORDER BY sh_no ";

					

		int StartRecord = 0;

		int EndRecord   = 0;

		int DefaultListRecord = 10;

		int DefaultPageBlock = 10;

	        

		int TotalRecordCount = FrontBoard.TotalCount(TableName, "");

%>



<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">



<head>

<title>수협 - 바다사랑 고객사랑</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript">

<!--

	function DownloadPopup(sh_no){

		pbform.sh_no.value=sh_no;

		var wint = (screen.height - 245) / 2;

		var winl = (screen.width - 300) / 2;

		winprops = 'height=245,width=300,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = '../minwonadmin/include/file_popup.jsp?sh_no='+sh_no;

		win = window.open(winurl, "file_popup", winprops)

	}





//-->

</script>



</head>



<body>



<%@ include file="/include/shHeader.jsp" %>

<!-- start content table-->

<form method=post action="" name="pbform" enctype="" >



<table width="100%" border="0" cellspacing="0" cellpadding="0">

  <tr> 

    <td height="95" bgcolor="f4f4f4"  style="padding-left:25;"> 

      <table width="945" border="0" cellspacing="0" cellpadding="0" background="../minwonadmin/img/title_bg.gif">

        <tr> 

          <td width="135"> 

            <table width="135" border="0" cellspacing="0" cellpadding="0">

              <tr> 

                <td height="70" align="center" class="admin_subject">민원처리결과 

공시</td>

              </tr>

            </table>

          </td>

          <td width="5"></td>

          <td> 

            <table width="100%" border="0" cellspacing="0" cellpadding="0">

              <tr> 

                <td height="60" class="adminsub_subject" style="padding-left:25;">반기(상반기/하반기) 단위의 민원처리결과 공시입니다.</td>

              </tr>

            </table>

          </td>

        </tr>

      </table>

    </td>

  </tr>

</table>

<br/>

<table width="100%" border="0" cellspacing="0" cellpadding="0">



  <tr> 

  

    <td style="padding-left:25;"><img src="../minwonadmin/img/arrow.gif" width="13" height="16" align="absmiddle" /> 

      <span class="txt_title">민원처리결과 공시내역</span></td>

  </tr>

  <tr> 

    <td style="padding:10 0 0 25;"> 

      <table width="945" border="0" cellspacing="0" cellpadding="0">

        <tr> 

          <td colspan="6" height="2" class="board_topline"></td>

        </tr>

        <tr height="30"> 

          <td class="board_bg_title" width="60" align="center">번호</td>

          <td class="board_bg_title" align="center" width="550">제목</td>

          <td class="board_bg_title" width="100" align="center">등록자</td>

		  <td class="board_bg_title" width="100" align="center">파일</td>

          <td class="board_bg_title" width="100" align="center">등록일</td>

          <td class="board_bg_title" width="100" align="center">삭제</td>

        </tr>

        <tr> 

          <td colspan="6" height="1" class="board_line"></td>

        </tr>

	<%

		Vector ResultVector = FrontBoard.list(TableName, SelectCondition, "", OrderCondition, PAGE, 0, DefaultListRecord);

	    

		String sh_no = "";

	    String sh_content = "";

		String sh_name = "";

		String sh_file_name = "";

		String sh_indate = "";

		

		if( ResultVector.size() > 0){

			for (int i=0; i < ResultVector.size();i++){

				

				Hashtable h = (Hashtable)ResultVector.elementAt(i);



				sh_no = (String)h.get("SH_NO");		

				sh_name = (String)h.get("SH_NAME");		

				sh_content = (String)h.get("SH_CONTENT");		

				sh_file_name = (String)h.get("SH_FILE_NAME");		

				sh_indate = (String)h.get("SH_INDATE");

				

				int listnum = (TotalRecordCount) - (i + (DefaultListRecord * (PAGE - 1)));

											

	%>

        <tr height="30" onMouseOver=this.style.backgroundColor='F4F4F4' onMouseOut=this.style.backgroundColor='ffffff'>  

          <td align="center"><%=listnum%></td>

          <td style="padding-left:10;"><%=sh_content%></a></td>

          <td align="center"><%=sh_name%></td>

          <td align="center"><a href="javascript:DownloadPopup('<%=sh_no%>');"><img src="../minwonadmin/img/file_icon.gif" border="0" align="absmiddle" /></a></td>

          <td align="center"><%=sh_indate%></td>

        </tr>

		<%	} %>

	<%	} %>

        <tr> 

          <td colspan="5" class="board_line2" height="1"></td>

        </tr>

      </table>

      <!-- // 부서별 관리자 -->

      <p>&nbsp;</p>

    </td>

  </tr>

</table>



<input type="hidden" name="sh_no" value="<%=sh_no%>">

</form>

<!-- end content table-->

<%@ include file="/include/shFooter.jsp" %>

</body>

</html>