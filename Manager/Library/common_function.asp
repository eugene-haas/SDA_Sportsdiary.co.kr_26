<%
'=========================================================================================================================================================
'============================================================* 한자리수 숫자 0붙이기  ====================================================================
'=========================================================================================================================================================

Function AddZero(Str)
 IF len(Str)=1 Then
  AddZero="0"&Str
 Else
  AddZero=Str
 End IF
End Function
'=========================================================================================================================================================
'============================================================* 한자리수 숫자 0붙이기  ====================================================================
'=========================================================================================================================================================
'=========================================================================================================================================================
'============================================================* 참여인원에 따른 강수 구하기================================================================
'=========================================================================================================================================================
	Function chk_TotRound(PlayerCnt)
		If PlayerCnt <=2 Then 
			chk_TotRound = 2
		ElseIf PlayerCnt > 2 And PlayerCnt <=4 Then 
			chk_TotRound = 4
		ElseIf PlayerCnt > 4 And PlayerCnt <=8 Then 
			chk_TotRound = 8
		ElseIf PlayerCnt > 8 And PlayerCnt <=16 Then 
			chk_TotRound = 16
		ElseIf PlayerCnt > 16 And PlayerCnt <=32 Then 
			chk_TotRound = 32
		ElseIf PlayerCnt > 32 And PlayerCnt <=64 Then 
			chk_TotRound = 64
		ElseIf PlayerCnt > 64 And PlayerCnt <=128 Then 
			chk_TotRound = 128
		End If 
	End Function 
'=========================================================================================================================================================
'============================================================* 참여인원에 따른 강수 구하기================================================================
'=========================================================================================================================================================
Function Medal_Score(Medal_Type)
	If Medal_Type = "sd034001" Then 
		Medal_Score = "1"
	ElseIf Medal_Type = "sd034002" Then 
		Medal_Score = "2"
	ElseIf Medal_Type = "sd034003" Then 
		Medal_Score = "3"
	End If 
End Function 
%>