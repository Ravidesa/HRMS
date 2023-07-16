/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.entities;

import java.sql.Date;
import java.sql.Timestamp;


public class Employee {
    private int id;
    private int user_id_emp ;
    private int deg_id_emp;
    private String contact;
    private Date dob;
    private byte[] emp_image;
    private String address;
    private String fname;
    private String lname;
    private String role;
    private String gender;
    private String email; 
    private Timestamp createdAccount;
    
    private int status;
    private int userStatus;
    private String degName;

    
    public Employee(){
    
    }
        
    //from here 
    public Employee(int user_id_emp, int deg_id_emp, String contact, Date dob, byte[] emp_image, String address) {
        this.user_id_emp = user_id_emp;
        this.deg_id_emp = deg_id_emp;
        this.contact = contact;
        this.dob = dob;
        this.emp_image = emp_image;
        this.address = address;
    }
    
    public Employee(int id, int user_id_emp,int deg_id_emp,byte[] emp_image,String fname,String lname, String degName, String role, Date dob,String address, String gender, String email, Timestamp createdAccount, String contact,int userStatus, int status) {
        this.id = id;
        this.user_id_emp = user_id_emp;
        this.deg_id_emp = deg_id_emp;
        this.emp_image = emp_image;
        this.fname = fname;
        this.lname = lname;
        this.degName = degName;
        this.role = role;
        this.dob = dob;
        this.address = address;
        this.gender = gender;
        this.email = email;
        this.createdAccount = createdAccount;
        this.contact = contact;
        this.status = status;
        this.userStatus = userStatus;
    }
    
    public Employee(int id, int deg_id_emp, String contact, byte[] emp_image, String address) {
        this.id = id;
        this.deg_id_emp = deg_id_emp;
        this.contact = contact;
        this.emp_image = emp_image;
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

    public Timestamp getCreatedAccount() {
        return createdAccount;
    }

    public void setCreatedAccount(Timestamp createdAccount) {
        this.createdAccount = createdAccount;
    }
    
    public int getId() {
        return id;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id_emp() {
        return user_id_emp;
    }

    public void setUser_id_emp(int user_id_emp) {
        this.user_id_emp = user_id_emp;
    }

    public int getDeg_id_emp() {
        return deg_id_emp;
    }

    public void setDeg_id_emp(int deg_id_emp) {
        this.deg_id_emp = deg_id_emp;
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

    public byte[] getEmp_image() {
        return emp_image;
    }

    public void setEmp_image(byte[] emp_image) {
        this.emp_image = emp_image;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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
