<!-- #include file="../../dev/dist/config.asp"-->
<!-- #include file="../../classes/JSON_2.0.4.asp" -->
<!-- #include file="../../classes/JSON_UTIL_0.1.1.asp" -->
<!-- #include file="../../classes/json2.asp" -->

<%
  REQ = Request("REQ")
  'REQ = "{""tPGameLevelIdx"":""6C1E439F047C23BEA742A80AD3A62D56"",""tIdx"":""4AC9519B3F35C40A5D496D69A6B07B65"",""tGameLevelIdx"":""6C1E439F047C23BEA742A80AD3A62D56"",""beforeNowPage"":1,""NowPage"":""1"",""i2"":""1"",""pType"":""level"",""iSearchText"":"""",""iSearchCol"":""T"",""CMD"":1,""tGameLevelDtlIdx"":""E3236AB416D97BB28B8A518164D91646"",""tPlayLevelType"":""D096EC5BB8B02F96118B096392C18758"",""tGameType"":""143222846ECFA17ECBDF9B9DE506DCBD"",""tStadium"":""040F9E5C3294000D22467CC44F74AAFB"",""tTotalRound"":""512"",""tEntryCnt"":""0"",""tGameTime"":""8:00 AM"",""tViewYN"":""N"",""tGameDay"":""2018-04-18"",""tLevelJooNum"":""1"",""tJooDivision"":""0""}"
  Set oJSONoutput = JSON.Parse(REQ)
	CMD = oJSONoutput.CMD
  Dim tJooRank : tJooRank = 1
  tGameLevelIdx = fInject(crypt.DecryptStringENC(oJSONoutput.tGameLevelIdx))
  tPGameLevelIdx= fInject(crypt.DecryptStringENC(oJSONoutput.tPGameLevelIdx))
  
  tIdx = fInject(crypt.DecryptStringENC(oJSONoutput.tIdx))
  tJooDivision = fInject(oJSONoutput.tJooDivision)
  tLevelJooNum = fInject(oJSONoutput.tLevelJooNum)
  tGameDay = fInject(oJSONoutput.tGameDay)
  tGameTime = fInject(oJSONoutput.tGameTime)
  tViewYN = fInject(oJSONoutput.tViewYN)
  tEntryCnt = fInject(oJSONoutput.tEntryCnt)
  tStadium = fInject(crypt.DecryptStringENC(oJSONoutput.tStadium))
  tPlayLevelType = fInject(crypt.DecryptStringENC(oJSONoutput.tPlayLevelType))
  tGameType = fInject(crypt.DecryptStringENC(oJSONoutput.tGameType))
  tFullGameYN = fInject(oJSONoutput.tFullGameYN)
  
  tPlayLevelType2 ="B0100002"
  tPlayLevelGroup = ""
  tLevelDtlName = ""
  tLevel =""

  'Response.Write "CMD :" & CMD & "<BR>"
  'Response.Write "tIdx :" & tIdx & "<BR>"
  'Response.Write "tGameTitleName :" & tGameTitleName & "<BR>"
  'Response.Write "tEnterType :" & tEnterType & "<BR>"
  'Response.Write "tGameLevelIdx :" & tGameLevelIdx & "<BR>"
  'Response.Write "tPGameLevelIdx :" & tPGameLevelIdx & "<BR>"
  'Response.Write "tPlayType :" & tPlayType & "<BR>"
  'Response.Write "tGameType :" & tGameType & "<BR>"
  'Response.Write "tStadiumNumber :" & tStadiumNumber & "<BR>"
  'Response.Write "tTotalRound :" & tTotalRound & "<BR>"
  'Response.Write "tLevelInfo :" & tLevelInfo & "<BR>"
  'Response.Write "tEntryCnt :" & tEntryCnt & "<BR>"
  'Response.Write "tGameDay :" & tGameDay & "<BR>"
  'Response.Write "tGameS :" & tGameS & "<BR>"
  'Response.Write "tGameE :" & tGameE & "<BR>"
  'Response.Write "tGameTime :" & tGameTime & "<BR>"
  'Response.Write "tViewYN :" & tViewYN & "<BR>"
  'Response.END
  IF tGameType = "B0040001" Then
    tTotalRound  = "0"
  else
    tTotalRound = fInject(oJSONoutput.tTotalRound)
  END IF 

  '------------------------PGameLevel??? ????????? ????????? ?????? ??????-----------------------
  LSQL = " SELECT COUNT(*) as Cnt  "
  LSQL = LSQL & " FROM  tblGameLevel "
  LSQL = LSQL & "  where PGameLevelidx = " & tPGameLevelIdx & " and Delyn ='n'"
  'Response.Write "LSQL : " & LSQL & "<BR>"
  Set LRs = DBCon.Execute(LSQL)
  
  If Not (LRs.Eof Or LRs.Bof) Then
    Do Until LRs.Eof
        iPCnt = LRs("Cnt")
        LRs.MoveNext
    Loop
  End If 

  IF cdbl(iPCnt) > 0 Then
    '???????????? (??????,??????,????????????)
    LSQL = " SELECT  JooRank  "
    LSQL = LSQL & " FROM  tblGameLevel "
    LSQL = LSQL & " WHERE DelYN = 'N' and GameLevelidx = '"  & tPGameLevelIdx  & "'"

    Set LRs = DBCon.Execute(LSQL)
    If Not (LRs.Eof Or LRs.Bof) Then
      Do Until LRs.Eof
          tJooRank = LRs("JooRank")
          LRs.MoveNext
      Loop
    End If 
  End IF

  '------------------------PGameLevel??? ????????? ????????? ?????? ??????-----------------------
  
 

  IF CDBL(tJooDivision) > 0 Then
    Redim LevelDTLIdArr(tJooDivision)
    '------------Level ?????? ????????????--------------
    LSQL = " SELECT Top 1 a.GroupGameGb, a.EnterType"
    LSQL = LSQL & " FROM  tblGameLevel  a "
    LSQL = LSQL & " WHERE a.GameLevelidx = '"  & tGameLevelIdx  & "' and a.DelYn ='N' "
   
    Set LRs = DBCon.Execute(LSQL)
    IF NOT (LRs.Eof Or LRs.Bof) Then
      Do Until LRs.Eof
        GroupGameGb = LRS("GroupGameGb")
        tEnterType = LRS("EnterType")
        LRs.MoveNext
      Loop
    End IF
    '------------Level ?????? ????????????--------------


    IF GroupGameGb = "B0030001" Then
      LSQL = " SELECT count(*) as RequestCnt "
      LSQL = LSQL & " FROM  tblGameRequestGroup "
      LSQL = LSQL & " WHERE GameTitleIDX = '" &  tIdx & "' AND  GameLevelidx = '" & tGameLevelIdx & "' AND DelYN='N' "
    End If

    IF GroupGameGb = "B0030002" Then
      LSQL = " SELECT count(*) as RequestCnt "
      LSQL = LSQL & " FROM  tblGameRequestTeam  "
      LSQL = LSQL & " WHERE GameTitleIDX = '" &  tIdx & "' AND  GameLevelidx = '" & tGameLevelIdx & "' AND DelYN='N' "
    End If

    Set LRs = DBCon.Execute(LSQL)
    If Not (LRs.Eof Or LRs.Bof) Then
      Do Until LRs.Eof
          tRequestCnt = LRs("RequestCnt")
        LRs.MoveNext
      Loop
    End If 

    FullGameYN = "N"
    
    IF CDBL(tRequestCnt) < 6 tHEN
      FullGameYN = "Y"
      IF CDBL(tJooDivision) > 1 Then
        tJooDivision = 1
      End IF
    Else
      FullGameYN = "N"
    END IF
    

    '---------?????? Division??? ????????? ????????? ??????--------
    'LSQL = " SELECT GameLevelDtlidx "
    'LSQL = LSQL & "   FROM  tblGameLevelDtl  "
    'LSQL = LSQL & " WHERE GameLevelidx = '"  & tGameLevelIDX  & "' and LevelJooDivision > 0 and DelYn ='N' "
    ''Response.Write "LSQL : " & LSQL & "<BR><BR><BR><BR><BR>"

    'Set LRs = DBCon.Execute(LSQL)
    'IF NOT (LRs.Eof Or LRs.Bof) Then
    '  Do Until LRs.Eof
    '    GameLevelDtlidx = LRS("GameLevelDtlidx")
    '    Del_GameLevelDtlidxs = Del_GameLevelDtlidxs & GameLevelDtlidx & "_"
    '    LRs.MoveNext
    '  Loop
    'End IF

    'Split_Del_GameLevelDtlidxs = Split(Del_GameLevelDtlidxs,"_")

    'for each x in Split_Del_GameLevelDtlidxs
    '  if(x <> "") Then
    '    LSQL = " Update tblGameLevelDtl Set DelYN = 'Y' " 
    '    LSQL = LSQL & "   WHERE GameLevelDtlidx = '" &  X & "'" 
    '    'Response.Write "SQL :" & LSQL & "<BR>"
    '    Set LRs = DBCon.Execute(LSQL)
    '    LSQL = " Update tblGameRequestTouney Set DelYN = 'Y' " 
    '    LSQL = LSQL & "   WHERE GameLevelDtlidx = '" &  X & "'" 
    '    'Response.Write "SQL :" & LSQL & "<BR>"
    '    Set LRs = DBCon.Execute(LSQL)
    '  End if
    'next
    '---------?????? Division??? ????????? ????????? ??????--------

    '---------?????? ????????? ??????--------
    For i = 1 To cdbl(tJooDivision)
      LSQL = " SET NOCOUNT ON insert into tblGameLevelDtl " 
      LSQL = LSQL & " (GameTitleIDX, GameLevelidx, PlayLevelType, PlayLevelGroup, GameType, StadiumNum, TotRound, GameDay, GameTime, EnterType, EntryCnt, Level, LevelDtlName, LevelJooNum, LevelJooDivision,ViewYN, JooRank, FullGameYN) "
      IF FullGameYN = "Y" Then
      LSQL = LSQL & " values ('"&tidx & "','"&tGameLevelIdx & "','" & tPlayLevelType2 & "', '" & tPlayLevelGroup & "' ,'"& tGameType & "','" & tStadium & "','" & tTotalRound & "','" & tGameDay & "', '" & tGameTime &"','" & tEnterType &"','" & tEntryCnt &"','" & tLevel &"','" & tLevelDtlName &"', '" & i & "','" & tJooDivision & "','" & tViewYN & "','" & tJooRank & "','" & FullGameYN & "')" 
      ELSE
      LSQL = LSQL & " values ('"&tidx & "','"&tGameLevelIdx & "','" & tPlayLevelType & "', '" & tPlayLevelGroup & "' ,'" & tGameType & "','" & tStadium & "','" & tTotalRound & "','" & tGameDay & "', '" & tGameTime &"','" & tEnterType &"','" & tEntryCnt &"','" & tLevel &"','" & tLevelDtlName &"', '" & i & "','" & tJooDivision & "','" & tViewYN & "','" & tJooRank & "','" & FullGameYN & "')" 
      End if
      LSQL = LSQL & " SELECT @@IDENTITY as IDX "
      'Response.Write "LSQLLSQLLSQLLSQLLSQL : "& LSQL &  "<br>"
      Set LRs = DBCon.Execute(LSQL)
      IF NOT (LRs.Eof Or LRs.Bof) Then
          Do Until LRs.Eof
          GameLevelDtlidx = LRs("IDX")
          GameLevelDtlidxs = GameLevelDtlidxs & GameLevelDtlidx & "_"
        LRs.MoveNext
        Loop
      End If  
    Next
    '---------?????? ????????? ??????--------


    '---------?????? ????????? ??????--------
    IF Len(GameLevelDtlidxs) > 0 AND FullGameYN ="N" Then
      LSQL = " SET NOCOUNT ON insert into tblGameLevelDtl " 
      LSQL = LSQL & " (GameTitleIDX, GameLevelidx, PlayLevelType, PlayLevelGroup, GameType, StadiumNum, TotRound, GameDay, GameTime, EnterType, EntryCnt, Level, LevelDtlName, LevelJooNum, LevelJooDivision, ViewYN) "
      LSQL = LSQL & " values ('"&tidx & "','"&tGameLevelIdx & "','" & tPlayLevelType2 & "', '" & tPlayLevelGroup & "' ,'B0040002','" & tStadium & "','" & tTotalRound & "','" & tGameDay & "', '" & tGameTime &"','" & tEnterType &"','" & tEntryCnt &"','" & tLevel &"','" & tLevelDtlName &"', '" & i & "','" & tJooDivision & "','" & tViewYN & "')" 
      LSQL = LSQL & " SELECT @@IDENTITY as IDX "
      'Response.Write "LSQLLSQLLSQLLSQLLSQL : "& LSQL &  "<br>"
      Set LRs = DBCon.Execute(LSQL)
      IF NOT (LRs.Eof Or LRs.Bof) Then
          Do Until LRs.Eof
          finalGameLevelDtlIdx = LRs("IDX")
        LRs.MoveNext
        Loop
      End If  
    End IF
    '---------?????? ????????? ??????--------


    '---------?????? LevelDtl ??? ????????? ??????--------
    Split_GameLevelDtlidxs = Split(GameLevelDtlidxs,"_")
    splitCnt = 0
    
    for each x in Split_GameLevelDtlidxs
      if(x <> "" )Then
        LevelDTLIdArr(splitCnt) = x
        splitCnt = splitCnt + 1
        'response.write("Split_PGameLevelidxs : " &  x & "<br />")
      End if
    next
    '---------?????? LevelDtl ??? ????????? ??????--------
      IF GroupGameGb = "B0030001" Then
        '---------????????? ?????? ??????--------
        LSQL = " SELECT COUNT(*) as GroupCnt "
        LSQL = LSQL & "FROM  tblGameRequestGroup   "
        LSQL = LSQL & " WHERE GameLevelIDX = '"  & tGameLevelIDX  & "' and DelYn ='N' "
        Set LRs = DBCon.Execute(LSQL)
        IF NOT (LRs.Eof Or LRs.Bof) Then
          Do Until LRs.Eof
            GroupCnt = LRS("GroupCnt")
            LRs.MoveNext
          Loop
        End IF
        '---------????????? ?????? ??????--------

        '---------????????? ?????? IDX ????????? ??????--------
        LSQL = " SELECT GameRequestGroupIDX  "
        LSQL = LSQL & " FROM  tblGameRequestGroup "
        LSQL = LSQL & " where GameLevelIDX = '" & tGameLevelIDX & "' and DelYN='N' "
        Set LRs = DBCon.Execute(LSQL)
        IF NOT (LRs.Eof Or LRs.Bof) Then
          GameRequestGroupArray = LRs.getrows()
        End If
        '---------????????? ?????? IDX ????????? ??????--------


        '---------????????? ?????? ?????? ???????????? ???????????? ????????????.-------
        RequestGroupArrayCnt = 0 
        If IsArray(GameRequestGroupArray) Then
            For ar = LBound(GameRequestGroupArray, 2) To UBound(GameRequestGroupArray, 2) 
              tGameRequestGroupIDX		= GameRequestGroupArray(0, ar) 
              RequestGroupArrayCnt = RequestGroupArrayCnt + 1
              currentArrayJoo =  (RequestGroupArrayCnt Mod tJooDivision) - 1
              
              if(currentArrayJoo < 0) Then
                currentArrayJoo = tJooDivision - 1
              End IF
              
              LSQL = " SET NOCOUNT ON insert into tblGameRequestTouney " 
              LSQL = LSQL & " ( RequestIDX, GroupGameGb, GameLevelDtlIDX) "
              LSQL = LSQL & " values ('"&tGameRequestGroupIDX & "','" &  GroupGameGb & "','"&  LevelDTLIdArr(currentArrayJoo) & "')" 
              LSQL = LSQL & " SELECT @@IDENTITY as IDX "
              'Response.Write "SQL :" & LSQL & "<BR>"
              
              Set LRs = DBCon.Execute(LSQL)
              IF NOT (LRs.Eof Or LRs.Bof) Then
                  Do Until LRs.Eof
                  GroupRequestGroupIdx = LRs("IDX")
                LRs.MoveNext
                Loop
              End If  
            Next

            '---------??????????????? ?????? ?????? ?????? ???????????? ????????? ????????? ????????????.-------
            if tGameType = "B0040002" Then
              'Response.Write "??????" & "<br>"
              for each x in Split_GameLevelDtlidxs
                if(x <> "" )Then

                  LSQL = " SELECT Count(*) as TouneyCnt " 
                  LSQL = LSQL & "  FROM  tblGameRequestTouney  "
                  LSQL = LSQL & "  where DelYN = 'N' and GameLevelDtlIDX = '" & x & "'"
                  'Response.Write "LSQL" & LSQL & "<br>"
                  
                  Set LRs_sub = DBCon.Execute(LSQL)
                  IF NOT (LRs_sub.Eof Or LRs_sub.Bof) Then
                    Do Until LRs_sub.Eof
                      TouneyCnt = LRs_sub("TouneyCnt")
                      LRs_sub.MoveNext
                    Loop
                  End IF

                  LRs_sub.close

                  '-------------?????? ??????-------------
                  drowCnt = GetDrowCnt(TouneyCnt)
                  '-------------?????? ??????-------------

                  '-----------?????? ?????? ??????----------
                  LSQL = " Update tblGameLevelDtl Set TotRound = '"  & drowCnt & "' " 
                  LSQL = LSQL & "   WHERE GameLevelDtlidx = '" &  x & "'" 
                  'Response.Write "SQL :" & LSQL & "<BR>"
                  Set LRs = DBCon.Execute(LSQL)
                  '-----------?????? ?????? ??????----------


                  '-----------?????? ?????? ??????----------
                  '-----------?????? ?????? ??????----------
                  

                End if
              next
            End if
             '---------??????????????? ?????? ?????? ?????? ???????????? ????????? ????????? ????????????.-------

        End If			
    END IF 
    '---------????????? ?????? ?????? ???????????? ???????????? ????????????.-------
        
    IF GroupGameGb = "B0030002" Then

      '---------?????? ?????? ??????--------
      LSQL = " SELECT COUNT(*) as TeamCnt "
      LSQL = LSQL & "FROM  tblGameRequestTeam   "
      LSQL = LSQL & " WHERE GameLevelIDX = '"  & tGameLevelIDX  & "' and DelYn ='N' "
      Set LRs = DBCon.Execute(LSQL)
      IF NOT (LRs.Eof Or LRs.Bof) Then
        Do Until LRs.Eof
          TeamCnt = LRS("TeamCnt")
          LRs.MoveNext
        Loop
      End IF
      '---------?????? ?????? ??????--------

      '---------?????? IDX ????????? ??????--------
      LSQL = " SELECT GameRequestTeamIDX  "
      LSQL = LSQL & " FROM  tblGameRequestTeam "
      LSQL = LSQL & " where GameLevelIDX = '" & tGameLevelIDX & "' and DelYN='N' "
      Set LRs = DBCon.Execute(LSQL)
      IF NOT (LRs.Eof Or LRs.Bof) Then
        GameRequestTeamArray = LRs.getrows()
      End If
      '---------?????? IDX ????????? ??????--------

      RequestGroupArrayCnt = 0 
      '---------????????? ?????? ?????? ???????????? ????????? ????????????.-------
      If IsArray(GameRequestTeamArray) Then
        For ar = LBound(GameRequestTeamArray, 2) To UBound(GameRequestTeamArray, 2) 
          tGameRequestTeamIDX		= GameRequestTeamArray(0, ar) 
          RequestTeamArrayCnt = RequestTeamArrayCnt + 1
          currentArrayJoo =  (RequestTeamArrayCnt Mod tJooDivision) - 1
          
          if(currentArrayJoo < 0) Then
            currentArrayJoo = tJooDivision - 1
          End IF
            
          LSQL = " SET NOCOUNT ON insert into tblGameRequestTouney " 
          LSQL = LSQL & " ( RequestIDX, GroupGameGb, GameLevelDtlIDX) "
          LSQL = LSQL & " values ('"&tGameRequestTeamIDX & "','" &  GroupGameGb & "','"&  LevelDTLIdArr(currentArrayJoo) & "')" 
          LSQL = LSQL & " SELECT @@IDENTITY as IDX "
          'Response.Write "SQL :" & LSQL & "<BR>"
          
          Set LRs = DBCon.Execute(LSQL)
          IF NOT (LRs.Eof Or LRs.Bof) Then
              Do Until LRs.Eof
              GroupRequestGroupIdx = LRs("IDX")
            LRs.MoveNext
            Loop
          End If  
        Next
        
         '---------??????????????? ?????? ?????? ?????? ???????????? ????????? ????????? ????????????.-------
        if tGameType = "B0040002" Then
          for each x in Split_GameLevelDtlidxs
            if(x <> "" )Then

              LSQL = " SELECT Count(*) as TouneyCnt " 
              LSQL = LSQL & "  FROM  tblGameRequestTouney  "
              LSQL = LSQL & "  where DelYN = 'N' and GameLevelDtlIDX = '" & x & "'"
              'Response.Write "LSQL" & LSQL & "<br>"
              Set LRs_sub = DBCon.Execute(LSQL)
              IF NOT (LRs_sub.Eof Or LRs_sub.Bof) Then
                Do Until LRs_sub.Eof
                  TouneyCnt = LRs_sub("TouneyCnt")
                  LRs_sub.MoveNext
                Loop
              End IF
              LRs_sub.close

              '-------------?????? ??????-------------
              drowCnt = GetDrowCnt(TouneyCnt)
              '-------------?????? ??????-------------

              '-----------?????? ?????? ??????----------
              LSQL = " Update tblGameLevelDtl Set TotRound = '"  & drowCnt & "' " 
              LSQL = LSQL & "   WHERE GameLevelDtlidx = '" &  x & "'" 
              'Response.Write "SQL :" & LSQL & "<BR>"
              Set LRs = DBCon.Execute(LSQL)
              '-----------?????? ?????? ??????----------

              '-----------?????? ?????? ??????----------
              '-----------?????? ?????? ??????----------

            End if
          next
        End If
        '---------??????????????? ?????? ?????? ?????? ???????????? ????????? ????????? ????????????.-------		
      End If			
      '---------????????? ?????? ?????? ???????????? ????????? ????????????.-------
  END IF
  Else
   
    
    'Response.Write "iPCnt : " & iPCnt & "<bR>"  
    'Response.Write "tJooRank : " & tJooRank & "<bR>"  

    LSQL = " SET NOCOUNT ON insert into tblGameLevelDtl " 
    LSQL = LSQL & " (GameTitleIDX, GameLevelidx, PlayLevelType, PlayLevelGroup, GameType, StadiumNumber, TotRound, GameDay, GameTime, EnterType, EntryCnt, Level, LevelDtlName, LevelJooNum,StadiumNum, LevelJooDivision, ViewYN, JooRank, FullGameYN) "
    LSQL = LSQL & " values ('"&tidx & "','"&tGameLevelIdx & "','" & tPlayLevelType & "', '" & tPlayLevelGroup & "' ,'" & tGameType & "','" & tStadiumNumber & "','" & tTotalRound & "','" & tGameDay & "', '" & tGameTime &"','" & tEnterType &"','" & tEntryCnt &"','" & tLevel &"','" & tLevelDtlName &"','" & tLevelJooNum &"','" & tStadium &"','" & tJooDivision  &"','" & tViewYN &"','" & tJooRank & "','" & tFullGameYN & "')" 
    LSQL = LSQL & " SELECT @@IDENTITY as IDX "
    
    'Response.Write "LSQLLSQLLSQLLSQLLSQLLSQLLSQL :" & LSQL & "<BR>"
    Set LRs = DBCon.Execute(LSQL)
    
    'IF NOT (LRs.Eof Or LRs.Bof) Then
    '    Do Until LRs.Eof
    '    IDX = LRs("IDX")
    '  LRs.MoveNext
    '  Loop
    'End If  
  End IF

  Call oJSONoutput.Set("result", 0 )
	strjson = JSON.stringify(oJSONoutput)
	Response.Write strjson
%>
  
<%
  DBClose()
%>
