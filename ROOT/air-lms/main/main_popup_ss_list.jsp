<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.emfrontier.air.lms.config.LmsConstants"%>
<%@page import="com.emfrontier.air.lms.util.LmsUtil"%>
<%@page import="com.emfrontier.air.common.jdbc.SQLResults"%>
<%@page import="com.emfrontier.air.common.bean.BeanResultMap"%>
<%@page import="com.emfrontier.air.common.config.CommonConstants" %>    
<%@page import="com.emfrontier.air.common.config.CommonProperties" %>
<%@page import="com.emfrontier.air.common.model.SysLoginModel" %>
<%@page import="com.emfrontier.air.common.util.HtmlUtil" %>
<%@page import="com.emfrontier.air.common.util.StringUtil" %>
<%
    SysLoginModel loginUser = (SysLoginModel)request.getSession().getAttribute(CommonConstants.SESSION_USER);
    String siteLocale = CommonProperties.getSystemDefaultLocale();
    
    if (loginUser != null) {
    	siteLocale = loginUser.getSiteLocale();
    }
    
    //-- 검색값 셋팅
    BeanResultMap requestMap     = (BeanResultMap)request.getAttribute(CommonConstants.REQUEST);
    String pageNo               = requestMap.getString(CommonConstants.PAGE_NO);
    String pageRowSize          = requestMap.getString(CommonConstants.PAGE_ROWSIZE);
    String pageOrderByField     = requestMap.getString(CommonConstants.PAGE_ORDERBY_FIELD);
    String pageOrderByMethod    = requestMap.getString(CommonConstants.PAGE_ORDERBY_METHOD);
    
    String menuParamMunseoBunryuGbnCod1 = requestMap.getString("menuParamMunseoBunryuGbnCod1");
    String menuParamMunseoSeosikGbn     = requestMap.getString("menuParamMunseoSeosikGbn");
    
    if(StringUtil.isBlank(menuParamMunseoBunryuGbnCod1)){
    	menuParamMunseoBunryuGbnCod1 = "SYS_MUNSEO_BUNRYU_GBN_LMS";
    }
    
    
    //-- 결과값 셋팅
    BeanResultMap resultMap             = (BeanResultMap)request.getAttribute(CommonConstants.RESULT);  
    
    // 리스트 컬럼
    String   finalListColumn 			= resultMap.getString("FINAL_LIST_COLUMN");
    String[] finalListColumnArray 		= StringUtil.split(finalListColumn, "|");
    
	String actionCode           = resultMap.getString(CommonConstants.ACTION_CODE);
    String modeCode             = resultMap.getString(CommonConstants.MODE_CODE);
    String contentName          = (String)StringUtil.convertNull(request.getAttribute(CommonConstants.CONTENT_NAME));
    
    String jsonDataUrl = "/ServletController"
            + "?AIR_ACTION=LMS_SS_MAS"  
            + "&AIR_MODE=JSON_LIST";
%>
<form name="form1">
<input type="hidden" data-type="search" name="damdang_id" value="<%=requestMap.getString("DAMDANG_ID")%>"/>
<input type="hidden" data-type="search" name="schGubun" value="<%=requestMap.getString("SCHGUBUN")%>"/>
<input type="hidden" data-type="search" name="stu_id" value="<%=requestMap.getString("STU_ID")%>"/>
<input type="hidden" data-type="search" name="STAT_CD" value="<%=requestMap.getString("STAT_CD")%>"/>
</form>
<div id="listTabsTools-LIST">
	<a href="javascript:void(0)" onclick="doSearch(document.form1)" class="icon-mini-refresh"></a>
</div>

<div id="listTabsLayer" class="easyui-tabs" data-options="border:false,plain:true" style="width:auto;height:auto">
	<table id="listTable" style="width:auto;height:auto">       
        <thead>
        <tr> 
        	<th data-options="field:'SOL_MAS_UID',width:0,hidden:true"></th>
			<th data-options="field:'GB_DOC_MAS_UID',width:0,hidden:true"></th>
			<th data-options="field:'GWANRI_NO',width:120,halign:'center',align:'center',sortable:'true'"><%=StringUtil.getLocaleWord("L.관리번호",siteLocale) %></th>
            <th data-options="field:'SAGEON_TIT',width:420,halign:'center',align:'left',sortable:'true'"><%=StringUtil.getLocaleWord("L.제목",siteLocale) %></th>
            <th data-options="field:'PIGO_NM',width:160,halign:'center',align:'center',sortable:'true'"><%=StringUtil.getLocaleWord("L.피고",siteLocale) %></th>
            <th data-options="field:'SIM_NAM',width:70,halign:'center',align:'center',sortable:'true'"><%=StringUtil.getLocaleWord("L.심급",siteLocale) %></th>
            <th data-options="field:'SOJEGI_DTE',width:100,halign:'center',align:'center',sortable:'true'"><%=StringUtil.getLocaleWord("L.소제기일",siteLocale) %></th>
            <th data-options="field:'SEONGO_DTE',width:100,halign:'center',align:'center',sortable:'true'"><%=StringUtil.getLocaleWord("L.종결일",siteLocale) %></th>
        </tr>
        </thead>
    </table>
</div>
<script type="text/javascript">
/**
 * 검색 수행
 */	
function doSearch() {
	$("#listTable").datagrid("load", airCommon.getSearchQueryParams());
};
 /**
  * onload event handler
  */
 $(document).ready(function() {		
 	$("#listTable").datagrid({
 		singleSelect:false,
		striped:true,
		fitColumns:false,
		rownumbers:true,
		multiSort:true,
		pagination:true,
		pagePosition:'bottom',	
		pageSize:<%=pageRowSize%>,
		nowrap:false,
 		url:'<%=jsonDataUrl%>',
 		method:"post",
 		queryParams:airCommon.getSearchQueryParams(),
 		onClickRow:function(rowIndex,rowData) {
			var url = "/ServletController";
			url += "?AIR_ACTION=LMS_SS_MAS";
			url += "&AIR_MODE=POPUP_INDEX";
			url += "&sol_mas_uid="+rowData.SOL_MAS_UID;
			url += "&gb_doc_mas_uid="+rowData.GB_DOC_MAS_UID;
			
			airCommon.openWindow(url, "1024", "800", "POPUP_VIEW_FORM", "yes", "no", "");	
       	}			            	             
 	});
 // 리사이징 처리
	$(window).resize(function(){
		airCommon.gridResize();
	});
 });
 </script>