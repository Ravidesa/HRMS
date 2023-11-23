package com.dao;

import com.entities.Employee;
import com.entities.LeaveApplication;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class LeaveApplicationDao {

    private Connection con;

    public LeaveApplicationDao(Connection con) {
        this.con = con;
    }

    public boolean saveLeave(LeaveApplication leaveApp) {
        boolean issave = false;

        try {
            //emp -> database	
            String query = "insert into leaveapplication(user_id_leave, cat_id_leave, startDate, endDate, reason, applyForDays) values (?,?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, leaveApp.getUser_id_leave());
            pstmt.setInt(2, leaveApp.getCat_id_leave());
            pstmt.setDate(3, leaveApp.getStartDate());
            pstmt.setDate(4, leaveApp.getEndDate());
            pstmt.setString(5, leaveApp.getReason());
            pstmt.setInt(6, leaveApp.getApplyForDays());

            int row = pstmt.executeUpdate();
            if (row > 0) {
                issave = true;
                System.out.println("application for leave inserted successsfully");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.print(issave);
        return issave;
    }

    public List<LeaveApplication> fetchLeaveApplicationOfIndividual(int userID) {
        List<LeaveApplication> leaveAppList = new ArrayList<>();
        try {
            String selectLeaveApp = "SELECT leaveapplication.*, leavecategory.catName FROM summerintern.leaveapplication,summerintern.leavecategory,summerintern.users\n"
                    + "WHERE leavecategory.idLeaveCategory = leaveapplication.cat_id_leave AND users.id = leaveapplication.user_id_leave AND leaveapplication.user_id_leave = " + userID + " order by leaveapplication.applicationID DESC ";
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectLeaveApp);
            while (rs.next()) {
                int applicationID = rs.getInt("applicationID");
                int user_id_leave = rs.getInt("user_id_leave");
                int cat_id_leave = rs.getInt("cat_id_leave");

                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String reason = rs.getString("reason");
                int applyForDays = rs.getInt("applyForDays");

                String catName = rs.getString("catName");
                String rejectReason = rs.getString("rejectreason");

                LeaveApplication leaveApp = new LeaveApplication(applicationID, user_id_leave, cat_id_leave, applyForDays, startDate, endDate, status, reason, catName, rejectReason);
                leaveAppList.add(leaveApp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveAppList;
    }

    public List<LeaveApplication> fetchAllLeaveApplication() {
        List<LeaveApplication> leaveAppList = new ArrayList<>();
        try {
            String selectLeaveApp = "SELECT leaveapplication.*, leavecategory.catName,users.fname,users.lname,users.role,leavebalance.daysRemaining,leavebalance.daysUsed FROM summerintern.leaveapplication,summerintern.leavecategory,summerintern.users,summerintern.leavebalance\n"
                    + "WHERE leavecategory.idLeaveCategory = leaveapplication.cat_id_leave AND users.id = leaveapplication.user_id_leave\n"
                    + "AND leavebalance.user_id_balance = leaveapplication.user_id_leave\n"
                    + "AND users.status = 0 ORDER BY CASE\n"
                    + "WHEN leaveapplication.status = 'PENDING' THEN 0\n"
                    + "WHEN leaveapplication.status = 'APPROVED' THEN 1\n"
                    + "WHEN leaveapplication.status = 'REJECTED' THEN 2\n"
                    + "ELSE 3\n"
                    + "END, leaveapplication.startDate ASC;";
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectLeaveApp);
            while (rs.next()) {
                int applicationID = rs.getInt("applicationID");
                int user_id_leave = rs.getInt("user_id_leave");
                int cat_id_leave = rs.getInt("cat_id_leave");

                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String reason = rs.getString("reason");
                int applyForDays = rs.getInt("applyForDays");

                String catName = rs.getString("catName");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
                int daysRemaining = rs.getInt("daysRemaining");
                String role = rs.getString("role");
                int daysUsed = rs.getInt("daysUsed");

                LeaveApplication leaveApp = new LeaveApplication(applicationID, user_id_leave, cat_id_leave, applyForDays, startDate, endDate, status, reason, catName, fname, lname, daysRemaining, role, daysUsed);
                leaveAppList.add(leaveApp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveAppList;
    }
    
    public List<LeaveApplication> fetchAllPendingApplication() {
        List<LeaveApplication> leaveAppList = new ArrayList<>();
        try {
            String selectLeaveApp = "SELECT leaveapplication.*, leavecategory.catName,users.fname,users.lname,users.role,leavebalance.daysRemaining,leavebalance.daysUsed FROM summerintern.leaveapplication,summerintern.leavecategory,summerintern.users,summerintern.leavebalance\n"
                    + "WHERE leavecategory.idLeaveCategory = leaveapplication.cat_id_leave AND users.id = leaveapplication.user_id_leave\n"
                    + "AND leavebalance.user_id_balance = leaveapplication.user_id_leave\n"
                    + "AND leaveapplication.status like \"PENDING\" AND users.status = 0 ORDER BY CASE\n"
                    + "WHEN leaveapplication.status = 'PENDING' THEN 0\n"
                    + "ELSE 1\n"
                    + "END, leaveapplication.startDate ASC;";
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectLeaveApp);
            while (rs.next()) {
                int applicationID = rs.getInt("applicationID");
                int user_id_leave = rs.getInt("user_id_leave");
                int cat_id_leave = rs.getInt("cat_id_leave");

                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String reason = rs.getString("reason");
                int applyForDays = rs.getInt("applyForDays");

                String catName = rs.getString("catName");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
                int daysRemaining = rs.getInt("daysRemaining");
                String role = rs.getString("role");
                int daysUsed = rs.getInt("daysUsed");

                LeaveApplication leaveApp = new LeaveApplication(applicationID, user_id_leave, cat_id_leave, applyForDays, startDate, endDate, status, reason, catName, fname, lname, daysRemaining, role, daysUsed);
                leaveAppList.add(leaveApp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveAppList;
    }
    
    public List<LeaveApplication> fetchAllApprovedApplication() {
        List<LeaveApplication> leaveAppList = new ArrayList<>();
        try {
            String selectLeaveApp = "SELECT leaveapplication.*, leavecategory.catName,users.fname,users.lname,users.role,leavebalance.daysRemaining,leavebalance.daysUsed FROM summerintern.leaveapplication,summerintern.leavecategory,summerintern.users,summerintern.leavebalance\n"
                    + "WHERE leavecategory.idLeaveCategory = leaveapplication.cat_id_leave AND users.id = leaveapplication.user_id_leave\n"
                    + "AND leavebalance.user_id_balance = leaveapplication.user_id_leave\n"
                    + "AND leaveapplication.status like \"APPROVED\" AND users.status = 0 ORDER BY CASE\n"
                    + "WHEN leaveapplication.status = 'APPROVED' THEN 0\n"
                    + "ELSE 1\n"
                    + "END, leaveapplication.startDate ASC;";
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectLeaveApp);
            while (rs.next()) {
                int applicationID = rs.getInt("applicationID");
                int user_id_leave = rs.getInt("user_id_leave");
                int cat_id_leave = rs.getInt("cat_id_leave");

                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String reason = rs.getString("reason");
                int applyForDays = rs.getInt("applyForDays");

                String catName = rs.getString("catName");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
                int daysRemaining = rs.getInt("daysRemaining");
                String role = rs.getString("role");
                int daysUsed = rs.getInt("daysUsed");

                LeaveApplication leaveApp = new LeaveApplication(applicationID, user_id_leave, cat_id_leave, applyForDays, startDate, endDate, status, reason, catName, fname, lname, daysRemaining, role, daysUsed);
                leaveAppList.add(leaveApp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveAppList;
    }
    
    public List<LeaveApplication> fetchAllRejectedApplication() {
        List<LeaveApplication> leaveAppList = new ArrayList<>();
        try {
            String selectLeaveApp = "SELECT leaveapplication.*, leavecategory.catName,users.fname,users.lname,users.role,leavebalance.daysRemaining,leavebalance.daysUsed FROM summerintern.leaveapplication,summerintern.leavecategory,summerintern.users,summerintern.leavebalance\n"
                    + "WHERE leavecategory.idLeaveCategory = leaveapplication.cat_id_leave AND users.id = leaveapplication.user_id_leave\n"
                    + "AND leavebalance.user_id_balance = leaveapplication.user_id_leave\n"
                    + "AND leaveapplication.status like \"REJECTED\" AND users.status = 0 ORDER BY CASE\n"
                    + "WHEN leaveapplication.status = 'REJECTED' THEN 0\n"
                    + "ELSE 1\n"
                    + "END, leaveapplication.startDate ASC;";
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectLeaveApp);
            while (rs.next()) {
                int applicationID = rs.getInt("applicationID");
                int user_id_leave = rs.getInt("user_id_leave");
                int cat_id_leave = rs.getInt("cat_id_leave");

                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String reason = rs.getString("reason");
                int applyForDays = rs.getInt("applyForDays");

                String catName = rs.getString("catName");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
                int daysRemaining = rs.getInt("daysRemaining");
                String role = rs.getString("role");
                int daysUsed = rs.getInt("daysUsed");

                LeaveApplication leaveApp = new LeaveApplication(applicationID, user_id_leave, cat_id_leave, applyForDays, startDate, endDate, status, reason, catName, fname, lname, daysRemaining, role, daysUsed);
                leaveAppList.add(leaveApp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveAppList;
    }
    
    
    public List<LeaveApplication> fetchLeaveApplicationOfEmp() {
        List<LeaveApplication> leaveAppList = new ArrayList<>();
        try {
            String selectLeaveApp = "SELECT leaveapplication.*, leavecategory.catName,users.fname,users.lname,users.role,leavebalance.daysRemaining,leavebalance.daysUsed FROM summerintern.leaveapplication,summerintern.leavecategory,summerintern.users,summerintern.leavebalance\n"
                    + "WHERE leavecategory.idLeaveCategory = leaveapplication.cat_id_leave AND users.id = leaveapplication.user_id_leave\n"
                    + "AND leavebalance.user_id_balance = leaveapplication.user_id_leave\n"
                    + "AND users.role like \"EMPLOYEE\" AND users.status = 0 ORDER BY CASE\n"
                    + "WHEN leaveapplication.status = 'PENDING' THEN 0\n"
                    + "WHEN leaveapplication.status = 'APPROVED' THEN 1\n"
                    + "WHEN leaveapplication.status = 'REJECTED' THEN 2\n"
                    + "ELSE 3\n"
                    + "END, leaveapplication.startDate ASC;";
            
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectLeaveApp);
            while (rs.next()) {
                int applicationID = rs.getInt("applicationID");
                int user_id_leave = rs.getInt("user_id_leave");
                int cat_id_leave = rs.getInt("cat_id_leave");

                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String reason = rs.getString("reason");
                int applyForDays = rs.getInt("applyForDays");

                String catName = rs.getString("catName");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
                int daysRemaining = rs.getInt("daysRemaining");
                String role = rs.getString("role");
                int daysUsed = rs.getInt("daysUsed");

                LeaveApplication leaveApp = new LeaveApplication(applicationID, user_id_leave, cat_id_leave, applyForDays, startDate, endDate, status, reason, catName, fname, lname, daysRemaining, role, daysUsed);
                leaveAppList.add(leaveApp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveAppList;
    }
    
    public List<LeaveApplication> fetchPendingApplicationOfEmp() {
        List<LeaveApplication> leaveAppList = new ArrayList<>();
        try {
            String selectLeaveApp = "SELECT leaveapplication.*, leavecategory.catName,users.fname,users.lname,users.role,leavebalance.daysRemaining,leavebalance.daysUsed FROM summerintern.leaveapplication,summerintern.leavecategory,summerintern.users,summerintern.leavebalance\n"
                    + "WHERE leavecategory.idLeaveCategory = leaveapplication.cat_id_leave AND users.id = leaveapplication.user_id_leave\n"
                    + "AND leavebalance.user_id_balance = leaveapplication.user_id_leave\n"
                    + "AND users.role like \"EMPLOYEE\" AND leaveapplication.status like \"PENDING\" AND users.status = 0 ORDER BY leaveapplication.applicationID desc";
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectLeaveApp);
            while (rs.next()) {
                int applicationID = rs.getInt("applicationID");
                int user_id_leave = rs.getInt("user_id_leave");
                int cat_id_leave = rs.getInt("cat_id_leave");

                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String reason = rs.getString("reason");
                int applyForDays = rs.getInt("applyForDays");

                String catName = rs.getString("catName");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
                int daysRemaining = rs.getInt("daysRemaining");
                String role = rs.getString("role");
                int daysUsed = rs.getInt("daysUsed");

                LeaveApplication leaveApp = new LeaveApplication(applicationID, user_id_leave, cat_id_leave, applyForDays, startDate, endDate, status, reason, catName, fname, lname, daysRemaining, role, daysUsed);
                leaveAppList.add(leaveApp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveAppList;
    }
    
    public List<LeaveApplication> fetchApprovedApplicationOfEmp() {
        List<LeaveApplication> leaveAppList = new ArrayList<>();
        try {
            String selectLeaveApp = "SELECT leaveapplication.*, leavecategory.catName,users.fname,users.lname,users.role,leavebalance.daysRemaining,leavebalance.daysUsed FROM summerintern.leaveapplication,summerintern.leavecategory,summerintern.users,summerintern.leavebalance\n"
                    + "WHERE leavecategory.idLeaveCategory = leaveapplication.cat_id_leave AND users.id = leaveapplication.user_id_leave\n"
                    + "AND leavebalance.user_id_balance = leaveapplication.user_id_leave\n"
                    + "AND users.role like \"EMPLOYEE\" AND leaveapplication.status like \"APPROVED\" AND users.status = 0 ORDER BY leaveapplication.applicationID desc";
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectLeaveApp);
            while (rs.next()) {
                int applicationID = rs.getInt("applicationID");
                int user_id_leave = rs.getInt("user_id_leave");
                int cat_id_leave = rs.getInt("cat_id_leave");

                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String reason = rs.getString("reason");
                int applyForDays = rs.getInt("applyForDays");

                String catName = rs.getString("catName");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
                int daysRemaining = rs.getInt("daysRemaining");
                String role = rs.getString("role");
                int daysUsed = rs.getInt("daysUsed");

                LeaveApplication leaveApp = new LeaveApplication(applicationID, user_id_leave, cat_id_leave, applyForDays, startDate, endDate, status, reason, catName, fname, lname, daysRemaining, role, daysUsed);
                leaveAppList.add(leaveApp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveAppList;
    }
    
    public List<LeaveApplication> fetchRejectedApplicationOfEmp() {
        List<LeaveApplication> leaveAppList = new ArrayList<>();
        try {
            String selectLeaveApp = "SELECT leaveapplication.*, leavecategory.catName,users.fname,users.lname,users.role,leavebalance.daysRemaining,leavebalance.daysUsed FROM summerintern.leaveapplication,summerintern.leavecategory,summerintern.users,summerintern.leavebalance\n"
                    + "WHERE leavecategory.idLeaveCategory = leaveapplication.cat_id_leave AND users.id = leaveapplication.user_id_leave\n"
                    + "AND leavebalance.user_id_balance = leaveapplication.user_id_leave\n"
                    + "AND users.role like \"EMPLOYEE\" AND leaveapplication.status like \"REJECTED\" AND users.status = 0 ORDER BY leaveapplication.applicationID desc";
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectLeaveApp);
            while (rs.next()) {
                int applicationID = rs.getInt("applicationID");
                int user_id_leave = rs.getInt("user_id_leave");
                int cat_id_leave = rs.getInt("cat_id_leave");

                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String reason = rs.getString("reason");
                int applyForDays = rs.getInt("applyForDays");

                String catName = rs.getString("catName");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
                int daysRemaining = rs.getInt("daysRemaining");
                String role = rs.getString("role");
                int daysUsed = rs.getInt("daysUsed");

                LeaveApplication leaveApp = new LeaveApplication(applicationID, user_id_leave, cat_id_leave, applyForDays, startDate, endDate, status, reason, catName, fname, lname, daysRemaining, role, daysUsed);
                leaveAppList.add(leaveApp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveAppList;
    }
    
    public boolean updateStatus(int applicationId, String status) {
        boolean isUpdate = false;

        try {
            //emp -> database	
            String query = "UPDATE leaveapplication SET status = ? WHERE applicationID=?";
            PreparedStatement preparedStatement = this.con.prepareStatement(query);
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, applicationId);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Status updated successfully");
                isUpdate = true;
            } else {
                System.out.println("Failed to update status");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.print(isUpdate);
        return isUpdate;
    }
    
    
    public boolean updateRejectReason(int applicationId, String rejectreson) {
        boolean isUpdate = false;

        try {
            //emp -> database	
            String query = "UPDATE leaveapplication SET rejectreason = ? WHERE applicationID=?";
            PreparedStatement preparedStatement = this.con.prepareStatement(query);
            preparedStatement.setString(1, rejectreson);
            preparedStatement.setInt(2, applicationId);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Status updated successfully");
                isUpdate = true;
            } else {
                System.out.println("Failed to update status");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.print(isUpdate);
        return isUpdate;
    }
    
    public boolean updateLeaveApplication(LeaveApplication leaveApp){
        boolean isUpdated = false;

        try {
            //emp -> database	
            String query = "UPDATE leaveapplication SET cat_id_leave=?, startDate=?, endDate=?, reason=?, applyForDays=? WHERE applicationID=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, leaveApp.getCat_id_leave());
            pstmt.setDate(2, leaveApp.getStartDate());
            pstmt.setDate(3, leaveApp.getEndDate());
            pstmt.setString(4, leaveApp.getReason());
            pstmt.setInt(5, leaveApp.getApplyForDays());
            pstmt.setInt(6,leaveApp.getApplicationID());

            int row = pstmt.executeUpdate();
            if (row > 0) {
                isUpdated = true;
                System.out.println("Updated Leave application successfully");
            }else{
                System.out.println("not updated Leave application");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.print(isUpdated);
        return isUpdated;
    }

    public boolean deleteLeaveApp(int leaveAppId){
        boolean isDeleted = false;
        try{
            String empSql = "DELETE FROM leaveapplication WHERE applicationID="+leaveAppId;
            
            Statement stmt = this.con.createStatement();
            int row = stmt.executeUpdate(empSql);
            
            if(row > 0){
                isDeleted = true;
            }
            
        }catch (Exception e) {
            e.printStackTrace();
        }
        
        return isDeleted;
    }
}
