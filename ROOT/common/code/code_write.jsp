<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.emfrontier.air.common.bean.*" %>
<%@ page import="com.emfrontier.air.common.config.*" %>
<%@ page import="com.emfrontier.air.common.jdbc.*" %>
<%@ page import="com.emfrontier.air.common.model.*" %>
<%@ page import="com.emfrontier.air.common.util.*" %>
<%!
public String getCodListJSON(SQLResults sqlResult) {
    StringBuffer buffer = new StringBuffer();

    if(sqlResult == null) {
    	buffer.append("[");
        buffer.append("{");
        buffer.append("\"init\" : ").append("\"").append("Y").append("\",");
        buffer.append("\"child_cnt\" : ").append("\"").append("0").append("\",");
        buffer.append("\"isNew\" : ").append("\"").append("Y").append("\",");
        buffer.append("\"index\" : ").append("\"").append(StringUtil.getRandomUUID()).append("\",");
        buffer.append("\"code_id\" : ").append("\"").append(StringUtil.getRandomUUID()).append("\",");
        buffer.append("\"code\" : ").append("\"").append("\",");
        buffer.append("\"lang_code\" : ").append("\"").append("\",");
        buffer.append("\"name_ko\" : ").append("\"").append("\",");
        buffer.append("\"name_en\" : ").append("\"").append("\",");
        buffer.append("\"memo_ko\" : ").append("\"").append("\",");
        buffer.append("\"memo_en\" : ").append("\"").append("\",");
        buffer.append("\"status_code\" : ").append("\"").append("N").append("\",");
        buffer.append("\"order_no\" : ").append("\"").append("\",");
        buffer.append("\"code_attr1\" : ").append("\"").append("\",");
        buffer.append("\"code_attr2\" : ").append("\"").append("\",");
        buffer.append("\"code_attr3\" : ").append("\"").append("\",");
        buffer.append("\"code_attr4\" : ").append("\"").append("\",");
        buffer.append("\"code_data\" : ").append("\"").append("\",");
        buffer.append("\"code_attr1_desc\" : ").append("\"").append("\",");
        buffer.append("\"code_attr2_desc\" : ").append("\"").append("\",");
        buffer.append("\"code_attr3_desc\" : ").append("\"").append("\",");
        buffer.append("\"code_attr4_desc\" : ").append("\"").append("\"");
        buffer.append("}");

 	    buffer.append("]");
    }else{

	    int totalCount = sqlResult.getRowCount();

	    buffer.append("[");
	    for (int i = 0; i < totalCount; i++) {
	        buffer.append("{");
	        buffer.append("\"init\" : ").append("\"").append("Y").append("\",");
	        buffer.append("\"isNew\" : ").append("\"").append("N").append("\",");
	        buffer.append("\"index\" : ").append("\"").append(StringUtil.convertNull(sqlResult.getString(i, "uuid"))).append("\",");
	        buffer.append("\"child_cnt\" : ").append("\"").append(StringUtil.convertNull(sqlResult.getString(i, "child_cnt"))).append("\",");
	        buffer.append("\"code_id\" : ").append("\"").append(StringUtil.convertNull(sqlResult.getString(i, "code_id"))).append("\",");
	        buffer.append("\"code\" : ").append("\"").append(StringUtil.convertNull(sqlResult.getString(i, "code"))).append("\",");
	        buffer.append("\"lang_code\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "lang_code"))).append("\",");
	        buffer.append("\"name_ko\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "name_ko"))).append("\",");
	        buffer.append("\"name_en\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "name_en"))).append("\",");
	        buffer.append("\"memo_ko\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "memo_ko"))).append("\",");
	        buffer.append("\"memo_en\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "memo_en"))).append("\",");
	        buffer.append("\"status_code\" : ").append("\"").append(StringUtil.convertNull(sqlResult.getString(i, "status_code"))).append("\",");
	        buffer.append("\"order_no\" : ").append("\"").append(StringUtil.convertNull(sqlResult.getString(i, "order_no"))).append("\",");
	        buffer.append("\"code_attr1\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "code_attr1"))).append("\",");
	        buffer.append("\"code_attr2\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "code_attr2"))).append("\",");
	        buffer.append("\"code_attr3\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "code_attr3"))).append("\",");
	        buffer.append("\"code_attr4\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "code_attr4"))).append("\",");
	        buffer.append("\"code_data\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "code_data"))).append("\",");
	        buffer.append("\"code_attr1_desc\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "code_attr1_desc"))).append("\",");
	        buffer.append("\"code_attr2_desc\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "code_attr2_desc"))).append("\",");
	        buffer.append("\"code_attr3_desc\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "code_attr3_desc"))).append("\",");
	        buffer.append("\"code_attr4_desc\" : ").append("\"").append(StringUtil.convertForJson(sqlResult.getString(i, "code_attr4_desc"))).append("\"");
	        buffer.append("}");

	        if(i != totalCount - 1) {
	            buffer.append(",");
	        }
	    }
	    buffer.append("]");
    }

    return buffer.toString();
}
%>
<%
	//-- ????????? ????????? ?????? ??????
	SysLoginModel loginUser 	= (SysLoginModel)request.getSession().getAttribute(CommonConstants.SESSION_USER);
	String siteLocale			= loginUser.getSiteLocale();

	//-- ????????? ??????
	BeanResultMap requestMap 	= (BeanResultMap)request.getAttribute(CommonConstants.REQUEST);
	//String page_no 			= requestMap.getString(CommonConstants.PAGE_NO);
	//String page_rowsize 		= requestMap.getString(CommonConstants.PAGE_ROWSIZE);

	//-- ????????? ??????
	BeanResultMap resultMap 	= (BeanResultMap)request.getAttribute(CommonConstants.RESULT);
	SQLResults resultView		= resultMap.getResult("VIEW");
	SQLResults STAT_LIST		= resultMap.getResult("STAT_LIST");

	//-- ???????????? ??????
	String action_code 		= resultMap.getString(CommonConstants.ACTION_CODE);
	String mode_code 		= resultMap.getString(CommonConstants.MODE_CODE);

	//-- ???????????? Null ?????? ????????????  CHILD?????? ??????????????? ??????
	String update_mode		= StringUtil.convertNull(request.getParameter("update_mode"));

	//-- ???????????? ??? ??????
	String parent_uuid		= requestMap.getString("UUID");
	String parent_code_id	= requestMap.getString("CODE_ID");
	String sel_uuid_path	= requestMap.getString("SEL_UUID_PATH");

	if ("UPDATE_FORM".equals(mode_code)) {
		if(resultView != null && resultView.getRowCount() > 0){
			parent_uuid			= resultView.getString(0, "parent_uuid");
			parent_code_id		= resultView.getString(0, "parent_code_id");
		}
	}
