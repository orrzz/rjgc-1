
<%
option explicit
response.buffer=true
%>
<!--#include file="inc/setup.asp"-->
<!--#include file="inc/cj_cls.asp"-->
<%
'--�Զ������
Dim Rs,Sql,FoundErr
Dim SqlItem,RsItem
Dim ItemID,ItemName,WebName,WebUrl,ChannelID,ChannelDir,ClassID,SpecialID,selEncoding,ItemDemo,LoginType,LoginUrl,LoginPostUrl,LoginUser,LoginPass,LoginFalse,Colleclx,ListStr,radio,LPsString,LPoString,ListPaingStr2 ,ListPaingID1,ListPaingID2,ListPaingStr3,Passed,SaveFiles,CollecOrder,ListPaingType,Flag,ListUrl,ItemCollecDate,LsString,LoString,HsString,HoString,imhstr,imostr,x_tp,Script_Iframe,Script_Object,Script_Script,Script_Div,Script_Class,Script_Table,Script_Tr,Script_Span,Script_Img,Script_Font,Script_A,Script_Html,Script_Td,Stars,ReadPoint,radioid,Hits,SaveFileUrl,HttpUrlStr,FilterType,CollecNewsNum,Timing,picpath,strReplace,IncludePic,UploadFiles
Dim Thumb_WaterMark,Thumbs_Create
Dim TsString,ToString,CsString,CoString,DateType,DsString,DoString,UpDateTime,AuthorType,AsString,AoString,AuthorStr,CopyFromType,FsString,FoString,CopyFromStr,KeyType,KsString,KoString,KeyStr,NewsPaingType,NPsString,NPoString,NewsPaingStr,NewsPaingHtml,Author,NewsUrlPaing_s,NewsUrlPaing_o
Dim PicUrls,ListTypeCode,ListTypeUrlCode,TypeUrlArray,TypeNewsUrl,NewsTypeCode
Dim CopyFrom,Key,SqlF,RSF,Arr_Filters,strInstallDir,strChannelDir
Dim photourls,photourlo,PhotoPaingType,PhotoType_s,PhotoType_o,PhotoLurl_s,PhotoLurl_o,Phototypefy_s,Phototypefy_o,Phototypefyurl_s,Phototypefyurl_o,Phototypeurl_s,Phototypeurl_o,Title,Content
dim UpDateType
dim temp_Fields
Dim tClass,tSpecial,CurrentPage,MaxPerPage,Allpage,ItemNum,iItem,NewsArrayCode,NewsArray,Testi,HttpUrlType,UrlTest,NewsCode,NewsUrl,NewsPaingNext,NewsPaingNext_Code,TypeArray_Url
dim Newsimage,Newsim
Dim i_Channel,i_Class,i_Special,tmpDepth,i,ArrShowLine(20)
Dim ClassName,SpecialName,Item_add,action,action1,ListCode
Dim rs_num
Dim ZdField(999)'--���嶨
Colleclx=Skcj.ChkNumeric(Skcj.G("Colleclx"))
Colleclx=1
IF Colleclx=0 then
	Response.Write ("ģ��ID����!")
	Response.End
End if 
Response.Write(Trim(Request.Form("DClassID")))
ItemID=Skcj.G("ItemID")
action=Skcj.G("action")
action1=Skcj.G("action1")
Dim CjName : CjName=Skcj.GetItemConfig("CjName",Colleclx)
Call Skcj.Show_Top()
If action="edit" Or action1="edit" Or action="s1" And action1<>"add" Or action="s2" And action1<>"add" Then
Response.Write "<table width=""100%"" border=""0"" align=""center"" cellpadding=""0"" cellspacing=""1"" class=""tableBorder"">"
Response.Write "<tr class=""tdbg"">"
Response.Write "<td width=""65"" height=""30"" bgcolor=""#F3F3F3""><strong>����������</strong></td>"
Response.Write "<td height=""30"" bgcolor=""#F3F3F3""> <font color=red><a href=?action=edit&ItemID="& ItemID &">��������</a></font> >> <a href=?action=s1&ItemID="& ItemID &">��һ��</a> >> <a href=?action=s2&ItemID="& ItemID &">�ڶ���</a> >> <a href=?action=demo&ItemID="& ItemID &">��������</a> </td>"
Response.Write "</tr></table>"
End If
	Select Case action
	Case "config"
		Call config'�ɼ���������	
	Case "ClassCj"'�����ɼ�
		Call ClassCj
	Case "BeginClasscj"'��ʼ�����ɼ�
		Call BeginClasscj
	Case "add"
		Call addnew1()'����	
	Case "edit"
		Call addnew1()'����		
	Case "s1"
	    Call setup1()
	Case "s2"
		Call setup2()
	Case "demo"
		Call demo()
	Case "copy"	
       	Call copy()
	Case "Del"	
		Call Del()
	Case else
		Call Show_Manage()	
	End Select 
Call CloseConnItem()
'=================================
'�ɼ���Ŀ����
'=================================
Sub Show_Manage
Dim MaxPerPage
MaxPerPage=Skcj.GetItemConfig("MaxPerPage",Colleclx)
IF MaxPerPage=0 Then MaxPerPage=10
%>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
    <tr> 
      <td height="22" colspan="2" class="title"> <div align="center"><strong>��  Ŀ  ��  ��</strong></div></td>

    </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#cccccc" class="tableBorder">
  <form name="myform" method="POST" action="SK_getArticle.asp">
    <tr class="tdbg" style="padding: 0px 2px;">
      <td width="33" height="22" align="center" bgcolor="#f3f3f3">ѡ��</td>
      <td width="188" align="center" bgcolor="#f3f3f3">��Ŀ����</td>
      <td width="153" height="22" align="center" bgcolor="#f3f3f3">��������</td>
      <td width="133" align="center" bgcolor="#f3f3f3">����ר��</td>
      <td width="32" align="center" bgcolor="#f3f3f3">״̬</td>
      <td width="180" height="22" align="center" bgcolor="#f3f3f3">�ϴβɼ�</td>
      <td width="192" height="22" align="center" bgcolor="#f3f3f3">����</td>
    </tr>
    <%            
If Skcj.G("page")<>"" Then
    CurrentPage=Cint(Skcj.G("Page"))
Else
    CurrentPage=1
End If
Dim SqlTemp
ClassID=Skcj.ChkNumeric(Skcj.G("DclassID")) 
If ClassID=0 Then
	SqlTemp=""
Else
	SqlTemp=" And ClassID='" &ClassID&"'"	
End if                
Set RsItem=server.createobject("adodb.recordset") 
SqlItem="Select * from Item where Colleclx="& Colleclx &" "& SqlTemp &"  order by ItemID DESC"      
RsItem.open SqlItem,ConnItem,1,1
If Not RsItem.Eof Then
   RsItem.PageSize=MaxPerPage
   Allpage=RsItem.PageCount
   If Currentpage>Allpage Then Currentpage=1
   ItemNum=RsItem.RecordCount
   RsItem.MoveFirst
   RsItem.AbsolutePage=CurrentPage
   iItem=0
   Do While Not RsItem.Eof
      ItemID=RsItem("ItemID")
      ItemName=RsItem("ItemName")
      WebName=RsItem("WebName")
      ChannelID=RsItem("ChannelID")      
      ClassID=RsItem("ClassID")
      SpecialID=RsItem("SpecialID")
      ListStr=RsItem("ListStr")
      ListPaingType=RsItem("ListPaingType")
      ListPaingStr2=RsItem("ListPaingStr2")
      ListPaingID1=RsItem("ListPaingID1")
      ListPaingID2=RsItem("ListPaingID2")
      ListPaingStr3=RsItem("ListPaingStr3")
      Flag=RsItem("Flag")
      If  ListPaingType=0   Then
            ListUrl=ListStr
      ElseIf  ListPaingType=1  Then
            ListUrl=Replace(ListPaingStr2,"{$ID}",CStr(ListPaingID1))
      ElseIf  ListPaingType=2  Then
            If  Instr(ListPaingStr3,"|")>0  Then
            ListUrl=Left(ListPaingStr3,Instr(ListPaingStr3,"|")-1)
         Else
               ListUrl=ListPaingStr3
         End  If
      End  If
%>
    <tr class="tdbg" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" style="padding: 0px 2px; " >
      <td width="33" height="22" align="center" style=" border-bottom:#cccccc 1xp solid">
      <input type="checkbox" value="<%=ItemID%>" name="ItemID" ></td>
      <td width="188" align="center" style=" border-bottom:#cccccc 1xp solid"><a href="<%=ListStr%>" target="_bank"><%=ItemName%></a></td>
      <td width="153" align="center" style=" border-bottom:#cccccc 1xp solid" title="����Ƶ��-<%Call Admin_ShowChannel_Name(ChannelID)%>"><%Call Admin_ShowClass_Name(ChannelID,ClassID)%></td>
      <td width="133" align="center" style=" border-bottom:#cccccc 1xp solid"><%Call Admin_ShowSpecial_Name(ChannelID,SpecialID)%></td>
      <td width="32" align="center" style=" border-bottom:#cccccc 1xp solid"> <b>
        <%If Flag=True Then
                    Response.write "��"
          Else
                 Response.write "<font color=red>��</font>"
          End If
        %>
      </b> </td>
      <td width="180" align="center" style=" border-bottom:#cccccc 1xp solid;">
      <%
       Set Rs=connItem.execute("Select Top 1 CollecDate From Histroly Where ItemID=" & ItemID & " Order by HistrolyID desc")
       If Not Rs.Eof Then
          ItemCollecDate=rs("CollecDate")
       Else
          ItemCollecDate=""
       End If
       Set Rs=Nothing
       If ItemCollecDate<>"" Then
          Response.Write "<font color=""#FF0000"">"& ItemCollecDate &"</font>"
       Else
          Response.Write "���޼�¼"
       End If
       %>      </td>
      <td width="192" align="center" style=" border-bottom:#cccccc 1xp solid"><a href=SK_getArticle.asp?Action=copy&ItemID=<%=ItemID%>&Colleclx=<%= Colleclx %>>����</a> <a href=SK_getArticle.asp?Action=edit&ItemID=<%=ItemID%>&Colleclx=<%= Colleclx %>>�༭</a> <a href=Sk_Collection.asp?ItemID=<%=ItemID%>&ItemNum=1&ListNum=1&NewsSuccesNum=0&NewsFalseNum=0&ImagesNumAll=0&NewsNum_i=0>�ɼ�</a> <a href=SK_getArticle.asp?action=demo&ItemID=<%=ItemID%>&Colleclx=<%= Colleclx %>>����</a> <a href=SK_getArticle.asp?Action=Del&ItemID=<%=ItemID%>&Colleclx=<%= Colleclx %> onClick='return confirm("ȷ��Ҫɾ������Ŀ����������ѡ���⽫ɾ������Ŀ����Ŀ��Ϣ����ʷ��¼��������Ϣ 3 ����Ŀ�������ݡ�");'>ɾ��</a> </td>
    </tr>
    <%
      iItem=iItem+1
      If iItem>=MaxPerPage Then  Exit  Do
      RsItem.MoveNext
   Loop
