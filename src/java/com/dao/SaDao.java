/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import com.entities.Hr;
import com.entities.SuperAdmin;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;


public class SaDao {
     private Connection con;

    public SaDao(Connection con) {
        this.con = con;
    }
    
    public SuperAdmin getSa(int userId) {
        SuperAdmin sa = new SuperAdmin();
        try {

            String selectQuery = "SELECT super_admin.id,super_admin.user_id_sa,super_admin.contact,super_admin.dob,super_admin.sa_image,super_admin.address,users.fname,users.lname,users.role,users.gender,users.createdAccount,users.email\n" +
                                 "FROM super_admin\n" +
                                 "JOIN users ON super_admin.user_id_sa = users.id\n" +
                                 "WHERE super_admin.status = 0 and users.id = "+userId;

            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectQuery);
            if (rs.next()) {

                sa.setId(rs.getInt("id"));
                sa.setUser_id_sa(rs.getInt("user_id_sa"));
                sa.setContact(rs.getString("contact"));
                sa.setDob(rs.getDate("dob"));
                sa.setSa_image(rs.getBytes("sa_image"));
                sa.setAddress(rs.getString("address"));
                
                sa.setFname(rs.getString("fname"));
                sa.setLname(rs.getString("lname"));
                sa.setEmail(rs.getString("email"));
                sa.setGender(rs.getString("gender"));
                sa.setRole(rs.getString("role"));
                sa.setCreatedAccount(rs.getTimestamp("createdAccount"));
                
            }
            System.out.print(sa);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sa;
    }
}
