<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<script src="/scripts/boot.js" type="text/javascript"></script>
	<link href="/scripts/miniui/themes/bootstrap/skin.css" rel="stylesheet" type="text/css" />
	
	<script src="/scripts/index/index.js" type="text/javascript"></script>
	<script src="/scripts/index/localStorage.js" type="text/javascript"></script>
	<link rel="stylesheet" href="/css/index/index.css" type="text/css" />
</head>
<body>
	<div class="wrap">
		<div id="header"></div>
		<form id="databaseinfo">
			<table>
				<tr>
					<td style="width:20%">数据库类型*</td>
					<td class="align-left"><div class="mini-combobox"  id="dbType"  textField="text" valueField="type" data="dbList" value="mysql"></div></td>
				</tr>
				<tr>
					<td>地址*</td>
					<td><input class="mini-textbox long"  id="url" name="url" emptyText="host:port eg: www.ucoplay.com:3306"/></td>
				</tr>
				<tr>
					<td>数据库名*</td>
					<td class="align-left"><input class="mini-textbox"  name="dbname"/></td>
				</tr>
				<tr>
					<td>用户名*</td>
					<td class="align-left"><input class="mini-textbox"  name="user"/></td>
				</tr>
				<tr>
					<td >密码*</td>
					<td class="align-left"><input class="mini-textbox"  name="pwd"/></td>
				</tr>
				<tr>
					<td></td>
					<td class="align-left">
						<a class="mini-button mini-button-primary" id="connect" onclick="connect">连接</a>
						<a class="mini-button mini-button-primary" id="remove" onclick="remove">删除记录</a>
					</td>
				</tr>
			</table>
		</form>
		<form id="detail" method="post">
			<table id="listTable" style="display:none">
					<tr>
						<td>
							<b>选择用户表\视图</b>
							<ul id="tableList" class="mini-tree"  showTreeIcon="true"  textField="column_comment" idField="column_name" parentField="table_name" 
								resultAsTree="false" allowDrag="true" allowDrop="true" style="height:300px;" showCheckBox="true"  onNodeCheck="setColumnWidgetData">
							</ul>
						</td>
					</tr>
					<tr>
						<td>
							<b>指定控件类型</b>
							<div class="mini-datagrid" id="columnWidget" showPager="false" allowCellEdit="true" allowAlternating="true" allowCellSelect="true">
								<div property="columns">
									<div header="表名" field="table_name"></div>
									<div header="字段" field="column_name"></div>
									<div header="字段说明" field="column_comment">
										<input class="mini-textbox" style="width:100%" property="editor">
									</div>
									<div header="控件类型"  field="widgetType"  autoShowPopup="true" type="comboboxcolumn">
										<input class="mini-combobox" property="editor" data="widgetList">
									</div>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<b>选择html模板</b>
							<ul>
								<li>
									<p>默认模板</p>
									<span>列表页</span></span><img src="/img/template/default/list.png" />
									<span>添加/修改</span><img src="/img/template/default/detail.png" />
								</li>
							</ul>
						</td>
					</tr>
					
					<tr>
						<td style="text-align:center;padding-top:20px;">
							<a class="mini-button mini-button-primary" id="genQueryHtml" onclick="genQueryHtml">生成查询页面</a>
							<a class="mini-button mini-button-primary" id="genDetailHtml" onclick="genDetailHtml">生成修改页面</a>
							<input type="hidden" name="colInfoListString" id="colInfoListString" />
						</td>
					</tr>
				</table>
			</form>		
	</div><!-- wrap end -->
</body>
<script>
</script>
</html>