%>
    <tr class="tdbg">
      <td colspan=7 height="30" >
        <input name="Action" type="hidden"  value="Del">
&nbsp;
        <input name="chkAll" type="checkbox" id="chkAll" onClick=CheckAll(this.form) value="checkbox" >
        ȫѡ </td>
    </tr>
    <tr class="tdbg">
      <td colspan=7 height="30" align=center><input name="Del" type="submit" class="lostfocus" style="cursor: hand;background-color: #cccccc;" value="���ٲɼ�">        
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input name="Del" type="submit" class="lostfocus" style="cursor: hand;background-color: #cccccc;" onClick='return confirm("ȷ��Ҫɾ��ѡ�е���Ŀ����������ѡ���⽫ɾ������Ŀ����Ŀ��Ϣ����ʷ��¼��������Ϣ 3 ����Ŀ�������ݡ�");' value=" ɾ&nbsp;&nbsp;�� ">
  &nbsp;&nbsp;&nbsp;&nbsp; </td>
    </tr>
    <%Else%>
    <tr class="tdbg">
      <td colspan='7' class="tdbg" align="center"><br>
        ϵͳ�����޲ɼ���Ŀ��</td>
    </tr>
    <%End If
RsItem.Close
Set  RsItem=Nothing
%>
  </form>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
    <tr> 
      <td height="22" colspan="2" class="tdbg">
<%
Response.Write ShowPage("SK_getArticle.asp",ItemNum,MaxPerPage,True,True," ����Ŀ")
%>

      </td>
    </tr>
</table>
<%
End Sub

'====================================
'�����ɼ�
'====================================
Sub ClassCj
    %>
   <table width="97%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
		<tr> 
		  <th height="22" colspan="2" class="title"> <div align="center"><b><% =ErrMsg_lx %>����&nbsp;��&nbsp;��</b></div></th>
		</tr>
		<tr>
		  <td height="22" colspan="2" ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
			<TR>
			  <TD width="19%" height=22  align=center bgcolor="#CAD7F7"> ���
				</DIV></TD>
			  <TD width="66%" height=22  align=center bgcolor="#CAD7F7"> ��Ŀ��������</TD>
			  <TD width="15%" height=22  align=center bgcolor="#CAD7F7"> ����</TD>
			</TR>
			<%
			Colleclx=Trim(Request("Colleclx"))
	select case Colleclx
	case 1
		Sql="select * from SK_class where ChannelID=1 order by OrderID" 
	case 3
		Sql="select * from SK_class where ChannelID=3 order by OrderID"  
	case 5
		Sql="select * from SK_class where ChannelID=5 order by OrderID"  
	case 0
		Call CloseConnItem
		Response.end
	end select
	set Rs=server.createobject("adodb.recordset")         
	Rs.open Sql,ConnItem,1,1
	do while not rs.eof
	%>
			<TR class="tdbg">
			  <TD width="19%" height=22  align=center bgcolor="#F2F2F2" class=tdbg><%=rs("classID")%>
			  </DIV></TD>
			  <TD width="66%" height=22  align=left bgcolor="#F2F2F2" class=tdbg>
				<%
			  If Rs("depth") = 1 Then Response.Write "&nbsp;&nbsp;<font color=""#666666"">��</font>"
			  If Rs("depth") > 1 Then
				For i = 2 To Rs("depth")
					Response.Write "&nbsp;&nbsp;<font color=""#666666"">��</font>"
				Next
				Response.Write "&nbsp;&nbsp;<font color=""#666666"">��</font> "
			  End If
			  If Rs("depth") = 0 Then Response.Write ("<b>")
			  Response.Write rs("className")
			  If Rs("depth")  = 0 Then Response.Write ("</b>")
			  %>
			  </DIV></TD>
			  <TD width="15%" height=22  align=center bgcolor="#F2F2F2" class=tdbg><a href=?Action=BeginClasscj&ClassID=<%=Rs("ClassID")%>>��ʼ�ɼ�</a></TD>
			</TR>
			<%
	rs.movenext
	loop
	rs.close
	set rs=nothing
	%>
		  </TABLE></td>
		</tr>
</table><%
End Sub
'============================================
'��ʼ�����ɼ�
'============================================
Sub BeginClasscj
	ClassID=Trim(Request("ClassID"))
	If ReturnSubClass(ClassID,1)="" then
		response.write "<script>alert('������û����Ŀ�ɼ���');history.go(-1);</script>"'�رմ���
		Response.end
	End if 
	ItemID=ReturnSubClass(ClassID,1)
	ItemID=Left(ItemID,len(ItemID)-1)
		Response.redirect "Sk_Collection.asp?ItemID="&ItemID&"&ItemNum=1&ListNum=1&NewsSuccesNum=0&NewsFalseNum=0&ImagesNumAll=0&NewsNum_i=0"
End Sub
'==========================================
'�ɼ���������
'==========================================
Sub config()
If Skcj.G("config")="save" Then
		SqlItem="Select top 1 Dir,MaxFileSize,FileExtName,Timeout,MaxPerPage from SK_Cj where ID=1"
     	Set Rs=server.CreateObject("adodb.recordset")
     	Rs.Open SqlItem,ConnItem,3,3
		rs("Timeout")=Skcj.ChkNumeric(Skcj.G("Timeout"))
		rs("Dir")=Skcj.G("Dir")
		rs("MaxFileSize")=Skcj.ChkNumeric(Skcj.G("MaxFileSize"))
		rs("FileExtName")=Skcj.G("FileExtName")
		rs("MaxPerPage")=Skcj.ChkNumeric(Skcj.G("MaxPerPage"))
		Rs.UpDate
      	Rs.Close	
	  	set rs=nothing
		response.write "<script>alert('�޸ĳɹ�!');</script>"'�رմ��� 
		config_main() 
Else
	config_main()
End If	
End Sub

Sub config_main()
set rs = ConnItem.execute("Select top 1 Dir,MaxFileSize,FileExtName,Timeout,MaxPerPage from SK_Cj where ID=1")
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder">
  <tr class='topbg'> 
    <th height="22" colspan="2" align="center" ><strong>�� �� �� �� �� �� ��</strong></th>
  </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder">
<form action="?action=config&config=save" method="post">
  <tr class="tdbg">
    <td width="20%" height="20" align="right" bgcolor="#F7F7F7"><STRONG>�ɼ���ʱ���ã�</STRONG></td>
    <td bgcolor="#F7F7F7"><input name="Timeout" type="text" class="lostfocus" value="<%= rs("Timeout") %>" size="10" maxlength="9">
    <STRONG>��</STRONG> <font class="alert">* Ĭ��64�� ���128K������64�뻹���ز���(��ÿ��2K���ع���)����ʱ��</font></td>
  </tr>
  <tr class="tdbg">
    <td height="20" align="right" bgcolor="#F7F7F7"><STRONG>��Ŀ�������ã�</STRONG></td>
    <td bgcolor="#F7F7F7"><input name="MaxPerPage" type="text" class="lostfocus" value="<%= rs("MaxPerPage") %>" size="10" maxlength="9">
      <strong>��</strong>      <font class="alert">* �ɼ���Ŀ������ʾ��������0Ϊ10����</font></td>
  </tr>
  <tr class="tdbg">
    <td width="20%" height="20" align="right" bgcolor="#F7F7F7"><STRONG>�������ص�ͼƬ��С��</STRONG></td>
    <td bgcolor="#F7F7F7"><input name="MaxFileSize" type="text" class="lostfocus" value="<%= rs("MaxFileSize") %>" size="15" maxlength="9">
    <STRONG>KB </STRONG> <font class="alert">* �����������롰0��</font></td>
  </tr>
  
  <tr class="tdbg">
    <td height="20" align="right" bgcolor="#F7F7F7"><STRONG>�ɼ������ַ��</STRONG></td>
    <td bgcolor="#F7F7F7"><input name="Dir" type="text" class="lostfocus" value="<% =rs("Dir") %>" size="27" maxlength="30">
    <font class="alert">&nbsp;��������"/"����</font></td>
  </tr>
  <tr class="tdbg">
    <td height="20" align="right" bgcolor="#F7F7F7"><STRONG>�ɼ������ļ����ͣ�</STRONG></td>
    <td height="30" bgcolor="#F7F7F7"><input name="FileExtName" type="text" class="lostfocus" value="<% =rs("FileExtName") %>" size="50" maxlength="300">
      <font class="alert">* ÿ���ļ��������á�|���ֿ� ��:Rm|swf|rar</font></td>
  </tr>
  <tr class="tdbg">
    <td height="38" align="right" bgcolor="#F7F7F7">&nbsp;</td>
    <td height="38" bgcolor="#F7F7F7"><input name="Submit2" type="submit" class="lostfocus" value="�ύ"></td>
  </tr>
  </form>
</table>
<%
Rs.Close	
set rs=nothing
End Sub

