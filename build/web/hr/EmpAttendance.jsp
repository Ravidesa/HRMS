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
                            <th>Week Number</th>
                            <th>Work Duration</th>
                            <th> View Weekly Attendance </th>
                        </tr>
                    </thead>
                    <tbody>

                        <%  PunchDataDao punchDao = new PunchDataDao(ConnectionProvider.getConnection());
                            List<PunchP> punchList = punchDao.getEmpAttendance();
                            for (PunchP punch : punchList) {
                        %>


                        <tr>
                            <td><%= punch.getFname()%></td>

                            <td><%= punch.getWeek_number()%></td>
                            <td><%= punch.getDuration()%></td>
                            <td>

                                <button type="button" class="btn view-attendance" data-bs-toggle="modal" data-bs-target="#viewAttendance" data-userid ="<%= punch.getUser_id()%>"  style="padding-left: 0.5rem;padding-right: 0.5rem;">
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


<div class="modal fade" id="viewAttendance" style="display:none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary-background text-white">
                <h5 class="modal-title" id="headerForDetails">  </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">

                </button>
            </div>

            <div class="modal-body">
                <input type="hidden" class="uniqueUserId" id="uniqueUserId" name="uniqueUserId" value="">

                <div class="container text-center" id="infoEmp">

                    <div class="col-md-8 col-12 h-100 overflow-auto">
                        <section class="section row m-0">




                            <% 

//                                PunchDataDao punch = new PunchDataDao(ConnectionProvider.getConnection());
//
//                                String str = "<h1 class='uniqueUserId'></h1>";
//                                out.println(str);
////                                int startIndex = str.indexOf(">") + 1;
////                                int endIndex = str.indexOf("</h1>");
////                                String value = str.substring(startIndex, endIndex).trim();
////                                int intValue = Integer.parseInt(value);
////                                out.println(intValue);
//                                int i=0;
//                                
//                                List<PunchP> punchListE = punch.getAttendance();
//                                for (PunchP punchData : punchListE) {
//                                    
//                                    java.util.Date newDate = punchData.getPunch_date();
//                                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
//                                    String d = dateFormat.format(newDate);

                            %>
                            <div class="col-md-6 col-12" >
                                <div class="card " style="border-radius: 50px;">
                                    <div class="card-body">
                                        <div class="d-block">
                                            <div class="d-block">
                                                <div class="align-self-center">
                                                    <!--<i class="fa fa-users text-warning fa-3x me-4"></i>-->
                                                </div>
                                                <div>

                                                    <h5>wed</h5>
                                                    <h5>22-07-2023</h5>
                                                    <h5>00:00:10</h5>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-6 col-12" >
                                <div class="card " style="border-radius: 50px;">
                                    <div class="card-body">
                                        <div class="d-block">
                                            <div class="d-block">
                                                <div class="align-self-center">
                                                    <!--<i class="fa fa-users text-warning fa-3x me-4"></i>-->
                                                </div>
                                                <div>

                                                    <h5>wed</h5>
                                                    <h5>22-07-2023</h5>
                                                    <h5>00:00:10</h5>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-6 col-12" >
                                <div class="card " style="border-radius: 50px;">
                                    <div class="card-body">
                                        <div class="d-block">
                                            <div class="d-block">
                                                <div class="align-self-center">
                                                    <!--<i class="fa fa-users text-warning fa-3x me-4"></i>-->
                                                </div>
                                                <div>

                                                    <h5>wed</h5>
                                                    <h5>22-07-2023</h5>
                                                    <h5>00:00:10</h5>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <% 
//                                }
                            %>


                            <!-- comment -->
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

<script>

    $(document).ready(function () {
        $(".view-attendance").click(function () {
            var userId = $(this).data("userid");

            $(".uniqueUserId").text(userId);
            alert(userId);
        });
    });

    function showModal() {
        $("#viewAttendance").show();
    }

    function closeModal() {
        $("#viewAttendance").hide();
    }
</script><!-- comment -->

<script>
    $(document).ready(function () {
        $(".view-attendance").click(function () {
            var userId = $(this).data("userid");

            $.ajax({
                url: "AttendanceServlet",
                type: "POST",
                data: {
                    userId: userId
                },
                dataType: "json",
                success: function (response) {
                    // Process the JSON data
                    for (var i = 0; i < response.length; i++) {
                        var date = response[i].date;
                        var weekday = response[i].weekday;
                        var duration = response[i].duration;
                        
                        
                    }
                },
                error: function (xhr, status, error) {
                    console.log(xhr.responseText); // Example: log the error message to the console
                    // TODO: Handle the error appropriately
                }
            });
        });
    });

</script>

<%@include file="footer.jsp" %>