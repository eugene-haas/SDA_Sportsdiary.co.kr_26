<!--#include file="../dev/dist/config.asp"-->

<%
	'꼭 로그인 유저를 제대로 받아야한다.
  'iLoginID = global_iLoginID ' 쿠키로 나중에 받을것
  'iLoginID = decode(fInject(Request.cookies(global_HP)("UserID")),0)

	iUserID = fInject(Request.cookies("UserID"))
	iUserID = decode(iUserID,0)
	iLoginID = iUserID

  ' 뷰에 해당하는 첨부파일 관련
  Dim  LCnt
  LCnt = 0

	' 이 현재 페이지에 대해서 알아봐야한다.
  NowPage = fInject(Request("i2"))

	' 게시판 고유 번호
  iMSeq = fInject(Request("i1"))
  MSeq = decode(iMSeq,0)

	'JudoTitleWriteLine "NowPage", NowPage
	'JudoTitleWriteLine "iLoginID", iLoginID
	'JudoTitleWriteLine "MSeq", MSeq

  ' 디버깅 모드로 수정 해서 강제로 접근할 경우 체크
  LSQL = "EXEC AD_tblADCode_R '" & NowPage & "','" & MSeq & "','" & iLoginID & "'"
	'response.Write "LSQL="&LSQL&"<br>"
  'response.End
  Set LRs = DBCon6.Execute(LSQL)
  If Not (LRs.Eof Or LRs.Bof) Then
		Do Until LRs.Eof
        LCnt = LCnt + 1
        LoginIDYN = LRs("LoginIDYN")
      LRs.MoveNext
		Loop
  End If
  LRs.close

  ' 디버깅 모드로 수정 해서 강제로 접근할 경우 체크
  If LoginIDYN = "N" Then
		DbClose()
    response.Write "<script type='text/javascript'>alert('잘못된 접근 입니다.');location.href='/';</script>"
    response.End

  Else

    ' 첨부파일 삭제
    Dim  LCnt1, iType
    LCnt1 = 0
    iType = 1 ' 1:Delete

		SportsGb = "tennis"

    LSQL = "EXEC AD_tblADCode_D '" & iType & "','" & MSeq & "','" & SportsGb & "'"
	  'response.Write "LSQL="&LSQL&"<br>"
    'response.End
    Set LRs = DBCon6.Execute(LSQL)
    If Not (LRs.Eof Or LRs.Bof) Then
		  Do Until LRs.Eof
          LCnt1 = LCnt1 + 1
          'FileName = LRs("FileName")
          'filePath = global_filepath + FileName
          'DeleteExistFile(filePath)
					
					iCodeMod = LRs("CodeMod")

        LRs.MoveNext
		  Loop
    End If
    LRs.close

		AD_DBClose()

		if iCodeMod = "NODEL" then

			response.Write "<script type='text/javascript'>alert('배너 이미지에 코드가 사용 중입니다.\n이미지 그룹 삭제가 안됐습니다.');location.href='./AD_Code_List.asp';</script>"
			response.End

		else

			response.Write "<script type='text/javascript'>alert('이미지 그룹 삭제가 잘 됐습니다.');location.href='./AD_Code_List.asp';</script>"
			response.End

		end if

  End If
%>