Sub addnew1()'��������
'call SetChannel
Colleclx=Skcj.G("Colleclx")
If action="edit" Or action1="edit" Then
   If ItemID<>"" Then
	   ItemID=Clng(ItemID)
	   SqlItem ="Select * from Item where ItemID=" & ItemID
	   Set RsItem=Server.CreateObject("adodb.recordset")
	   RsItem.Open SqlItem,ConnItem,1,1
	   If RsItem.Eof And RsItem.Bof  Then
		  FoundErr=True
		  ErrMsg=ErrMsg & "<br><li>��������û���ҵ�����Ŀ��</li>"
	   Else
		ItemName=RsItem("ItemName")
		ChannelID=RsItem("ChannelID")
		ClassID=RsItem("ClassID")
	   	SpecialID=RsItem("SpecialID")
		selEncoding=RsItem("selEncoding")
	   	WebUrl=RsItem("WebUrl")
	   	ListStr=RsItem("ListStr")
		ListPaingType=RsItem("ListPaingType")
		LPsString=RsItem("LPsString")
		LPoString=RsItem("LPoString")
		ListPaingStr2=RsItem("ListPaingStr2")
		Select Case ListPaingType
		   Case 0 
			  ListUrl=ListStr
		   Case 1
		   	  ListPaingID1=RsItem("ListPaingID1")
			  ListPaingID2=RsItem("ListPaingID2")
			  ListUrl=Replace(ListPaingStr2,"{$ID}",CStr(ListPaingID1))
		   Case 2
			  ListPaingStr3=RsItem("ListPaingStr3")
			  If  Instr(ListPaingStr3,"|")>0  Then
					ListUrl=Left(ListPaingStr3,Instr(ListPaingStr3,"|")-1)
			  Else
					ListUrl=ListPaingStr3
			  End  If
			  ListPaingStr3=Replace(ListPaingStr3,"|",CHR(13))
		End Select
	   	Colleclx=RsItem("Colleclx")
		SaveFileUrl=RsItem("SaveFileUrl")
		Passed=RsItem("Passed")
		SaveFiles=RsItem("SaveFiles")
		CollecOrder=RsItem("CollecOrder")
		Script_Iframe=RsItem("Script_Iframe")
     	Script_Object=RsItem("Script_Object")
		Script_Script=RsItem("Script_Script")
		Script_Div=RsItem("Script_Div")
		Script_Class=RsItem("Script_Class")
		Script_Span=RsItem("Script_Span")
		Script_Img=RsItem("Script_Img")
		Script_Font=RsItem("Script_Font")
		Script_A=RsItem("Script_A")
		Script_Html=RsItem("Script_Html")
		Script_Table=RsItem("Script_Table")
		Script_Tr=RsItem("Script_Tr")
		Script_Td=RsItem("Script_Td")
		Stars=RsItem("Stars")
		ReadPoint=RsItem("ReadPoint")
		Hits=RsItem("Hits")
		Colleclx=RsItem("Colleclx")
		Thumb_WaterMark=RsItem("Thumb_WaterMark")
		CollecNewsNum=RsItem("CollecNewsNum")
		Timing=RsItem("Timing")
		strReplace=RsItem("strReplace")
	   End If
   RsItem.Close
   Set RsItem=Nothing
   End If
End If
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
<form method="post" action="SK_getArticle.asp" name="myform" onSubmit="return CheckForm();">
    <tr> 
      <td height="22" colspan="2" class="title"> <div align="center"><strong>�� �� �� 
		�� Ŀ--�� �� �� ��</strong></div></td>
    </tr>
    <tr class="tdbg"> 
      <td width="20%" align="right" bgcolor="#F3F3F3" class="txtlist"><strong>��Ŀ���ƣ�</strong></td>
      <td width="75%" bgcolor="#F3F3F3" class="tdbg">
	  <input name="ItemName" type="text" class="lostfocus" value="<%= ItemName %>" size="27" maxlength="30">&nbsp;&nbsp;<font color=red>*</font>�磺���������������� �ȼ�������      </td>
    </tr>
    
    <tr class="tdbg"> 
      <td width="20%" align="right" bgcolor="#F3F3F3" class="txtlist"><strong> �������ࣺ</strong></td>
      <td width="75%" bgcolor="#F3F3F3" class="tdbg"><Select ID="ClassID" name="ClassID"><%Call InitClassSelectOption(1,0,ClassID)%></Select>       </td>
    </tr>
    

    <tr>
      <td align="right" bgcolor="#F3F3F3" class="txtlist"><STRONG>Ŀ����ҳ���룺</STRONG></td>
      <td bgcolor="#F3F3F3" ><font color=blue>��ѡ������</font></span>      <Select name="selEncoding" size="1" onChange="Encoding.value=this.value;">
        <option>��ѡ�����</option>
        <option value="GB2312" Selected <% If selEncoding="GB2312" Then Response.Write "Selected" %>>GB2312</option>
        <option value="UTF-8" <% If selEncoding="UTF-8" Then Response.Write "Selected" %>>UTF-8</option>
        <option value="BIG5" <% If selEncoding="BIG5" Then Response.Write "Selected" %>>BIG5</option>
          </Select></td>
    </tr>
    
    <tr class="tdbg">
      <td  align="right" bgcolor="#F3F3F3" class="txtlist"><strong>Զ���б�URL:</strong></td>
      <td bgcolor="#F3F3F3" class="tdbg"><input name="ListStr" type="text" class="lostfocus"  value="<%= ListStr %>" size="80" maxlength="200">
        <font color=red>*</font></td>
    </tr>
    <tr class="tdbg">
      <td  align="right" bgcolor="#F3F3F3" class="txtlist"><strong>�б���ҳ�ɼ�����:</strong></td>
      <td bgcolor="#F3F3F3" class="tdbg">
	  <input type="radio" value="0" name="ListPaingType" <% If ListPaingType=0 Or ListPaingType="" Then Response.Write "checked" %> onClick="ListPaing2.style.display='none';ListPaing3.style.display='none';ListPaing4.style.display='none'">
        ��������&nbsp;&nbsp;
        <input type="radio" value="1" name="ListPaingType" <% If ListPaingType=1 Then Response.Write "checked" %> onClick="ListPaing2.style.display='';ListPaing3.style.display='none';ListPaing4.style.display='none'">
        ��������&nbsp;
        <input type="radio" value="2" name="ListPaingType" <% If ListPaingType=2 Then Response.Write "checked" %> onClick="ListPaing2.style.display='none';ListPaing3.style.display='';ListPaing4.style.display='none'">
      �ֶ����� <input type="radio" value="3" name="ListPaingType" <% if ListPaingType=3 then Response.Write "checked" %> onClick="ListPaing2.style.display='none';ListPaing3.style.display='none';ListPaing4.style.display=''">
      �����ȡ</td>
    </tr>
    
    <tr  class="tdbg" id="ListPaing2" <% If ListPaingType<>1 Then Response.Write "style=""display:none""" %> >
      <td  align="right" bgcolor="#F3F3F3" class="txtlist"><strong><font color=blue>�������ɣ�</font></strong></td>
      <td bgcolor="#F3F3F3" class="tdbg"><input name="ListPaingStr2" type="text" class="lostfocus" value="<% =ListPaingStr2 %>" size="80" maxlength="200">
        ��ҳ���� <font color=red>{$ID}</font><br>
��ʽ��http://www.scuta.net/list.asp?page={$ID}<br>
���ɷ�Χ��<br>
<input name="ListPaingID1" value="<%= ListPaingID1 %>" type="text" class="lostfocus" size="8" maxlength="200">
<span lang="en-us"> To </span>
<input name="ListPaingID2"  value="<%= ListPaingID2 %>" type="text" class="lostfocus" size="8" maxlength="200"> 
���磺1 - 9 ���� 9 - 1<br>
��ʽ��ֻ�������֣���������߽��� </td>
    </tr>
    
    <tr class="tdbg" id="ListPaing3" <% If ListPaingType<>2 Then Response.Write "style=""display:none""" %>>
      <td  align="right" bgcolor="#F3F3F3" class="txtlist" ><strong><font color=blue>�ֶ����ӣ�</font></strong></td>
      <td bgcolor="#F3F3F3" class="tdbg"><textarea name="ListPaingStr3" cols="60" rows="7" class="lostfocus"><%= ListPaingStr3 %></textarea>
      ��ʽ������һ����ַ�󰴻س�����������һ��</td>
    </tr>
	 <tr class="tdbg" bgcolor="#F3F3F3" id="ListPaing4" <% if ListPaingType<>3 then Response.Write "style=""display:none""" %> >
	   <td height="30" align="right"><strong><font color=blue>��ҳ��ʼ��ǣ�</font></strong>
	     <p>��</p>
       <strong><font color=blue>��ҳ������ǣ�</font></strong></td>
	   <td><textarea name="LPsString" cols="60" rows="7" class="lostfocus"><%= LPsString %></textarea>
         <br>
         <textarea name="LPoString" cols="60" rows="7" class="lostfocus"><%= LPoString %></textarea></td>
    </tr>
	 <tr class="tdbg" bgcolor="#F3F3F3">
	   <td height="30" align="right"><STRONG>�ɼ�ͼƬ�ļ�����Ŀ¼</STRONG>��</td>
	   <td><input name="SaveFileUrl" type="text" class="lostfocus" value="<% =SaveFileUrl %>" size="80" maxlength="200">
       <font class="alert">&nbsp;��������"/"����</font></td>
    </tr>
	 
	 <tr class="tdbg" bgcolor="#F3F3F3">
	   <td height="30" align="right"><STRONG>�������ã�</STRONG></td>
	   <td><input name="Passed" type="checkbox" value="yes" <%If Passed=1 Then response.write "checked"%> style="border: 0px;background-color: #eeeeee;">
�������
  <input name="SaveFiles" type="checkbox" value="yes" <%If SaveFiles=1 Then response.write "checked"%> <%If IsObjInstalled("Scripting.FileSystemObject")=False Then Response.Write "disabled"%> style="border: 0px;background-color: #eeeeee;">
