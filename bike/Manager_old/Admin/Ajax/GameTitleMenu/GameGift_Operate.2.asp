<!-- #include file="../../dev/dist/config.asp"-->
<!-- #include file="../../classes/JSON_2.0.4.asp" -->
<!-- #include file="../../classes/JSON_UTIL_0.1.1.asp" -->
<!-- #include file="../../classes/json2.asp" -->
<script language="Javascript" runat="server">
function hasown(obj,  prop){
  if (obj.hasOwnProperty(prop) == true){
    return "ok";
  }
  else{
    return "notok";
  }
}
</script>
<%

Response.ContentType = "text/html"
Response.AddHeader "Content-Type", "text/html;charset=utf-8"
Response.CodePage = "65001"
Response.CharSet = "utf-8"

Const PersonGame = "B0030001"
Const GroupGame = "B0030002"

REQ = Request("Req")
REQ = "{""CMD"":4,""tGameTitleIDX"":""A0B63180CC3215B403232E31C8E393B4"",""tGameDay"":"""",""tStadiumIDX"":"""",""tSearchName"":"""",""tGroupGameGB"":""F9A43D4DE4191C125B08095CC465CD4B"",""tTotalClass"":""""}"
Set oJSONoutput = JSON.Parse(REQ)

If hasown(oJSONoutput, "tGameTitleIDX") = "ok" then
    If ISNull(oJSONoutput.tGameTitleIDX) Or oJSONoutput.tGameTitleIDX = "" Then
      GameTitleIDX = ""
      DEC_GameTitleIDX = ""
    Else
      GameTitleIDX = fInject(oJSONoutput.tGameTitleIDX)
      DEC_GameTitleIDX = fInject(crypt.DecryptStringENC(oJSONoutput.tGameTitleIDX))    
    End If
End if  

If hasown(oJSONoutput, "tGameDay") = "ok" then
    If ISNull(oJSONoutput.tGameDay) Or oJSONoutput.tGameDay = "" Then
      GameDay = ""
      DEC_GameDay = ""
    Else
      GameDay = fInject(oJSONoutput.tGameDay)
      DEC_GameDay = fInject(crypt.DecryptStringENC(oJSONoutput.tGameDay))    
    End If
End if  

If hasown(oJSONoutput, "tStadiumIDX") = "ok" then
    If ISNull(oJSONoutput.tStadiumIDX) Or oJSONoutput.tStadiumIDX = "" Then
      StadiumIDX = ""
      DEC_StadiumIDX = ""
    Else
      StadiumIDX = fInject(oJSONoutput.tStadiumIDX)
      DEC_StadiumIDX = fInject(crypt.DecryptStringENC(oJSONoutput.tStadiumIDX))    
    End If
End if  

If hasown(oJSONoutput, "tStadiumNumber") = "ok" then
    If ISNull(oJSONoutput.tStadiumNumber) Or oJSONoutput.tStadiumNumber = "" Then
      StadiumNumber = ""
      DEC_StadiumNumber = ""
    Else
      StadiumNumber = fInject(oJSONoutput.tStadiumNumber)
      DEC_StadiumNumber = fInject(crypt.DecryptStringENC(oJSONoutput.tStadiumNumber))    
    End If
End if  


If hasown(oJSONoutput, "PlayType") = "ok" then
    If ISNull(oJSONoutput.PlayType) Or oJSONoutput.PlayType = "" Then
      PlayType = ""
      DEC_PlayType = ""
    Else
      PlayType = fInject(oJSONoutput.PlayType)
      DEC_PlayType = fInject(crypt.DecryptStringENC(oJSONoutput.PlayType))    
    End If
End if  

If hasown(oJSONoutput, "IngType") = "ok" then
    If ISNull(oJSONoutput.IngType) Or oJSONoutput.IngType = "" Then
      IngType = ""
      DEC_IngType = ""
    Else
      IngType = fInject(oJSONoutput.IngType)
      DEC_IngType = fInject(crypt.DecryptStringENC(oJSONoutput.IngType))    
    End If
End if  

If hasown(oJSONoutput, "tSearchName") = "ok" then
    If ISNull(oJSONoutput.tSearchName) Or oJSONoutput.tSearchName = "" Then
      SchUserName = ""
      DEC_SchUserName = ""
    Else
      SchUserName = fInject(oJSONoutput.tSearchName)
      DEC_SchUserName = fInject(crypt.DecryptStringENC(oJSONoutput.tSearchName))    
    End If
End if  

If hasown(oJSONoutput, "tPlayLevelType") = "ok" then
  If ISNull(oJSONoutput.tPlayLevelType) Or oJSONoutput.tPlayLevelType = "" Then
    PlayLevelType = ""
    DEC_PlayLevelType = ""
  Else
    PlayLevelType = fInject(oJSONoutput.tPlayLevelType)
    DEC_PlayLevelType = fInject(crypt.DecryptStringENC(oJSONoutput.tPlayLevelType))    
  End If
