/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.query;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author RAVI DESAI
 */
public class SelectQuery {
    private String tableName;
    private List<String> columns;
    private List<String> conditions;
    
    public SelectQuery() {
        conditions = new ArrayList<>();
    }
    
    public SelectQuery setTableName(String tableName){
        this.tableName = tableName;
        return this;
    }
    
    public SelectQuery setColumns(List<String> columns) {
        this.columns = columns;
        return this;
    }
    
    public SelectQuery addCondition(String columnName, Object value) {
        String condition;
        if(value instanceof String){
            condition = columnName + " = '" + value + "'";        
        }else{
            condition = columnName + " = " + value + "";    
        }
        conditions.add(condition);
        return this;
    }
    
    public String buildSelect(){
        StringBuilder selectBuilder =  new StringBuilder();
        selectBuilder.append("SELECT ");
        
        if(columns == null || columns.isEmpty()){
            selectBuilder.append("*");
        }else{
            for(int i=0; i<columns.size(); i++){
                if(i > 0){
                    selectBuilder.append(", ");
                }
                selectBuilder.append(columns.get(i));
            }
        }
        
        selectBuilder.append(" FROM ").append(tableName);
        
        if (!conditions.isEmpty()) {
            selectBuilder.append(" WHERE ");
            for (int i = 0; i < conditions.size(); i++) {
                if (i > 0) {
                    selectBuilder.append(" AND ");
                }
                selectBuilder.append(conditions.get(i));
            }
        }
         
        return selectBuilder.toString();
    }
}
