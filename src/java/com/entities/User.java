/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.entities;
import java.sql.Timestamp;


public class User {
    private int id;
    private String username;
    private String email;
    private String password;
    private String gender;
    private Timestamp createdAccount;
    private String role;

    public User(int id, String username, String email, String password, String gender, Timestamp createdAccount, String role) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.createdAccount = createdAccount;
        this.role = role;
    }
    
    public User(){
        
    }

    public User(String username, String email, String password,  String gender,String role) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.role = role;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getId() {
        return id;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getUsername() {
        return username;
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
}
