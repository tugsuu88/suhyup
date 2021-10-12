<%
/*****************************************************************************
*Title			: center_minwon_admin_proc.jsp
*@author		: K.H.S
*@date			: 2007-10
*@Description	: 등록 DB처리
*@Copyright		: 
******************************************************************************
*수정일		*수정자		*수정사유
******************************************************************************/
%>

<%@ page import="java.util.*, java.text.*, java.io.*, util.*" contentType="text/html;charset=euc-kr" %>

<%@ page import="board.board3.DataFileInfo" %>

<%@ page import="com.oreilly.servlet.*" %>

<%@ page import="com.oreilly.servlet.multipart.*" %>

<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>


<%@ include file="../inc/requestSecurity.jsp" %>

<!-- 로그인 권한 체크 -->
<%--  
<%@ include file="../inc/authority_check.jsp" %>
 --%>

<%
	try 
	{
		//
    	// Object define : request.getParameter
    	//
    		//lib 폴더 밑에 cos.jar 파일이 필요함



	String savePath = application.getRealPath("/upload/banner"); //폴더 얻기 or /upload/board

	//out.println("savePath : " + savePath + "<br><br>");



 	//int sizeLimit = 5 * 1024 * 1024 ; // 5메가까지 제한 넘어서면 예외발생

 	int sizeLimit = 500 * 1024 * 1024 ; // 20메가까지 제한 넘어서면 예외발생

 	Vector filenames = new Vector();



// 	try {

	 	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy()); 

    	
    	
    	String PAGE = Converter.nullchk(request.getParameter("PAGE"));
		if(PAGE == null || PAGE.equals("")) {
			PAGE = "1";
		}
		String KEY = Converter.nullchk(request.getParameter("KEY"));	//검색어
    	if(KEY != null && !KEY.equals("")) {
    		KEY = StringReplace.sqlFilter(KEY);		//금지어 필터링
    	}
    	//out.println("KEY : " + KEY + "<br>");
    	String FIELD = Converter.nullchk(request.getParameter("FIELD"));			//검색구분
    	String DIV_KIND = Converter.nullchk(request.getParameter("DIV_KIND"));		//구분종류 검색구분
    	String AREA_KIND = Converter.nullchk(request.getParameter("AREA_KIND"));	//지역종류 검색구분
    	
    	if(KEY == null) KEY = "";
    	if(FIELD == null || FIELD.equals("")) FIELD = "";
    	if(DIV_KIND == null || DIV_KIND.equals("")) DIV_KIND = "";
    	if(AREA_KIND == null || AREA_KIND.equals("")) AREA_KIND = "";
		
    	//String cmd = Converter.nullchk(request.getParameter("cmd"));
    	String cmd = multi.getParameter("cmd");
    	String center_minwon_admin_no=multi.getParameter("center_minwon_admin_no");
    	String center=multi.getParameter("center");
    	String sh_no=multi.getParameter("sh_no");
   	
		// System.out.println("center_minwon_admin_no in multi="+multi.getParameter("center_minwon_admin_no"));

		String Result = null;
		String TableName = " center_minwon_admin ";
		String InsertTemplete = " ";
		String ValuesString = "( seq_center_minwon_admin.NEXTVAL, ?, ?,  sysdate )";
	
		Vector vtsheet = new Vector();
	
		String type_1 = "String";
		String type_2 = "int";
		String type_3 = "long";
		String type_4 = "LongString";
	
	    String SetString = null;
		
		SetString = "  center= ?, sh_no = ?";

		// System.out.println("SetString="+SetString);
		// System.out.println("cmd="+cmd);
		
		if(cmd.equals("add")){
			// System.out.println("insert query=" + "insert into " + TableName + InsertTemplete + " values " + ValuesString);
			// System.out.println("select query="+"Select  center_minwon_admin_no from center_minwon_admin where  sh_no=" + sh_no + " and center='" + center + "'");
			vtsheet.addElement("insert into " + TableName + InsertTemplete + " values " + ValuesString);
			vtsheet.addElement(type_1);
			vtsheet.addElement(center);
			vtsheet.addElement(type_2);
			vtsheet.addElement(sh_no);
			
		}else if(cmd.equals("edit")){
		        vtsheet.addElement("update " + TableName + " set " + SetString + " where center_minwon_admin_no=" + center_minwon_admin_no);
				vtsheet.addElement(type_1);
				vtsheet.addElement(center);
				vtsheet.addElement(type_2);
				vtsheet.addElement(sh_no);
		}else if(cmd.equals("del")) {
			// System.out.println("query="+"delete from " + TableName + " where banner_no= " + banner_no);
			vtsheet.addElement("delete from " + TableName + " where center_minwon_admin_no= " + center_minwon_admin_no);
		}

		String existing_center_minwon_no =Board.OnlyOne("Select  center_minwon_admin_no from center_minwon_admin where  center='" + center + "'"); // sh_no=" + sh_no + " and
		// System.out.println("existing_center_minwon_no="+existing_center_minwon_no);
		// System.out.println("center_minwon_admin_no="+center_minwon_admin_no);
		String msg = "";
		if(cmd.equals("add")){
			if (existing_center_minwon_no==null) {
				msg = "등록";
				Result = Board.DataProcess(vtsheet);
			} else {
				msg = "선택하신 민원종류에 이미 담당자가 등록되어 있습니다. ";
				Result = "Already";
			}
		}else if(cmd.equals("edit")){
			if (existing_center_minwon_no.equals(center_minwon_admin_no)) {
				msg = "수정";
				Result = Board.DataProcess(vtsheet);
			} else {
				msg = "선택하신 민원종류에 담당자가 이미 등록되어 있습니다. ";
				Result = "Already";
			}
		}else if(cmd.equals("del")){
			msg = "삭제";
			Result = Board.DataProcess(vtsheet);
		}
		
		// System.out.println("Result="+Result);
		// System.out.println("Result= True ->"+Result.equals("True"));
%>
		<% 		if(Result.equals("True")) { %>

			        <script language="javascript">

			        <!--
			        	alert("<%=msg%>" +  " 되었습니다.");
			        	self.location = "center_minwon_admin_list.jsp?PAGE=<%=PAGE%>&FIELD=<%=FIELD%>&KEY=<%=KEY%>";
			        //-->

			        </script>
		<%		} else if(Result.equals("Already")) { %>

			        <script language="javascript">
			        <!--

						alert("<%=msg%>" );
						history.go(-1);				

			        //-->
			        </script>


		<%		}else{ %>

			        <script language="javascript">
			        <!--

						alert("<%=msg%>" + "되지 않았습니다. \n\n 관리자에게 문의바랍니다.");
						history.go(-1);				

			        //-->
			        </script>

		<%		} %>
<%		
	} catch(Exception e) {
		out.println("center_minwon_admin_proc.jsp : " + e.getMessage());
	} finally {

	}
%>        