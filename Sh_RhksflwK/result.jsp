<%@ page import="java.util.*, java.text.*, util.*" contentType="text/html;charset=euc-kr" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<jsp:useBean id="AdminInfo" scope="request" class="board.admin.AdminInfo"/>

<%@ include file="include/admin_session.jsp" %>
<%@ include file="include/logincheck.jsp" %>
<%@ include file="include/top_login.jsp" %>
<%@ include file="include/top_menu03.jsp" %>
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
int DefaultListRecord = 100; //공시내역 출력내용 갯수
int DefaultPageBlock = 100;

int TotalRecordCount = FrontBoard.TotalCount(TableName, "");
%>
<script language="javascript" src="../js/common.js"></script>
<script language="javascript">
    <!--

    //등록
    function GoReg() {

        if(pbform.sh_content.value.length==0){ alert("제목을 입력해 주세요"); return; }

        // 특수문자 체크: + ; ( ) - 는 가능
        var keyword = pbform.sh_content.value;
        //var keyword_sp_char = "~`!@#$%^&*_=|\\<,>.?/{}[]:\"'";
        var keyword_sp_char = "`!@#$%^&*=|\\<,>:\'";
        if(CheckSpecialChar(keyword, keyword_sp_char) == false)
        {
            alert("특수문자(" + keyword_sp_char + ")를 입력하실 수 없습니다.");
            pbform.sh_content.focus();
            return;
        }

        /*var src = getFileExtension(pbform.file1.value);

        if (src == "") {
            alert(src + "파일을 첨부해주세요!");
            return;
        } else if (src != "") {
            if ( !((src.toLowerCase() == "hwp") || (src.toLowerCase() == "ppt") || (src.toLowerCase() == "xls")|| (src.toLowerCase() == "gul")) ) {
                   alert(src + "파일은 첨부 될 수 없습니다!");
                   pbform.file1.focus();
                return;
            }
        }*/

        pbform.action = "result_reg_proc.jsp";
        pbform.encoding="multipart/form-data";
        pbform.submit();
    }


    //파일을 선택 후 포커스 이동시 호출
    function uploadFile_Change( value ){
        var src = getFileExtension(value);
        if (src == "") {
            alert("올바른 파일을 입력하세요");
            return;
        } else if( !((src.toLowerCase() == "hwp") || (src.toLowerCase() == "ppt") || (src.toLowerCase() == "xls")|| (src.toLowerCase() == "gul")) ) {
            alert("hwp 와 ppt, xls, gul 파일만 첨부 가능합니다.");
            //document.form1.afile.value = "";
            //form1.afile.focus();
            return;
        }
    }


    //파일의 확장자를 가져옮
    function getFileExtension( filePath ){
        var lastIndex = -1;
        lastIndex = filePath.lastIndexOf('.');
        var extension = "";

        if ( lastIndex != -1 ){
            extension = filePath.substring( lastIndex+1, filePath.len );
        } else {
            extension = "";
        }
        return extension;
    }

    function goDel(sh_no){
        pbform.sh_no.value=sh_no;
        if (confirm("삭제하시겠습니까?")) {
            pbform.action = "result_del_proc.jsp";
            pbform.submit();
        }
        else {
            alert("취소되었습니다!");
        }
    }

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
<form method=post action="" name="pbform" enctype="" >
    <input type="hidden" name="sa_name" value="<%=sa_name%>" >
    <div class="list-header">
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="admin_subject">민원처리결과 공시</td>
                <td class="adminsub_subject" style="padding-left:25;">반기(상반기/하반기) 단위의 민원처리결과 공시입니다.</td>
            </tr>
        </table>
    </div>
    <!-- // 민원정보담당자관리 설명 -->
    <div class="tbl-wrap">
        <!-- 검색결과 -->
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height="30"><img src="img/result.gif" align="absmiddle"> 검색결과 : <span class="result_text"><%=TotalRecordCount%></span></td>
            </tr>
        </table>
        <!-- // 검색결과 -->
        <table border="0" cellspacing="0" cellpadding="0" class="read_outline">
            <tr>
                <td height="30" style="padding-left:10;" class="table_bg_title">민원처리결과
                    공시자료 등록</td>
            </tr>
            <tr>
                <td valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="30" style="padding-left:10;" class="bluesky" width="135">제목</td>
                            <td height="40">
                                <input type="text" class="input01" size="100" name="sh_content" value="">
                            </td>
                        </tr>
                        <tr>
                            <td height="30" style="padding-left:10;" class="bluesky">첨부파일</td>
                            <td height="50">
                                <input type="file" class="typeText file" size="70" name="file1" value="" onChange="uploadFile_Change( this.value )">
                                <br>
                                첨부파일은 문서형식의 파일(hwp, ppt, xls, gul 등)만 가능합니다. </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="right" height="8"></td>
            </tr>
            <tr>
                <td align="right"><a href="javascript:GoReg();"><img src="img/btn_upload.gif" width="55" height="21" border="0" alt="등록"></td>
            </tr>
        </table>

       
                    <div class="subtit"><img src="img/arrow.gif" width="13" height="16" align="absmiddle"><span class="txt_title">반기별 민원처리결과 공시내역</span></div>
                    <table width="945" border="0" cellspacing="0" cellpadding="0" class="tbl-list">
                        <tr>
                            <td class="board_bg_title" width="60" align="center">번호</td>
                            <td class="board_bg_title" align="center" width="550">제목</td>
                            <td class="board_bg_title" width="100" align="center">등록자</td>
                            <td class="board_bg_title" width="100" align="center">파일</td>
                            <td class="board_bg_title" width="100" align="center">등록일</td>
                            <td class="board_bg_title" width="100" align="center">삭제</td>
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
                            <td align="center">
                                <a href="javascript:DownloadPopup('<%=sh_no%>');">
                                    <img src="img/file_icon.gif" border="0" align="absmiddle">
                                </a>
                            </td>
                            <td align="center"><%=sh_indate%></td>
                            <td align="center"><a href="javascript:goDel('<%=sh_no%>');"><img src="img/btn_delete.gif" width="55" height="21" border="0" alt="삭제"></td>
                        </tr>
                        <%	} %>
                        <%	} %>
                    </table>
                    <!-- // 부서별 관리자 -->
        <input type="hidden" name="sh_no" value="<%=sh_no%>">
    </div>

</form>
<%@ include file="include/bottom.jsp" %>