%>
<script type="text/javascript">
/* [ Javascript Class ?????? ] */
var CODE_WRITE = function(){
    var self = this;

    /**
     * ?????? ???????????? ??????
     */
    this.goList = function(frm) {
    	if (confirm("<%=StringUtil.getLocaleWord("M.ALERT_GOLIST",siteLocale)%>")) {
    		frm.<%=CommonConstants.MODE_CODE%>.value = "LIST";
    		frm.action = "/ServletController";
    		frm.target = "_self";
    		frm.submit();
    	}
    }

    /**
     * ??????
     */
    this.doSubmit = function(frm) {
    	var code	 	= document.getElementsByName("code");
    	var code_id 	= document.getElementsByName("code_id");
    	var chk_code_id = document.getElementsByName("chk_code_id");
    	var name_ko		= document.getElementsByName("name_ko");

    	for(var i=0;i < code_id.length ; i++){

    		//CODE_ID Validation
    		if(code_id[i].value == ""){
    			alert("<%=StringUtil.getScriptMessage("M.ALERT_INPUT",siteLocale,"L.???????????????")%>");
    			code_id[i].focus();
    			return;
    		}else if(code_id[i].value != chk_code_id[i].value){
    			alert("?????? ????????? ?????? ????????? ????????????.");
    			code_id[i].focus();
    			return;
    		}

    		//CODE Validation
    		if(code[i].value == ""){
    			alert("<%=StringUtil.getScriptMessage("M.ALERT_INPUT",siteLocale,"L.??????")%>");
    			code[i].focus();
    			return;
    		}

    		//NAME_KO Validation
    		if(name_ko[i].value == ""){
    			alert("<%=StringUtil.getScriptMessage("M.ALERT_INPUT",siteLocale, "?????? ??????(?????????)")%>");
    			name_ko[i].focus();
    			return;
    		}
    	}
    	if($("#div_CODE_SUB_DATA").css("display") == "block"){
    		alert("???????????? ????????? ?????? ???????????? ???????????? ????????? ????????? ?????????.");
			return;
    	}

    	if (confirm("<%=StringUtil.getScriptMessage("M.ALERT_SUBMIT",siteLocale,"L.??????")%>")) {
    		if (frm.current_mode_code.value == "UPDATE_FORM") {
    			frm.<%=CommonConstants.MODE_CODE%>.value = "UPDATE_PROC";
    		} else {
    			frm.<%=CommonConstants.MODE_CODE%>.value = "WRITE_PROC";
    		}

    		frm.action = "/ServletController";
    		frm.target = "_self";
    		frm.submit();
    	}
    }
    /**
     * ?????? ????????? ?????? ??????
     */
    this.ajaxSelectCode = function(index){
    	var code_id = $("#code_id_"+index).val();
    	var chk_code_id = $("#chk_code_id_"+index).val();

    	if(chk_code_id == code_id){
    		alert("????????? ????????? ????????????.");
    		return;
    	}
    	var url = "/ServletController?AIR_ACTION=SYS_CODE&AIR_MODE=JSON_DATA&code_id="+code_id ;
    	$.ajax({
			url: url
			, type: "GET"
			, async: true
			, cache: false
			, dataType: "json"
			, error: function (data,text,error) {
			}
			, success: function (data) {
				self.chkCodId(data,index);
			}
		});
    }
    this.chkCodId = function(data,index){
    	var mode_code = "<%=mode_code%>";

    	if(mode_code == "UPDATE_FORM"){
	    	if(data.length > 1){
	    		alert("????????? ???????????? ?????? ?????????.");
	    		$("#code_id_"+index).focus();
	    		return;
	    	}else{
	    		alert("????????????!!!");
	    		$("#chk_code_id_"+index).val($("#code_id_"+index).val());
	    	}
    	}else{
    		if(data.length > 0){
	    		alert("????????? ???????????? ?????? ?????????.");
	    		$("#code_id_"+index).focus();
	    		return;
	    	}else{
	    		alert("????????????!!!");
	    		$("#chk_code_id_"+index).val($("#code_id_"+index).val());
	    	}
    	}
    }
    /**
     * ?????? ?????? ????????? ?????? ?????????
     */
    this.ParentCodeId_Clear = function(frm) {
    	if (frm.parent_code_id.value != "") {
    		if (confirm("<%=StringUtil.getLocaleWord("M.??????????????????????????????????????????", siteLocale)%>")) {
    			frm.parent_uuid.value = "";
    			frm.parent_code_id.value = "";
    		}
    	}
    }

    /**
     * ?????? ?????? ????????? ??????
     */
    this.ParentCodeId_Search = function() {
    	airCommon.popupCodeSelect("CODDWRITE.ParentCodeId_Change", "", "ALL", "","&multiSelect=N");
    }

    /**
     * ?????? ?????? ????????? ?????? ??????
     */
    this.ParentCodeId_Change = function(json) {
    	console.log(json);
    	var frm = document.form1;
//     	var current_mode_code			= frm.current_mode_code.value;
//     	var current_parent_uuid			= frm.current_parent_uuid.value;
//     	var current_uuid				= frm.uuid.value;

    	// ?????? ????????? ?????? ???????????????????????? ??????????????? ??????,
    	<%--
    	if (current_mode_code == "UPDATE_FORM" && current_parent_uuid != uuid) {
    		if (uuidPath.indexOf(current_uuid) > -1) {
    			alert("<%=StringUtil.getScriptMessage("M.ERROR_SELECT",siteLocale,"L.????????????" ?????? ?????? ????????? ?????? ??????)%>");
    			return;
    		}
    	}
    	 --%>

    	json = JSON.parse(json);
    	document.form1.parent_uuid.value 	= json[0]["UUID"];
    	document.form1.parent_code_id.value = json[0]["CODE_ID"];
    }
    
    //????????? ??????
    this.attachEvents = function(){
    	//?????? ?????? ??????
    	$("#div_CODE_WRITE_LIST a[data-meaning=code_list_add]").click(function(){
            self.addCodList();
        });
    }

    //?????? ????????????
    this.addCodList = function(){
    	var codIdx = airCommon.getRandomUUID();
    	var data = [{init:"N",
    			child_cnt:"0",
    			index:codIdx,
    			code_id:codIdx,
    			code:"",
    			name_ko:"",
    			name_en:"",
    			lang_code:"",
    			status_code:"N",
    			isNew:"Y",
    			order_no:""
    			}];
    	$("#TMPL_CODE_WIRTE").tmpl(data).appendTo($("#CODE_INPUT_LIST"));
    }

    /*
    * ?????? ?????? ??????
    */
    this.removeCodLine = function(removeKey,child_cnt){
    	if(child_cnt != "0"){
    		if(confirm("?????? ????????? ?????? ?????????. ??????????????? ?????????????????? ?????? ?????? ?????????.\n?????? ???????????????????")){
    			$("#div_CODE_WRITE_LIST tr[data-meaning="+removeKey+"]").remove();
    		}
    	}else{
	    	$("#div_CODE_WRITE_LIST tr[data-meaning="+removeKey+"]").remove();
    	}
    }

    //?????? ?????? ?????? ?????? ??????
    this.subDataOpen = function(trIdx){

    	var tm_index =	$("#tmp_index").val();
    	//???????????? ?????? ??????.
    	if($("#div_CODE_SUB_DATA").css("display") == "none"){
    		self.setTmpData(trIdx);
	    	$("#div_CODE_SUB_DATA").show();
    	}else{
    		//??????????????? ????????? Idx ??? Tmp??? Idx??? ????????? ??????
    		if(tm_index == trIdx){
	    		$("#div_CODE_SUB_DATA").hide();

	    	//??????????????? ????????? Idx ??? Tmp??? Idx??? ????????? ?????????????????? ????????????.
    		}else{
    			self.subDataReset();
    	    	self.setTmpData(trIdx);
    		}
    	}
    }

    this.setTmpData = function(trIdx){
    	$("#tmp_index").val(trIdx);
    	$("#tmp_memo_ko").val($("#memo_ko_"+trIdx).val());
    	$("#tmp_memo_en").val($("#memo_en_"+trIdx).val());
    	$("#tmp_code_attr1").val($("#code_attr1_"+trIdx).val());
    	$("#tmp_code_attr2").val($("#code_attr2_"+trIdx).val());
    	$("#tmp_code_attr3").val($("#code_attr3_"+trIdx).val());
    	$("#tmp_code_attr4").val($("#code_attr4_"+trIdx).val());
    	$("#tmp_code_attr1_desc").val($("#code_attr1_desc_"+trIdx).val());
    	$("#tmp_code_attr2_desc").val($("#code_attr2_desc_"+trIdx).val());
    	$("#tmp_code_attr3_desc").val($("#code_attr3_desc_"+trIdx).val());
    	$("#tmp_code_attr4_desc").val($("#code_attr4_desc_"+trIdx).val());
    	$("#tmp_code_data").val($("#code_data_"+trIdx).val());
    }
    //?????? ?????? ?????? ????????? ?????????
    this.subDataClose = function(trInx){
    	self.subDataReset();
    	$("#tmp_index").val(trInx);
    	$("#div_CODE_SUB_DATA").hide();
    }
    //?????? ?????? ?????? ????????? ?????????
    this.subDataReset = function(){
    	$("#div_CODE_SUB_DATA INPUT[data-meaning=TMP]").val("");
    	$("#div_CODE_SUB_DATA TEXTAREA[data-meaning=TMP]").val("");
    }

    //?????? ?????? ?????? ?????? ??????
    this.doCompleSubData = function(){

    	var trIdx = $("#tmp_index").val();
    	$("#memo_ko_"+trIdx).val($("#tmp_memo_ko").val());
    	$("#memo_en_"+trIdx).val($("#tmp_memo_en").val());
    	$("#code_attr1_"+trIdx).val($("#tmp_code_attr1").val());
    	$("#code_attr2_"+trIdx).val($("#tmp_code_attr2").val());
    	$("#code_attr3_"+trIdx).val($("#tmp_code_attr3").val());
    	$("#code_attr4_"+trIdx).val($("#tmp_code_attr4").val());
    	$("#code_attr1_desc_"+trIdx).val($("#tmp_code_attr1_desc").val());
    	$("#code_attr2_desc_"+trIdx).val($("#tmp_code_attr2_desc").val());
    	$("#code_attr3_desc_"+trIdx).val($("#tmp_code_attr3_desc").val());
    	$("#code_attr4_desc_"+trIdx).val($("#tmp_code_attr4_desc").val());
    	$("#code_data_"+trIdx).val(	$("#tmp_code_data").val());

    	self.subDataClose();
    }

  	//???????????? ??????
    this.loadPatentTable = function(){
    	var savedDataJson = <%=getCodListJSON(resultView)%>;
        $("#TMPL_CODE_WIRTE").tmpl(savedDataJson).appendTo($("#CODE_INPUT_LIST"));
    }
}

