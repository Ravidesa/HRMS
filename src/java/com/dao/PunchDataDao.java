package com.dao;

import com.entities.Employee;
import com.entities.PunchP;
import com.entities.GetAttendace;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class PunchDataDao {

    private Connection con;

    public PunchDataDao(Connection con) {
        this.con = con;
    }

    public boolean savePunch(PunchP punch) {

        boolean isSave = false;
        try {
            //user -> database

            String query = "insert into attendance_emp(user_id,punch_in,punch_out,work_duration,punch_date,week_day) values (?,?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, punch.getUser_id());
            pstmt.setString(2, punch.getPunch_in());
            pstmt.setString(3, punch.getPunch_out());
            pstmt.setString(4, punch.getDuration());
            pstmt.setDate(5, punch.getPunch_date());
            pstmt.setString(6, punch.getWeek_day());

            int rowsAffected = pstmt.executeUpdate();

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

    public List<PunchP> getAttendance(int uid) {
        List<PunchP> punch = new ArrayList<>();
        try {
           
//           System.out.println(userId.getClass().getSimpleName());
//"SELECT punch_date, week_day, work_duration FROM attendance_emp WHERE user_id = "+userId+" AND YEAR(punch_date) = "+year+" AND MONTH(punch_date) = "+month

            String selectQuery = "SELECT punch_date,week_day,work_duration FROM attendance_emp WHERE punch_date >= DATE_SUB(CURDATE(), INTERVAL DAYOFWEEK(CURDATE()) - 1 DAY)  AND punch_date <= DATE_ADD(CURDATE(), INTERVAL 7 - DAYOFWEEK(CURDATE()) DAY)  AND user_id = " + uid;

            Statement stmt = this.con.createStatement();

            ResultSet rs = stmt.executeQuery(selectQuery);
            while (rs.next()) {

                Date date = rs.getDate("punch_date");
                String week_day = rs.getString("week_day");
                String work_duration = rs.getString("work_duration");

                PunchP p = new PunchP(date, week_day, work_duration);
                punch.add(p);
            }
//            System.out.print(p);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return punch;
    }

    public List<PunchP> getEmpAttendance() {
        List<PunchP> punch = new ArrayList<>();
        try {
//"SELECT punch_date, week_day, work_duration FROM attendance_emp WHERE user_id = "+userId+" AND YEAR(punch_date) = "+year+" AND MONTH(punch_date) = "+month
    String PQuery="SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))";
            String selectQuery = "SELECT attendance_emp.id,attendance_emp.user_id, users.fname,users.lname,WEEK(punch_date) AS week_number,attendance_emp.week_day,SEC_TO_TIME(SUM(TIME_TO_SEC(STR_TO_DATE(attendance_emp.work_duration, '%H:%i:%s'))))  AS total_duration FROM attendance_emp,users WHERE attendance_emp.user_id = users.id AND users.role like \"EMPLOYEE\" GROUP BY user_id,WEEK(punch_date)";
            Statement stmt = this.con.createStatement();
            stmt.executeUpdate(PQuery);
            ResultSet rs = stmt.executeQuery(selectQuery);
            while (rs.next()) {
                int id = rs.getInt("id");
                int userId =rs.getInt("user_id");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
//                Date date = rs.getDate("week_number");
                Long week_number = rs.getLong("week_number");
                String week_day = rs.getString("week_day");
                String work_duration = rs.getString("total_duration");

                PunchP p = new PunchP(id,userId,fname, lname, week_number, week_day, work_duration);
                punch.add(p);
            }
//            System.out.print(p);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return punch;
    }

    
    public List<GetAttendace<Date, String, String>> getAttendanceIndi(int uid) {
        List<GetAttendace<Date, String, String>> attendanceData  = new ArrayList<>();
        try {
              
            Calendar calendar = Calendar.getInstance();
            int currentWeek = calendar.get(Calendar.WEEK_OF_YEAR);
//            String selectQuery = "SELECT punch_date,week_day,work_duration FROM attendance_emp WHERE punch_date >= DATE_SUB(CURDATE(), INTERVAL DAYOFWEEK(CURDATE()) - 1 DAY)  AND punch_date <= DATE_ADD(CURDATE(), INTERVAL 7 - DAYOFWEEK(CURDATE()) DAY)  AND user_id = " + uid;
            
//            String selectQuery = "SELECT punch_date,week_day,work_duration FROM attendance_emp WHERE user_id = "+uid;
            String selectQuery = "SELECT punch_date, week_day, work_duration " +
                                 "FROM attendance_emp " +
                                 "WHERE user_id = " + uid + " AND WEEK(punch_date) = " + currentWeek;
            Statement stmt = this.con.createStatement();

            ResultSet rs = stmt.executeQuery(selectQuery);
            while (rs.next()) {

                Date date = rs.getDate("punch_date");
                String week_day = rs.getString("week_day");
                String work_duration = rs.getString("work_duration");

                attendanceData.add(new GetAttendace<>(date, week_day, work_duration));
                
//                PunchP p = new PunchP(date, week_day, work_duration);
//                punch.add(p);
            }
//            System.out.print(p);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return attendanceData;
    }
    
   
    
   
   public List<PunchP> getEmpAttendanceTotalTime() {
        List<PunchP> punch = new ArrayList<>();
        try {

            String PQuery="SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))";
            String selectQuery = "SELECT attendance_emp.id,attendance_emp.user_id, users.fname, users.lname, SEC_TO_TIME(SUM(TIME_TO_SEC(STR_TO_DATE(attendance_emp.work_duration, '%H:%i:%s')))) AS total_duration\n" +
                                 " FROM attendance_emp\n" +
                                 " JOIN users ON attendance_emp.user_id = users.id\n" +
                                 " WHERE attendance_emp.user_id = users.id AND users.role = \"EMPLOYEE\"\n" +
                                 " GROUP BY attendance_emp.user_id";
            
            Statement stmt = this.con.createStatement();
            stmt.executeUpdate(PQuery);
            ResultSet rs = stmt.executeQuery(selectQuery);
            while (rs.next()) {
                int id = rs.getInt("id");
                int userId =rs.getInt("user_id");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
//                Date date = rs.getDate("week_number");
//                Long week_number = rs.getLong("week_number");
//                String week_day = rs.getString("week_day");
                String work_duration = rs.getString("total_duration");

                PunchP p = new PunchP(id,userId,fname, lname, work_duration);
                punch.add(p);
            }
//            System.out.print(p);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return punch;
    }
   
   
   public List<PunchP> getAllAttendance() {
        List<PunchP> punch = new ArrayList<>();
        try {
//"SELECT punch_date, week_day, work_duration FROM attendance_emp WHERE user_id = "+userId+" AND YEAR(punch_date) = "+year+" AND MONTH(punch_date) = "+month
    String PQuery="SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))";
            String selectQuery = "SELECT attendance_emp.id,attendance_emp.user_id, users.fname,users.lname,WEEK(punch_date) AS week_number,attendance_emp.week_day,SEC_TO_TIME(SUM(TIME_TO_SEC(STR_TO_DATE(attendance_emp.work_duration, '%H:%i:%s'))))  AS total_duration FROM attendance_emp,users WHERE attendance_emp.user_id = users.id GROUP BY user_id,WEEK(punch_date)";
            Statement stmt = this.con.createStatement();
            stmt.executeUpdate(PQuery);
            ResultSet rs = stmt.executeQuery(selectQuery);
            while (rs.next()) {
                int id = rs.getInt("id");
                int userId =rs.getInt("user_id");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
//                Date date = rs.getDate("week_number");
                Long week_number = rs.getLong("week_number");
                String week_day = rs.getString("week_day");
                String work_duration = rs.getString("total_duration");

                PunchP p = new PunchP(id,userId,fname, lname, week_number, week_day, work_duration);
                punch.add(p);
            }
//            System.out.print(p);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return punch;
    }

    public List<PunchP> getAllAttendanceTotalTime() {
        List<PunchP> punch = new ArrayList<>();
        try {

            String PQuery="SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))";
            String selectQuery = "SELECT attendance_emp.id,attendance_emp.user_id, users.fname, users.lname, SEC_TO_TIME(SUM(TIME_TO_SEC(STR_TO_DATE(attendance_emp.work_duration, '%H:%i:%s')))) AS total_duration\n" +
                                 " FROM attendance_emp\n" +
                                 " JOIN users ON attendance_emp.user_id = users.id\n" +
                                 " WHERE attendance_emp.user_id = users.id\n" +
                                 " GROUP BY attendance_emp.user_id";
            
            Statement stmt = this.con.createStatement();
            stmt.executeUpdate(PQuery);
            ResultSet rs = stmt.executeQuery(selectQuery);
            while (rs.next()) {
                int id = rs.getInt("id");
                int userId =rs.getInt("user_id");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
//                Date date = rs.getDate("week_number");
//                Long week_number = rs.getLong("week_number");
//                String week_day = rs.getString("week_day");
                String work_duration = rs.getString("total_duration");

                PunchP p = new PunchP(id,userId,fname, lname, work_duration);
                punch.add(p);
            }
//            System.out.print(p);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return punch;
    }
   
}