End if  

If hasown(oJSONoutput, "tGroupGameGB") = "ok" then
  If ISNull(oJSONoutput.tGroupGameGB) Or oJSONoutput.tGroupGameGB = "" Then
    GroupGameGb = ""
    DEC_GroupGameGb = ""        
  Else
    GroupGameGb = fInject(oJSONoutput.tGroupGameGB)
    DEC_GroupGameGb = fInject(crypt.DecryptStringENC(oJSONoutput.tGroupGameGB))
  End If
Else  
  GroupGameGb = ""
  DEC_GroupGameGb = ""
End if	

If hasown(oJSONoutput, "tTotalClass") = "ok" then
  If ISNull(oJSONoutput.tTotalClass) Or oJSONoutput.tTotalClass = "" Then
    reqSex=""     
    reqPlayType=""     
    reqTeamGb=""     
    reqLevel=""     
    reqLevelName =""
    reqLevelJooNum=""     
  Else
    TotalClass = oJSONoutput.tTotalClass
    If InStr(TotalClass,"|") > 1 Then
      arr_TotalClass = Split(TotalClass,"|")
      reqSex = fInject(arr_TotalClass(0))
      reqPlayType = fInject(arr_TotalClass(1))
      reqTeamGb = fInject(arr_TotalClass(2))
      reqLevel = fInject(arr_TotalClass(3))
      reqLevelName = fInject(arr_TotalClass(4))
      reqLevelJooNum = fInject(arr_TotalClass(5))


      LSQL = "SELECT Top 1 GameLevelidx "
      LSQL = LSQL & " FROM tblGameLevel "
      LSQL = LSQL & " WHERE GameTitleIDX = '" & DEC_GameTitleIDX & "'"
      LSQL = LSQL & " And Sex = '" & reqSex & "'"
      LSQL = LSQL & " And PlayType = '" & reqPlayType & "'"
      LSQL = LSQL & " And TeamGb = '" & reqTeamGb & "'"
      LSQL = LSQL & " And Level = '" & reqLevel & "'"
      LSQL = LSQL & " And LevelJooName = '" & reqLevelName & "'"
      LSQL = LSQL & " And LevelJooNum = '" & reqLevelJooNum & "'"
      

      Set LRs = Dbcon.Execute(LSQL)
      If Not (LRs.Eof Or LRs.Bof) Then
        Do Until LRs.Eof
          reqGameLevelidx = LRs("GameLevelidx")
          LRs.MoveNext
        Loop
      Else
      End If      
      LRs.Close        
     
      
    End if
  End If
Else  
  reqSex=""     
  reqPlayType=""     
  reqTeamGb=""     
  reqLevel=""     
  reqLevelName =""
  reqLevelJooNum=""    
End if	




strjson = JSON.stringify(oJSONoutput)
Response.Write strjson
Response.write "`##`"
'Response.Write "lsql" & reqSex & "<br/>"
'Response.Write "reqSex" & reqSex & "<br/>"
'Response.Write "reqPlayType" & reqPlayType & "<br/>"
'Response.Write "reqTeamGb" & reqTeamGb & "<br/>"
'Response.Write "reqLevel" & reqLevel & "<br/>"
'Response.Write "reqLevelName" & reqLevelName & "<br/>"
'Response.Write "reqLevelJooNum" & reqLevelJooNum & "<br/>"

DEC_TempNum = ""
DEC_Searchkeyword =""
DEC_Searchkey = ""

