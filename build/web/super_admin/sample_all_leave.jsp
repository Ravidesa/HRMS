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
                        <li class="breadcrumb-item active" aria-current="page">Manage Leave</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>

    <div class="dropdownForStatus" style="position: absolute;right: -32px;z-index: 200;top: 201px;width: 17%;">

        <select name="filter-status" id="filter-status">
            <option  value="all">All</option>
            <option  value="pending">Pending</option>
            <option  value="rejected">Rejected</option>
            <option  value="approved" >Approved</option>
        </select>
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
                            <th>
                                <div class="dropdown nav-icon">                   
                                    <div class="overflow-elisp dropdown-toggle nav-link-user"  data-bs-toggle="dropdown" style="width:92px;">Leave Type</div>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-large">
                                        <p class='text-xs text-muted px-3'>
                                            Leave Type
                                        </p>
                                    </div>
                                </div>
                            </th>
                            <th>From</th>
                            <th>To</th>
                            <th>
                                <div class="dropdown nav-icon">                   
                                    <div class="overflow-elisp dropdown-toggle nav-link-user"  data-bs-toggle="dropdown" style="width:94px;">Duration (Days)</div>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-large">
                                        <p class='text-xs text-muted px-3'>
                                            Duration (Days)
                                        </p>
                                    </div>
                                </div>
                            </th>
                            <th>
                                <div class="dropdown nav-icon">                   
                                    <div class="overflow-elisp dropdown-toggle nav-link-user"  data-bs-toggle="dropdown" style="width:94px;">Remaining Days</div>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-large">
                                        <p class='text-xs text-muted px-3'>
                                            Remaining Days
                                        </p>
                                    </div>
                                </div>
                            </th>
                            <th>Reason</th>
                            <th>Status</th>
                            <!--<th>Action</th>-->
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            LeaveApplicationDao leaveAppDao = new LeaveApplicationDao(ConnectionProvider.getConnection());
                            List<LeaveApplication> leaveAppList = leaveAppDao.fetchAllLeaveApplication();
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
                    
                        <tr class="filter-rows"
                            data-status="<%= status.toLowerCase()%>"
                            data-leave-application-id="<%= leaveApp.getApplicationID()%>" data-daysused-for-leave="<%= leaveApp.getApplyForDays()%>"
                            data-leave-userid="<%= leaveApp.getUser_id_leave()%>"
                            data-currentrole="<%= user.getRole()%>" data-role="<%= leaveApp.getRole()%>"
                            >
                            <td style="padding: 0" style="text-align: center;">

                                <div class="dropdown nav-icon">                   
                                    <div class="overflow-elisp dropdown-toggle nav-link-user"  data-bs-toggle="dropdown" style="width:120px;"><%= leaveApp.getFname() + " "+ leaveApp.getLname()%></div>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-large">
                                        <p class='text-xs text-muted px-3'>
                                            <%= leaveApp.getFname() + " "+ leaveApp.getLname()%>
                                        </p>
                                    </div>
                                </div>

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

                                <!--equalsIgnoreCase-->
                                <%
                                    if(status.equalsIgnoreCase("pending")){
                                %>
                                <div class="dropdownForStatus2">
                                    <select name="emp-status" id="emp-status" class="status-dropdown" style="color:#FFA500; background-color: #FFF3CD;">
                                        <option class="pending" value="pending" <%= pendingSelected %> >Pending</option>
                                        <option class="rejected" value="rejected" <%= rejectedSelected %> >Rejected</option>
                                        <option class="approved" value="approved" <%= approvedSelected %> >Approved</option>
                                    </select>
                                </div>
                                <%
                                    } else if(status.equalsIgnoreCase("rejected")){
                                %>
                                <div class="dropdownForStatus2">
                                    <select name="emp-status" id="emp-status" class="status-dropdown" style="color:#DC3545; background-color: #F8D7DA;">
                                        <option class="pending" value="pending" <%= pendingSelected %> >Pending</option>
                                        <option class="rejected" value="rejected" <%= rejectedSelected %> >Rejected</option>
                                        <option class="approved" value="approved" <%= approvedSelected %> >Approved</option>
                                    </select>
                                </div>
                                <%
                                    } else if(status.equalsIgnoreCase("approved")){
                                %>
                                <div class="dropdownForStatus2">
                                    <select name="emp-status" id="emp-status" class="status-dropdown" style="color:#28A745; background-color: #D4EDDA;">
                                        <option class="pending" value="pending" <%= pendingSelected %> >Pending</option>
                                        <option class="rejected" value="rejected" <%= rejectedSelected %> >Rejected</option>
                                        <option class="approved" value="approved" <%= approvedSelected %> >Approved</option>
                                    </select>
                                </div>
                                <% } %>

                            </td>

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
        // Get the initial selected value
        var selectedStatus = $("#filter-status").val();
//        alert(selectedStatus);
        // Show/hide rows based on the selected filter
        filterRows(selectedStatus);

        // Handle the change event of the dropdown
        $("#filter-status").change(function () {
            selectedStatus = $(this).val();
            filterRows(selectedStatus);
        });

        function filterRows(status) {
            // Show all rows by default
            $("tr.filter-rows").show();

            if (status !== "all") {
                $("tr.filter-rows").not("[data-status='" + status + "']").hide();
            }
        }
    });
</script>


<script>
    $(document).ready(function () {
        $("#magOfSuc").delay(1000).fadeOut();
        $('.dropdownForStatus2').on('change', 'select', function () {
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