var frm = document.form1;
var CODDWRITE = new CODE_WRITE();
$(function(){
	CODDWRITE.attachEvents();
	CODDWRITE.loadPatentTable();
})
</script>
<script id="TMPL_CODE_WIRTE" type="text/x-jquery-tmpl">
	<tr align="center" data-meaning="\${index}">
		<td>
			<input type="text" name="code_id" id="code_id_\${index}"  class="text" value="\${code_id}" style="width:80%" onfocus="this.select();" onblur="airCommon.validateSpecialChars(this);" />
			<input type="button" name="btnParentCodeIdSearch" value=" " title="<%=StringUtil.getLocaleWord("L.??????????????????", siteLocale)%>" class="btn_search" onclick="CODDWRITE.ajaxSelectCode('\${index}');" />
		</td>
		<td><input type="text" name="code"   class="text width_max" value="\${code}" onblur="airCommon.validateSpecialChars(this);" /></td>
		<td><input type="text" name="name_ko"   class="text width_max" value="\${name_ko}" onblur="airCommon.validateSpecialChars(this);" /></td>
		<td><input type="text" name="name_en"  class="text width_max" value="\${name_en}" onblur="airCommon.validateSpecialChars(this);" /></td>
		<td><input type="text" name="lang_code"  class="text width_max" value="\${lang_code}" onblur="airCommon.validateSpecialChars(this);" /></td>
		<td>
			<select name="status_code" id="status_code" >
