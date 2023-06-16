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

/**
 *
 * @author RAVI DESAI
 */
public class UserDAO {

    private Connection con;

    public UserDAO(Connection con) {
        this.con = con;
    }

    //method to insert user to data base:
    public boolean saveUser(User user) {
        boolean f = false;

        try {
            //user -> database	
            String query = "insert into users(username, email, password, gender, role, jwt_token) values (?,?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getRole());

            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
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
    public boolean insertUserData(String tableName, List<String> attributeNames, List<String> attributeValues) {
        boolean isSave = false;
        try {
            InsertQuery insertObj = new InsertQuery();
            String insertQuery = insertObj.buildInsertQuery(tableName, attributeNames, attributeValues);
            System.out.println("Query is --> " + insertQuery);
            Statement statement = this.con.createStatement();
            int rowsAffected = statement.executeUpdate(insertQuery);
            if (rowsAffected > 0) {
                isSave = true;
            } else {
                isSave = false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSave;
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
                user.setUsername(set.getString("username"));
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
            SelectQuery selectObj = new SelectQuery();
            selectObj.setTableName("users")
                    .addCondition("role", "EMPLOYEE");

            String selectQuery = selectObj.buildSelect();
//            System.out.println(selectQuery);
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectQuery);
            while (rs.next()) {
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String gender = rs.getString("gender");
                Timestamp createdAccount = rs.getTimestamp("createdAccount");
                String role = rs.getString("role");

                User u = new User(id, username, email, password, gender, createdAccount, role);
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
                name = rs.getString("username");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }
}