����ͼƬ 
<input name="Thumb_WaterMark" type="checkbox" style="border: 0px;background-color: #eeeeee;" value="yes"  <%If Thumb_WaterMark=1 Then response.write "checked"%>>
ͼƬˮӡ
<input name="Timing" type="checkbox" style="border: 0px;background-color: #eeeeee;" value="yes"  <%If Timing=1 Then response.write "checked"%>>
��ʱ�ɼ�
<input name="CollecOrder" type="checkbox" style="border: 0px;background-color: #eeeeee;" value="yes"  <%If CollecOrder=1 Then response.write "checked"%>>
����ɼ�</td>
    </tr>
	 <tr class="tdbg" bgcolor="#F3F3F3">
	   <td height="30" align="right"><STRONG>��������</STRONG>��</td>
	   <td>
	   <input name="SKxiuok" type="radio" value="radiobutton" onClick="SKxiuok1.style.display='none';SKxiuok2.style.display='none';SKxiuok3.style.display='none';SKxiuok4.style.display='none';SKxiuok5.style.display='none';SKxiuok6.style.display='none';" checked>
	    ����
	    <input type="radio" name="SKxiuok" onClick="SKxiuok1.style.display='';SKxiuok2.style.display='';SKxiuok3.style.display='';SKxiuok4.style.display='';SKxiuok5.style.display='';SKxiuok6.style.display='';"  value="radiobutton"> 
	    ��ʾ	   </td>
    </tr>
	 <tr class="tdbg" bgcolor="#F3F3F3" id="SKxiuok1" style="display:none" >
      <td height="30" width="20%" align="right"><b><font color=blue>��ǩ���ˣ�</font></b></td>
      <td>
        <input name="Script_Iframe" type="checkbox" value="yes" <%If Script_Iframe=1 Then response.write "checked"%> style="border: 0px;background-color: #eeeeee;">
        Iframe
        <input name="Script_Object" type="checkbox" value="yes" <%If Script_Object=1 Then response.write "checked"%> onclick='return confirm("ȷ��Ҫѡ��ñ�����⽫ɾ�������е�����Object��ǣ���������¸������е�����Flash������ɾ����");' style="border: 0px;background-color: #eeeeee;">
        Object
        <input name="Script_Script" type="checkbox" value="yes" <%If Script_Script=1 Then response.write "checked"%> style="border: 0px;background-color: #eeeeee;">
        Script
        <input name="Script_Div" type="checkbox"  value="yes" <%If Script_Div=1 Then response.write "checked"%> style="border: 0px;background-color: #eeeeee;">
        Div
        <input name="Script_Class" type="checkbox"  value="yes" <%If Script_Class=1 Then response.write "checked"%> style="border: 0px;background-color: #eeeeee;">
        Class
        <input name="Script_Table" type="checkbox"  value="yes" <%If Script_Table=1 Then response.write "checked"%> style="border: 0px;background-color: #eeeeee;">
        Table
        <input name="Script_Tr" type="checkbox"  value="yes" <%If Script_Tr=1 Then response.write "checked"%> style="border: 0px;background-color: #eeeeee;">
        Tr
        <br>
        <input name="Script_Span" type="checkbox"  value="yes" <%If Script_Span=1 Then response.write "checked"%> style="border: 0px;background-color: #eeeeee;">
        Span&nbsp;&nbsp;
        <input name="Script_Img" type="checkbox" value="yes" <%If Script_Img=1 Then response.write "checked"%> style="border: 0px;background-color: #eeeeee;">
        Img&nbsp;&nbsp;&nbsp;
        <input name="Script_Font" type="checkbox"  value="yes" <%If Script_Font=1 Then response.write "checked"%> style="border: 0px;background-color: #eeeeee;">
        Font&nbsp;&nbsp;
        <input name="Script_A" type="checkbox" value="yes" <%If Script_A=1 Then response.write "checked"%> style="border: 0px;background-color: #eeeeee;">
        A&nbsp;&nbsp;
        <input name="Script_Html" type="checkbox" value="yes" <%If Script_Html=1 Then response.write "checked"%> onclick='return confirm("ȷ��Ҫѡ��ñ�����⽫ɾ�������е�����Html��ǣ���������¸����µĿɲ鿴�Խ��ͣ�");' style="border: 0px;background-color: #eeeeee;">
        Html&nbsp;
        <input name="Script_Td" type="checkbox"  value="yes" <%If Script_Td=1 Then response.write "checked"%> style="border: 0px;background-color: #eeeeee;">
        Td        </td>
    </tr>
    
     <tr class="tdbg" bgcolor="#F3F3F3" id="SKxiuok2" style="display:none" >
       <td align="right"><b><font color=blue>�����ַ��滻������</font></b></td>
       <td><table width="98%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="70%"><select name="strReplace" size="2" id="strReplace" style="width:400;height:100" ondblclick="return ModifyReplace();">
		   <%
		   	If Not IsNull(strReplace) Then
					Dim strReplaceArray 
					strReplaceArray = Split(strReplace, "$$$")
					For i = 0 To UBound(strReplaceArray)
						If Len(strReplaceArray(i)) > 1 Then
							Response.Write "      <option value=""" & strReplaceArray(i) & """>" & strReplaceArray(i) & "</option>" & vbCrLf
						End If
					Next
					
			End If
		   %>
           </select>           </td>
           <td width="30%" align="left">      <input type="button" name="addreplace" value="�����滻�ַ�" onClick="AddReplace();">
             <br><br style="overflow: hidden; line-height: 5px">
      <input type="button" name="modifyreplace" value="�޸ĵ�ǰ�ַ�" onClick="return ModifyReplace();">
      <br><br style="overflow: hidden; line-height: 5px">
      <input type="button" name="delreplace" value="ɾ����ǰ�ַ�" onClick="DelReplace();">
      <br>
      <input type="hidden" name="ReplaceList" value=""></td>
         </tr>
       </table>       </td>
     </tr>
     <tr class="tdbg" bgcolor="#F3F3F3" id="SKxiuok3" style="display:none" >
       <td align="right"><b><font color=blue>�������ƣ�</font></b></td>
	   <% if CollecNewsNum="" then CollecNewsNum=0 %>
       <td><input name="CollecNewsNum" type="text" id="CollecNewsNum" value="<%=CollecNewsNum%>" size="10" maxlength="10"> 
         <font color='#0000FF'>0Ϊ�ɼ����� �ɹ����� </font></td>
     </tr>
    <tr class="tdbg" bgcolor="#F3F3F3"  id="SKxiuok4" style="display:none" >
      <td align="right"><b><font color=blue>���ֵȼ���</font></b></td>
      <td>
	  <% If Stars=0 Then Stars=5 %>
	  <Select name="Stars">
            <option value="5" Selected <%If Stars=5 Then response.write "Selected"%>>������</option>
            <option value="4" <%If Stars=4 Then response.write "Selected"%>>�����</option>
            <option value="3" <%If Stars=3 Then response.write "Selected"%>>����</option>
            <option value="2" <%If Stars=2 Then response.write "Selected"%>>���</option>
            <option value="1" <%If Stars=1 Then response.write "Selected"%>>��</option>
        </Select>      </td>
    </tr>
	<tr class="tdbg" bgcolor="#F3F3F3"  id="SKxiuok5" style="display:none" >
      <td align="right"><b><font color=blue>�鿴������</font></b></td>
      <td><input name='ReadPoint' type='text' id='ReadPoint' value='<%=ReadPoint%>' size='5' maxlength='3'>
      <font color='#0000FF'>�������0�����û��鿴��<%=radioid%>ʱ��������Ӧ�����������οͺ͹���Ա��Ч��</font>      </td>
    </tr>
	<tr class="tdbg" bgcolor="#F3F3F3"  id="SKxiuok6" style="display:none" >
      <td align="right"><b><font color=blue>�������ʼֵ��</font></b></td>
      <td><input name="Hits" type="text" id="Hits" value="<%=Hits%>" size="10" maxlength="10">
        <font color='#0000FF'>�⹦�����ṩ������Ա�����õġ�����������Ҫ��ѽ��^_^</font>      </td>
    </tr>
    <tr class="tdbg"> 
      <td height="30" colspan="2" align="center" bgcolor="#F3F3F3" class="tdbg">
	  <% 
	  Select Case action 
	  Case "add" 
	  Response.Write "<input name=""Action1"" type=""hidden"" id=""Action"" value=""add"">"
	  Case "edit"
	  Response.Write "<input name=""Action1"" type=""hidden"" id=""Action"" value=""edit"">"
	  End Select
	    %>
	  <input name="ItemID" type="hidden" id="ItemID" value="<%=ItemID%>">
	   <input name="Action" type="hidden" id="Action" value="s1">
	   <input name="Colleclx" type="hidden" id="Action" value="<%= Colleclx %>">
        <input name="Cancel" type="button" class="lostfocus" id="Cancel" style="cursor: hand;background-color: #cccccc;" onClick="window.location.href='SK_getArticle.asp'" value=" ��&nbsp;&nbsp;�� ">
        &nbsp; 
      <input name="Submit"  type="submit" class="lostfocus" style="cursor: hand;background-color: #cccccc;" value="��&nbsp;һ&nbsp;��">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <input type="checkbox" name="ShowCode" value="checkbox">��ʾԴ��</td>
    </tr>
</form>
</table>


  
</body>         
</html>
<%End Sub%>
<%
Sub setup1()'��һ��
If Action1="edit" And Action="s1" Or Action1="add" Then
	Req_Err_msg 1 '����ύ���ò�����
	If FoundErr<>True And Skcj.G("ShowCode")="checkbox" Then
		  ListCode=Skcj.ReplaceTrim(Skcj.GetHttpPage(ListUrl,selEncoding))
		  If ListCode="$False$" Then
			 FoundErr=True
			 ErrMsg=ErrMsg & "<br><li>�ڻ�ȡ:" & ListUrl & "��ҳԴ��ʱ��������</li>"
		  End If
	End If
End If
If FoundErr=True Then
   call WriteErrMsg(ErrMsg)
Else
If Skcj.G("ShowCode")="checkbox" Then
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
    <tr> 
      <td height="22" colspan="2" class="title"> <div align="center"><strong>�� Ŀ �� �� -- �ɼ�Ŀ����վԴ����&nbsp;&nbsp;&nbsp;&nbsp; </strong>
	  <input type="radio" value="0" name="ShowCodeobt"  onClick="ShowCode1.style.display='none';">
        ����Դ���봰��&nbsp;&nbsp;
        <input type="radio" value="0" name="ShowCodeobt" checked onClick="ShowCode1.style.display='';">
        ��ʾԴ���봰��&nbsp;
		</div>
	  </td>
    </tr>
    <tr class="tdbg" class="tdbg" id="ShowCode1"> 
      <td height="22" colspan="2" bgcolor="f3f3f3" class="tdbg" align="center">
        <textarea name="showCode" cols="120" rows="10" class="lostfocus"><%=ListCode%></textarea><br>�ɼ���Ŀ���ַ ��<a href=<%=ListUrl%> target="_blank"><%=ListUrl%></a> <a href='view-source:<%=ListUrl%>' target='_blank'><font color='blue'>����鿴Ŀ��Դ����</font></a></td>
    </tr>
</table>
<% End If 

If action="edit" Or action1="edit" Or action="s1" And action1<>"add" Then'�Ƿ��������������
Set RsItem=ConnItem.execute("Select * from Item where ItemID=" & ItemID)
	  HttpUrlType=RsItem("HttpUrlType")'�ض�����
	  HttpUrlStr=RsItem("HttpUrlStr")'�ض�����
	  LsString=RsItem("LsString")
   	  LoString=RsItem("LoString")
	  HsString=RsItem("HsString")
  	  HoString=RsItem("HoString")
  	  ListUrl=RsItem("ListStr")
	  imhstr=RsItem("imhstr")
      imostr=RsItem("imostr")
	  x_tp=RsItem("x_tp")
	  selEncoding=RsItem("selEncoding")
	  RsItem.close
	  set RsItem=nothing
	  action1="edit"
End If
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
<form method="post" action="?" name="form1">
    <tr> 
      <td height="22" colspan="2" class="title"> <div align="center"><strong>		�� Ŀ--�б���������</strong></div></td>
    </tr>
    <tr class="tdbg">
      <td align="right" bgcolor="f3f3f3" class="tdbg" ><strong>�б���ʼ���룺</strong></td>
      <td bgcolor="f3f3f3" class="tdbg"><textarea name="LsString" cols="70" rows="7" class="lostfocus"><%=LsString %></textarea></td>
    </tr>
    <tr class="tdbg">
      <td align="right" bgcolor="f3f3f3" class="tdbg" ><strong>�б��������룺</strong></td>
      <td bgcolor="f3f3f3" class="tdbg"><textarea name="LoString" cols="70" rows="7" class="lostfocus"><%=LoString %></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><strong>���ӿ�ʼ���룺</strong></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
        <textarea name="HsString" cols="70" rows="7" class="lostfocus"><%= HsString %></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><strong>���ӽ������룺</strong></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
      <textarea name="HoString" cols="70" rows="7" class="lostfocus"><%= HoString %></textarea></td>
    </tr>
	<tr class="tdbg"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><strong>�ض����ӵ�ַ��</strong></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
       <input type="radio" name="HttpUrlType" value="0" <% If HttpUrlType=0 Or HttpUrlType="" Then Response.Write("checked")%>  onClick="HttpUrlType1.style.display='none'">�Զ�����
	   <input type="radio" name="HttpUrlType" value="1" <% If HttpUrlType=1 Then Response.Write("checked")%> onClick="HttpUrlType1.style.display=''">
��������λ��
	   </td>
    </tr>
	<tr class="tdbg" id="HttpUrlType1" style="display:none" >
      <td align="right" bgcolor="f3f3f3" class="tdbg" ><b><font color=blue>�ض������ַ���</font></b></td>
      <td bgcolor="f3f3f3" class="tdbg">
      <input name="HttpUrlStr" type="text" size="70" maxlength="200" value="<%=HttpUrlStr%>" class="lostfocus">
	  <br>
	  ��:javascript:Openwin("<font color="#FF0000">8785</font>") <br>
	  function Openwin(ID) {
  		popupWin = window.open('<font color="#FF0000">http://www.iising.com/</font>'+ ID + '<font color="#FF0000">.html</font>','','width=517,height=400,scrollbars=yes')}<br>
		<font color="#FF0000">��ȷ����:http://www.iising.com/{$ID}.html</font>
	  </td>
    </tr>
    <tr class="tdbg">
      <td align="right" bgcolor="f3f3f3" class="tdbg" ><strong>�б�Сͼ�����ã�</strong></td>
      <td bgcolor="f3f3f3" class="tdbg">
	  
	  <input type="radio" name="x_tp" value="0" <% If x_tp=0 Or x_tp="" Then Response.Write("checked")%>  onClick="picl1.style.display='none'">
��������
  <input type="radio" name="x_tp" value="1" <% If x_tp=1 Then Response.Write("checked")%> onClick="picl1.style.display=''">
�б�Сͼ</td>
    </tr>
    <tr class="tdbg" id="picl1" <% If x_tp<>1 Then Response.Write "style=""display:none"""  %> >
      <td align="right" bgcolor="f3f3f3" class="tdbg" ><p><strong><font color=blue>�б�СͼƬ��ʼ���룺</font>
      </strong></p>
      <p>&nbsp;</p>
      <p><strong><font color=blue>�б�СͼƬ�������룺</font></strong></p></td>
      <td bgcolor="f3f3f3" class="tdbg"><textarea name="imhstr" cols="70" rows="7" id="imhstr" class="lostfocus"><%= imhstr %></textarea>
      <textarea name="imostr" cols="70" rows="7" id="imostr" class="lostfocus"><%= imostr %></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td colspan="2" align="center" bgcolor="f3f3f3" class="tdbg" height="30">
        <input name="ItemID" type="hidden" value="<%=ItemID%>">
		 <input name="selEncoding" type="hidden" value="<%=selEncoding%>">
		 <% 
	  Select Case action1 
	  Case "add" 
	  Response.Write "<input name=""Action1"" type=""hidden"" id=""Action"" value=""add"">"
	  Case "edit"
	  Response.Write "<input name=""Action1"" type=""hidden"" id=""Action"" value=""edit"">"
	  End Select
	    %>
		
		<input name="Action" type="hidden" id="Action" value="s2">
		
        <input  type="button" name="button1" class="lostfocus"  value="��&nbsp;һ&nbsp;��" onClick="window.location.href='javascript:history.go(-1)'"  style="cursor: hand;background-color: #cccccc;">
        &nbsp;&nbsp;&nbsp;&nbsp; 
      <input  type="submit" name="Submit" class="lostfocus"  value="��&nbsp;һ&nbsp;��" style="cursor: hand;background-color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <input type="checkbox" name="ShowCode" value="checkbox">��ʾԴ��</td>
    </tr>
