package com.entities;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Tapan
 */
public class PunchP {

    private int id;
    private int user_id;
    private String punch_in;
    private String punch_out;
    private String duration;
    private Date punch_date;
    private String week_day;
    private String fname;
    private String lname;
    private Long week_number;

    public Long getWeek_number() {
        return week_number;
    }

    public void setWeek_number(Long week_number) {
        this.week_number = week_number;
    }

    public String getWeek_day() {
        return week_day;
    }

    public void setWeek_day(String week_day) {
        this.week_day = week_day;
    }

    public PunchP() {
    }

    public PunchP(String fname, String lname, Date punch_date, String week_day, String duration) {
//        this.user_id = user_id;
        this.fname = fname;
        this.lname = lname;
        this.duration = duration;
        this.punch_date = punch_date;
        this.week_day = week_day;
    }
    public PunchP(int id,int user_id,String fname, String lname, Long week_number, String week_day, String duration) {
        this.id = id;
        this.user_id = user_id;
        this.fname = fname;
        this.lname = lname;
        this.duration = duration;
        this.week_number = week_number;
        this.week_day = week_day;
    }

    //used in dao of getEmpAttendanceTotalTime()

    public PunchP(int id, int user_id, String fname, String lname, String duration) {
        this.id = id;
        this.user_id = user_id;
        this.duration = duration;
        this.fname = fname;
        this.lname = lname;
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

    public PunchP(int user_id, String punch_in, String punch_out, String duration, Date punch_date, String week_day) {
//        this.id = id;
        this.user_id = user_id;
        this.punch_in = punch_in;
        this.punch_out = punch_out;
        this.duration = duration;
        this.punch_date = punch_date;
        this.week_day = week_day;
    }

    public PunchP(Date punch_date, String week_day, String duration) {

        this.punch_date = punch_date;
        this.week_day = week_day;
        this.duration = duration;
    }

    public PunchP(int user_id) {
        this.user_id = user_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getPunch_in() {
        return punch_in;
    }

    public void setPunch_in(String punch_in) {
        this.punch_in = punch_in;
    }

    public String getPunch_out() {
        return punch_out;
    }

    public void setPunch_out(String punch_out) {
        this.punch_out = punch_out;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public Date getPunch_date() {
        return punch_date;
    }

    public void setPunch_date(Date punch_date) {
        this.punch_date = punch_date;
    }

}
