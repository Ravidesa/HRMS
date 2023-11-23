/*
 * Click nbfs://nbhost/SystemFileSystem/Thrlates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Thrlates/Classes/Class.java to edit this thrlate
 */
package com.entities;

import java.sql.Date;
import java.sql.Timestamp;

public class Hr {
    private int id;
    private int user_id_hr ;
    private int deg_id_hr;
    private String contact;
    private Date dob;
    private byte[] hr_image;
    private String address;
    private String fname;
    private String lname;
    private String role;
    private String gender;
    private String email; 
    private Timestamp createdAccount;
    
    private String degName;
    
    private int status;
    private int userStatus;
    
    public Hr(){
        
    }
    
    public Hr(int user_id_hr, int deg_id_hr, String contact, Date dob, byte[] hr_image, String address) {
        this.user_id_hr = user_id_hr;
        this.deg_id_hr = deg_id_hr;
        this.contact = contact;
        this.dob = dob;
        this.hr_image = hr_image;
        this.address = address;
    }
    
    public Hr(int id, int user_id_hr, int deg_id_hr, String contact, Date dob, byte[] hr_image, String address, String fname, String lname, String role, String gender, String email, Timestamp createdAccount, String degName, int userStatus, int status) {
        this.id = id;
        this.user_id_hr = user_id_hr;
        this.deg_id_hr = deg_id_hr;
        this.contact = contact;
        this.dob = dob;
        this.hr_image = hr_image;
        this.address = address;
        this.fname = fname;
        this.lname = lname;
        this.role = role;
        this.gender = gender;
        this.email = email;
        this.createdAccount = createdAccount;
        this.degName = degName;
        this.status = status;
        this.userStatus = userStatus;
    }

    public Hr(int id,  int deg_id_hr,String contact, byte[] hr_image, String address) {
        this.id = id;
        this.deg_id_hr = deg_id_hr;
        this.contact = contact;
        this.hr_image = hr_image;
        this.address = address;
    }
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id_hr() {
        return user_id_hr;
    }

    public void setUser_id_hr(int user_id_hr) {
        this.user_id_hr = user_id_hr;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public byte[] getHr_image() {
        return hr_image;
    }

    public void setHr_image(byte[] hr_image) {
        this.hr_image = hr_image;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getCreatedAccount() {
        return createdAccount;
    }

    public void setCreatedAccount(Timestamp createdAccount) {
        this.createdAccount = createdAccount;
    }
    
    public int getDeg_id_hr() {
        return deg_id_hr;
    }

    public void setDeg_id_hr(int deg_id_hr) {
        this.deg_id_hr = deg_id_hr;
    }

    public String getDegName() {
        return degName;
    }

    public void setDegName(String degName) {
        this.degName = degName;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(int userStatus) {
        this.userStatus = userStatus;
    }
    
}