</form>
</table>
<%
End If
End Sub'��һ����

Sub setup2()'�ڶ���
	Req_Err_msg 2
	'======================��ʾԶ��Դ��==============
	If FoundErr<>True And Skcj.G("ShowCode")="checkbox" Then'�õ�Զ��Դ��
	 ListCode=Skcj.ReplaceTrim(Skcj.GetHttpPage(ListUrl,selEncoding))
	   If ListCode<>"$False$" Then
		 ListCode=SKcj.GetBody(ListCode,LsString,LoString,False,False)
		  If ListCode<>"$False$" Then 
			 NewsArrayCode=Skcj.GetArray(ListCode,HsString,HoString,False,False)
			 If x_tp =1 Then
				Newsimage=Skcj.GetArray(ListCode,imhstr,imostr,False,False)
			 End If
			 If NewsArrayCode<>"$False$" Then
				   NewsArray=Split(NewsArrayCode,"$Array$")
				   For Testi=0 To Ubound(NewsArray)
					  If HttpUrlType=1 Then
						 NewsArray(Testi)=Replace(HttpUrlStr,"{$ID}",NewsArray(Testi))
					  Else
						 NewsArray(Testi)=Skcj.FormatRemoteUrl(NewsArray(Testi),ListUrl)
					  End If
				   Next
				   UrlTest=NewsArray(0)
				   NewsCode=Skcj.ReplaceTrim(Skcj.GetHttpPage(UrlTest,selEncoding))
			 Else
				FoundErr=True
				ErrMsg=ErrMsg & "<br><li>�ڻ�ȡ�����б�ʱ������</li>"
			 End If   
		  Else
			 FoundErr=True
			 ErrMsg=ErrMsg & "<br><li>�ڽ�ȡ�б�ʱ��������</li>"
		  End If
	   Else
		  FoundErr=True
		  ErrMsg=ErrMsg & "<br><li>�ڻ�ȡ:" & ListUrl & "��ҳԴ��ʱ��������</li>"
	   End If
		'--
		If x_tp =1 Then
			If imostr="" Or imhstr="" Then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>СͼƬ���벻��Ϊ��</li>" 
			else
			   If Newsimage="$False$" Then
				 FoundErr=True
				 ErrMsg=ErrMsg & "<br><li>�ڷ�����" & ListUrl & "�����б�ʱ��������</li>"
			   Else
				 Newsim=Split(Newsimage,"$Array$")
					 If IsArray(Newsim)=True Then
						For Testi=0 To Ubound(Newsim)
						   If HttpUrlType=1 Then
							  Newsim(Testi)=Replace(HttpUrlStr,"{$ID}",Newsim(Testi))
						   Else
							  Newsim(Testi)=Skcj.FormatRemoteUrl(Newsim(Testi),ListUrl)
						   End If
						Next
					 Else
						FoundErr=True
						ErrMsg=ErrMsg & "<br><li>�ڷ�����" & ListUrl & "�����б�ʱ��������</li>"
					 End If            
				End If  
			End If
		 End If
	End If
	'===================��ʾԶ��Դ����=============================
If FoundErr=True Then
   call WriteErrMsg(ErrMsg)
Else
If Skcj.G("ShowCode")="checkbox" Then
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
    <tr> 
      <td height="22" colspan="2" class="title"> <div align="center"><strong>�� Ŀ �� �� -- �ɼ�Ŀ����վԴ����&nbsp;&nbsp;&nbsp;&nbsp; </strong>
	  <input type="radio" value="0" name="ShowCodeobt"  onClick="ShowCode1.style.display='none';">
        ����Դ���봰��&nbsp;&nbsp;
        <input type="radio" value="0" name="ShowCodeobt" checked onClick="ShowCode1.style.display='';">
        ��ʾԴ���봰��&nbsp;
		</div></td>
    </tr>
    <tr class="tdbg" id="ShowCode1"> 
      <td height="22" colspan="2" bgcolor="f3f3f3" class="tdbg" align="center">
        <textarea name="showCode" cols="120" rows="10" class="lostfocus"><%=NewsCode%></textarea><br>
<%
For Testi=0 To Ubound(NewsArray)
   Response.Write "�ɼ���Ŀ���ַ ��<a href="& NewsArray(Testi) &" target=""_blank"">"& NewsArray(Testi) &"</a>"
   Response.Write "<a href='view-source:" & NewsArray(Testi) & "' target=_blank><font color='blue'>����鿴Ŀ��Դ����</font></a><br>"
Next
If x_tp = 1 Then
For Testi=0 To Ubound(Newsim)
Response.Write "�ɼ���СͼƬ��ַ ��"
   Response.Write "<a href='" & Newsim(Testi) & "' target=_blank>" & Newsim(Testi) & "</a><br>"
