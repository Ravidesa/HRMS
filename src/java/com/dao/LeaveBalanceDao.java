/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import com.entities.LeaveBalance;
import com.entities.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author RAVI DESAI
 */
public class LeaveBalanceDao {
    private Connection con;

    public LeaveBalanceDao(Connection con) {
        this.con = con;
    }
    
    public boolean saveLeaveBal(LeaveBalance leaveBal) {
        boolean isSaved = false;

        try {
            //emp -> database	
            String query = "insert into leavebalance(user_id_balance) values (?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, leaveBal.getUser_id_balance());

            int row = pstmt.executeUpdate();
            if(row > 0){
                isSaved = true;
                System.out.println("leave Balance inserted successfully");
            }else{
                System.out.println("Something wrong with leave Balance insertion");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSaved;
    }
    
    public LeaveBalance fetchRemainingAndUsedDays(int userId){
        LeaveBalance leaveBalObj = null;
        try{
            String selectdays = "SELECT daysRemaining,daysUsed FROM leavebalance WHERE user_id_balance="+userId;
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(selectdays);
            
            if(rs.next()){
                leaveBalObj = new LeaveBalance();
                leaveBalObj.setDaysRemaining(rs.getInt("daysRemaining"));
                leaveBalObj.setDaysUsed(rs.getInt("daysUsed"));
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return leaveBalObj;
    }
    
    public boolean updateRemainingAndUsedDays(int userId, int remainingDays, int usedDays){
        boolean isUpdated = false;

        try {
            //emp -> database	
            String query = "UPDATE leavebalance SET daysRemaining=?, daysUsed=? WHERE user_id_balance=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, remainingDays);
            pstmt.setInt(2, usedDays);
            pstmt.setInt(3, userId);
            

            int row = pstmt.executeUpdate();
            if(row > 0){
                isUpdated = true;
                System.out.println("leave Balance Updated successfully");
            }else{
                System.out.println("Something wrong with leave Balance updation");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isUpdated;
    }
    
    
}
