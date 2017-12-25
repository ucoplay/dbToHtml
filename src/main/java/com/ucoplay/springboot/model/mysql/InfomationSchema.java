package com.ucoplay.springboot.model.mysql;

public class InfomationSchema {
	String table_schema;
	String table_name;
	String column_name;
	String ordinal_position;
	String column_default;
	String is_nullable;
	String data_type;
	long character_maximum_length;
	String column_key;
	String column_comment;
	public String getTable_schema() {
		return table_schema;
	}
	public void setTable_schema(String table_schema) {
		this.table_schema = table_schema;
	}
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	public String getColumn_name() {
		return column_name;
	}
	public void setColumn_name(String column_name) {
		this.column_name = column_name;
	}
	public String getOrdinal_position() {
		return ordinal_position;
	}
	public void setOrdinal_position(String ordinal_position) {
		this.ordinal_position = ordinal_position;
	}
	public String getColumn_default() {
		return column_default;
	}
	public void setColumn_default(String column_default) {
		this.column_default = column_default;
	}
	public String getIs_nullable() {
		return is_nullable;
	}
	public void setIs_nullable(String is_nullable) {
		this.is_nullable = is_nullable;
	}
	public String getData_type() {
		return data_type;
	}
	public void setData_type(String data_type) {
		this.data_type = data_type;
	}
	
	public long getCharacter_maximum_length() {
		return character_maximum_length;
	}
	public void setCharacter_maximum_length(long character_maximum_length) {
		this.character_maximum_length = character_maximum_length;
	}
	public String getColumn_key() {
		return column_key;
	}
	public void setColumn_key(String column_key) {
		this.column_key = column_key;
	}
	public String getColumn_comment() {
		return column_comment;
	}
	public void setColumn_comment(String column_comment) {
		this.column_comment = column_comment;
	}
	

}
