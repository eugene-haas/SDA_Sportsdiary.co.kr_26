<!--#include file="../Library/ajax_config.asp"-->
<%
	Check_Login()
	
	SportsGb 		=  Request.Cookies("SportsGb")
	MemberIDX   	=  decode(Request.Cookies("MemberIDX"),0)
	PlayerIDX   	=  decode(Request.Cookies("PlayerIDX"),0)
 
   ' /*�Ʒ�����*/
     tblSvcTrRerd       = fInject(ReplaceTagText(Request("tblSvcTrRerd")))
   ' /*�Ʒ���*/
     tblSvcTrRerdAsmt   = fInject(ReplaceTagText(Request("tblSvcTrRerdAsmt")))

     SQL =  "EXEC Insert_Train_sche '"&SportsGb&"',"&MemberIDX&",'"&tblSvcTrRerd&"','"&tblSvcTrRerdAsmt &"'"
    ''üũ  : �Ʒ� �� / �Ʒø�ǥ /

	If tblSvcTrRerd = "" Then 	
		Response.Write "FALSE|"&SQL
		Response.End
	Else                                                      '  /*�Ʒ�����*             *�Ʒ���*    /
		SQL =  "EXEC Insert_Train_sche '"&SportsGb&"',"&MemberIDX&",'"&tblSvcTrRerd&"','"&tblSvcTrRerdAsmt &"'"
		DBCon.Execute(SQL)	

		Response.Write "TRUE"
		Response.End
	End If 
    
	Dbclose()
%>