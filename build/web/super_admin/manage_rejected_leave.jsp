<%@include file="header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dao.LeaveCatDao,com.dao.LeaveApplicationDao" %>
<%@ page import="com.entities.LeaveCat,com.entities.LeaveApplication,com.helper.GetDesignationOptions" %>
<%@ page import="java.text.SimpleDateFormat" %>

<div class="main-content container-fluid">
    <div class="page-title">
        <div class="row">
            <div class="col-12 col-md-12 order-md-1 order-last">
                <h3>Manage Leave</h3>
            </div>
            <div class="col-12 col-md-12 order-md-2 order-first" style="padding-left: 14px;padding-bottom: 8px;">
                <nav aria-label="breadcrumb" class='breadcrumb-header'>
                    <ol class="breadcrumb" style="justify-content: flex-start;padding-left: 0px;">
                        <li class="breadcrumb-item"><a href="index.jsp" class="text-info">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Rejected Leave</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
    <section class="section">
        <div class="card">
            <div class="card-body">


                <table class='table' id="table1" >

                    <%
                        Message m = (Message)session.getAttribute("msg");
                        if(m != null){
                    %>

                    <div id="magOfSuc" class="alert <%= m.getCssClass() %> alert-dismissible fade show" role="alert" style="width: 26%;position: absolute;top: -171px; right: -13px;">
                        <strong><%= m.getContent() %></strong>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>

                    <% 
                       session.removeAttribute("msg");
                        } 
                    %>
                    <thead>

                        <tr>
                            <th>Name</th>
                            <th>Leave Type</th>
                            <th>From</th>
                            <th>To</th>
                            <th>Duration(Days)</th>
                            <th>Remaining Days</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <!--<th>Action</th>-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            LeaveApplicationDao leaveAppDao = new LeaveApplicationDao(ConnectionProvider.getConnection());
                            List<LeaveApplication> leaveAppList = leaveAppDao.fetchAllRejectedApplication();
                            for (LeaveApplication leaveApp : leaveAppList) {
                           
                            java.sql.Date startDateTime = leaveApp.getStartDate();
                            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                            String  startDate= dateFormat.format(startDateTime);
                            
                            java.sql.Date endDateTime = leaveApp.getEndDate();
                            SimpleDateFormat dateFormat2 = new SimpleDateFormat("dd-MM-yyyy");
                            String  endDate= dateFormat2.format(endDateTime);
                            
                             
                            String status = leaveApp.getStatus(); // Retrieve the status value from the database

                            // Check the status value and set the appropriate default selected option
                            String pendingSelected = "";
                            String rejectedSelected = "";
                            String approvedSelected = "";
                            if (status.equalsIgnoreCase("pending")) {
                                pendingSelected = "selected";
                            } else if (status.equalsIgnoreCase("rejected")) {
                                rejectedSelected = "selected";
                            } else if (status.equalsIgnoreCase("approved")) {
                                approvedSelected = "selected";
                            }
                               
                        %>

                        <tr
                            data-leave-application-id="<%= leaveApp.getApplicationID()%>" data-daysused-for-leave="<%= leaveApp.getApplyForDays()%>"
                            data-leave-userid="<%= leaveApp.getUser_id_leave()%>"
                            data-currentrole="<%= user.getRole()%>" data-role="<%= leaveApp.getRole()%>"
                            >
                            <td style="padding: 0" style="text-align: center;">
                                <%= leaveApp.getFname() + " "+ leaveApp.getLname()%>
                            </td>
                            <th style="font-weight: normal; "><%= leaveApp.getCatName()%></th>
                            <td style="text-align: center;"><%= startDate%></td>
                            <td style="text-align: center;"><%= endDate%></td>
                            <td style="text-align: center;"><%= leaveApp.getApplyForDays()%></td>
                            <td style="text-align: center;"><%= leaveApp.getDaysRemaining()%></td>
                            <td>
                                <div class="dropdown nav-icon">                   
                                    <div class="overflow-elisp dropdown-toggle nav-link-user"  data-bs-toggle="dropdown" style="width:130px;"><%= leaveApp.getReason()%></div>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-large">
                                        <p class='text-xs text-muted px-3'>
                                            <%= leaveApp.getReason()%>
                                        </p>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <spna class="badge bg-danger">Rejected</spna>
                            </td>
                            <!--                            <td>
                                                            <a style="cursor: pointer;padding-right: 5px;" 
                                                               data-bs-toggle="modal"  data-bs-target="#editEmployeeModal"><i class="fa fa-pen text-info"></i>
                                                            </a>
                                                               
                                                            <a style="cursor: pointer;">
                                                                <i class="fa fa-trash text-danger"></i>
                                                            </a>
                                                        </td>-->
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

    </section>
</div>


<!--modal for reject reason-->
<div class="modal fade" id="reasonModal" tabindex="-1" aria-labelledby="reasonModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reasonModalLabel">Enter Reason</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <label for="reasonInput">Reason:</label>
                <input type="text" id="reasonInput" class="form-control">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="submitReason">Submit</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!--end rejected reason modal-->


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>-->



<script>
    $(document).ready(function () {
        $("#magOfSuc").delay(1000).fadeOut();
        
        $('.dropdownForStatus').on('change', 'select', function () {
            var leaveStatus = $(this).val();
//            var leaveStatus = $("#emp-status").val();
            var leaveApplicationId = $(this).closest('tr').data('leave-application-id');
            var userId = $(this).closest('tr').data('leave-userid');
            var daysUsedForLeave = $(this).closest('tr').data('daysused-for-leave');
            var currentRole = $(this).closest('tr').data('currentrole');
            var role = $(this).closest('tr').data('role');

            if (leaveStatus === "rejected" || leaveStatus === "approved") {
                $("#reasonModal").modal("show");
                $("#submitReason").click(function () {
                    var reason = $("#reasonInput").val();
                    $("#reasonModal").modal("hide");

                    $.ajax({
                        url: '../UpdateReasonLeave', // Replace with the actual servlet URL
                        method: 'POST',
                        data: {
                            leaveApplicationId: leaveApplicationId,
                            reason: reason
                        },
                        success: function (response) {
                            if (response === "success") {
                                console.log(response);
                            } else {
                                console.log(response);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.log(error);
                        }
                    });

                    updateLeaveStatus(leaveStatus, leaveApplicationId, userId, daysUsedForLeave, currentRole, role);
                });
            } else {
                updateLeaveStatus(leaveStatus, leaveApplicationId, userId, daysUsedForLeave, currentRole, role);
            }

        });

        function updateLeaveStatus(leaveStatus, leaveApplicationId, userId, daysUsedForLeave, currentRole, role) {
            var leaveStatus = leaveStatus;
            var leaveApplicationId = leaveApplicationId;
            var userId = userId;
            var daysUsedForLeave = daysUsedForLeave;
            var currentRole = currentRole;
            var role = role;

            $.ajax({
                url: '../UpdateStatus', // Replace with the actual servlet URL
                method: 'POST',
                data: {
                    leaveApplicationId: leaveApplicationId,
                    userId: userId,
                    daysUsedForLeave: daysUsedForLeave,
                    leaveStatus: leaveStatus,
                    currentRole: currentRole,
                    role: role
                },
                success: function (response) {
                    if (response === "success") {
                        location.reload();
                        console.log(response);
                    } else {
                        location.reload();
                        console.log(response);
                    }
                },
                error: function (xhr, status, error) {
                    console.log(error);
                }
            });
        }
        
        $("#magOfSuc").delay(1000).fadeOut();
    });
</script>

<script>
    $(document).ready(function () {

        $("#leaveCatId").change(function () {
            var leaveCatId = $(this).val();
//           alert(leaveCatId);
            $('#result').val(leaveCatId);
        });
        $('#leaveCatId').trigger('change');
    });
</script>
<%@include file="footer.jsp" %>