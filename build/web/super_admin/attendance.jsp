<%@page import="com.entities.PunchP"%>
<%@page import="com.dao.PunchDataDao"%>
<%@page import="com.helper.GetDesignationOptions"%>
<%@page import="com.helper.GetDesignationOptions"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.entities.Employee"%>
<%@page import="com.dao.EmployeeDao,java.util.List,java.util.ArrayList"%>

<%@page import="java.util.regex.Matcher,java.util.regex.Pattern" %>

<%@include file="header.jsp" %>



<section class="section p-4">
    <div class="card">
        <div class="card-body">

            <div class="addButton" data-bs-toggle="modal" data-bs-target="#exampleModal">

            </div>
            <section class="component-section" id="employee">
                <table class="table pmd-table table-hover pmd-table-card">
                    <thead class="thead-light">
                        <tr>
                            <th>Name</th>
                            <th>Total Work Duration</th>
                            <th> View Weekly Attendance </th>
                        </tr>
                    </thead>
                    <tbody>

                        <%  PunchDataDao punchDao = new PunchDataDao(ConnectionProvider.getConnection());
                            List<PunchP> punchList = punchDao.getAllAttendanceTotalTime();
                            for (PunchP punch : punchList) {
                        %>


                        <tr>
                            <td><%= punch.getFname() +" "+ punch.getLname()%></td>
                            <td><%= punch.getDuration()%></td>
                            <td>

                                <button type="button" class="btn view-attendance" data-bs-toggle="modal" data-bs-target="#viewAttendance" data-userid ="<%= punch.getUser_id()%>"  style="padding-left: 0.5rem;padding-right: 0.5rem;box-shadow: none;">
                                    <i class="fa fa-eye text-success" aria-hidden="true" ></i>
                                </button></td>
                        </tr>

                        <% }%>
                    </tbody>
                </table>
            </section>

            </tr>
            </tbody>
            </table>
        </div>
    </div>

</section>


<!--modalContent = "<div class='modal fade' id='viewAttendance' style='display:none;'><div class='modal-dialog modal-lg'><div class='modal-content'>";                    
modalContent += "<div class='modal-header primary-background text-white'><h5 class='modal-title' id='headerForDetails'>  </h5><button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button></div>";
modalContent += "<div class='modal-body'><div class='container text-center' id='infoEmp'><div class='col-md-12 col-12 h-100 overflow-auto'>";
modalContent += "<section class='section row m-0' id='viewAttendaceIndividial'>";

    
    
modalContent += "</section></div></div></div><div class='modal-footer'>";
modalContent += "<button type='button' class='btn btn-secondary' data-bs-dismiss='modal' onclick='closeModal()'>Close</button></div></div></div></div>";-->


<div class="modal fade" id="viewAttendance" style="display:none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header primary-background text-white">

            </div>

            <div class="modal-body">
                <div class="container text-center" id="infoEmp">

                    <div class="col-md-12 col-12 h-100 overflow-auto">
                        <section class="section row m-0" id="viewAttendaceIndividial">


                        </section>

                    </div><!-- comment -->


                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeModal()">Close</button>
            </div>
        </div>
    </div>
</div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<script>
    $(document).ready(function () {
        $(".view-attendance").click(function () {
            var userId = $(this).data("userid");
//            alert(userId);

            $.ajax({
                url: "../AttendanceServlet",
                type: "POST",
                data: {
                    userId: userId
                },
                dataType: "json",
                success: function (response) {


                    console.log(response);
                    console.log(response.attendanceData[0].date);
                    // Process the JSON data
                    for (var i = 0; i < response.attendanceData.length; i++) {

                        var date = response.attendanceData[i].date;
                        var weekday = response.attendanceData[i].weekday;
                        var duration = response.attendanceData[i].duration;

                        var dateObj = moment(date);

                        var formattedDate = dateObj.format("DD-MM-YYYY");

                        console.log(date);
                        console.log(weekday);
                        console.log(duration);


                        var modalContent = "<div class='col-md-4 col-12'><div class='card ' style='border-radius: 50px;width:74%;'>";
                        modalContent += "<div class='card-body' style='width:auto;'><div class='d-block'><div class='d-block'>";
                        modalContent += "<div class='align-self-center'></div>";

                        modalContent += "<div>";
                        modalContent += "<h5>" + formattedDate + "</h5><br/>";
                        modalContent += "<h5>" + weekday + "</h5><br/>";
                        modalContent += "<h5>" + duration + "</h5>";
                        modalContent += "<div>";

                        modalContent += "</div></div></div> </div></div>";

                        $("#viewAttendaceIndividial").append(modalContent);
                        showModal();
                    }


                },
                error: function (xhr, status, error) {
                    console.log(xhr.responseText); // Example: log the error message to the console
                    // TODO: Handle the error appropriately
                }
            });
        });
    });

    function showModal() {
        $("#viewAttendance").show();
    }

    function closeModal() {
        $("#viewAttendaceIndividial").empty();
        $("#viewAttendance").hide();
    }

</script>

<%@include file="footer.jsp" %>