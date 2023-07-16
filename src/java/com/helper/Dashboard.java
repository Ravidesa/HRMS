/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.helper;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class Dashboard {

    private Connection con;

    public Dashboard(Connection con) {
        this.con = con;
    }
    
    public int countAllHr() {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_employees FROM users WHERE role like \"HR\" ";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_employees");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int countAllPendingLeaveOfHr() {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_pending_leave_applications\n" +
                              "FROM leaveapplication,users WHERE leaveapplication.status = 'PENDING'\n" +
                              " AND users.role like \"HR\" AND leaveapplication.user_id_leave = users.id; ";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_leave_employees");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int countAllApprovedLeaveOfHr() {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_pending_leave_applications\n" +
                              "FROM leaveapplication,users WHERE leaveapplication.status = 'APPROVED'\n" +
                              " AND users.role like \"HR\" AND leaveapplication.user_id_leave = users.id; ";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_leave_employees");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int countAllRejectedLeaveOfHr() {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_pending_leave_applications\n" +
                              "FROM leaveapplication,users WHERE leaveapplication.status = 'REJECTED'\n" +
                              " AND users.role like \"HR\" AND leaveapplication.user_id_leave = users.id; ";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_leave_employees");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int countAllEmp() {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_employees FROM users WHERE role like \"EMPLOYEE\" ";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_employees");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int countAllPendingLeaveOfEmp() {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_pending_leave_applications\n" +
                              "FROM leaveapplication,users WHERE leaveapplication.status = 'PENDING'\n" +
                              " AND users.role like \"EMPLOYEE\" AND leaveapplication.user_id_leave = users.id; ";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_pending_leave_applications");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int countAllApprovedLeaveOfEmp() {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_approve_leave_applications\n" +
                              "FROM leaveapplication,users WHERE leaveapplication.status = 'APPROVED'\n" +
                              " AND users.role like \"EMPLOYEE\" AND leaveapplication.user_id_leave = users.id; ";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_approve_leave_applications");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int countAllRejectedLeaveOfEmp() {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_rejected_leave_applications\n" +
                              "FROM leaveapplication,users WHERE leaveapplication.status = 'REJECTED'\n" +
                              " AND users.role like \"EMPLOYEE\" AND leaveapplication.user_id_leave = users.id; ";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_rejected_leave_applications");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    //For Individual
    public int countAllPendingLeave(int userId) {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_pending_leave_applications\n" +
                              "FROM leaveapplication WHERE status = 'PENDING' AND user_id_leave ="+userId ;
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_pending_leave_applications");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int countAllApproveLeave(int userId) {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_approved_leave_applications\n" +
                              "FROM leaveapplication WHERE status = 'APPROVED' AND user_id_leave ="+userId ;
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_approved_leave_applications");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int countAllLeave(int userId) {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_leave\n" +
                              "FROM leaveapplication WHERE user_id_leave ="+userId ;
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_leave");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int countAllRejectedLeave(int userId) {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_rejected_leave_applications\n" +
                              "FROM leaveapplication WHERE status = 'REJECTED' AND user_id_leave ="+userId ;
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_rejected_leave_applications");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    
//    For SA
    public int countAllPending() {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_pending_leave_applications\n" +
                              "FROM leaveapplication,users WHERE leaveapplication.status = 'PENDING'\n" +
                              "AND leaveapplication.user_id_leave = users.id; ";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_pending_leave_applications");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int countAllApproved() {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_approved_leave_applications\n" +
                              "FROM leaveapplication,users WHERE leaveapplication.status = 'APPROVED'\n" +
                              " AND leaveapplication.user_id_leave = users.id; ";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_approved_leave_applications");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public int countAllRejected() {
        int count = 0;
        try {
            String sqlCount = "SELECT COUNT(*) AS total_rejected_leave_applications\n" +
                              "FROM leaveapplication,users WHERE leaveapplication.status = 'REJECTED'\n" +
                              "AND leaveapplication.user_id_leave = users.id; ";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sqlCount);

            if (rs.next()) {
                int totalEmployees = rs.getInt("total_rejected_leave_applications");
                count = totalEmployees;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