<%
	if(STAT_LIST != null && STAT_LIST.getRowCount() > 0){
		for(int i = 0 ; i < STAT_LIST.getRowCount(); i++){
			String tmp_code_id = STAT_LIST.getString(i, "code");
			String tmp_name_ko = STAT_LIST.getString(i, "name_ko");
%>
			{{if status_code == "<%=tmp_code_id%>"}}
				<option value="<%=tmp_code_id%>" title="" selected><%=tmp_name_ko%></option>
			{{else}}
				<option value="<%=tmp_code_id%>" title="" ><%=tmp_name_ko%></option>
			{{/if}}
<%
		}
	}
%>
			</select>
		</td>
		<td><input type="text" name="order_no" class="text width_max" value="\${order_no}" onblur="airCommon.validateNumber(this, this.value)" /></td>
		<td><span class="ui_btn small icon"><span class="add"></span><a href="javascript:void(0)" onclick="CODDWRITE.subDataOpen('\${index}');"> </a></span></td>
		<td align="center">
			{{if init == "N"}}
			<span class="ui_btn small icon"><span class="delete"></span><a href="javascript:void(0)" onclick="CODDWRITE.removeCodLine('\${index}','\${child_cnt}');"> </a></span>
			{{/if}}
			<input type="hidden" name="uuid" id="uuid_\${index}" value="\${index}"/>
			<input type="hidden" name="isNew" id="isNew_\${index}" value="\${isNew}"/>
			<input type="hidden" name="chk_code_id" id="chk_code_id_\${index}" value="\${code_id}"/>
			<input type="hidden" name="memo_ko" id="memo_ko_\${index}" value="\${memo_ko}"/>
			<input type="hidden" name="memo_en" id="memo_en_\${index}" value="\${memo_en}"/>
			<input type="hidden" name="code_attr1" id="code_attr1_\${index}" value="\${code_attr1}"/>
			<input type="hidden" name="code_attr2" id="code_attr2_\${index}" value="\${code_attr2}"/>
			<input type="hidden" name="code_attr3" id="code_attr3_\${index}" value="\${code_attr3}"/>
			<input type="hidden" name="code_attr4" id="code_attr4_\${index}" value="\${code_attr4}"/>
			<input type="hidden" name="code_attr1_desc" id="code_attr1_desc_\${index}" value="\${code_attr1_desc}"/>
			<input type="hidden" name="code_attr2_desc" id="code_attr2_desc_\${index}" value="\${code_attr2_desc}"/>
			<input type="hidden" name="code_attr3_desc" id="code_attr3_desc_\${index}" value="\${code_attr3_desc}"/>
			<input type="hidden" name="code_attr4_desc" id="code_attr4_desc_\${index}" value="\${code_attr4_desc}"/>
			<input type="hidden" name="code_data" id="code_data_\${index}" value="\${code_data}"/>
        </td>
	</tr>