Next
End If
%>
	</td>
    </tr>
</table>
<% End If
If action="edit" Or action1="edit" Or action="s2" And action1<>"add" Then'�Ƿ��������������
Set RsItem=ConnItem.execute("Select * from Item where ItemID=" & ItemID)
   TsString=RsItem("TsString")
   ToString=RsItem("ToString")
   CsString=RsItem("CsString")
   CoString=RsItem("CoString")
   photourls=RsItem("photourls")
   photourlo=RsItem("photourlo")
   
   NewsPaingType=RsItem("NewsPaingType")
   NPsString=RsItem("NPsString")
   NPoString=RsItem("NPoString")
   NewsUrlPaing_s=RsItem("NewsUrlPaing_s")
   NewsUrlPaing_o=RsItem("NewsUrlPaing_o")
   
   PhotoPaingType=RsItem("PhotoPaingType")
      PhotoType_s=RsItem("PhotoType_s")
      PhotoType_o=RsItem("PhotoType_o")
	  PhotoLurl_s=RsItem("PhotoLurl_s")
      PhotoLurl_o=RsItem("PhotoLurl_o")
	  Phototypefy_s=RsItem("Phototypefy_s")
      Phototypefy_o=RsItem("Phototypefy_o")
	  Phototypefyurl_s=RsItem("Phototypefyurl_s")
      Phototypefyurl_o=RsItem("Phototypefyurl_o") 
	  Phototypeurl_s=RsItem("Phototypeurl_s")
      Phototypeurl_o=RsItem("Phototypeurl_o")
  
   DateType=RsItem("DateType")
      DsString=RsItem("DsString")
      DoString=RsItem("DoString")

   AuthorType=RsItem("AuthorType")
      AsString=RsItem("AsString")
      AoString=RsItem("AoString")
      AuthorStr=RsItem("AuthorStr")

   CopyFromType=RsItem("CopyFromType")
      FsString=RsItem("FsString")
      FoString=RsItem("FoString")
      CopyFromStr=RsItem("CopyFromStr")

   KeyType=RsItem("KeyType")
      KsString=RsItem("KsString")
      KoString=RsItem("KoString")
      KeyStr=RsItem("KeyStr")
	  	  
	  RsItem.close
	  set RsItem=nothing
	  action1="edit"
End If
 %>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder">
<form method="post" action="?" name="form1">
    <tr> 
      <td height="22" colspan="2" class="title"> <div align="center"><strong>�� �� �� 
		�� Ŀ--�� �� �� ��</strong></div>      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="30%" align="right" bgcolor="f3f3f3" class="tdbg" ><strong>���⿪ʼ��ǣ�</strong><p>��</p>
      <strong>���������ǣ�</strong></td>
      <td width="70%" bgcolor="f3f3f3" class="tdbg">
      <textarea name="TsString" cols="70" rows="5" class="lostfocus"><%= TsString %></textarea><br>
      <textarea name="ToString" cols="70" rows="5" class="lostfocus"><%= ToString %></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><strong>���Ŀ�ʼ��ǣ�</strong><p>��</p>
      <strong>���Ľ�����ǣ�</strong></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
      <textarea name="CsString" cols="70" rows="5" class="lostfocus"><%= CsString %></textarea>&nbsp;��Ϊ"0"���ɼ�<br>
      <textarea name="CoString" cols="70" rows="5" class="lostfocus"><%= CoString %></textarea>&nbsp;��Ϊ"0"���ɼ�</td>
    </tr>
    <tr class="tdbg">
      <td align="right" bgcolor="f3f3f3" class="tdbg" ><b>�Ƿ����ķ�ҳ���ã�</b></td>
      <td bgcolor="f3f3f3" class="tdbg"><input type="radio" value="0" name="NewsPaingType" <% If NewsPaingType=0 Or NewsPaingType="" Then Response.Write("checked") %> onClick="photo1.style.display='none'">
        ��������&nbsp;
        <input type="radio" value="1" name="NewsPaingType" <% If NewsPaingType=1 Then Response.Write("checked") %> onClick="photo1.style.display=''">
    ���ķ�ҳ         </tr>
    <tr class="tdbg" id="photo1" style="display:none">
      <td align="right" bgcolor="f3f3f3" class="tdbg" ><p><strong><font color=blue>��ҳ��ʼ���:</font></strong></p>
        <p>&nbsp;</p>
        <p><strong><font color=blue>��ҳ�������:</font></strong></p>
      <p>&nbsp;</p>
      <p><strong><font color=blue><br>
       ��ҳ���ӿ�ʼ���:</font></strong></p>
      <p>&nbsp;</p>
      <p><strong><font color=blue>��ҳ���ӽ������:</font></strong></p>  
	  </td>
      <td bgcolor="f3f3f3" class="tdbg"><p>
        <textarea name="NPsString" cols="70" rows="5" class="lostfocus"><%= NPsString %></textarea>
        <br>
        <textarea name="NPoString" cols="70" rows="5" class="lostfocus"><%= NPoString %></textarea>
		 <br>
        <textarea name="NewsUrlPaing_s" cols="70" rows="5" class="lostfocus"><%= NewsUrlPaing_s %></textarea>
        <br>
		<textarea name="NewsUrlPaing_o" cols="70" rows="5" class="lostfocus"><%= NewsUrlPaing_o %></textarea>

    </p>    </tr>
    
    <tr class="tdbg"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><b>ʱ&nbsp; ��&nbsp;
		��&nbsp; �ã�</b></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
      	<input type="radio" value="0" name="DateType" <% If DateType<>1 Then Response.Write("checked") %> onClick="Date1.style.display='none'">��������&nbsp;
	<input type="radio" value="1" <% If DateType=1 Then Response.Write("checked") %> name="DateType" onClick="Date1.style.display=''">���ñ�ǩ&nbsp;    </tr>
    <tr class="tdbg" id="Date1" style="display:none"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><strong><font color=blue>ʱ�俪ʼ��ǣ�</font></strong><p>��</p>
		<p>��</p>
      <strong><font color=blue>ʱ�������ǣ�</font></strong></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
      <textarea name="DsString" cols="70" rows="5" class="lostfocus"><%= DsString %></textarea><br>
      <textarea name="DoString" cols="70" rows="5" class="lostfocus"><%= DoString %></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><b>��<span lang="en-us">&nbsp; </span>��<span lang="en-us">&nbsp;
		</span>��<span lang="en-us">&nbsp; </span>�ã�</b></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
      	<input type="radio" value="0" <% If AuthorType=0 Or AuthorType="" Then Response.Write("checked") %> name="AuthorType"  onClick="Author1.style.display='none';Author2.style.display='none'">��������&nbsp;
		<input type="radio" value="1" <% If AuthorType=1 Then Response.Write("checked") %> name="AuthorType" onClick="Author1.style.display='';Author2.style.display='none'">���ñ�ǩ&nbsp;
		<input type="radio" value="2" name="AuthorType" <% If AuthorType=2 Then Response.Write("checked") %> onClick="Author1.style.display='none';Author2.style.display=''">ָ������</td>
    </tr>
    <tr class="tdbg" id="Author1" style="display:none"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><strong><font color=blue>���߿�ʼ��ǣ�</font></strong><p>��</p>
		<p>��</p>
      <strong><font color=blue>���߽�����ǣ�</font></strong></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
      <textarea name="AsString" cols="70" rows="7" class="lostfocus"><%= AsString %></textarea><br>
      <textarea name="AoString" cols="70" rows="7" class="lostfocus"><%= AoString %></textarea></td>
    </tr>
    <tr class="tdbg" id="Author2" style="display:none"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><strong><font color=blue>��ָ�����ߣ�</font></strong></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
      <input name="AuthorStr" type="text" class="lostfocus" id="AuthorStr" value="<%= AuthorStr %>">      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><b>��&nbsp; Դ&nbsp;
		��&nbsp; �ã�</b></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
      	<input type="radio" value="0" name="CopyFromType" <% If CopyFromType=0 Or CopyFromType="" Then Response.Write("checked") %> onClick="CopyFrom1.style.display='none';CopyFrom2.style.display='none'">��������&nbsp;
		<input type="radio" value="1" name="CopyFromType" <% If CopyFromType=1 Then Response.Write("checked") %> onClick="CopyFrom1.style.display='';CopyFrom2.style.display='none'">���ñ�ǩ&nbsp;
		<input type="radio" value="2" name="CopyFromType" <% If CopyFromType=2 Then Response.Write("checked") %> onClick="CopyFrom1.style.display='none';CopyFrom2.style.display=''">ָ����Դ</td>
    </tr>
    <tr class="tdbg" id="CopyFrom1" style="display:none"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><strong><font color=blue>��Դ��ʼ��ǣ�</font></strong><p>��</p>
		<p>��</p>
      <strong><font color=blue>��Դ������ǣ�</font></strong></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
      <textarea name="FsString" cols="70" rows="7" class="lostfocus"><%= FsString %></textarea><br>
      <textarea name="FoString" cols="70" rows="7" class="lostfocus"><%= FoString %></textarea></td>
    </tr>
    <tr class="tdbg" id="CopyFrom2" style="display:none"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><strong><font color=blue>��ָ����Դ��</font></strong></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
      <input name="CopyFromStr" type="text" class="lostfocus" id="CopyFromStr" value="<%= CopyFromStr %>">      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><b>�ؼ��ִ����ã�</b></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
      	<input type="radio" value="0" name="KeyType" <% If KeyType=0 Or KeyType="" Then Response.Write("checked") %> onClick="Key1.style.display='none';Key2.style.display='none'">��������&nbsp;
		<input type="radio" value="1" name="KeyType" <% If KeyType=1  Then Response.Write("checked") %> onClick="Key1.style.display='';Key2.style.display='none'">��ǩ����&nbsp;
		<input type="radio" value="2" name="KeyType" <% If KeyType=2  Then Response.Write("checked") %> onClick="Key1.style.display='none';Key2.style.display=''">�Զ���ؼ���</td>
    </tr>
    <tr class="tdbg" id="Key1" style="display:none"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><strong><font color=blue>�ؼ��ʿ�ʼ��ǣ�</font></strong><p>��</p>
		<p>��</p>
      <strong><font color=blue>�ؼ��ʽ�����ǣ�</font></strong></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg">
      <textarea name="KsString" cols="70" rows="7" class="lostfocus"><%= KsString %></textarea><br>
      <textarea name="KoString" cols="70" rows="7" class="lostfocus"><%= KoString %></textarea></td>
    </tr>
    <tr class="tdbg" id="Key2" style="display:none"> 
      <td width="20%" align="right" bgcolor="f3f3f3" class="tdbg" ><strong><font color=blue>��ָ���ؼ���</font></strong></td>
      <td width="75%" bgcolor="f3f3f3" class="tdbg"><input name="KeyStr" type="text" class="lostfocus" id="KeyStr" value="<%= KeyStr %>">
        <br>
      ��ʽ���ؼ���֮����<font color=red>|</font>�ָ����磺����|IT      </td>

    </tr>
	<%

	%>
	
    <tr class="tdbg"> 
      <td height="30" colspan="2" align="center" bgcolor="f3f3f3" class="tdbg">
       <input name="ItemID" type="hidden" value="<%=ItemID%>"> 
	  <% 
	  Response.Write "<input name=""Action1"" type=""hidden"" id=""Action"" value="& action1 &">"
	    %>
		<input name="Action" type="hidden" id="Action" value="demo">
		<input type="hidden" name="UrlTest" id="UrlTest" value="<%=UrlTest%>">
        <input name="button1"  type="button" class="lostfocus"  style="cursor: hand;background-color: #cccccc;" onClick="window.location.href='javascript:history.go(-1)'" value="��&nbsp;һ&nbsp;��">
        &nbsp;&nbsp;&nbsp;&nbsp; 
        <input name="Submit"  type="submit" class="lostfocus" style="cursor: hand;background-color: #cccccc;" value="��&nbsp;һ&nbsp;��">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <input type="checkbox" name="ShowCode" value="checkbox">��ʾԴ��</td>
    </tr>
	</form>
