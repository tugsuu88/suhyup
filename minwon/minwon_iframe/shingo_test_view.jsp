<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>


<%@ page contentType="text/html;charset=euc-kr" %>





<%@ page import="board.board2.DataFileInfo" %>


<%@ page import="com.oreilly.servlet.*" %>


<%@ page import="com.oreilly.servlet.multipart.*" %>





<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>


<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>





<%@ include file="../inc/requestSecurity.jsp" %>


<% String pageNum = "5"; %>


<%





	String mid = request.getParameter("mid");


	if(mid == null) mid="0";


	int sh_mid = Integer.parseInt(mid);


	


	String telephone = Converter.nullchk(request.getParameter("telephone"));





	String name = "";


	String subject = "";


	String content = "";


	String email = "";


	String tel = "";


	String passwd = "";


	String addr = "";


	String addr2 = "";


	String answer = "";


	String address = "";


	try {	


	


		DataSource ds = null;


		Connection conn = null;


		Statement stmt = null;


		ResultSet rs = null;


		ResultSetMetaData meta = null;


		PreparedStatement pstmt=null;





	





		Context ic = new InitialContext();


		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");


		conn = ds.getConnection();


		String sql = "";	


		





		sql = " select thid, name, title, branch, tel, password, text,text1, addr,addr2 from sh_financetrouble " ;


		sql += " where thid = '"+mid+"'";





		stmt=conn.createStatement();


		rs = stmt.executeQuery(sql);


	


		if(rs.next()){


			name = rs.getString("name");


			if(name == null) name="";


			subject = rs.getString("title");


			if(subject == null) subject="";


			content = rs.getString("text");


			if(content == null) content="";


			tel = rs.getString("tel");


			if(tel == null) tel="";


			email = rs.getString("branch");


			if(email == null) email="";


			addr = rs.getString("addr");


			if(addr == null) addr="";


			addr2 = rs.getString("addr2");


			if(addr2 == null) addr2="";


			address = addr + addr2;





			passwd = rs.getString("password");


			if(passwd == null) passwd="";


			answer = rs.getString("text1");


			if(answer == null) answer="";





			StringTokenizer stk = new StringTokenizer(content, "\r\n");


			content="";


			while(stk.hasMoreElements()){


				content += stk.nextToken();


				content += "<br/>";


			}


			


			StringTokenizer stk1 = new StringTokenizer(answer, "\r\n");


			answer="";


			while(stk1.hasMoreElements()){


				answer += stk1.nextToken();


				answer += "<br/>";


			}


		}





		rs.close();


		conn.close();


		


	}


	catch(Exception e){


		out.println(e.toString());


	}


 %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">


<head>


<title>수협 - 바다사랑 고객사랑</title>


<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />


<link rel='stylesheet' type='text/css' media='all' href='../css/main.css' />


<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />


<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />


<script type="text/javascript" src="../js/quickMenu.js"></script>


<script type="text/javascript" src="../js/public.js"></script>


<script type="text/javascript">


<!--


	function goReg(){


		//alert(f.phone.value);


		f.action = "shingo_test_list.jsp";	


		f.submit();


	}


	function goEdit(){


		if (confirm("수정하시겠습니까?")) {


			f.action = "shingo_test_edit.jsp";	


			f.submit();


		}


		else {


		alert("취소되었습니다!");		


		}


	}


	function goDel(){


		if (confirm("삭제하시겠습니까?")) {


			f.action = "shingo_del_proc.jsp";	


			f.submit();


		}


		else {


		alert("취소되었습니다!");		


		}


	}


	function goCode(){


		if (confirm("철회하시겠습니까?")) {


			f.action = "shingo_code_proc.jsp";	


			f.submit();


		}


		else {


		alert("취소되었습니다!");		


		}


	}


//-->


</SCRIPT>


</head>


<body id="shingo01">


<!-- start content table-->


<form method=get name="f" enctype="" action="">


<input type="hidden" name="name" value="<%=name%>" />


<input type="hidden" name="passwd" value="<%=passwd%>" />


<input type="hidden" name="sh_mid" value="<%=sh_mid%>" />


<input type="hidden" name="tel" value="<%=tel%>">


<INPUT TYPE="hidden" NAME="telephone" value="<%=telephone%>" />


