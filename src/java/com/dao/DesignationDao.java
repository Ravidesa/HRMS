/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import com.entities.Designation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DesignationDao {
    
    private Connection con;
    
    public DesignationDao(Connection con){
        this.con = con;
    }
    
    public List<Designation> getEmpAllDesignation(){
        List<Designation> degList = new ArrayList<>();
        try{
            String sql = "select * from designation WHERE status=0";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            
            while(rs.next()){
                int id = rs.getInt("id");
                String name = rs.getString("name");
                
                Designation deg = new Designation(id, name);
                degList.add(deg);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return degList;
    }
    
    public List<Designation> getHrAllDesignation(){
        List<Designation> degList = new ArrayList<>();
        try{
            String sql = "select * from designation WHERE status=1";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            
            while(rs.next()){
                int id = rs.getInt("id");
                String name = rs.getString("name");
                
                Designation deg = new Designation(id, name);
                degList.add(deg);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return degList;
    }
}
