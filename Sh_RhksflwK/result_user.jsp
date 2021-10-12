<%@ page import="java.util.*, java.text.*, util.*" contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>

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
<script language="javascript" src="../js/common.js"></script>
<script language="javascript">
<!--




	//첨부파일 팝업 2008-02-22
	function DownloadPopup(sh_no){
		pbform.sh_no.value=sh_no;
		var wint = (screen.height - 245) / 2;
		var winl = (screen.width - 300) / 2;
		winprops = 'height=245,width=300,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'
		winurl = 'include/file_popup.jsp?sh_no='+sh_no;
		win = window.open(winurl, "file_popup", winprops)
	}

//-->
</script>
<link rel='stylesheet' type='text/css' media='all' href='../Sh_RhksflwK/style.css' />
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<form method=post action="" name="pbform" enctype="" >
<input type="hidden" name="sa_name" value="<%=sa_name%>" >
<!-- // 민원정보담당자관리 설명 -->
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td > 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="5" height="2" class="board_topline"></td>
        </tr>
        <tr height="30"> 
          <td class="board_bg_title" width="60" align="center">번호</td>
          <td class="board_bg_title" align="center" width="550">제목</td>
          <td class="board_bg_title" width="100" align="center">등록자</td>
		  <td class="board_bg_title" width="100" align="center">파일</td>
          <td class="board_bg_title" width="100" align="center">등록일</td>
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
          <td style="padding-left:10;"><%=sh_content%></td>
          <td align="center"><%=sh_name%></td>
          <td align="center"><a href="javascript:DownloadPopup('<%=sh_no%>');"><img src="img/file_icon.gif" border="0" align="absmiddle"></a></td>
          <td align="center"><%=sh_indate%></td>
        </tr>
		<%	} %>
	<%	} %>
        <tr> 
          <td colspan="5" class="board_line2" height="1"></td>
        </tr>
      </table>
     
           <!-- 페이지 넘버링 -->
      <table width="945" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align="center">
          	<% if(TotalRecordCount > 0) { %>
			<%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, "result_user.jsp.jsp?KEY="+KEY+"&cmd=" + cmd + "&sh_name=" + sh_name + "&sh_content=" + sh_content + "&sh_file_name=" + sh_file_name + "&PAGE=","<img src=../Sh_RhksflwK/img/board_prev.gif width=13 height=13 align=absmiddle border=0>","<img src=../Sh_RhksflwK/img/board_next.gif width=13 height=13 align=absmiddle border=0>")%>
			<% } %>
          </td>
        </tr>



      </table>
      <!-- 페이지 넘버링 -->
    </td>
  </tr>
</table>
<input type="hidden" name="cmd">
<input type="hidden" name="thid">
<input type="hidden" name="PAGE">
<input type="hidden" name="sh_no" value="<%=sh_no%>">
</form>