<table id="contentTable" cellpadding="0" cellspacing="0">


  <tr> 


    <td id="sideContent" valign="top">&nbsp;</td>


<td id="primaryContent" valign="top"> 


      <table cellpadding="0" cellspacing="0">


        <tr> 


          <td><IMG SRC="../images/pc_bg_topline.gif" WIDTH="795" HEIGHT="5" BORDER="0" alt="" /></td>


        </tr>


        <tr> 


          <td style="background:url(../images/pc_middle_line.gif); padding-left:30px;" valign="top"> 


            <table cellpadding="0" cellspacing="0" border="0">


              <tr> 


                <td id="content"> 


                  <!-- 민원신청 입력 창 시작 -->


                  <table cellpadding="0" cellspacing="0" border="0" class="view">


                    <thead> 


                    <tr> 


                      <td class="lineLeft"><span>성명</span></td>


                      <td class="lineRight"><%=name%></td>


                    </tr>


                    <tr> 


                      <td class="writerT title">이메일</td>


                      <td class="writer"><%=email%>&nbsp;</td>


                    </tr>


                    <tr> 


                      <td class="writerT title">연락처</td>


                      <td class="writer"><%=tel%></td>


                    </tr>


                    <tr> 


                      <td class="writerT title">주소</td>


                      <td class="writer"><%=address%>&nbsp;</td>


                    </tr>


                    <tr> 


                      <td class="writerT title">제목</td>


                      <td class="writer"><%=subject%></td>


                    </tr>


                    </thead> 


                  </table>


				  <table width="370" border="0" cellspacing="0" cellpadding="0">


                    <tr>


                        <td height="30"><img src="images/min_question.gif" /></td>


                     </tr>


				   <table width="370" border="0" cellspacing="0" cellpadding="0">


                    <tr> 


                      <td style="padding:5px 0 5px 0"> 


                        <table cellspacing="0" style="width:745px; border:2px solid #E9E9E9; background-color:#F8F8F7;" width="100%">


                          <tr> 


                            <td style="padding:10px;"> 


                              <table width="100%" border="0" cellspacing="0" style="border:1px solid #E9E9E9; background-color:#FFFFFF;">


                                <tr> 


                                  <td style="padding:10px;"><%=content%>


                                    


                                  </td>


                                </tr>


                              </table>


                            </td>


                          </tr>


                        </table>


                      </td>


                    </tr>


                    <tr> 


                      <td height="1" bgcolor="ebebeb"></td>


                    </tr>


				  <table width="370" border="0" cellspacing="0" cellpadding="0">


                    <tr>


                        <td height="30"><img src="images/min_answer.gif" /></td>


                     </tr>


				 <table width="370" border="0" cellspacing="0" cellpadding="0">


                    <tr> 


                      <td style="padding:5px 0 5px 0"> 


                        <table cellspacing="0" style="width:745px; border:2px solid #E9E9E9; background-color:#F8F8F7;" width="100%">


                          <tr> 


                            <td style="padding:10px;"> 


                              <table width="100%" border="0" cellspacing="0" style="border:1px solid #E9E9E9; background-color:#FFFFFF;">


                                <tr> 


                                  <td style="padding:10px;">


								  <%if(answer==null || answer.equals("")){%>처리중입니다.


								  <%}else{%>


								    <%=answer%>


								  <%} %>


		                         </td>


                                </tr>


                              </table>


                            </td>


                          </tr>


                        </table>


                      </td>


                    </tr>


                    <tr> 


                      <td height="1" bgcolor="ebebeb"></td>


                    </tr>


                  </table>				  


                  <table cellpadding="0" cellspacing="0" border="0" class="button">


                    <tr> 


                      <td><a href="javascript:goReg();"><img src="../pub_img/btT01List.gif" alt="목록"/></a>


					  <!--


					  <a href="javascript:goEdit();"><img src="../pub_img/btT01Modify.gif" /></a><a href="javascript:goDel();"><img src="../pub_img/btT01Delete.gif" /></a>


					  -->


					  <a href="javascript:goCode();"><img src="../pub_img/btminwon_repeal.gif" /></a> 


                      </td>


                    </tr>


                  </table>


                  <!-- 민원신청 입력 창 끝 -->


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


</body>


</html>