</table>

<%
End If
End Sub'�ڶ���

Sub demo()'����ҳ
	If ItemID="" Then
	   FoundErr=True
	   ErrMsg=ErrMsg & "<br><li>����������ĿID����Ϊ��</li>"
	Else
	   ItemID=Clng(ItemID)
	End If
	If FoundErr<>True Then
		Req_Err_msg 3
	End If
	If FoundErr<>True And Action="demo" And Action1=""  Then
	   SK.GetTest()
	End If
	
If FoundErr=True Then
   Call WriteErrMsg(ErrMsg)
Else
If Action1="" And Action="demo" Or Skcj.G("ShowCode")="checkbox" Then
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder"  >
    <tr> 
      <td height="22" colspan="2" class="title"> <div align="center"><strong>�� �� �� Ŀ--�� �� �� ��</strong></div></td>
    </tr>
</table>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
  <tr align="center" class="tdbg"> 
    <td colspan="2" valign="bottom"><span lang="zh-cn">
	<%=Title%></span></td>
  </tr>
  <tr align="center" class="tdbg">
    <td colspan="2">
        <strong>���ߣ�</strong><%=Author%>&nbsp;&nbsp;<strong>��Դ��</strong><%=CopyFrom%>&nbsp;&nbsp;<strong>����ʱ�䣺</strong><%=UpDateTime%>
    </td>
  </tr>
  <tr class="tdbg">
    <td colspan="2">
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="5">
        <tr>
          <td height="200" valign="top">
		  <%
		  If x_tp=1 Then
		  	Response.Write "<font color=blue>�б�СͼƬ��ַ:</font>"
		 	 Response.Write "<a href="& picpath &" target=""_blank"">"& picpath &"<a/>"
		  End If
		  Response.Write "<br><br><strong>����:</strong>" & Server.HtmlEncode(Content) &"<br>"
		  Response.Write "<br><b>�ؼ��֣�</b>" & Server.HtmlEncode(Key) &"<br>"

		  %>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <form method="post" action="SK_getArticle.asp" name="form1">
  <tr class="tdbg">
  	<td colspan="2" align="center">
	    <input name="Cancel" class="lostfocus" type="button"  value=" ��&nbsp;һ&nbsp;�� " onClick="window.location.href='javascript:history.go(-1)'" style="cursor: hand;background-color: #cccccc;">&nbsp;&nbsp;<input  type="submit" name="Submit" class="lostfocus" value=" �������&nbsp; " style="cursor: hand;background-color: #cccccc;">
	</td>
  </tr>
  </form>
</table>
<%
else
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
  
  <tr class="tdbg">
    <td colspan="2">
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="5">
        <tr>
          <td height="30" valign="top"><a href="?action=demo&ItemID=<%= ItemID %>">����鿴����ҳ</a></td>
        </tr>
      </table>    </td>
  </tr>
  <form method="post" action="SK_getArticle.asp" name="form1">
  <tr class="tdbg">
  	<td colspan="2" align="center">
	    <input name="Cancel" class="lostfocus" type="button"  value=" ��&nbsp;һ&nbsp;�� " onClick="window.location.href='javascript:history.go(-1)'" style="cursor: hand;background-color: #cccccc;">&nbsp;&nbsp;<input  type="submit" name="Submit" class="lostfocus" value=" �������&nbsp; " style="cursor: hand;background-color: #cccccc;">	</td>
  </tr>
  </form>
</table>

<%
End If
End If
End Sub

Sub copy
	ItemID=Skcj.G("ItemID")
	If ItemID="" Then
		  FoundErr=True
		  ErrMsg=ErrMsg & "<br><li>��ѡ��Ҫɾ������Ŀ��</li>"
	   Else
		Dim copy_s,copyitem(99999)
		SqlItem="Select top 1 * from Item where ItemID="& ItemID
		Set RsItem=server.CreateObject("adodb.recordset")
		RsItem.Open SqlItem,ConnItem,3,3
		copy_s =Cint(RsItem.Fields.count)
		for i=1 to copy_s - 1
		copyitem(i)=RsItem(i)
		next
		RsItem.AddNew
		for i=1 to copy_s - 1
		RsItem(i)=copyitem(i)
		RsItem(1)=copyitem(1) & " ����"
		next
		RsItem.update
		RsItem.close
		Call show_Manage()
	End If
End Sub

Sub Del
ItemID=Skcj.G("ItemID")
If Skcj.G("Del")="���ٲɼ�" Then
	Response.redirect "Sk_CollectionFast.asp?ItemID="&ItemID&"&ItemNum=1&ListNum=1&NewsSuccesNum=0&NewsFalseNum=0&ImagesNumAll=0&NewsNum_i=0"
Else
	If Skcj.G("Del")="������м�¼" Then
	   ConnItem.Execute("Delete From Item")
	   ConnItem.Execute("Delete From Filters")
	   ConnItem.Execute("Delete From Histroly")
	Else
	   If ItemID="" Then
		  FoundErr=True
		  ErrMsg=ErrMsg & "<br><li>��ѡ��Ҫɾ������Ŀ��</li>"
	   Else
		  ItemID=Replace(ItemID," ","")   
		  ConnItem.Execute("Delete From [Item] Where ItemID In(" & ItemID & ")")
		  ConnItem.Execute("Delete From [Filters] Where ItemID In(" & ItemID & ")")
		  ConnItem.Execute("Delete From [Histroly] Where ItemID In(" & ItemID & ")")
	   End If
	End  If
