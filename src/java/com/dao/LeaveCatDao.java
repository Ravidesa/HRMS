/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import com.entities.Employee;
import com.entities.LeaveCat;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author RAVI DESAI
 */
public class LeaveCatDao {
    private Connection con;

    public LeaveCatDao(Connection con) {
        this.con = con;
    }
    
    public List<LeaveCat> getAllLeaveCat(){
        List<LeaveCat> degList = new ArrayList<>();
        try{
            String sql = "select * from leavecategory";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            
            while(rs.next()){
                int id = rs.getInt("idLeaveCategory");
                String catName = rs.getString("catName");
                int allocatedDays = rs.getInt("allocatedDays");
                
                LeaveCat leaveCat = new LeaveCat(id, catName, allocatedDays);
                degList.add(leaveCat);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return degList;
    }
    
    public boolean saveLeave(Employee emp) {
        boolean f = false;

        try {
            //emp -> database	
            String query = "insert into employee(user_id_emp, deg_id_emp, contact, dob, emp_image, address) values (?,?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, emp.getUser_id_emp());
            pstmt.setInt(2, emp.getDeg_id_emp());
            pstmt.setString(3, emp.getContact());
            pstmt.setDate(4, emp.getDob());
            pstmt.setBytes(5, emp.getEmp_image());
            pstmt.setString(6, emp.getAddress());

            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.print(f);
        return f;
    }
    
}
