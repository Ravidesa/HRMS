package com.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class GetDesignationOptions {

    public static String getEmpDesignationOptions(int deg_id) {
        StringBuilder options = new StringBuilder();

        try ( Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/summerintern", "root", "root");  PreparedStatement stmt = conn.prepareStatement("SELECT id, name FROM designation WHERE status=0");  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                if (id == deg_id) {
                    options.append("<option selected value='").append(id).append("'>").append(name).append("</option>");
                } else {
                    options.append("<option value='").append(id).append("'>").append(name).append("</option>");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return options.toString();
    }
    
    public static String getHrDesignationOptions(int deg_id) {
        StringBuilder options = new StringBuilder();

        try ( Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/summerintern", "root", "root");  PreparedStatement stmt = conn.prepareStatement("SELECT id, name FROM designation WHERE status=1");  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                if (id == deg_id) {
                    options.append("<option selected value='").append(id).append("'>").append(name).append("</option>");
                } else {
                    options.append("<option value='").append(id).append("'>").append(name).append("</option>");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return options.toString();
    }
    
    public static String getLeaveTypeOptions(int leaveTypeId) {
        StringBuilder options = new StringBuilder();

        try ( Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/summerintern", "root", "root");  PreparedStatement stmt = conn.prepareStatement("SELECT idLeaveCategory,catName,allocatedDays FROM leavecategory");  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int leavecatId = rs.getInt("idLeaveCategory");
                String catName = rs.getString("catName");
                int allocatedDays = rs.getInt("allocatedDays");
                if (leavecatId == leaveTypeId) {
                    options.append("<option selected value='").append(leavecatId).append("'>").append(catName).append("</option>");
                } else {
                    options.append("<option value='").append(leavecatId).append("'>").append(catName).append("</option>");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return options.toString();
    }
}
