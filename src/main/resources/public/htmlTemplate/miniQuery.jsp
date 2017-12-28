<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML>
<html>
<head>
<title>学生信息管理</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="renderer" content="webkit" />
<meta name="robots" content="noindex,nofollow" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<script src="scripts/boot.js" type="text/javascript"></script>
<link href="scripts/miniui/res/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}
.header {
	background: url(images/header.gif) repeat-x 0 -15px;
}
html body .searchbox .mini-buttonedit-icon {
	background: url(images/search.gif) no-repeat 50% 50%;
}
.inputLable {
	width: 70px;
}
.inputWidthH{
	width:48%;
}
</style>
<script src="scripts/gridFun.js" type="text/javascript"></script>
<script type="text/javascript">
	var gendarData=[{"id":"男","text":"男","nameSpell":"nan"},{"id":"女","text":"女","nameSpell":"nv"}];
	var canLoginData=[{"id":"0","text":"禁止登录"},{"id":"1","text":"允许登录"}];
</script>
</head>
<body>
	<div class="mini-toolbar" style="padding: 2px;">
		<table style="width: 100%;">
			<tr>
				<td style="width: 100%;">
					<a class="mini-button" id="addBtn" iconCls="fa-plus colorGreen" plain="true" onclick="addFun('stuBaseEdit.shtml','新增信息',800,450,'datagrid1','stuBaseSave_add.shtml','examno','true')">新增</a> 
					<a class="mini-button" id="editBtn" iconCls="fa-edit colorBlue" plain="true" onclick="editSetFun()">查看/编辑</a> 
					<a class="mini-button" id="delBtn" iconCls="fa-remove colorRed" plain="true" onclick="removeFun('stuBaseDelete.shtml', 'datagrid1', 'examno')">删除</a> 
					<a class="mini-button" iconCls="fa-database colorGreen" plain="true" onclick="showImpPanel">数据导入</a>
					<a class="mini-button" iconCls="fa-key colorBlue" plain="true" onclick="onPswClick">重置密码</a>
					<a class="mini-button" iconCls="fa-refresh colorGreen" plain="true" onclick="location.reload(true)">刷新</a>
				</td>

				<td style="white-space: nowrap;"><a class="mini-button" iconCls="expand1" onclick="expand" plain="true">隐藏搜索</a></td>
			</tr>
		</table>
	</div>

	<div id="p1" style="border: 1px solid #99BCE8; border-top: 0; height: 240px; padding: 5px; background-color: #ECEDEF;">
		<form id="form1" method="post" style="margin: 0px; padding: 0px; margin-top: 10px;">
			<table style="width: 100%;table-layout:fixed;" >
				<!--container_tag_start-->			
				<tr>
					<!--content_repeat:{"repeat":4,"columns":["column_comment","column_name","column_name","widgetType"]}-->
					<td class="inputLable">%s：</td><td><input name="%s" id="%s" class="%s inputWidth" /></td>			
				</tr>
				<!--container_tag_end-->
				<tr>
					<td colspan="6" style="text-align: center;padding-top:5px;">
						<a class="mini-button" iconCls="fa-search colorGreen" onclick="search();" style="margin-right:10px;">查询</a>
						<a class="mini-button" iconCls="fa-rotate-left colorOrange" onclick="resetFun" style="margin-right:10px;">重置</a>
						<a class="mini-button" iconCls="collapse1" onclick="stuExp" style="margin-right:10px;">导出</a>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<!--撑满页面-->
	<div id="myfit" class="mini-fit">
		<div id="datagrid1" class="mini-datagrid" style="width: 100%; height: 100%;" borderStyle="border-top-width:0px;" url="stuBaseJsonPages.shtml" idField="id" multiSelect="true" 
			sizeList="[20,50,100,300,500,1000,3000]" pageSize="20" allowSortColumn="false" onrowdblclick="editSetFun" showColumnsMenu="true" showEmptyText="true" emptyText="无查询结果！">
			<div property="columns">
				<div type="checkcolumn" width="10"></div>
				<!--single_repeat:{"repeat":10,"columns":["column_name","column_name","column_comment"]}-->
				<div name="%s" field="%s" width="30" headerAlign="center" allowSort="true">%s</div>
			</div>
		</div>
	</div>


