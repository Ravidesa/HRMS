
package com.dao;

import com.entities.Employee;
import com.entities.User;

import com.query.InsertQuery;
import com.query.SelectQuery;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


public class EmployeeDao {

    private Connection con;

    public EmployeeDao(Connection con) {
        this.con = con;
    }

    public boolean insertEmployeeData(String tableName, List<String> attributeNames, List<Object> attributeValues) {
        boolean isSave = false;
        try {
            InsertQuery insertObj = new InsertQuery();
            insertObj = insertObj.setTableName(tableName)
                    .addColumns(attributeNames)
                    .addValue(attributeValues);

            String insertQuery = insertObj.buildWithPara();
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

    public boolean saveEmp(Employee emp) {
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

    public Employee getEmployee(int userId) {
        Employee emp = new Employee();
        try {

            String selectQuery = "SELECT employee.id,employee.user_id_emp,employee.deg_id_emp,employee.contact,employee.dob,employee.emp_image,employee.address,users.fname,users.lname,users.role,users.gender,users.createdAccount,users.email,designation.name as degName\n" +
                                 "FROM employee\n" +
                                 "JOIN users ON employee.user_id_emp = users.id\n" +
                                 "JOIN designation ON employee.deg_id_emp = designation.id\n" +
                                 "WHERE employee.status = 0 AND designation.status = 0 AND users.id = "+userId;

            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectQuery);
            if (rs.next()) {

                emp.setId(rs.getInt("id"));
                emp.setUser_id_emp(rs.getInt("user_id_emp"));
                emp.setDeg_id_emp(rs.getInt("deg_id_emp"));
                emp.setContact(rs.getString("contact"));
                emp.setDob(rs.getDate("dob"));
                emp.setEmp_image(rs.getBytes("emp_image"));
                emp.setAddress(rs.getString("address"));
                
                emp.setFname(rs.getString("fname"));
                emp.setLname(rs.getString("lname"));
                emp.setEmail(rs.getString("email"));
                emp.setGender(rs.getString("gender"));
                emp.setRole(rs.getString("role"));
                emp.setCreatedAccount(rs.getTimestamp("createdAccount"));
                
                emp.setDegName(rs.getString("degName"));
            }
            System.out.print(emp);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return emp;
    }
    
    public List<Employee> getAllEmployee() {
        List<Employee> emp = new ArrayList<>();
        try {

            String selectQuery = "SELECT employee.id,employee.user_id_emp,employee.deg_id_emp,employee.emp_image,designation.name,employee.address,employee.dob,employee.contact,employee.status,users.id,users.fname,users.lname,users.role,users.gender,users.createdAccount,users.email,users.status as userStatus FROM employee,users,designation\n"
                    + "WHERE users.role like \"EMPLOYEE\" AND users.id=employee.user_id_emp AND designation.id = employee.deg_id_emp AND users.isDeleted=0 AND employee.isDeleted=0 AND designation.status=0 order by employee.id desc";
//            System.out.println(selectQuery);
            Statement stmt = this.con.createStatement();
            ResultSet rs = stmt.executeQuery(selectQuery);
            while (rs.next()) {

                int id = rs.getInt("id");
                int user_id_emp = rs.getInt("user_id_emp");
                int deg_id_emp = rs.getInt("deg_id_emp");
                byte[] emp_image = rs.getBytes("emp_image");
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
                
                Employee e = new Employee(id, user_id_emp, deg_id_emp, emp_image, fname, lname, degName, role, dob, address, gender, email, createdAccount, contact, userStatus, status);
                emp.add(e);
            }
            System.out.print(emp);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return emp;
    }
    
    public boolean updateEmp(Employee emp){
        boolean isUpdate = false;
        try {
            String query = "update employee set deg_id_emp=?, contact=?, address=?, emp_image=? where id=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, emp.getDeg_id_emp());
            pstmt.setString(2, emp.getContact());
            pstmt.setString(3, emp.getAddress());
            pstmt.setBytes(4, emp.getEmp_image());
            pstmt.setInt(5, emp.getId());
            PreparedStatement str = pstmt;
            System.out.print(str);
            pstmt.executeUpdate();
            isUpdate = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isUpdate;
    }
    
    
    public boolean deactiveEmpUser(int empId, int userIdEmp){
        boolean isDeleted = false;
        try{
            String empSql = "update employee set status=1 WHERE id="+empId;
            String userSql = "update users set status=1 WHERE id="+userIdEmp;
            Statement stmt = this.con.createStatement();
            int row = stmt.executeUpdate(empSql);
            int row2 = stmt.executeUpdate(userSql);
            if(row > 0 && row2 > 0){
                isDeleted = true;
            }
            
        }catch (Exception e) {
            e.printStackTrace();
        }
        
        return isDeleted;
    }
    
    public boolean activeDeactiveEmpUser( int id,int userId, int status){
        boolean ischangeStatus = false;
        try{
            
            System.out.println(status);
            
            String empSql = "update employee set status=? WHERE id=?";
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
    
     public boolean deleteEmpUser(int empId, int userIdEmp){
        boolean isDeleted = false;
        try{
           String empSql = "update employee set isDeleted=1 WHERE id="+empId;
            String userSql = "update users set isDeleted=1 WHERE id="+userIdEmp;
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
