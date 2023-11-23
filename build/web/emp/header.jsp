
<%@page import="com.entities.User,com.entities.Message" %>
<%@page import="java.sql.*,java.util.*,com.helper.ConnectionProvider,java.sql.*,java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% 
    User user=(User)session.getAttribute("currentUser"); 
    if(user == null){
        response.sendRedirect("../login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Employee Leave Management System</title>
        <link rel="stylesheet" href="../assets/css/bootstrap.css">
        <script defer src="../assets/fontawesome/js/all.min.js"></script>
        <link rel="stylesheet" href="../assets/vendors/chartjs/Chart.min.css">
        <link rel="stylesheet" href="../assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
        <link rel="stylesheet" href="../assets/css/app.css">

        <!--for sweet alert-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.min.css">


        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <style type="text/css">
            .notif:hover {
                background-color: rgba(0, 0, 0, 0.1);
            }
            .dataTable-sorter{
                color: #827e8c;
            }
            .addButton{
                position: absolute;
                top:18px;
                /*padding-right: 10px;*/
                left:370px;
            }
        </style>

        <!--for activate current link-->
        <script>
            $(document).ready(function () {
                // Get the current page URL
                var url = window.location.href;

                // Remove trailing slash if present
                url = url.replace(/\/$/, "");

                // Get all the <a> tags within the navigation menu
                var menuLinks = $(".menu a.sidebar-link");

                // Get the "Settings" link element
                var settingsLink = $("#settings-link");

                // Iterate over each menu link
                menuLinks.each(function () {
                    var link = $(this);
                    var linkHref = link.attr("href");

                    if (url.indexOf(settingsLink.attr("href")) > -1) {
                        settingsLink.closest("li.sidebar-item").addClass("active");
                        return false;
                    }
                    // Check if the current page URL matches the link's href
                    if (url.indexOf(linkHref) > -1 || linkHref.indexOf("emp_manage_all_leave.jsp") > -1) {
                        // Add the active class to the parent <ul> tag
                        link.closest("li.sidebar-item").addClass("active");
                        return false; // Exit the loop
                    }
                });
            });
        </script>
    </head>

    <body>
        <div id="app">
            <div id="sidebar" class='active'>
                <div class="sidebar-wrapper active">
                    <div class="sidebar-header" style="height: 50px;margin-top: -30px">
                        <!--<i class="fa fa-users text-success me-4"></i>-->
                        <img src="../images/bsPng.png" style="width: 22%;"/>
                        <span>BS-HRM</span>
                    </div>
                    <div class="sidebar-menu">
                        <ul class="menu">
                            <li class="sidebar-item">
                                <a href="index.jsp" class='sidebar-link'>
                                    <i class="fa fa-home text-info"></i>
                                    <span>Dashboard</span>
                                </a>
                            </li>

                            <li class="sidebar-item">
                                <a href="manage_leave.jsp" class='sidebar-link'>
                                    <i class="fa fa-calendar text-info"></i>
                                    <span>Leave</span>
                                </a>
                            </li>

                            <li class="sidebar-item">
                                <a href="../checkPunchIn?userId=<%= user.getId()%>" method="post" class='sidebar-link'>
                                    <i class="fa fa-calendar text-info"></i>
                                    <span>Attendance</span>
                                </a>
                            </li>

                            <li class="sidebar-item  has-sub">
                                <a href="manage_profile.jsp" class='sidebar-link' id="settings-link">
                                    <i class="fa fa-cog text-info"></i>
                                    <span>Settings</span>
                                </a>
                                <ul class="submenu ">
                                    <li>
                                        <a href="manage_profile.jsp">Account</a>
                                    </li>
                                    <li>
                                        <a href="../LogoutServlet">Logout</a>
                                    </li>
                                </ul>
                            </li>


                            <!--                            <li class="sidebar-item  has-sub">
                                                            <a href="#" class='sidebar-link'>
                                                                <i class="fa fa-user text-success"></i>
                                                                <span>Payroll</span>
                                                            </a>
                                                            <ul class="submenu ">
                                                                <li>
                                                                    <a href="emp_salary.jsp">Employee salary</a>
                                                                </li>
                                                                <li>
                                                                    <a href="manage_user.html">Payslip</a>
                                                                </li>
                                                                <li>
                                                                    <a href="manage_user.html">Payroll items</a>
                                                                </li>
                                                            </ul>
                                                        </li>-->

                            <!--                            <li class="sidebar-item ">
                                                            <a href="reports.html" class='sidebar-link'>
                                                                <i class="fa fa-chart-bar text-success"></i>
                                                                <span>Reports</span>
                                                            </a>
                                                        </li>-->
                        </ul>
                    </div>
                    <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
                </div>
            </div>
            <div id="main">
                <nav class="navbar navbar-header navbar-expand navbar-light">
                    <a class="sidebar-toggler" href="#"><span class="navbar-toggler-icon"></span></a>
                    <button class="btn navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav d-flex align-items-center navbar-light ms-auto">
                            <li class="dropdown nav-icon">
                                <a href="#" data-bs-toggle="dropdown" class="nav-link  dropdown-toggle nav-link-lg nav-link-user">
                                    <div class="d-lg-inline-block">
                                        <i data-feather="bell"></i><span class="badge bg-info">2</span>
                                    </div>
                                </a>
                                <div class="dropdown-menu dropdown-menu-end dropdown-menu-large">
                                    <h6 class='py-2 px-4'>Reason</h6>
                                    <ul class="list-group rounded-none">
                                        <li class="list-group-item border-0 align-items-start">
                                            <div class="row mb-2">
                                                <div class="col-md-12 notif">
                                                    <a href="leave_details.html">
                                                        <h6 class='text-bold'>John Doe</h6>
                                                        <p class='text-xs'>
                                                            applied for leave at 05-21-2021
                                                        </p>
                                                    </a>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li class="dropdown">
                                <a href="#" data-bs-toggle="dropdown" class="nav-link dropdown-toggle nav-link-lg nav-link-user">
                                    <div class="avatar me-1">
                                        <img src="../assets/images/admin.png" alt="" srcset="">
                                    </div>
                                    <div class="d-none d-md-block d-lg-inline-block">Hi, <%= user.getFname() +" "+ user.getLname() %> </div>
                                </a>
                                <div class="dropdown-menu dropdown-menu-end">
                                    <a class="dropdown-item" href="manage_profile.jsp"><i data-feather="user"></i> Account</a>
                                    <a class="dropdown-item" href="#"><i data-feather="settings"></i> Settings</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="../LogoutServlet"><i data-feather="log-out"></i> Logout</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>