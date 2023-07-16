
<%@page import="com.entities.User,com.entities.Message" %>
<%@page import="java.sql.*,java.util.*,com.helper.ConnectionProvider,java.sql.*,java.util.*" %>

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
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>

        <!--for sweet alert-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.min.css">

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
        <style>
            .dropdownForStatus {
                position: relative;
                display: inline-block;
                width: 200px;
            }
            
            .dropdownForStatus2 {
                position: relative;
                display: inline-block;
                width: 200px;
            }
            /* Style for the dropdown button */
            .dropdownForStatus select {
                width: 55%;
                padding: 4px;
                font-size: 16px;
                border: none;
                border-radius: 4px;
                background-color: #f1f1f1;
                color: #333;
                cursor: pointer;
            }
            
            .dropdownForStatus2 select {
                width: 55%;
                padding: 8px;
                font-size: 16px;
                border: none;
                border-radius: 4px;
                background-color: #f1f1f1;
                color: #333;
                cursor: pointer;
            }

            /* Style for the dropdown options */
            .dropdownForStatus select option {
                padding: 8px;
            }


            /* Custom color styles for options */
            .dropdownForStatus select option.approved {
                background-color: #D4EDDA;
                color: #28A745;
            }

            .dropdownForStatus select option.rejected {
                background-color: #F8D7DA;
                color: #DC3545;
            }

            .dropdownForStatus select option.pending {
                background-color: #FFF3CD;
                color: #FFA500;
            }
            
            /* Style for the dropdown options */
            .dropdownForStatus select option {
                padding: 8px;
            }


            /* Custom color styles for options */
            .dropdownForStatus2 select option.approved {
                background-color: #D4EDDA;
                color: #28A745;
            }

            .dropdownForStatus2 select option.rejected {
                background-color: #F8D7DA;
                color: #DC3545;
            }

            .dropdownForStatus2 select option.pending {
                background-color: #FFF3CD;
                color: #FFA500;
            }
            
            .forTdPadding{
                padding-bottom: 0px;
                padding-top: 0px;
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
                var manageLeaveLink = $("#manage-leave");
                
                // Iterate over each menu link
                menuLinks.each(function () {
                    var link = $(this);
                    var linkHref = link.attr("href");

                    if(url.indexOf(settingsLink.attr("href")) > -1){
                         settingsLink.closest("li.sidebar-item").addClass("active");
                         return false;
                    }else if(url.indexOf(manageLeaveLink.attr("href")) > -1){
                        manageLeaveLink.closest("li.sidebar-item").addClass("active");
                         return false;
                    }
                    // Check if the current page URL matches the link's href
                    if (url.indexOf(linkHref) > -1 || linkHref.indexOf("emp_manage_all_leave.jsp") > -1 ) {
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
                                <a href="manage_hr.jsp" class='sidebar-link'>
                                    <i class="fa fa-users text-info"></i>
                                    <span>HR Administrator</span>
                                </a>
                            </li>
                            <li class="sidebar-item">
                                <a href="manage_employee.jsp" class='sidebar-link'>
                                    <i class="fa fa-users text-info"></i>
                                    <span>Employee Administrator</span>
                                </a>
                            </li>
                            <li class="sidebar-item">
                                <a href="attendance.jsp" class='sidebar-link'>
                                    <i class="fa fa-users text-info"></i>
                                    <span>Attendance</span>
                                </a>
                            </li>
                            <li class="sidebar-item  has-sub">
                                <a href="manage_all_leave.jsp" class='sidebar-link' id="manage-leave">
                                    <i class="fa fa-calendar text-info"></i>
                                    <span>Leave Management</span>
                                </a>
                                <ul class="submenu">
                                    <li>
                                        <a href="manage_all_leave.jsp"><i class="far fa-circle text-info"></i> All Leaves</a>
                                    </li>
                                    <li>
                                        <a href="manage_pending_leave.jsp"><i class="far fa-circle text-warning"></i> Pending Leaves</a>
                                    </li>
                                    <li>
                                        <a href="manage_approved_leave.jsp"><i class="far fa-circle text-success"></i> Approve Leaves</a>
                                    </li>
                                    <li>
                                        <a href="manage_rejected_leave.jsp"><i class="far fa-circle text-danger"></i> Rejected Leaves</a>
                                    </li>
                                </ul>
                            </li>
                            
                            <li class="sidebar-item has-sub">
                                <a href="manage_profile.jsp" class='sidebar-link' id="settings-link">
                                    <i class="fa fa-cog fa-spin text-info"></i>
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
                           
                            <li class="dropdown">
                                <a href="#" data-bs-toggle="dropdown" class="nav-link dropdown-toggle nav-link-lg nav-link-user">
                                    <div class="avatar me-1">

                                        <img src="../assets/images/admin.png" alt="" srcset="">
                                    </div>
                                    <div class="d-none d-md-block d-lg-inline-block">Hi, <%= user.getFname()+" "+user.getLname() %></div>
                                </a>
                                <div class="dropdown-menu dropdown-menu-end">
                                    <a class="dropdown-item" href="manage_profile.jsp"><i data-feather="user"></i> Account</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="../LogoutServlet"><i data-feather="log-out"></i> Logout</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>