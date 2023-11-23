/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.entities;

public class LeaveBalance {

    
    private int idLeaveBalance;
    private int user_id_balance;
    private int daysRemaining;
    private int daysUsed;
    
    private int daysRemainingSoft;
    private int daysUsedSoft;

    public LeaveBalance() {
    
    }

    
    
    public LeaveBalance(int idLeaveBalance, int user_id_balance, int daysRemaining, int daysUsed) {
        this.idLeaveBalance = idLeaveBalance;
        this.user_id_balance = user_id_balance;
        this.daysRemaining = daysRemaining;
        this.daysUsed = daysUsed;
    }
    
    //used in addSampleUser
    public LeaveBalance(int user_id_balance) {
        this.user_id_balance = user_id_balance;
    }

    public int getIdLeaveBalance() {
        return idLeaveBalance;
    }

    public void setIdLeaveBalance(int idLeaveBalance) {
        this.idLeaveBalance = idLeaveBalance;
    }

    public int getUser_id_balance() {
        return user_id_balance;
    }

    public void setUser_id_balance(int user_id_balance) {
        this.user_id_balance = user_id_balance;
    }

    public int getDaysRemaining() {
        return daysRemaining;
    }

    public void setDaysRemaining(int daysRemaining) {
        this.daysRemaining = daysRemaining;
    }

    public int getDaysUsed() {
        return daysUsed;
    }

    public void setDaysUsed(int daysUsed) {
        this.daysUsed = daysUsed;
    }

    public int getDaysRemainingSoft() {
        return daysRemainingSoft;
    }

    public void setDaysRemainingSoft(int daysRemainingSoft) {
        this.daysRemainingSoft = daysRemainingSoft;
    }

    public int getDaysUsedSoft() {
        return daysUsedSoft;
    }

    public void setDaysUsedSoft(int daysUsedSoft) {
        this.daysUsedSoft = daysUsedSoft;
    }
    
    
}
