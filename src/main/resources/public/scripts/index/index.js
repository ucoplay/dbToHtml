var dbList=[
					{
						"type":"mysql",
						"text":"mysql"
					}
				];

var templates = [
	{
		"id":"1",
		"text":"default"
	}
	];
$(document).ready(main);

function main(){
	mini.parse();
	var form = new mini.Form("databaseinfo");
	var data = getDBInfo();
	form.setData(data);
}

/**
 * 连接数据库
 * @returns
 */
function connect(){
	var form = new mini.Form("databaseinfo");
	var data = form.getData();
	var dbType = mini.get("dbType").getValue();
	var url = "";
	if(dbType=="mysql"){
		url = "/queryMysqlUserTables";
	}
	$.ajax({ 
		type:"POST", 
		url:url,
		dataType:"json",      
		contentType: "application/json; charset=utf-8",
		processData: false,
		data:mini.encode(data),
		beforeSend:function(){
			mini.mask({
		        el: document.body,
		        cls: 'mini-mask-loading',
		        html: '连接中...'
		    });	
		}
	}).done(function(dataList){
		storeDBInfo(data);
		showTables(dataList);
	}).fail(function(data){
		mini.showMessageBox({
			title:"连接失败",
			buttons:["确定"],
			message:data.responseText,
			iconCls:"mini-messagebox-info"
		});
	}).always(function(){
		mini.unmask();
	});
}

/**
 * 生成tree的数据
 * @param dataList
 * @returns
 */
function showTables(dataList){
	var parentList = getParentList(dataList);
	var treeData = setChildren(parentList,dataList)
	mini.get("tableList").loadData(treeData);
	$("#listTable").show();
	mini.parse();
}
function setChildren(parentList,dataList){
	for(var i=0;i<parentList.length;i++){
		var parent = parentList[i];
		parent.children = [];
		for(var j=0;j<dataList.length;j++){
			var data = dataList[j];
			if(data.table_name == parent.table_name){
				parent.children.push(data);
			}
		}
	}
	return parentList;
}
function getParentList(dataList){
	var parentList = [];
	for(var i=0;i<dataList.length;i++){
		var data = dataList[i];
		var matched = false;
		for(var j=0;j<parentList.length;j++){
			var parent = parentList[j];
			if(data.table_name==parent.table_name){
				matched = true;
				break;
			}
		}
		if(!matched){
			var parent = new Object();
			parent.table_name = data.table_name;
			parent.column_comment = data.table_name;
			parent.column_name = data.table_name;
			parentList.push(parent);
		}
	}
	return parentList;
}

function genQueryHtml(){
	var url = "/downLoadMiniuiQueryTemplate";
	download(url);
}
function genDetailHtml(){
	var url = "/downLoadMiniuiEditTemplate";
	download(url);
}
/**
 * 根据选择的表和模板，生成html
 * @returns
 */
function download(url){
	var tableList = mini.get("columnWidget");
	var columns = tableList.getData();
	if(!columns||columns.length==0){
		mini.alert("请先选择要生成的表！");
		return;
	}
	$("#colInfoListString").val(mini.encode(columns));
	var form = $("#detail");
	form.attr("action",url)
	form.attr("target","_blank");
	console.log(form.attr("elements"));
	form.submit();
}

function setColumnWidgetData(sender,node,isLeaf){
	var tableList = mini.get("tableList");
	var checkedNodes = tableList.getCheckedNodes(false);
	var columnWidget = mini.get("columnWidget");
	var columnList = mini.clone(checkedNodes);
	addDefaultWidgetType(columnList);
	columnWidget.setData(columnList);
}


var widgetList = [
	{"id":"mini-datepicker","text":"日期控件(date)"},
	{"id":"mini-textbox","text":"文本框(textbox)"},
	{"id":"mini-combobox","text":"下拉框(combobox)"},
	{"id":"mini-spinner","text":"数值(spinner)"}
];

var defaultComboboxReg = /(编码|状态|名称|民族|性别)/;
function addDefaultWidgetType(columnList){
	if(!columnList) return
	for(var i=0;i<columnList.length;i++){
		var column = columnList[i]; 
		if(column.data_type=="varchar"){
			column.widgetType="mini-textbox";
			if(defaultComboboxReg.test(column.column_comment)){
				column.widgetType="mini-combobox";
			}
		}else if(column.data_type=="date"){
			column.widgetType="mini-datepicker";
		}else if(column.data_type=="decimal"){
			column.widgetType="mini-spinner";
		}
	}
}










