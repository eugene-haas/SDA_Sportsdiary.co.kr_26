<!--#include file="../dev/dist/config.asp"-->
<%
	'==============================================================================================
	'대표팀 등록
   	'/Main_HP/NationalTeam_Write.asp
	'==============================================================================================
	Check_AdminLogin()

	dim valType 		: valType 		=  fInject(Request("valType"))
	dim CIDX 			: CIDX 			=  fInject(Request("CIDX"))
   	dim MemberIDX 		: MemberIDX 	=  fInject(Request("MemberIDX"))
	dim UserName 		: UserName 		=  HtmlSpecialChars(fInject(Request("UserName")))
	dim UserEnName 		: UserEnName 	=  HtmlSpecialChars(fInject(Request("UserEnName")))
	dim Sex 			: Sex 			=  fInject(Request("Sex"))
	dim Birthday 		: Birthday 		=  fInject(Request("Birthday"))
   	dim RegYear 		: RegYear 		=  fInject(Request("RegYear"))
   	dim TeamGb 			: TeamGb 		=  fInject(Request("TeamGb"))
   	dim SubstituteYN 	: SubstituteYN	=  fInject(Request("SubstituteYN"))
   	
   	dim UserID 			: UserID 		= crypt.DecryptStringENC(fInject(Request.Cookies(global_HP)("UserID")))	
	
   	
	IF valType = "" Then 	
		response.Write "FALSE|200"
		response.End()
	Else
		
		SELECT CASE valType
			
			CASE "DEL"
			
				IF CIDX <> "" Then
					LSQL =  "		 DELETE [KoreaBadminton].[dbo].[tblMemberKorea]" 
					LSQL = LSQL & " WHERE MemberKoreaIDX = '" & CIDX & "'"
					
					DBCon.Execute(LSQL)
					
					IF DBCon.Errors.Count > 0 Then
						response.Write "FALSE|66"
						response.End()
					Else
						response.Write "TRUE|70"
						response.End()
					End IF
				Else
					response.Write "FALSE|200"
					response.End()
				End IF
				
				
			CASE "MOD"
		
				IF CIDX <> "" Then					
						
					LSQL = "		UPDATE [KoreaBadminton].[dbo].[tblMemberKorea] " 
					LSQL = LSQL & " SET MemberIDX = '" & MemberIDX & "'"
					LSQL = LSQL & "		,RegYear = '" & RegYear & "'"
					LSQL = LSQL & "		,TeamGb = '" & TeamGb & "'"
					LSQL = LSQL & "		,SubstituteYN = '" & SubstituteYN & "'"
					LSQL = LSQL & "		,UserName = '" & UserName & "'"
					LSQL = LSQL & "		,UserEnName = '" & UserEnName & "'"
					LSQL = LSQL & "		,Sex = '" & Sex & "'"
					LSQL = LSQL & "		,Birthday = '" & Birthday & "'"
					LSQL = LSQL & "		,ModID = '" & UserID & "'"
					LSQL = LSQL & "		,ModDate = GETDATE()"
					LSQL = LSQL & " WHERE MemberKoreaIDX = '" & CIDX & "'"

					DBCon.Execute(LSQL)

					IF DBCon.Errors.Count > 0 Then
						response.Write "FALSE|66"
						response.End()
					Else
						response.Write "TRUE|80"
						response.End()
					End IF
				Else
					response.Write "FALSE|200"
					response.End()
				End IF
				
				
			CASE "SAVE"
				LSQL = "		SELECT COUNT(*) "
				LSQL = LSQL & "	FROM [KoreaBadminton].[dbo].[tblMemberKorea]"
				LSQL = LSQL & " WHERE DelYN = 'N'"
				LSQL = LSQL & " 	AND RegYear = '"&RegYear&"'"
				LSQL = LSQL & " 	AND UserName = '"&UserName&"'"
				LSQL = LSQL & " 	AND Replace(Birthday, '-', '') = '"&Birthday&"'"
				LSQL = LSQL & "		AND Sex = '" & Sex & "'"

				SET LRs = DBCon.Execute(LSQL)
				IF LRs(0) > 0 Then 
					response.Write "FALSE|99"
					response.End()
				Else
					
					LSQL = "		INSERT INTO [KoreaBadminton].[dbo].[tblMemberKorea] (" 
					LSQL = LSQL & "		MemberIDX "  
					LSQL = LSQL & "		,RegYear " 
					LSQL = LSQL & "		,TeamGb " 										
					LSQL = LSQL & "		,SubstituteYN " 
					LSQL = LSQL & "		,UserName " 
					LSQL = LSQL & "		,UserEnName " 
					LSQL = LSQL & "		,Birthday"  
					LSQL = LSQL & "		,Sex"  
					LSQL = LSQL & "		,DelYN "  					
					LSQL = LSQL & "		,InsID "  					
					LSQL = LSQL & "		,InsDate "  					
					LSQL = LSQL & "		,ModDate "  						
					LSQL = LSQL & "	) VALUES( " 
					LSQL = LSQL & "		'" & MemberIDX & "'" 
					LSQL = LSQL & "		,'" & RegYear & "'" 
					LSQL = LSQL & "		,'" & TeamGb & "'" 
					LSQL = LSQL & "		,'" & SubstituteYN & "'" 
					LSQL = LSQL & "		,'" & UserName & "'" 
					LSQL = LSQL & "		,'" & UserEnName & "'" 
					LSQL = LSQL & "		,'" & Birthday & "'" 			
					LSQL = LSQL & "		,'" & Sex & "'" 			
					LSQL = LSQL & "		,'N'" 
					LSQL = LSQL & "		,'" & UserID & "'" 			
					LSQL = LSQL & "		,GETDATE()" 
					LSQL = LSQL & "		,GETDATE()" 
					LSQL = LSQL & "	)"

					DBCon.Execute(LSQL)
				
					IF DBCon.Errors.Count > 0 Then
						response.Write "FALSE|66"
						response.End()
					Else
						response.Write "TRUE|90"
						response.End()
					End IF

				End IF
					LRs.Close
				SET LRs = Nothing
			
		END SELECT
			
	End IF 
%>