DEC_Sex = reqSex
DEC_PlayType = reqPlayType
DEC_TeamGb = reqTeamGb
DEC_Level = reqLevel
DEC_reqLevelName = reqLevelName
DEC_LevelJooNum = reqLevelJooNum
DEC_GameLevelIdx= reqGameLevelidx
DEC_Searchkeyword = SchUserName
LSQL = " EXEC tblGameGiftTourney_Searched_STR '" & DEC_GameTitleIDX & "', '" & GameDay & "', '" & DEC_StadiumIDX &"' ,'"  & StadiumNumber &"','" & "" & "','" & PlayLevelType & "' ,'" & DEC_TempNum & "'  ,'" & DEC_Searchkey & "'  ,'"  & DEC_Searchkeyword & "','" & DEC_GroupGameGb & "','" & DEC_GameLevelIdx  & "'"
'Response.WRite "LSQL : " & LSQL & "<BR/>"
'Response.end
Set LRs = Dbcon.Execute(LSQL)
GameTourneyCnt = 0
If Not (LRs.Eof Or LRs.Bof) Then
    Do Until LRs.Eof
    Array_Players = ""
    GameTourneyCnt = GameTourneyCnt + 1 
    A_SexNM= LRs("SexNM")
    A_PlayTypeNM = LRs("PlayTypeNM")
    A_TeamGbNm= LRs("TeamGbNM")
    A_LevelNM= LRs("LevelNM")
    A_LevelJooNum= LRs("LevelJooNum")
    A_Team= LRs("Team")
    A_TeamNm= LRs("TeamNm")
    A_LevelJooName= LRs("LevelJooName")
    A_LevelJooNameNm= LRs("LevelJooNameNm")
    A_TeamDtl= LRs("TeamDtl")
    A_GameRanking = LRs("GameRanking")
    A_Players= LRs("Players")
    A_RequestIDX= LRs("RequestIDX")
    if A_RequestIDX <> "" Then
    crypt_RequestIDX = crypt.EncryptStringENC(A_RequestIDX)
    End IF
    A_GroupGameGb= LRs("GroupGameGb")
    crypt_GroupGameGb = crypt.EncryptStringENC(A_GroupGameGb)
    A_GameLevelDtlidx= LRs("GameLevelDtlidx")
    crypt_GameLevelDtlidx = crypt.EncryptStringENC(A_GameLevelDtlidx)
    IF A_Players <> "" Then
      Array_Players = Split(A_Players,"|")
    End IF
    A_IsGIft= LRs("IsGIft")
    A_ResultGangSu = GetGangSu(A_GameType, A_MaxRound,A_Round)
    A_Score= LRs("Score")
    A_SignData = LRs("SignData")

    'A_PlayLevelTypeNM= LRs("PlayLevelTypeNM")
    'A_GameType= LRs("GameType")
    'A_MaxRound = LRs("MaxRound")
    'A_Round = LRs("Round")

%>
        <tr>
          <td>
            <span><%Response.Write A_SexNM & A_PlayTypeNM & A_TeamGbNm & " " & A_LevelNM %>

            <%
              IF A_LevelJooNameNm <> "" Then
                RESPONSE.write  "-" & A_LevelJooNameNm  & A_LevelJooNum 
              End IF
            %>
            </span>
          </td>
          <td>
            <span><%
            IF A_GameRanking <> "0" and A_GameRanking <> "" Then
              Response.Write A_GameRanking & "???"
            End IF
            %>
            </span>
          </td>
          <td>
            <span><%=A_TeamNm%> <%IF LEN(A_TeamDtl) > 0 And A_TeamDtl <> "0" Then Response.Write A_TeamDtl End If%></span>
          </td>
          <td>
            <span>  <%
            'Response.Write "CDBL(UBound(Array_Players)):::" & CDBL(UBound(Array_Players))
          
              IF ISARRAY(Array_Players) = true Then
                IF CDBL(UBound(Array_Players)) <> -1   Then
                  Response.Write Array_Players(0)
               
                End IF
              END if
            %></span>
          </td>
          <td>
            <span>
            <% 
            IF ISARRAY(Array_Players) = true Then
              IF CDBL(UBound(Array_Players)) = 1 Then
                Response.Write Array_Players(1)
               
              End IF
            End IF
              
            %>
            </span>
          </td>
          <td>
            <span>
            <%
            IF A_GroupGameGb = PersonGame Then
            Response.Write A_Score
            End IF
            %></span>
          </td>
          <td>
            <a href="#" 
              <%If A_SignData <> "" AND NOT ISNULL(A_SignData) Then%>class="blue_btn"<%Else%>class="gray_btn"<%End If%>
              onclick="PopupGiftSign('<%=crypt_GameLevelDtlidx%>','<%=crypt_RequestIDX%>','<%=crypt_GroupGameGb%>','N');" data-toggle="modal" data-target=".play_detail_modal">????????????</a>
          </td>
          <td>
            <label class="switch">
              <input type="checkbox" id="<%=crypt_GameLevelDtlidx%>_<%=crypt_RequestIDX%>" name="<%=crypt_GameLevelDtlidx%>_<%=crypt_RequestIDX%>" class="switch-input" <% if A_IsGIft = "Y" Then%> checked <%End IF%> onclick="OnGiftStatusChanged('<%=crypt_GameLevelDtlidx%>','<%=crypt_RequestIDX%>','<%=crypt_GroupGameGb%>');">
              <span class="switch-label" data-on="??????" data-off="?????????"></span>
              <span class="switch-handle"></span>
            </label>
          </td>
        </tr>
    
    <%
            LRs.MoveNext
        Loop
    %>
   

    <% End If 
      IF CDBL(GameTourneyCnt) = 0 Then %>
    <tr>
      <td colspan="14">?????? ????????? ?????? ?????? ????????????.</td>
    </tr>
    <%
      End if
      Set LRs = Nothing
      DBClose()
      
    %>