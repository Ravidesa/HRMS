/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.entities;

import java.sql.Date;

public class LeaveApplication {

    private int applicationID;
    private int user_id_leave;
    private int cat_id_leave;

    private int applyForDays;

    private Date startDate;
    private Date endDate;

    private String status;
    private String reason;
    
    private String catName;
    private String fname;
    private String lname;
    private int daysRemaining;
    private String role;
    private int daysUsed;
    
    private String rejectReason;

    public LeaveApplication(int applicationID, int user_id_leave, int cat_id_leave, Date startDate, Date endDate, String status, String reason) {
        this.applicationID = applicationID;
        this.user_id_leave = user_id_leave;
        this.cat_id_leave = cat_id_leave;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.reason = reason;
    }

    //used in applyLeave servlet
    public LeaveApplication(int user_id_leave, int cat_id_leave, Date startDate, Date endDate, String reason, int applyForDays) {
        this.user_id_leave = user_id_leave;
        this.cat_id_leave = cat_id_leave;
        this.startDate = startDate;
        this.endDate = endDate;
        this.reason = reason;
        this.applyForDays = applyForDays;
    }
    
    //used in leaveApplicationdao for individual emp

    public LeaveApplication(int applicationID, int user_id_leave, int cat_id_leave, int applyForDays, Date startDate, Date endDate, String status, String reason, String catName, String rejectReason) {
        this.applicationID = applicationID;
        this.user_id_leave = user_id_leave;
        this.cat_id_leave = cat_id_leave;
        this.applyForDays = applyForDays;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.reason = reason;
        this.catName = catName;
        this.rejectReason = rejectReason;
    }
    
    //used in applicationDao for all emp
    public LeaveApplication(int applicationID, int user_id_leave, int cat_id_leave, int applyForDays, Date startDate, Date endDate, String status, String reason, String catName, String fname, String lname, int daysRemaining, String role, int daysUsed) {
        this.applicationID = applicationID;
        this.user_id_leave = user_id_leave;
        this.cat_id_leave = cat_id_leave;
        this.applyForDays = applyForDays;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.reason = reason;
        this.catName = catName;
        this.fname = fname;
        this.lname = lname;
        this.daysRemaining = daysRemaining;
        this.role = role;
        this.daysUsed = daysUsed;
    }
    
//    Used in UpdatedLeaveApply.java
    
    public LeaveApplication(Date startDate, Date endDate, String reason, int applyForDays, int applicationID, int cat_id_leave) {
        this.applicationID = applicationID;
        this.cat_id_leave = cat_id_leave;
        this.applyForDays = applyForDays;
        this.startDate = startDate;
        this.endDate = endDate;
        this.reason = reason;
    }


    public int getApplicationID() {
        return applicationID;
    }

    public void setApplicationID(int applicationID) {
        this.applicationID = applicationID;
    }

    public int getUser_id_leave() {
        return user_id_leave;
    }

    public void setUser_id_leave(int user_id_leave) {
        this.user_id_leave = user_id_leave;
    }

    public int getCat_id_leave() {
        return cat_id_leave;
    }

    public void setCat_id_leave(int cat_id_leave) {
        this.cat_id_leave = cat_id_leave;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public int getApplyForDays() {
        return applyForDays;
    }

    public void setApplyForDays(int applyForDays) {
        this.applyForDays = applyForDays;
    }

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public int getDaysRemaining() {
        return daysRemaining;
    }

    public void setDaysRemaining(int daysRemaining) {
        this.daysRemaining = daysRemaining;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getDaysUsed() {
        return daysUsed;
    }

    public void setDaysUsed(int daysUsed) {
        this.daysUsed = daysUsed;
    }

    public String getRejectReason() {
        return rejectReason;
    }

    public void setRejectReason(String rejectReason) {
        this.rejectReason = rejectReason;
    }
    
    
}
