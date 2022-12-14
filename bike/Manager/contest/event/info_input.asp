<!-- #include virtual = "/pub/header.bike.asp" -->

<%
req = request("req")
Set db = new clsDBHelper
If req <> "" Then
  Set oJSONoutput = JSON.Parse(req)
  eventIdx = oJSONoutput.eventIdx
  SQL =       " SELECT EventIdx, EventType, CourseLength, EventDetailType, GroupType, Gender, MinPlayer, MaxPlayer, EventDate, RatingCategory, MemberLimit, EntryFee "
  SQL = SQL & " FROM tblBikeEventList WHERE eventIdx = "& eventIdx &" AND DelYN = 'N' "
  Set rs = db.ExecSQLReturnRs(SQL, Null, B_ConStr)
  If Not rs.eof Then
    rsEventIdx          = rs("EventIdx")
    rsEventType       = rs("EventType")
    rsCourseLength    = rs("CourseLength")
    rsEventDetailType = rs("EventDetailType")
    rsGroupType       = rs("GroupType")
    rsGender          = rs("Gender")
    rsEventDate       = rs("EventDate")
    rsMinPlayer       = rs("MinPlayer")
    rsMaxPlayer       = rs("MaxPlayer")
    rsRatingCategory  = rs("RatingCategory")
    rsMemberLimit     = rs("MemberLimit")
    rsEntryFee        = rs("EntryFee")
  End If
End If

SQL = " SELECT Type, Code FROM tblBikeEventCode WHERE Type = 'EventType' "
Set rs = db.ExecSQLReturnRs(SQL, Null, B_ConStr)
If Not rs.eof Then
  arrEventType = rs.getrows()
End If

SQL = " SELECT Type, Code FROM tblBikeEventCode WHERE Type = 'CourseLength' "
Set rs = db.ExecSQLReturnRs(SQL, Null, B_ConStr)
If Not rs.eof Then
  arrCourseLength = rs.getrows()
End If

SQL = " SELECT Type, Code FROM tblBikeEventCode WHERE Type = 'EventDetailType' "
Set rs = db.ExecSQLReturnRs(SQL, Null, B_ConStr)
If Not rs.eof Then
  arrEventDetailType = rs.getrows()
End If

SQL = " SELECT Type, Code FROM tblBikeEventCode WHERE Type = 'GroupType' "
Set rs = db.ExecSQLReturnRs(SQL, Null, B_ConStr)
If Not rs.eof Then
  arrGroupType = rs.getrows()
End If

SQL = " SELECT Type, Code FROM tblBikeEventCode WHERE Type = 'Gender' "
Set rs = db.ExecSQLReturnRs(SQL, Null, B_ConStr)
If Not rs.eof Then
  arrGender = rs.getrows()
End If

SQL = " SELECT Type, Code FROM tblBikeEventCode WHERE Type = 'RatingCategory' "
Set rs = db.ExecSQLReturnRs(SQL, Null, B_ConStr)
If Not rs.eof Then
  arrRatingCategory = rs.getrows()
End If

SQL = " SELECT Type, Code FROM tblBikeEventCode WHERE Type = 'TeamSize' "
Set rs = db.ExecSQLReturnRs(SQL, Null, B_ConStr)
If Not rs.eof Then
  arrTeamSize = rs.getrows()
End If

SQL = " SELECT Type, Code FROM tblBikeEventCode WHERE Type = 'MemberLimit' "
Set rs = db.ExecSQLReturnRs(SQL, Null, B_ConStr)
If Not rs.eof Then
  arrMemberLimit = rs.getrows()
End If