</script>

<form name="form1" method="post">
	<input type="hidden" name="<%=CommonConstants.ACTION_CODE%>" value="<%=action_code%>" />
	<input type="hidden" name="<%=CommonConstants.MODE_CODE%>" />

	<input type="hidden" name="update_mode" value="<%=update_mode%>" />
	<input type="hidden" name="current_mode_code" value="<%=mode_code%>" />
	<input type="hidden" name="current_parent_uuid" value="<%=parent_uuid%>" />
	<input type="hidden" name="sel_uuid_path" value="<%=sel_uuid_path%>" />
<div class="wrap-indent">
	<div class="table_cover">
	<table class="basic">
		<tr>
			<th class="th2"><%=StringUtil.getLocaleWord("L.?????????????????????", siteLocale)%></th>
			<td class="td2">
				<input type="hidden" name="parent_uuid" value="<%=parent_uuid%>" />
				<input type="text" name="parent_code_id" class="text" value="<%=parent_code_id%>" readonly onclick="CODDWRITE.ParentCodeId_Clear(this.form);" />
				<input type="button" name="btnParentCodeIdSearch" value=" " title="<%=StringUtil.getLocaleWord("B.SEARCH",siteLocale)%>" class="btn_search" onclick="CODDWRITE.ParentCodeId_Search();" />
				<br />
				<span class="info">(??? ???????????? ?????? ?????? ????????? ????????? ????????? ??????)</span>
			</td>
		</tr>
	</table>
	</div>
	<br/>