End If	
Call show_Manage()
End Sub
	'================================================
	'��������Req_Err_msg
	'��  �ã�����ύ���ò�����
	'��  ����erron   ----�ڼ���
	'================================================
	Public Sub Req_Err_msg(erron)
	select case erron
	case 1
		ItemName=Trim(Request.Form("ItemName"))
		ChannelID=Trim(Request.Form("ChannelID"))
		ClassID=Trim(Request.Form("ClassID"))
		SpecialID=Trim(Request.Form("SpecialID"))
		selEncoding=Trim(Request.Form("selEncoding"))
		Colleclx=Trim(Request.Form("Colleclx"))
		ListStr=Trim(Request.Form("ListStr"))
		ListPaingType=Trim(Request.Form("ListPaingType"))
		ListPaingStr2=Trim(Request.Form("ListPaingStr2"))
		ListPaingID1=Trim(Request.Form("ListPaingID1"))
		ListPaingID2=Trim(Request.Form("ListPaingID2"))
		ListPaingStr3=Trim(Request.Form("ListPaingStr3"))
		LPoString=Trim(Request.Form("LPoString"))
		LPsString=Trim(Request.Form("LPsString"))
		Passed=Trim(Request.Form("Passed"))
		SaveFiles=Trim(Request.Form("SaveFiles"))
		Thumb_WaterMark=Request.Form("Thumb_WaterMark")
		SaveFileUrl=Trim(Request.Form("SaveFileUrl"))
		Script_Iframe=Trim(Request.Form("Script_Iframe"))
		Script_Object=Trim(Request.Form("Script_Object"))
		Script_Script=Trim(Request.Form("Script_Script"))
		Script_Div=Trim(Request.Form("Script_Div"))
		Script_Class=Trim(Request.Form("Script_Class"))
		Script_Span=Trim(Request.Form("Script_Span"))
		Script_Img=Trim(Request.Form("Script_Img"))
		Script_Font=Trim(Request.Form("Script_Font"))
		Script_A=Trim(Request.Form("Script_A"))
		Script_Html=Trim(Request.Form("Script_Html"))
		Script_Table=Trim(Request.Form("Script_Table"))
		Script_Tr=Trim(Request.Form("Script_Tr"))
		Script_Td=Trim(Request.Form("Script_Td"))
		Stars=Trim(Request.Form("Stars"))
		ReadPoint=Trim(Request.Form("ReadPoint"))
		Hits=Trim(Request.Form("Hits"))
		Colleclx=Request.Form("Colleclx")
		CollecNewsNum=Request.Form("CollecNewsNum")
		Timing=Trim(Request.Form("Timing"))
		strReplace=Trim(Request.Form("ReplaceList"))'�����滻
		If ItemName="" Then
		   FoundErr=True
		   ErrMsg=ErrMsg & "<br><li>��Ŀ���Ʋ���Ϊ��</li>"
		End If
		If ClassID=0 Then
		   FoundErr=True
		   ErrMsg=ErrMsg & "<br><li>δָ����Ŀ����</li>"
		End If
		If ListStr="" Then
		   FoundErr=True
		   ErrMsg=ErrMsg & "<br><li>Զ���б�URL����Ϊ��</li>" 
		End If
		If ListPaingType="" Then
		   FoundErr=True
		   ErrMsg=ErrMsg & "<br><li>��ѡ���б�������ҳ����</li>" 
		Else
		   ListPaingType=Clng(ListPaingType)
		   Select Case ListPaingType
		   Case 0
		   Case 1
			  If ListPaingStr2="" Then
				 FoundErr=True
				 ErrMsg=ErrMsg & "<br><li>���������ַ�����Ϊ��</li>"
			  End If
			  If isNumeric(ListPaingID1)=False Or isNumeric(ListPaingID2)=False Then
				 FoundErr=True
				 ErrMsg=ErrMsg & "<br><li>�������ɵķ�Χֻ��������</li>"
			  Else
				 ListPaingID1=Clng(ListPaingID1)
				 ListPaingID2=Clng(ListPaingID2)
				 If ListPaingID1=0 And ListPaingID2=0 Then
					FoundErr=True
					ErrMsg=ErrMsg & "<br><li>�������ɷ�Χ���ò���ȷ</li>"
				 End If
			  End If
		   Case 2
			  If ListPaingStr3="" Then
				 FoundErr=True
				 ErrMsg=ErrMsg & "<br><li>�б�������ҳ����Ϊ�գ����ֶ�����</li>"
			  Else
				 ListPaingStr3=Replace(ListPaingStr3,CHR(13),"|") 
			  End If
		   Case 3
		   	  IF LPsString="" or LPoString="" then
				 FoundErr=True
				 ErrMsg=ErrMsg & "<br><li>������ҳ��ʼ���������Ϊ��!</li>"
			  End if	  
		   Case Else
			  FoundErr=True
			  ErrMsg=ErrMsg & "<br><li>��ѡ���б�������ҳ����</li>" 
		   End Select
		End If
		If Stars="" Then
		   FoundErr=True
		   ErrMsg=ErrMsg & "<br><li>��ѡ���������ֵȼ���</li>"
		Else
		   Stars=Clng(Stars)
		End If
		If ReadPoint="" Then
		   ReadPoint=0
		Else
		   ReadPoint=Clng(ReadPoint)
		End If
		If Hits="" Then
		   Hits=0
		Else
		   Hits=Clng(Hits)
		End If
		'-----------------������������---------------------------------
		Dim Sqllx
		If FoundErr<>True Then
			If action1="add" Then sqllx="add" 
			If action1="edit" Then sqllx="edit"
			If sqllx <> "" And sqllx="edit" Or sqllx="add" Then
			If sqllx="add" Then 
				Sql="Select top 1 * from Item"
			Else
				Sql="select top 1 * from Item where ItemID="& ItemID
			End If
			   Set RsItem=server.CreateObject("adodb.recordset")
			   RsItem.Open Sql,ConnItem,1,3
			   If sqllx="add" Then RsItem.AddNew
					RsItem("ItemName")=ItemName
					RsItem("ClassID")=ClassID
					'RsItem("SpecialID")=SpecialID
					RsItem("selEncoding")=selEncoding
					RsItem("ListStr")= ListStr
					RsItem("ListPaingType")=ListPaingType
					RsItem("LPsString")=LPsString
					RsItem("LPoString")=LPoString
					RsItem("ListPaingStr2")=ListPaingStr2
					Select Case ListPaingType
					   Case 0 
						  ListUrl=ListStr
					   Case 1
						  RsItem("ListPaingStr2")=ListPaingStr2
						  RsItem("ListPaingID1")=ListPaingID1
						  RsItem("ListPaingID2")=ListPaingID2
						  ListUrl=Replace(ListPaingStr2,"{$ID}",CStr(ListPaingID1))
					   Case 2
						  RsItem("ListPaingStr3")=ListPaingStr3
						  If  Instr(ListPaingStr3,"|")>0  Then
								ListUrl=Left(ListPaingStr3,Instr(ListPaingStr3,"|")-1)
						  Else
								ListUrl=ListPaingStr3
						  End  If
					   Case 3
					   	  ListUrl=ListStr	  
					End Select
					RsItem("Colleclx")=3
					If Passed="yes" Then
						 RsItem("Passed")=1
					Else
						 RsItem("Passed")=0
					End If
					If SaveFiles="yes" Then
						 RsItem("SaveFileUrl")=SaveFileUrl
						 RsItem("SaveFiles")=1
					Else
						 RsItem("SaveFiles")=0
					End If
					If Thumb_WaterMark="yes" Then  RsItem("Thumb_WaterMark")=1 else  RsItem("Thumb_WaterMark")=0 End If	
					If Timing="yes" Then RsItem("Timing")=1 else  RsItem("Timing")=0 End If	
					If CollecOrder="yes" Then
						 RsItem("CollecOrder")=1
					Else
						 RsItem("CollecOrder")=0
					End If
						  If Script_Iframe="yes" Then
					 RsItem("Script_Iframe")=1
				  Else
					 RsItem("Script_Iframe")=0
				  End If
				  If Script_Object="yes" Then
					 RsItem("Script_Object")=1
				  Else
					 RsItem("Script_Object")=0
				  End If
				  If Script_Script="yes" Then
					 RsItem("Script_Script")=1
				  Else
					 RsItem("Script_Script")=0
				  End If
				  If Script_Div="yes" Then
					 RsItem("Script_Div")=1
				  Else
					 RsItem("Script_Div")=0
				  End If
				  If Script_Class="yes" Then
					 RsItem("Script_Class")=1
				  Else
					 RsItem("Script_Class")=0
				  End If
				  If Script_Span="yes" Then
					 RsItem("Script_Span")=1
				  Else
					 RsItem("Script_Span")=0
				  End If
				  If Script_Img="yes" Then
					 RsItem("Script_Img")=1
				  Else
					 RsItem("Script_Img")=0
				  End If
				  If Script_Font="yes" Then
					 RsItem("Script_Font")=1
				  Else
					 RsItem("Script_Font")=0
				  End If
				  If Script_A="yes" Then
					 RsItem("Script_A")=1
				  Else
					 RsItem("Script_A")=0
				  End If
				  If Script_Html="yes" Then
					 RsItem("Script_Html")=1
				  Else
					 RsItem("Script_Html")=0
				  End If
				  If Script_Table="yes" Then
					 RsItem("Script_Table")=1
				  Else
					 RsItem("Script_Table")=0
				  End If
				  If Script_Tr="yes" Then
					 RsItem("Script_Tr")=1
				  Else
					 RsItem("Script_Tr")=0
				  End If
				  If Script_Td="yes" Then
					 RsItem("Script_Td")=1
				  Else
					 RsItem("Script_Td")=0
				  End If	  	  
				  RsItem("Stars")=Stars
				  RsItem("ReadPoint")=ReadPoint
				  RsItem("Hits")=Hits
				  RsItem("CollecNewsNum")=CollecNewsNum
				  RsItem("Colleclx")=SKcj.ChkNumeric(Colleclx)
				  RsItem("strReplace")=strReplace
				  If sqllx="add" Then ItemID=RsItem("ItemID")
	
			   RsItem.UpDate
			   RsItem.Close
			   Set RsItem=Nothing
			End If
		End If
		'------------------------������������(��)------------------------------------
	case 2 
		If Action1="" And Action="s2" Then
		Set RsItem=ConnItem.execute("select * from Item where ItemID=" & ItemID)
			  LsString=RsItem("LsString")
			  LoString=RsItem("LoString")
			  HsString=RsItem("HsString")
			  HoString=RsItem("HoString")
			  ListUrl=RsItem("ListStr")
			  imhstr=RsItem("imhstr")
			  imostr=RsItem("imostr")
			  x_tp=RsItem("x_tp")
			  RsItem.close
			  set RsItem=nothing
			  action1="edit"
		else
		HttpUrlType=Trim(Request.Form("HttpUrlType"))'�ض�����
	    HttpUrlStr=Trim(Request.Form("HttpUrlStr"))'�ض�����
		LsString=Trim(Request.Form("LsString"))
		LoString=Trim(Request.Form("LoString"))
		HsString=Trim(Request.Form("HsString"))
		HoString=Trim(Request.Form("HoString"))
		imhstr=Trim(Request.Form("imhstr"))
		imostr=Trim(Request.Form("imostr"))
		x_tp=Trim(Request.Form("x_tp")	)
		selEncoding=Trim(Request.Form("selEncoding"))
		End If
		If ItemID="" Then
		   FoundErr=True
		   ErrMsg=ErrMsg & "<br><li>�������������Ч���ӽ���</li>"
		Else
		   ItemID=Clng(ItemID)
		End If
		If LsString="" Then
		   FoundErr=True
		   ErrMsg=ErrMsg & "<br><li>�б���ʼ���벻��Ϊ��</li>"
		End If
		If LoString="" Then
		   FoundErr=True
		   ErrMsg=ErrMsg & "<br><li>�б��������벻��Ϊ��</li>" 
		End If
		If HsString="" Then
		   FoundErr=True
		   ErrMsg=ErrMsg & "<br><li>���ӿ�ʼ���벻��Ϊ��</li>"
		End If
		If HoString="" Then
		   FoundErr=True
		   ErrMsg=ErrMsg & "<br><li>���ӽ������벻��Ϊ��</li>" 
		End If
		If FoundErr<>True Then
		   SqlItem="Select * from Item Where ItemID=" & ItemID 
		   Set RsItem=server.CreateObject("adodb.recordset")
		   RsItem.Open SqlItem,ConnItem,1,3
		   	  RsItem("HttpUrlType")=Skcj.ChkNumeric(HttpUrlType)'�ض�����
	  		  RsItem("HttpUrlStr")=HttpUrlStr'�ض�����
			  RsItem("LsString")=LsString
			  RsItem("LoString")=LoString
			  RsItem("HsString")=HsString
			  RsItem("HoString")=HoString
			  ListUrl=RsItem("ListStr")
			  RsItem("x_tp")=x_tp
			  If x_tp=1 Then
			  	RsItem("imhstr")=imhstr
			  	RsItem("imostr")=imostr
			  End If
		   RsItem.UpDate
		   RsItem.Close
		   Set RsItem=Nothing
		End If   
	case 3
		If Action1="add" Or Action1="edit"  Then
			call SK.SaveEdit()
		End If
		If FoundErr<>True And Request.Form("ShowCode")="checkbox" Then
			call Sk.GetTest()
		End If
	End select
	End Sub 
%>
  