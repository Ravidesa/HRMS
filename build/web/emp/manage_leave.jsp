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
    <section class="section">
        <div class="card">
            <div class="card-body">

                <div data-bs-toggle="modal" data-bs-target="#exampleModal" style="display:flex; justify-content: end;">
                    <a data-bs-toggle="modal" data-bs-target="#addApply" style="position: absolute">
                        <button class="btn btn-primary">Add Leave</button>
                    </a>
                </div>
                

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
                            <th style="width: 9.394%;">Leave Type</th>
                            <th>Reason</th>
                            <th>From</th>
                            <th>To</th>
                            <th>Duration(Days)</th>
                            <th>Status</th>
                            <th>Action/reason</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            LeaveApplicationDao leaveAppDao = new LeaveApplicationDao(ConnectionProvider.getConnection());
                            List<LeaveApplication> leaveAppList = leaveAppDao.fetchLeaveApplicationOfIndividual(user.getId());
                            for (LeaveApplication leaveApp : leaveAppList) {
                           
                            java.sql.Date startDateTime = leaveApp.getStartDate();
                            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                            String  startDate= dateFormat.format(startDateTime);
                            
                            java.sql.Date endDateTime = leaveApp.getEndDate();
                            SimpleDateFormat dateFormat2 = new SimpleDateFormat("dd-MM-yyyy");
                            String  endDate= dateFormat2.format(endDateTime);
                            
                            String leaveCatOptions = GetDesignationOptions.getLeaveTypeOptions(leaveApp.getCat_id_leave());
                        %>
                        <tr>
                            <td style="padding: 0">
                                <%= leaveApp.getCatName()%>
                            </td>
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
                            <td><%= startDate%></td>
                            <td><%= endDate%></td>
                            <td><%= leaveApp.getApplyForDays()%></td>
                            <td>
                                <%
                                    if(leaveApp.getStatus().equalsIgnoreCase("pending")){
                                %>
                                    <spna class="badge bg-info"> <%= leaveApp.getStatus()%> </spna>

                                <% }else if(leaveApp.getStatus().equalsIgnoreCase("Approved")){ %>

                                    <spna class="badge bg-success"> <%= leaveApp.getStatus()%> </spna>

                                <% } else if(leaveApp.getStatus().equalsIgnoreCase("rejected")){ %>

                                    <spna class="badge bg-danger"> <%= leaveApp.getStatus()%> </spna>

                                <% } %>
                            </td>
                            <td style="text-align: center;">
                            <% if(leaveApp.getStatus().equalsIgnoreCase("Pending")) { %>
                                <a style="cursor: pointer;padding-right: 5px;" class="editLeave"
                                   name ="<%= leaveApp.getApplicationID()%>" 
                                   data-startdate="<%= startDate%>" data-enddate="<%= endDate%>" data-reason="<%= leaveApp.getReason()%>"
                                   data-daysused-for-leave="<%= leaveApp.getApplyForDays()%>"
                                   data-leave-userid="<%= leaveApp.getUser_id_leave()%>"
                                   data-leavetypeid="<%= leaveApp.getCat_id_leave()%>"
                                   data-leavecatoption="<%= leaveCatOptions%>" data-status="<%= leaveApp.getStatus()%>"
                                   data-currentrole="<%= user.getRole()%>"
                                   data-bs-toggle="modal"  data-bs-target="#editEmpLeaveModal"><i class="fa fa-pen text-info"></i>
                                </a>
                                <a style="cursor: pointer;" id="leaveDelete" class="leave-delete"
                                   name="<%= leaveApp.getApplicationID()%>" data-userid="<%= leaveApp.getUser_id_leave()%>">
                                    <i class="fa fa-trash text-danger"></i>
                                </a>
                                    <!--if(leaveApp.getStatus().equalsIgnoreCase("Rejected"))-->
                            <% } else if(leaveApp.getRejectReason()!=null) {
                                    
                            %>
                                    
                            <ul class="navbar-nav d-flex align-items-center navbar-light ms-auto">
                                 <li class="dropdown nav-icon">
                                    <a href="#" data-bs-toggle="dropdown" style="padding-top: 0px;padding-bottom: 0px;" class="dropdown-toggle nav-link-user">
                                        <i class="fa fa-eye text-info"></i>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-large">
                                        <h6 class='py-2 px-2' style="margin-bottom: 0px;">Reason</h6>
                                        <ul class="list-group rounded-none">
                                            <li class="list-group-item border-0 align-items-start"style="padding-top: 0; padding-bottom: 0;">
                                                <div class="row mb-2 px-0">
                                                    <div class="col-md-12 notif px-1">
                                                        <p class='text-xs text-muted px-0'>
                                                            <%= leaveApp.getRejectReason()%>
                                                        </p>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                            </ul>

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

<!--Modal for leave apply-->

<div class="modal fade" id="addApply" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">ADD Leave</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form class="form" action="../ApplyLeave" method="post">
                    <div class="row">

                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">Start Date</label>
                                <div class="position-relative">
                                    <input type="text" class="form-control" id="datepicker" name="startDate">
                                    <div class="form-control-icon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                </div>
                                <spam id="lnameError" class="errors text-danger"></spam>
                            </div>
                        </div>

                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">End Date</label>
                                <div class="position-relative">
                                    <input type="text" class="form-control" id="datepicker2" name="endDate">
                                    <div class="form-control-icon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                </div>
                                <spam id="lnameError" class="errors text-danger"></spam>
                            </div>
                        </div>

                        <div class="col-md-12 col-12">
                            <div class="form-group has-icon-left">
                                <label for="first-name-icon">Leave Type</label>
                                <div class="position-relative">
                                    <fieldset class="form-group">
                                        <select class="form-select" name="leaveCatId" id="leaveCatId" aria-label="Default select example" style="width: 100%;right: 0px;bottom: -39px;">

                                            <%
                                                LeaveCatDao leaveCatDao = new LeaveCatDao(ConnectionProvider.getConnection());
                                                List<LeaveCat> leaveCatList = leaveCatDao.getAllLeaveCat();
                                 
                                                for(LeaveCat leaveCat : leaveCatList){
                                            %>
                                            <option value="<%= leaveCat.getCatId()%>"><%= leaveCat.getCatName()%></option>
                                            <!--<input type="hidden" value="<%= leaveCat.getAllocatedDays()%>" />-->
                                            <% } %>
                                        </select>
                                    </fieldset>
                                </div>
                            </div>
                        </div>


                        <!--<input type="hidden" class="form-control" placeholder="employee id" id="empId" name="user_id_emp" readonly>-->


                        <div class="col-md-12 col-12 mb-5"style="position: relative;top: 39px;">
                            <label for="first-name-icon">Reason</label>
                            <div class="form-group has-icon-left">
                                <!--                                <label for="first-name-icon">Reason</label>-->
                                <textarea class="form-control" id="reason" rows="4" name="reason" style="padding-left: 6px;padding-right: 6px;"></textarea>
                            </div>
                            <spam id="reasonError" class="errors text-danger"></spam>
                        </div>

                        <input type="hidden" name="userIdLeave" value="<%= user.getId()%>" readonly>

                        <div class="col-md-6 col-12">
                            <div class="form-group has-icon-left">

                                <div class="position-relative">
                                    <input type="hidden" id="result" name="leaveCatId">

                                    <input type="hidden" name="role" value="<%= user.getRole()%>" readonly>
                                    <input type="hidden" id="total-days" name="daysForLeave" readonly>
                                </div>
                                <spam id="lnameError" class="errors text-danger"></spam>
                            </div>
                        </div>


                        <div class="col-12 d-flex justify-content-end">
                            <button id="submitAddButton" type="submit" class="btn btn-primary me-1 mb-1">Submit</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- End leave apply modal -->

<!-- Modal of Edit Employee -->
<div class="modal fade" id="editEmpLeaveModal" style="display:none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header primary-background text-white">
                <h5 class="modal-title" id="exampleModalLabel"> Edit Leave </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                    <!--                    <span aria-hidden="true">&times;</span>-->
                </button>
            </div>
            <div class="modal-body" id="editLeaveBody">

            </div>
        </div>
    </div>
</div>
<!--end of edit employee modal-->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>-->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.all.min.js"></script>

<!--for date-->
<script>
    $(function () {
        var dateFormat = "dd-mm-yy";
        var startDateInput = $("#datepicker");
        var endDateInput = $("#datepicker2");
        var totalDaysInput = $("#total-days");

        startDateInput.datepicker({
            dateFormat: dateFormat,
            minDate: 0,
            onSelect: function (selectedDate) {
                var startDate = $(this).datepicker("getDate");
                startDate.setDate(startDate.getDate() + 1);
                endDateInput.datepicker("option", "minDate", startDate);

                updateTotalDays();
            }
        });

        endDateInput.datepicker({
            dateFormat: dateFormat,
            minDate: 0,
            beforeShowDay: function (date) {
                var startDate = startDateInput.datepicker("getDate");
                if (startDate && date < startDate) {
                    return [false];
                }
                return [true];
            },
            onSelect: function (selectedDate) {
                updateTotalDays();
            }
        });

        function updateTotalDays() {
            var startDate = startDateInput.datepicker("getDate");
            var endDate = endDateInput.datepicker("getDate");

            if (startDate && endDate) {
                var totalDays = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24));
                totalDaysInput.val(totalDays);
            }
        }
        
        $("#magOfSuc").delay(1000).fadeOut();
    });

