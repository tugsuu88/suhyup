<%@ page import="java.util.*, util.*,java.text.SimpleDateFormat"
	String mid = request.getParameter("thididx");
	if(mid == null) mid="0";
	int sh_mid = Integer.parseInt(mid);
	String PAGE = request.getParameter("PAGE");
	//out.println(sh_mid);
	
	String TableName = " sh_chungtak ";
	String SelectCondition = " sg_name, sg_addr1, sg_tel, title, code, buseo, result, ct_content, sg_publication, ";
		   SelectCondition += " to_char(time1, 'YYYY-MM-DD') AS time1, sg_addr2,text1" ;
	String WhereCondition = " where thid=" + sh_mid;
	String OrderCondition = "";
	
	Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 0, 0);	
	
	String name = "";
	String addr = "";
	String tel = "";
	String title = "";
// 	String branch = "";
	String code = "";
	String buseo = "";
	String result = "";
	String text = "";
	String time1 = "";
	String publication = "";
	String addr2 = "";
	String address = "";
	String text1 = "";

	//out.println(ResultVector.size());

	if( ResultVector.size() > 0){
			Hashtable h = (Hashtable)ResultVector.elementAt(i);
			name = (String)h.get("SG_NAME");
			tel = (String)h.get("SG_TEL");
			if(tel == null) tel = "";
// 			branch=(String)h.get("BRANCH");
			buseo = (String)h.get("BUSEO");
			code = (String)h.get("CODE");
			result = (String)h.get("RESULT");
			text = (String)h.get("CT_CONTENT");
			time1 = (String)h.get("TIME1");
			publication = (String)h.get("SG_PUBLICATION");
			text1 = (String)h.get("TEXT1");

			StringTokenizer stk = new StringTokenizer(text, "\r\n");

			StringTokenizer stk1 = new StringTokenizer(text1, "\r\n");
			text1="";
			while(stk1.hasMoreElements()){
				text1 += stk1.nextToken();
				text1 += "<br>";
			}