%>
<!-- S: ????????? ??? -->
<div class="form-group">

  <div class="col-sm-1">
    <label class="control-label">????????????</label>
  </div>
  <div class="col-sm-2">
    <div class="input-group [ _date ]" id="">
      <input type="text" class="form-control" placeholder="????????????" id="eventDate" value="<%=rsEventDate%>">
      <span class="input-group-addon">
        <span class="glyphicon glyphicon-calendar"></span>
      </span>
    </div>
  </div>

  <div class="col-sm-1">
    <label class="control-label">????????????</label>
  </div>
  <div class="col-sm-2">
    <select id="eventType" class="form-control" onchange="addInput($(this))">
      <option value="" data-code="">=?????????=</option>
      <%
        If IsArray(arrEventType) Then
          For i = 0 To Ubound(arrEventType, 2)
            cType = arrEventType(0, i)
            Code = arrEventType(1, i)
            %><option value="" data-c-type="<%=cType%>" data-code="<%=Code%>" <% If CStr(rsEventType) = CStr(Code) Then %>selected<% End If %>><%=Code%></option><%
          Next
        End If
      %>
      <option value="add" data-c-type="<%=cType%>" >[????????????]</option>
    </select>
  </div>

  <div class="col-sm-1">
    <label class="control-label">??????/??????</label>
  </div>
  <div class="col-sm-2">
    <select id="groupType" class="form-control" onchange="addInput($(this))">
      <option value="" data-code="">=?????????=</option>
      <%
        If IsArray(arrGroupType) Then
          For i = 0 To Ubound(arrGroupType, 2)
            cType = arrGroupType(0, i)
            Code = arrGroupType(1, i)
            %><option value="" data-c-type="<%=cType%>" data-code="<%=Code%>" <% If CStr(rsGroupType) = CStr(Code) Then %>selected<% End If %>><%=Code%></option><%
          Next
        End If
      %>
      <option value="add" data-c-type="<%=cType%>">[????????????]</option>
    </select>
  </div>

  <div class="col-sm-1">
    <label class="control-label">??????</label>
  </div>
  <div class="col-sm-1">
    <select id="gender" class="form-control" onchange="addInput($(this))">
      <option value="" data-code="">=??????=</option>
      <%
        If IsArray(arrGender) Then
          For i = 0 To Ubound(arrGender, 2)
            cType = arrGender(0, i)
            Code = arrGender(1, i)
            %><option value="" data-c-type="<%=cType%>" data-code="<%=Code%>" <% If CStr(rsGender) = CStr(Code) Then %>selected<% End If %>><%=Code%></option><%
          Next
        End If
      %>
      <option value="add" data-c-type="<%=cType%>">[????????????]</option>
    </select>
  </div>

</div>
<!-- E: ????????? ??? -->


<!-- S: ????????? ??? -->
<div class="form-group">

  <div class="col-sm-1">
    <label class="control-label">??????</label>
  </div>
  <div class="col-sm-2">
    <select id="ratingCategory" class="form-control" onchange="addInput($(this))">
      <option value="" data-code="">=??????=</option>
      <%
        If IsArray(arrRatingCategory) Then
          For i = 0 To Ubound(arrRatingCategory, 2)
            cType = arrRatingCategory(0, i)
            Code = arrRatingCategory(1, i)
            %><option value="" data-c-type="<%=cType%>" data-code="<%=Code%>" <% If CStr(rsRatingCategory) = CStr(Code) Then %>selected<% End If %>><%=Code%></option><%
          Next
        End If
      %>
      <!-- <option value="add" data-c-type="<%=cType%>">[????????????]</option> -->
    </select>
  </div>

  <div class="col-sm-1">
    <label class="control-label">????????????</label>
  </div>
  <div class="col-sm-2">
    <select id="courseLength" class="form-control" onchange="addInput($(this))">
      <option value="" data-code="">=??????=</option>
      <%
        If IsArray(arrCourseLength) Then
          For i = 0 To Ubound(arrCourseLength, 2)
            cType = arrCourseLength(0, i)
            Code = arrCourseLength(1, i)
            %><option value="" data-c-type="<%=cType%>" data-code="<%=Code%>" <% If CStr(rsCourseLength) = CStr(Code) Then %>selected<% End If %>><%=Code%></option><%
          Next
        End If
      %>
      <option value="add" data-c-type="<%=cType%>">[????????????]</option>
    </select>
  </div>

  <div class="col-sm-1">
    <label class="control-label">??????</label>
  </div>
  <div class="col-sm-2">
    <select id="eventDetailType" class="form-control" onchange="addInput($(this))">
      <option value="" data-code="">=????????????=</option>
      <%
        If IsArray(arrEventDetailType) Then
          For i = 0 To Ubound(arrEventDetailType, 2)
            cType = arrEventDetailType(0, i)
            Code = arrEventDetailType(1, i)
            %><option value="" data-c-type="<%=cType%>" data-code="<%=Code%>" <% If CStr(rsEventDetailType) = CStr(Code) Then %>selected<% End If %>><%=Code%></option><%
          Next
        End If
      %>
      <option value="add" data-c-type="<%=cType%>">[????????????]</option>
    </select>
  </div>

  <div class="col-sm-1">
    <label class="control-label">??????</label>
  </div>
  <div class="col-sm-2" id="">
    <input type="text" class="form-control" placeholder="?????????" id="entryFee" value="<%=rsEntryFee%>">
  </div>
  <div class="col-sm-2">

  </div>