</script>

<!-- for edit leave -->
<script>
    $(document).ready(function () {
        $(".editLeave").click(function () {
            var applicationId = parseInt($(this).attr("name"));
            var userIdEmp = parseInt($(this).data("leave-userid"));
            var leavetypeid = parseInt($(this).data("leavetypeid"));
            var startDate = $(this).data("startdate");
            var endDate = $(this).data("enddate");
            var reason = $(this).data("reason");
            var status = $(this).data("status");

            var prevdayUsed = parseInt($(this).data("daysused-for-leave"));
            var updatedDaysUsed = prevdayUsed;

            var currentuserrole = $(this).data("currentrole");

            var leavecatoption = $(this).data("leavecatoption");

            var dateFormat = "dd-mm-yy";

            var modalContent = "<form class='form' action='../UpdateLeaveApply' method='post'><div class='row'>";


            modalContent += "<div class='col-md-6 col-12'><div class='form-group has-icon-left'>";
            modalContent += "<label for='first-name-icon'>Start Date</label>";
            modalContent += "<div class='position-relative'>";
            modalContent += "<input type='text' class='form-control datepickerForStart' id='startDatePicker' name='startDateEdit' value='" + startDate + "'>";
            modalContent += "<input class='form-control' type='hidden' name='leaveAppId' value='" + applicationId + "' readonly>";
            modalContent += "<input class='form-control' type='hidden' name='leaveAppUserId' value='" + userIdEmp + "' readonly>";
            modalContent += "<input class='form-control' type='hidden' id='catLeaveId' name='catLeaveId' value='" + leavetypeid + "' readonly>";
            modalContent += "<input class='form-control' type='hidden' name='prevDayUsed' value='" + prevdayUsed + "' readonly>";
            modalContent += "<input class='form-control' type='hidden' id='total-days-forEdit' name='updatedDayUsed' value='" + updatedDaysUsed + "' readonly>";
            modalContent += "<input class='form-control' type='hidden' name='currentRole' value='" + currentuserrole + "' readonly>";
            modalContent += "<input class='form-control' type='hidden' name='status' value='" + status + "' readonly>";
            modalContent += "<div class='form-control-icon'><i class='fa fa-user'></i></div></div></div></div>";

            modalContent += "<div class='col-md-6 col-12'><div class='form-group has-icon-left'>";
            modalContent += "<label for='first-name-icon'>End Date</label>";
            modalContent += "<div class='position-relative'>";
            modalContent += "<input type='text' class='form-control datepickerForEnd' id='endDatePicker' name='endDateEdit' value='" + endDate + "'>";
            modalContent += "<div class='form-control-icon'><i class='fa fa-user'></i></div></div></div></div>";

            modalContent += "<div class='col-md-12 col-12 mb-1'><div class='form-group has-icon-left'>";
            modalContent += "<label for='first-name-icon'>Leave Type</label>";
            modalContent += "<div class='position-relative'>";
            modalContent += "<fieldset class='form-group'><select onchange='updateLeaveType()' class='form-select' id='selectLeaveType' aria-label='Default select example' style='width: 100%;right: 0px;bottom: unset;'>";
            modalContent += leavecatoption;
            modalContent += "</select></fieldset></div></div></div>";

            modalContent += "<div class='col-md-12 col-12 mb-5' style='position: relative;top: 39px;'><label for='first-name-icon'>Reason</label><div class='form-group has-icon-left'>";
            modalContent += "<textarea class='form-control' id='reason' rows='4' name='reasonEdit' style='padding-left: 6px;padding-right: 6px;'>" + reason + "</textarea>";
            modalContent += "</div><spam id='reasonError' class='errors text-danger'></spam></div>";


            modalContent += "<div class='col-12 d-flex justify-content-end'>";
            modalContent += "<button type='buttton' class='btn btn-secondary me-1 mb-1' data-bs-dismiss='modal' onclick='closeEditModal()' style='height:100%;'>Close</button>";
            modalContent += "<button id='submitAddButton' type='submit' class='btn btn-primary '>Submit</button>";

            modalContent += "</div>";
            modalContent += "</div></form>";

            $("#editLeaveBody").html(modalContent);

            // Initialize datepickers
            $(".datepickerForStart").datepicker({
                dateFormat: dateFormat,
                minDate: 0,
                onSelect: function (selectedDate) {
                    var startDate = $(this).datepicker("getDate");
                    startDate.setDate(startDate.getDate() + 1);
                    $(".datepickerForEnd").datepicker("option", "minDate", startDate);

                    updateTotalDaysForEdit();
                }
            });

            $(".datepickerForEnd").datepicker({
                dateFormat: dateFormat,
                minDate: 0,
                beforeShowDay: function (date) {
                    var startDate = $(".datepickerForStart").datepicker("getDate");
                    if (startDate && date < startDate) {
                        return [false];
                    }
                    return [true];
                },
                onSelect: function (selectedDate) {
                    updateTotalDaysForEdit();
                }
            });

            showEditModal();
        });

        function updateTotalDaysForEdit() {
            var startDate = $(".datepickerForStart").datepicker("getDate");
            var endDate = $(".datepickerForEnd").datepicker("getDate");

            if (startDate && endDate) {
                var totalDays = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24));
                $("#total-days-forEdit").val(totalDays);
            }
        }
        
        $(".leave-delete").click(function () {
            var leaveAppId = parseInt($(this).attr("name"));
//            alert(leaveAppId);
            Swal.fire({
            icon: 'warning',
            title: 'Confirm Delete',
            text: 'Are you sure you want to delete this leave?',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Delete',
            cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                  // Send AJAX request to delete employee
                  $.ajax({
                    url: '../DeleteLeaveServlet',
                    type: 'POST',
                    data: { 
                        leaveAppId: leaveAppId
                    },
                    success: function(response) {
                      if (response === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success',
                            text: 'Deleted successfully.',
                            onClose: function() {
                              location.reload(); // Refresh the page
                            }
                        });
                      } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'could not be deleted.'
                        });
                      }
                    },
                    error: function() {
                      Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'An error occurred while deleting the Leave.'
                      });
                    }
                  });

                }
            });
        }); 
    });



    function showEditModal() {
        $("#editEmpLeaveModal").show();
    }

    function closeEditModal() {
        $("#editEmpLeaveModal").hide();
    }
</script>

<!--Update leave Type for edit-->
<script>
    function updateLeaveType() {
        var dropdown = document.getElementById("selectLeaveType");

        var catLeaveId = document.getElementById("catLeaveId");

        var selectedOption = dropdown.options[dropdown.selectedIndex];
        var selectedCatId = selectedOption.value;

        catLeaveId.value = selectedCatId;
    }
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