<div id="div_CODE_WRITE_LIST" class="table_cover">

	<table class="basic" id="CODE_INPUT_LIST">
		<colgroup>
			<col width="20%" />
			<col width="20%" />
			<col width="17%" />
			<col width="17%" />
			<col width="9%" />
			<col width="5%" />
			<col width="5%" />
			<col width="5%" />
			<col width="auto" />
		</colgroup>
		<thead>
		<tr>
			<th colspan="9"><span class="info">??????????????????  ???????????? ??? ????????? ??????????????? ????????? ????????? ?????? ???????????? ???????????????.</span></th>
		</tr>
		</thead>
			<tr>
				<th style="text-align:center;"><%=StringUtil.getLocaleWord("L.???????????????", siteLocale)%></th>
				<th style="text-align:center;"><%=StringUtil.getLocaleWord("L.??????", siteLocale)%></th>
				<th style="text-align:center;"><%=StringUtil.getLocaleWord("L.???????????????", siteLocale)%></th>
				<th style="text-align:center;"><%=StringUtil.getLocaleWord("L.???????????????", siteLocale)%></th>
				<th style="text-align:center;"><%=StringUtil.getLocaleWord("L.???????????????", siteLocale)%></th>
				<th style="text-align:center;"><%=StringUtil.getLocaleWord("L.????????????", siteLocale)%></th>
				<th style="text-align:center;"><%=StringUtil.getLocaleWord("L.????????????", siteLocale)%></th>
				<th style="text-align:center;"><%=StringUtil.getLocaleWord("B.??????", siteLocale)%><br/><%=StringUtil.getLocaleWord("B.??????", siteLocale) %></th>
				<th style="text-align:center;"><span class="ui_btn small icon" style="float: right;"><span class="add"></span><a href="javascript:void(0)"  data-meaning="code_list_add"><%=StringUtil.getLocaleWord("B.ADD",siteLocale)%></a></span></th>
			</tr>
		<tbody></tbody>
	</table>
</div>
	<br/>
	<br/>
