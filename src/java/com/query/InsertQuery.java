/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.query;

import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author RAVI DESAI
 */
public class InsertQuery {
    
    private String tableName;
    private List<String> columns;
    private List<Object> values;

    public InsertQuery() {
        columns = new ArrayList<>();
        values = new ArrayList<>();
    }

    public InsertQuery setTableName(String tableName) {
        this.tableName = tableName;
        return this;
    }

    public InsertQuery addColumns(List<String> columnNames) {
        columns.addAll(columnNames);
        return this;
    }

    public InsertQuery addValue(Object value) {
        values.add(value);
        return this;
    }
    
   public String buildInsertQuery(String tableName, List<String> attributeNames, List<String> attributeValues) {
        StringBuilder queryBuilder = new StringBuilder();
        queryBuilder.append("INSERT INTO ")
                .append(tableName)
                .append(" (");

        StringBuilder valuesBuilder = new StringBuilder();
        valuesBuilder.append("VALUES (");

        boolean isFirst = true;
        for (int i = 0; i < attributeNames.size(); i++) {
            if (!isFirst) {
                queryBuilder.append(", ");
                valuesBuilder.append(", ");
            }
            queryBuilder.append(attributeNames.get(i));
            
            valuesBuilder.append("'");
            valuesBuilder.append(attributeValues.get(i));
            valuesBuilder.append("'");

            isFirst = false;
        }

        queryBuilder.append(") ")
                .append(valuesBuilder)
                .append(")");

        return queryBuilder.toString();
    }
   
   

    public String buildWithPara() {
        StringBuilder queryBuilder = new StringBuilder();
        queryBuilder.append("INSERT INTO ")
                .append(tableName);

        if (!columns.isEmpty()) {
            queryBuilder.append(" (");
            for (int i = 0; i < columns.size(); i++) {
                if (i > 0) {
                    queryBuilder.append(", ");
                }
                queryBuilder.append(columns.get(i));
            }
            queryBuilder.append(")");
        }

        queryBuilder.append(" VALUES ");
        
        

        if (!values.isEmpty()) {
            queryBuilder.append("(");
            for (int i = 0; i < values.size(); i++) {
                if (i > 0) {
                    queryBuilder.append(", ");
                }
                Object value = values.get(i);
                if (value instanceof String) {
                    queryBuilder.append("'").append(value).append("'");
                } else {
                    queryBuilder.append(value);
                }
            }
            queryBuilder.append(")");
        }

        return queryBuilder.toString();
    }
    
}
