<!--#include file="../Library/ajax_config.asp"-->
<%
	'==================================================================================
	'ȸ�����Խ� ���̵� �ߺ� üũ
	'==================================================================================
	
	dim UserID : UserID = fInject(Request("UserID"))
	
	dim CSQL, CRs
	
	If UserID = "" Then 
		Response.Write "FALSE"
		Response.End
	Else
	
	
		CSQL = 	"		SELECT UserID " 
		CSQL = CSQL & " FROM [SD_Member].[dbo].[tblMember] " 
		CSQL = CSQL & "	WHERE UserID = '"&UserID&"' " 
		
		SET CRs = DBCon3.Execute(CSQL)
		If Not(CRs.Eof Or CRs.Bof) Then 
			Response.Write "FALSE"
		Else
			Response.Write "TRUE"
		End If 
			
			CRs.Close
		SET CRs = Nothing
				
		DBClose3()
			
	End If 
	
%>