<div id="div_CODE_SUB_DATA" class="table_cover" style="display:none;">
	<table class="basic">
		<colgroup>
			<col width="10%"/>
			<col width="15%"/>
			<col width="10%"/>
			<col width="15%"/>
			<col width="10%"/>
			<col width="15%"/>
			<col width="10%"/>
			<col width="15%"/>
		</colgroup>
		<tr>
			<th style="">?????? ??????<br />(?????????)</th>
			<td colspan="3"><textarea name="tmp_memo_ko" id="tmp_memo_ko" data-meaning="TMP" class="memo" style="width:98%" onkeyup="airCommon.validateMaxLength(this, '4000');" onblur="airCommon.validateSpecialChars(this);"></textarea></td>
			<th>?????? ??????<br />(??????)</th>
			<td colspan="3"><textarea name="tmp_memo_en" id="tmp_memo_en" data-meaning="TMP" class="memo" style="width:98%" onkeyup="airCommon.validateMaxLength(this, '4000');" onblur="airCommon.validateSpecialChars(this);"></textarea></td>
		</tr>
		<tr>
			<th>?????? ?????????1</th>
			<td><input type="text" name="tmp_code_attr1"  id="tmp_code_attr1" data-meaning="TMP"   class="text width_max" value="" onblur="airCommon.validateSpecialChars(this);" /></td>
			<th>?????? ?????????2</th>
			<td><input type="text" name="tmp_code_attr2"  id="tmp_code_attr2" data-meaning="TMP"   class="text width_max" value="" onblur="airCommon.validateSpecialChars(this);" /></td>
			<th>?????? ?????????3</th>
			<td><input type="text" name="tmp_code_attr3"  id="tmp_code_attr3" data-meaning="TMP"   class="text width_max" value="" onblur="airCommon.validateSpecialChars(this);" /></td>
			<th>?????? ?????????4</th>
			<td><input type="text" name="tmp_code_attr4"  id="tmp_code_attr4" data-meaning="TMP"   class="text width_max" value="" onblur="airCommon.validateSpecialChars(this);" /></td>
		</tr>
		<tr>
			<th><%=StringUtil.getLocaleWord("L.??????", siteLocale)%></th>
			<td><input type="text" name="tmp_code_attr1_desc" id="tmp_code_attr1_desc" data-meaning="TMP"   class="text width_max" value="" onblur="airCommon.validateSpecialChars(this);" /></td>
			<th><%=StringUtil.getLocaleWord("L.??????", siteLocale)%></th>
			<td><input type="text" name="tmp_code_attr2_desc" id="tmp_code_attr2_desc" data-meaning="TMP"   class="text width_max" value="" onblur="airCommon.validateSpecialChars(this);" /></td>
			<th><%=StringUtil.getLocaleWord("L.??????", siteLocale)%></th>
			<td><input type="text" name="tmp_code_attr3_desc" id="tmp_code_attr3_desc" data-meaning="TMP"   class="text width_max" value="" onblur="airCommon.validateSpecialChars(this);" /></td>
			<th><%=StringUtil.getLocaleWord("L.??????", siteLocale)%></th>
			<td><input type="text" name="tmp_code_attr4_desc" id="tmp_code_attr4_desc" data-meaning="TMP"   class="text width_max" value="" onblur="airCommon.validateSpecialChars(this);" /></td>
		</tr>
		<tr>
			<th><%=StringUtil.getLocaleWord("L.???????????????", siteLocale)%></th>
			<td colspan="7"><textarea name="tmp_code_data" id="tmp_code_data" class="memo" style="width:99%" data-meaning="TMP" onkeyup="airCommon.validateMaxLength(this, '4000');"></textarea></td>
		</tr>
	</table>
	<input type="hidden" name="tmp_index" id="tmp_index" data-meaning="TMP" value=""/>
	<span class="ui_btn small icon" style="float: right;"><span class="add"></span><a href="javascript:void(0)"  onclick="CODDWRITE.doCompleSubData();">????????????</a></span>
</div>

	<div class="buttonlist">
		<span class="ui_btn medium icon"><span class="confirm"></span><a href="javascript:void(0)" onclick="CODDWRITE.doSubmit(document.form1);"><%=StringUtil.getLocaleWord("B.SAVE",siteLocale)%></a></span>
		<span class="ui_btn medium icon"><span class="list"></span><a href="javascript:void(0)" onclick="CODDWRITE.goList(document.form1);"><%=StringUtil.getLocaleWord("B.LIST",siteLocale)%></a></span>
	</div>
</div>
</form>

<%--// ????????? ?????? ??? ?????????????????? ?????? ?????? //--%>