<!-- 修改密码 -->
	<div id="win1" class="mini-window" title="更改学生登录信息" style="width: 350px; height: 200px;" showMaxButton="false" showFooter="true" showModal="true" allowResize="false" allowDrag="true">
		<form id="form2" method="post">
			<div style="padding: 15px; border: 0px #ccc solid;">
				<input name="ids" id="ids" class="mini-hidden inputWidth" required="true" enabled="false" />
				<table style="width:100%;">
					<tr>
						<td class="inputLable">允许登录：</td>
						<td style="font-size:14px;font-weight:bold;color:red;">
							<input name="canLogin" id="canLogin" data="canLoginData" value="1" class="mini-combobox inputWidth" required="false" allowInput="false" valueFromSelect="true" />
						</td>
					</tr>
					<tr>
						<td class="inputLable">新密码：</td>
						<td><input name="loginPsw" id=loginPsw class="mini-password inputWidth" required="false" emptyText="不改请留空" /></td>
					</tr>
					<tr>
						<td class="inputLable">确认密码：</td>
						<td><input name="loginPswRep" id="loginPswRep" class="mini-password inputWidth" required="false"  onvalidation="onPswRepValidation" emptyText="不改请留空" /></td>
					</tr>
				</table>
			</div>
		</form>
		<div property="footer" style="text-align: right; padding: 5px; padding-right: 15px;">
			<a class="mini-button" iconCls="icon-remove" onclick="hidePswWindow">取消</a>&nbsp;&nbsp; <a class="mini-button" iconCls="icon-save" onclick="stuLoginRestSave">保存</a>
		</div>
	</div>
	
	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid1");
		var form = new mini.Form("form1");
		//重置密码
		var form2 = new mini.Form("form2");
		var win = mini.get("win1");
		function onPswClick(e) {
			form2.reset();
			var rows = grid.getSelecteds();
			if (rows.length < 1) {
				mini.alert("请选中一条记录");
				return;
			}
			var ids = [];
			for (var i = 0, l = rows.length; i < l; i++) {
				var r = rows[i];
				ids.push(r.examno);
			}
			var id = ids.join(',');
			mini.get("ids").setValue(id);
			win.show();
		}
		function hidePswWindow() {
			form2.reset();
			win.hide();
		}
		function onPswRepValidation(e) {
			if (e.isValid) {
				var userpassStr = mini.get("loginPsw").getValue();
				if (e.value != userpassStr) {
					e.errorText = "两次密码输入不一致";
					e.isValid = false;
				}
			}
		}
		function stuLoginRestSave() {
		    var o = form2.getData(true); 
		    form2.validate();
		    if (form2.isValid() == false) return;
		    mini.mask({
		        el: document.body,
		        cls: 'mini-mask-loading',
		        html: '保存中...'
		    });
		    $.ajax({
		        url:"stuLoginReset.shtml",
				type: "POST",
		        data: o,
		        cache: false,
		        dataType:"json",
		        success: function(json) {
		        	var messageid = mini.showMessageBox({
		                title: "操作提示",
		                iconCls: "mini-messagebox-question",
		                buttons: ["ok"],
		                message: json.msg,
		                iconCls:"mini-messagebox-info",
		                callback: function (action) {
		                	if(json.success){
		                		hidePswWindow();
		                	}
		                }
		            });
		        },
		        error: function (jqXHR, textStatus, errorThrown) {
		            alert(jqXHR.responseText);
		        },
		        complete:function(jqXHR, textStatus, errorThrown){
		        	mini.unmask(document.body);
		        }
		    });
		}
		
		//search
		function search() {
			form.validate();
			if (form.isValid() == false){
				mini.alert("查询条件输入有误，请检查！");
				return;
			}
			
			mini.mask({
	            el: document.body,
	            cls: 'mini-mask-loading',
	            html: 'loading...'
	        });
			var o = form.getData();
			o.birthdate=mini.formatDate(o.birthdate,"yyyy-MM-dd");
			o.birthdate2=mini.formatDate(o.birthdate2,"yyyy-MM-dd");
			grid.load(o);
			setTimeout(function(){
				mini.unmask();
			},"100");
		}
		
		var tip = new mini.ToolTip();
		tip.set({
			target : document,
			selector : '[data-tooltip], [title]'
		});

		function beforeTreeLoad(e) {
	        var mytree = e.sender;    //树控件
	        var node = e.node;      //当前节点
	        var params = e.params;  //参数对象
	        //可以传递自定义的属性
	        params.pid = node.spid; //后台：request对象获取"myField"  
	    }
		
        function beforeTreeLoadXzqh(e) {
	        var mytree = e.sender;    //树控件
	        var node = e.node;      //当前节点
	        var params = e.params;  //参数对象
	        //可以传递自定义的属性
	        params.pid = node.codeid; //后台：request对象获取"myField"  
	    }
        
        function beforenodeselect(e) {
        	 //禁止选中父节点
            if (e.isLeaf == false) e.cancel = true;
        }
	
		function editSetFun() {
			var baseData = {
				url : 'stuBaseEdit.shtml',//mini.open的URL
				title : '编辑信息',
				width : '800',
				height : '450',
				gridId : 'datagrid1',
				dataid : 'examno',
				saveUrl : 'stuBaseSave_edit.shtml',
				setDataUrl : 'stuBaseByIdJson.shtml',
				idsEnabled : '${noEditField}',
				//idsEnabled : 'examno,stuno,gendar,idno,birthdate,schoolcensus,enroyear,clsid,enrollspname,enrollspid',
				idsEnabledValue : 'false',
				formid : 'form1',
				parObj : []
			/*
			parObj:[{//二次赋值
				parid:'roleid',
				parUrl:'getPrvByRoleid.shtml',
				parResId:'prvid',
				parResText:'pname'
			}]
			 */
			}
			editFun(baseData);
		}

		//searchBtn
		var girdObj = mini.get("datagrid1");
		var girdHeight = $("#datagrid1").height();
		var myfitHeight = $("#myfit").height();
		function expand(e) {
			var btn = e.sender;
			var display = $('#p1').css('display');
			if (display == "none") {
				$("#myfit").height(myfitHeight);
				mini.get("datagrid1").setHeight(girdHeight);
				btn.setIconCls("expand1");
				btn.setText("隐藏搜索");
				$('#p1').css('display', "block");
			} else {
				$("#myfit").height(myfitHeight + 251);
				mini.get("datagrid1").setHeight(girdHeight + 251);
				btn.setIconCls("collapse1");
				btn.setText("展开搜索");
				$('#p1').css('display', "none");
			}
		}
		
		
	
	//系、专业、班级 三级联动
	var deptCombo = mini.get("did");
	var spCombo = mini.get("spid");
	var clsCombo = mini.get("clsid");
	
	function onDeptChanged(e) {
		var did = deptCombo.getValue();
		spCombo.setValue("");
		spCombo.load("stuSpclJsonByDid.shtml?did="+did);
		
		clsCombo.setValue("");
		clsCombo.load("stuClasJsonByDid.shtml?did="+did);
	}
	
	function onSpChanged(e) {
		var spid = spCombo.getValue();
		clsCombo.setValue("");
		clsCombo.load("stuClasJsonBySpid.shtml?spid="+spid);
	}
	
	function resetFun(e) {
		form.reset();
		spCombo.load("stuSpclJsonByDid.shtml");
		clsCombo.load("stuClasJsonBySpid.shtml");
	}
	
	/*****************added by zhouy*************************************/
	function stuExp(){
		var temp_form = document.getElementById("form1");
        temp_form.action = "excel/exp/stu.shtml";
        temp_form.target = "_blank";
        temp_form.method = "post";
        mini.confirm("确认导出数据？","确认",function(action){
			if(action=="ok"){
				temp_form.submit();
			}
		});
	}
	
	function showImpPanel(){
		var win = mini.open({
            title: '基本信息数据导入',
            url: 'excel/imp/stuImpView.shtml',
            showModal: true,
            width: 800,
            height: 500
        });
	}
	/*****************end*************************************/
	$(function() {
		$("#key").bind("keydown", function(e) {
			if (e.keyCode == 13) {
				gridSearchFun('datagrid1', 'key');
			}
		});
	
		//权限验证
		var r = "${STU_BASE_A}";
		if (r == "false") {
			mini.get("addBtn").setEnabled(false);
			mini.get("addBtn").setTooltip("无权限<br/>STU_BASE_A");
			mini.get("addBtn").hide();
		}
	
		var r3 = "${STU_BASE_D}";
		if (r3 == "false") {
			mini.get("delBtn").setEnabled(false);
			mini.get("delBtn").setTooltip("无权限<br/>STU_BASE_D");
			mini.get("delBtn").hide();
		}
		
	
	});
	
	</script>

</body>
</html>