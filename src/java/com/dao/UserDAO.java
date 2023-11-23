/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import com.query.QueryBuilder;
import com.entities.User;
import com.query.InsertQuery;
import com.query.SelectQuery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;


public class UserDAO {

    private Connection con;

    public UserDAO(Connection con) {
        this.con = con;
    }

    //method to insert user to data base:
    public int saveUser(User user) {
        int recentId = -1;

        try {
            //user -> database	
            String query = "insert into users(fname, lname, email, password, gender, role) values (?,?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getFname());
            pstmt.setString(2, user.getLname());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPassword());
            pstmt.setString(5, user.getGender());
            pstmt.setString(6, user.getRole());

            pstmt.executeUpdate();

            String selectRecentId = "SELECT id FROM users ORDER BY id DESC LIMIT 1";
            Statement st = this.con.createStatement();
            ResultSet set = st.executeQuery(selectRecentId);
            
            if(set.next()){
                int id = set.getInt("id");
                recentId = id;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return recentId;
    }

   
    public User getUserEmailAndPassword(String email, String password) {
        User user = null;
        try {
            SelectQuery selectObj = new SelectQuery();
            List<String> col = new ArrayList<String>();
            col.add("email");
            col.add("password");
            selectObj = selectObj.setTableName("users")
                    .setColumns(col)
                    .addCondition("email", email)
                    .addCondition("password", password);

            Statement stmt = this.con.createStatement();
            String selectQuery = selectObj.buildSelect();
            System.out.println(selectQuery);
            ResultSet rs = stmt.executeQuery(selectQuery);

            if (rs.next()) {
                user = new User();
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public User getUserPass(String email) {
        User user = null;
        try {
            SelectQuery selectObj = new SelectQuery();
            List<String> col = new ArrayList<>();
            col.add("email");
            col.add("password");
            selectObj = selectObj.setTableName("users")
                    .setColumns(col)
                    .addCondition("email", email);

            Statement stmt = this.con.createStatement();
            String selectQuery = selectObj.buildSelect();
            System.out.println(selectQuery);
            ResultSet rs = stmt.executeQuery(selectQuery);

            if (rs.next()) {
                user = new User();
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
//        System.out.println("password is --> "+pass);
        return user;
    }
    
    public User getUserRole(String userEmail) {
        User user = null;

        try {
            SelectQuery selectObj = new SelectQuery();
            selectObj = selectObj.setTableName("users")
                    .addCondition("email", userEmail);

            String selectQuery = selectObj.buildSelect();
            Statement stmt = this.con.createStatement();
            ResultSet set = stmt.executeQuery(selectQuery);
            if (set.next()) {
                user = new User();
                user.setId(set.getInt("id"));
                user.setFname(set.getString("fname"));
                user.setLname(set.getString("lname"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setRole(set.getString("role"));
                user.setCreatedAccount(set.getTimestamp("createdAccount"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public List<User> getAllUserEMP() {
        List<User> users = new ArrayList<>();
        try {
//            SelectQuery selectObj = new SelectQuery();
//            selectObj.setTableName("users")
//                    .addCondition("role", "EMPLOYEE");
//
//            String selectQuery = selectObj.buildSelect();
            String selectQuery = "SELECT *\n"
                    + "FROM users WHERE role like \"EMPLOYEE\"\n"
                    + "AND NOT EXISTS (\n"
                    + "  SELECT 1\n"
                    + "  FROM employee\n"
                    + "  WHERE employee.user_id_emp = users.id\n"
                    + ")";
//            System.out.println(selectQuery);
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectQuery);
            while (rs.next()) {
                int id = rs.getInt("id");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String gender = rs.getString("gender");
                Timestamp createdAccount = rs.getTimestamp("createdAccount");
                String role = rs.getString("role");

                User u = new User(id, fname, lname, email, password, gender, createdAccount, role);
                users.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public String userName(int id) {
        String name = "";
        try {
            SelectQuery selectObj = new SelectQuery();
            selectObj.setTableName("users")
                    .addCondition("id", id);

            String selectQuery = selectObj.buildSelect();
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectQuery);

            if (rs.next()) {
                name = rs.getString("fname");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }

    public boolean updateUser(User user){
        boolean isUpdate = false;
        try {
            String query = "update  users set fname=?, lname=?, email=?, gender=? where id=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getFname());
            pstmt.setString(2, user.getLname());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getGender());
            pstmt.setInt(5, user.getId());
            PreparedStatement str = pstmt;
            System.out.print(str);
            pstmt.executeUpdate();
            isUpdate = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isUpdate;
    }
    
    
    //    public User getUserEmailAndPassword(String email, String password) {
//        User user = null;
//
//        try {
//            String query = "SELECT * FROM users WHERE email=? AND password=?";
//            PreparedStatement pstmt = con.prepareStatement(query);
//
//            pstmt.setString(1, email);
//            pstmt.setString(2, password);
//
//            ResultSet set = pstmt.executeQuery();
//            if (set.next()) {
//                user = new User();
//
//                user.setId(set.getInt("id"));
//                user.setEmail(set.getString("email"));
//                user.setPassword(set.getString("password"));
//                user.setGender(set.getString("gender"));
//                user.setRole(set.getString("role"));
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return user;
//    }
//    public User getUserRole(String userEmail){
//        User user = null;
//
//        try {
//            String query = "SELECT role FROM users WHERE email=?";
//            PreparedStatement pstmt = con.prepareStatement(query);
//
//            pstmt.setString(1, userEmail);
//
//            ResultSet set = pstmt.executeQuery();
//            if (set.next()) {
//                user = new User();
//                
//                user.setRole(set.getString("role"));
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return user;
//    }
}
