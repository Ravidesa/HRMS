/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.entities;
import java.sql.Timestamp;


public class User {
    private int id;
   
    private String fname;
    private String lname;
    private String email;
    private String password;
    private String gender;
    private String role;
    private int status;
    
    private Timestamp createdAccount;

    public User(int id, String fname, String lname, String email, String password, String gender, Timestamp createdAccount, String role) {
        this.id = id;
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.createdAccount = createdAccount;
        this.role = role;
    }
    

  
    public User(){
        
    }

    public User(String fname, String lname, String email, String password, String gender, String role) {
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.role = role;
    }
    
    public User(int id, String fname, String lname, String email, String gender) {
        this.id = id;
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.gender = gender;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getId() {
        return id;
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
      
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getEmail() {
        return email;
    }

    public Timestamp getCreatedAccount() {
        return createdAccount;
    }

    public void setCreatedAccount(Timestamp createdAccount) {
        this.createdAccount = createdAccount;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getPassword() {
        return password;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getGender() {
        return gender;
    }
        
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }


    
}
