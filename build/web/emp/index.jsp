
<%@include file="header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.helper.Dashboard,com.helper.GetDesignationOptions" %>
<%@ page import="com.dao.LeaveBalanceDao,com.entities.LeaveBalance" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    Dashboard dashObj = new Dashboard(ConnectionProvider.getConnection());
    LeaveBalanceDao leaveBalDao = new LeaveBalanceDao(ConnectionProvider.getConnection());
    LeaveBalance leaveBalObj = leaveBalDao.fetchRemainingAndUsedDays(user.getId());
%>
<div class="main-content container-fluid">
                <div class="page-title">
                    <h3>Dashboard</h3>
                </div>
                <section class="section">
                    <div class="row mb-2">
                        <div class="col-xl-4 col-md-12 mb-4">
                            
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between p-md-1">
                                        <div class="d-flex flex-row">
                                            <div class="align-self-center">
                                                <i class="fa fa-users text-warning fa-3x me-4"></i>
                                            </div>
                                            <div>
                                                <h4>Employees</h4>
                                                <h2 class="h1 mb-0"><%= dashObj.countAllEmp()%></h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                           
                        </div>
                        <div class="col-xl-4 col-md-12 mb-4">
                            <a href="manage_leave.jsp">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between p-md-1">
                                        <div class="d-flex flex-row">
                                            <div class="align-self-center">
                                                <i class="fa fa-clock text-info fa-3x me-4"></i>
                                            </div>
                                            <div>
                                                <h4>Remaining Leave</h4>
                                                <h2 class="h1 mb-0"><%= leaveBalObj.getDaysRemaining()%>/25</h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </a>
                        </div>
                        <div class="col-xl-4 col-md-12 mb-4">
                            <a href="manage_leave.jsp">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between p-md-1">
                                        <div class="d-flex flex-row">
                                            <div class="align-self-center">
                                                <i class="fa fa-share text-success fa-3x me-4"></i>
                                            </div>
                                            <div>
                                                <h4>Taken Leaves</h4>
                                                <h2 class="h1 mb-0"><%= leaveBalObj.getDaysUsed()%>/25</h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </a>
                        </div>
                        <div class="col-xl-4 col-md-12 mb-4">
                            <a href="manage_leave.jsp">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between p-md-1">
                                        <div class="d-flex flex-row">
                                            <div class="align-self-center">
                                                <i class="fa fa-check text-info fa-3x me-4"></i>
                                            </div>
                                            <div>
                                                <h4>Approved</h4>
                                                <h2 class="h1 mb-0"><%= dashObj.countAllApproveLeave(user.getId())%></h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </a>
                        </div>
                        <div class="col-xl-4 col-md-12 mb-4">
                            <a href="manage_leave.jsp">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between p-md-1">
                                        <div class="d-flex flex-row">
                                            <div class="align-self-center">
                                                <i class="fa fa-info text-warning fa-3x me-4"></i>
                                            </div>
                                            <div>
                                                <h4>Pending</h4>
                                                <h2 class="h1 mb-0"><%= dashObj.countAllPendingLeave(user.getId())%></h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </a>
                        </div>
                        <div class="col-xl-4 col-md-12 mb-4">
                            <a href="manage_leave.jsp">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between p-md-1">
                                        <div class="d-flex flex-row">
                                            <div class="align-self-center">
                                                <i class="fa fa-trash text-danger fa-3x me-4"></i>
                                            </div>
                                            <div>
                                                <h4>Canceled</h4>
                                                <h2 class="h1 mb-0"><%= dashObj.countAllRejectedLeave(user.getId())%></h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </a>
                        </div>
                    </div>
                </section>
            </div>

    <%@include file="footer.jsp" %>