</div>
<!-- E: ????????? ??? -->


<!-- S: ????????? ??? -->
<div class="form-group">

  <div class="col-sm-1">
    <label class="control-label">?????????(??????)</label>
  </div>
  <div class="col-sm-1">
    <select id="minPlayer" class="form-control" onchange="addInput($(this))">
      <option value="" data-code="">=??????=</option>
      <%
        If IsArray(arrTeamSize) Then
          For i = 0 To Ubound(arrTeamSize, 2)
            cType = arrTeamSize(0, i)
            Code = arrTeamSize(1, i)
            %><option value="" data-c-type="<%=cType%>" data-code="<%=Code%>" <% If CStr(rsMinPlayer) = CStr(Code) Then %>selected<% End If %>><%=Code%></option><%
          Next
        End If
      %>
      <option value="add" data-c-type="<%=cType%>">[????????????]</option>
    </select>
  </div>

  <div class="col-sm-1">
    <label class="control-label">?????????(??????)</label>
  </div>
  <div class="col-sm-1">
    <select id="maxPlayer" class="form-control" onchange="addInput($(this))">
      <option value="" data-code="">=??????=</option>
      <%
        If IsArray(arrTeamSize) Then
          For i = 0 To Ubound(arrTeamSize, 2)
            cType = arrTeamSize(0, i)
            Code = arrTeamSize(1, i)
            %><option value="" data-c-type="<%=cType%>" data-code="<%=Code%>" <% If CStr(rsMaxPlayer) = CStr(Code) Then %>selected<% End If %>><%=Code%></option><%
          Next
        End If
      %>
      <option value="add" data-c-type="<%=cType%>">[????????????]</option>
    </select>
  </div>

  <div class="col-sm-1">
    <label class="control-label">????????????</label>
  </div>
  <div class="col-sm-1">
    <select id="memberLimit" class="form-control" onchange="addInput($(this))">
      <option value="" data-code="">=??????=</option>
      <%
        If IsArray(arrMemberLimit) Then
          For i = 0 To Ubound(arrMemberLimit, 2)
            cType = arrMemberLimit(0, i)
            Code = arrMemberLimit(1, i)
            %><option value="" data-c-type="<%=cType%>" data-code="<%=Code%>" <% If CStr(rsMemberLimit) = CStr(Code) Then %>selected<% End If %>><%=Code%></option><%
          Next
        End If
      %>
      <option value="add" data-c-type="<%=cType%>">[????????????]</option>
    </select>
  </div>

</div>
<!-- E: ????????? ??? -->


<div class="btn-group pull-right" role="group" aria-label="...">
  <a href="#" class="btn btn-primary" id="" onclick="accessEvent('insert')" accesskey="i">??????<span>(I)</span></a>
  <a href="#" class="btn btn-primary" id="" onclick="accessEvent('update', <%=rsEventIdx%>)" accesskey="e">??????<span>(E)</span></a>
  <a href="#" class="btn btn-danger" id="" onclick="accessEvent('delete', <%=rsEventIdx%>)" accesskey="r">??????<span>(R)</span></a>
</div>
