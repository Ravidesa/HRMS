/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import com.entities.Employee;
import com.entities.Hr;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


public class HrDao {
    
    private Connection con;

    public HrDao(Connection con) {
        this.con = con;
    }
    
    public boolean saveHr(Hr hr) {
        boolean f = false;

        try {
            //emp -> database	
            String query = "insert into hr(user_id_hr, deg_id_hr, contact, dob, hr_image, address) values (?,?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, hr.getUser_id_hr());
            pstmt.setInt(2, hr.getDeg_id_hr());
            pstmt.setString(3, hr.getContact());
            pstmt.setDate(4, hr.getDob());
            pstmt.setBytes(5, hr.getHr_image());
            pstmt.setString(6, hr.getAddress());

            pstmt.executeUpdate();
            PreparedStatement str = pstmt;
            System.out.print(str);
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return f;
    }
    
    
    public Hr getHr(int userId) {
        Hr hr = new Hr();
        try {

            String selectQuery = "SELECT hr.id,hr.user_id_hr,hr.deg_id_hr,hr.contact,hr.dob,hr.hr_image,hr.address,users.fname,users.lname,users.role,users.gender,users.createdAccount,users.email,designation.name as degName\n" +
                                 "FROM hr\n" +
                                 "JOIN users ON hr.user_id_hr = users.id\n" +
                                 "JOIN designation ON hr.deg_id_hr = designation.id\n" +
                                 "WHERE hr.status = 0 and designation.status = 1 and users.id = "+userId;

            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectQuery);
            if (rs.next()) {

                hr.setId(rs.getInt("id"));
                hr.setUser_id_hr(rs.getInt("user_id_hr"));
                hr.setDeg_id_hr(rs.getInt("deg_id_hr"));
                hr.setContact(rs.getString("contact"));
                hr.setDob(rs.getDate("dob"));
                hr.setHr_image(rs.getBytes("hr_image"));
                hr.setAddress(rs.getString("address"));
                
                hr.setFname(rs.getString("fname"));
                hr.setLname(rs.getString("lname"));
                hr.setEmail(rs.getString("email"));
                hr.setGender(rs.getString("gender"));
                hr.setRole(rs.getString("role"));
                hr.setCreatedAccount(rs.getTimestamp("createdAccount"));
                
                hr.setDegName(rs.getString("degName"));
            }
            System.out.print(hr);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return hr;
    }
    
     public List<Hr> getAllHr() {
        List<Hr> hr = new ArrayList<>();
        try {

            String selectQuery = "SELECT hr.id,hr.user_id_hr,hr.deg_id_hr,hr.hr_image,hr.address,hr.dob,hr.contact,hr.status,designation.name,users.fname,users.lname,users.role,users.gender,users.createdAccount,users.email,users.status as userStatus FROM hr,users,designation\n"
                    + "WHERE users.role like \"HR\" AND users.id=hr.user_id_hr AND designation.id = hr.deg_id_hr AND users.isDeleted=0 AND hr.isDeleted=0 AND designation.status=1 order by hr.id desc";
//            System.out.println(selectQuery);
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectQuery);
            while (rs.next()) {

                int id = rs.getInt("id");
                int user_id_hr = rs.getInt("user_id_hr");
                int deg_id_hr = rs.getInt("deg_id_hr");
                byte[] hr_image = rs.getBytes("hr_image");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
                String role = rs.getString("role");
                Date dob = rs.getDate("dob");
                String gender = rs.getString("gender");
                String email = rs.getString("email");
                Timestamp createdAccount = rs.getTimestamp("createdAccount");
                String contact = rs.getString("contact");
                String address = rs.getString("address");
                
                String degName = rs.getString("name");
                int userStatus = rs.getInt("userStatus");
                int status = rs.getInt("status");
                System.out.print(createdAccount);

                Hr h = new Hr(id, user_id_hr, deg_id_hr, contact, dob, hr_image, address, fname, lname, role, gender, email, createdAccount, degName, userStatus, status);
                hr.add(h);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return hr;
    }
     
    public boolean updateHr(Hr hr){
        boolean isUpdate = false;
        try {
            String query = "update hr set deg_id_hr=?, contact=?, address=?, hr_image=? where id=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, hr.getDeg_id_hr());
            pstmt.setString(2, hr.getContact());
            pstmt.setString(3, hr.getAddress());
            pstmt.setBytes(4, hr.getHr_image());
            pstmt.setInt(5, hr.getId());
            
            PreparedStatement str = pstmt;
            System.out.print(str);
            int row = pstmt.executeUpdate();
            if(row > 0){
                isUpdate = true;
            }
        
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isUpdate;
    }
    
    public boolean activeDeactiveHrUser( int id,int userId, int status){
        boolean ischangeStatus = false;
        try{
            
            System.out.println(status);
            
            String empSql = "update hr set status=? WHERE id=?";
            String userSql = "update users set status=? WHERE id=?";
            
            PreparedStatement pstmt1 = this.con.prepareStatement(empSql);
            
            pstmt1.setInt(1, status);
            pstmt1.setInt(2, id);
            
            PreparedStatement pstmt2 = this.con.prepareStatement(userSql);
            pstmt2.setInt(1, status);
            pstmt2.setInt(2, userId);
            int row1 = pstmt1.executeUpdate();
            int row2 = pstmt2.executeUpdate();
            
//            System.out.println(row1);
//            System.out.println(row2);
            if(row1 > 0 && row2 > 0){
                ischangeStatus = true;
            }
            
        }catch (Exception e) {
            e.printStackTrace();
        }
        
        return ischangeStatus;
    }
    
    
    public boolean deleteHrUser(int hrId, int userIdHr){
        boolean isDeleted = false;
        try{
           String empSql = "update hr set isDeleted=1 WHERE id="+hrId;
            String userSql = "update users set isDeleted=1 WHERE id="+userIdHr;
            Statement stmt = this.con.createStatement();
            int row1 = stmt.executeUpdate(empSql);
            int row2 = stmt.executeUpdate(userSql);
            if(row1 > 0 && row2 > 0){
                isDeleted = true;
            }
            
        }catch (Exception e) {
            e.printStackTrace();
        }
        
        return isDeleted;
    }    
}
