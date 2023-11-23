
package com.entities;

import java.sql.Date;
import java.sql.Timestamp;

public class SuperAdmin {
    private int id;
    private int user_id_sa;
    private String contact;
    private Date dob;
    private byte[] sa_image;
    private String address;
    private String fname;
    private String lname;
    private String role;
    private String gender;
    private String email; 
    private Timestamp createdAccount;
    
    private int status;
    private int userStatus;
    
    public SuperAdmin(){
        
    }
    
    public SuperAdmin(int user_id_sa, String contact, Date dob, byte[] sa_image, String address) {
        this.user_id_sa = user_id_sa;
        this.contact = contact;
        this.dob = dob;
        this.sa_image = sa_image;
        this.address = address;
    }
    
    public SuperAdmin(int id, int user_id_sa, String contact, Date dob, byte[] sa_image, String address, String fname, String lname, String role, String gender, String email, Timestamp createdAccount, int userStatus, int status) {
        this.id = id;
        this.user_id_sa = user_id_sa;
        this.contact = contact;
        this.dob = dob;
        this.sa_image = sa_image;
        this.address = address;
        this.fname = fname;
        this.lname = lname;
        this.role = role;
        this.gender = gender;
        this.email = email;
        this.createdAccount = createdAccount;
        this.status = status;
        this.userStatus = userStatus;
    }

    public SuperAdmin(int id, String contact, byte[] sa_image, String address) {
        this.id = id;
        
        this.contact = contact;
        this.sa_image = sa_image;
        this.address = address;
    }
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id_sa() {
        return user_id_sa;
    }

    public void setUser_id_sa(int user_id_sa) {
        this.user_id_sa = user_id_sa;
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

    public byte[] getSa_image() {
        return sa_image;
    }

    public void setSa_image(byte[] sa_image) {
        this.sa_image = sa_image;
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
