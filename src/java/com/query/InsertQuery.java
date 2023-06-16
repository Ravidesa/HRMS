/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.query;

import java.util.List;

/**
 *
 * @author RAVI DESAI
 */
public class InsertQuery {
    
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
    
}
