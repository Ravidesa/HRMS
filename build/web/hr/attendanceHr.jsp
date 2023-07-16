<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.entities.PunchP"%>
<%@page import="com.dao.PunchDataDao"%>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*, java.io.PrintWriter" %>


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

<%    
    String isPunched = request.getParameter("isPunched");

    if (isPunched.equals("true")) {
        // User is already punched in, show the duration
%>
<div class="col-12 h-100 overflow-auto">
    <section class="section row m-0">
        <h3> Weekly Attendance</h3>
        <%
            LocalDate currentDate = LocalDate.now();
            
            PunchDataDao punch = new PunchDataDao(ConnectionProvider.getConnection());
            List<PunchP> punchList = punch.getAttendance(user.getId());
            
            for (PunchP punchData : punchList) {

                java.util.Date newDate = punchData.getPunch_date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                String d = dateFormat.format(newDate);


        %>
        <div class="col-md-3 col-12" >


            <div class="card " style="border-radius: 50px;">
                <div class="card-body">
                    <div class="d-block">
                        <div class="d-block">
                            <div class="align-self-center">
                                <!--<i class="fa fa-users text-warning fa-3x me-4"></i>-->
                            </div>
                            <div>
                                <h5><%= d%></h5>
                                <h5><%= punchData.getWeek_day()%></h5>
                                <h5 ><%= punchData.getDuration()%></h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <% }%>


        <!-- comment -->
    </section>

</div>
<%
} else if (isPunched.equals("false")) {
    // User is not punched in, show the punch-in form

%>

<div class="row m-0 p-3" style="height:calc(100vh - 70px)">
    <div class="card col-md-6 col-12 h-auto">
        <div class="card-body timesheet-card h-100"style="padding:1.4rem 0.7rem"> 

            <div class="punch-det h-100 position-relative">
                <h5 class="card-title timesheet-title"> <small class="text-muted" id="currentDate"></small></h5>
                <br>
                <div class="punch-hours1" style="display: flex; align-items: center;justify-content: center;">
                    <br><br>
                    <h5 class="card-title"> <small class="text-muted" id="currentTime"></small></h5>
                </div>


                <form action="../punchData" method="post">

                    <div class="punch-info ">
                        <br><br>
                        <span id="punchInTime" name="punchInTime" class="m-5"></span><br><br>
                        <span id="punchOutTime" class="m-5"></span><br><br>


                        <div class="punch-hours" style="display: none; align-items: center;justify-content: center;">

                            <span id="durationValue"></span>
                        </div>
                    </div>
                    <div class="punch-btn-section" style="position:absolute; bottom:0; right: 50%; transform: translate(50% , 0)">
                        <button type="button" class="btn btn-primary punch-btn" id="punchInOutBtn"onclick="punchInOut()">Punch In</button>
                        <button class="btn btn-primary punch-btn" id="submitButton" style="display:none;" type="submit" style="margin-top: 10px;">Submit</button>
                    </div>
                    <input type="hidden" name="userId"  id="userId"value="<%= user.getId()%>">
                    <input type="hidden" id="punchInTimeInput" name="punchInTimeInput" value="">
                    <input type="hidden" id="punchOutTimeInput" name="punchOutTimeInput" value="">
                    <input type="hidden" id="durationInput" name="durationInput" value="">
                    <input type="hidden" id="currentDateInput" name="currentDateInput" value="">
                    <input type="hidden" id="selectedWeekDay" name="selectedWeekDay" value="" />
                    <input type="hidden" id="role" name="role" value="<%= user.getRole()%>" />

                </form>
            </div>
        </div>


    </div>

    <div class="col-md-6 col-12 h-100 overflow-auto">
        <section class="section row m-0">
            <%

                PunchDataDao punch = new PunchDataDao(ConnectionProvider.getConnection());
                List<PunchP> punchList = punch.getAttendance(user.getId());
                for (PunchP punchData : punchList) {

                    java.util.Date newDate = punchData.getPunch_date();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                    String d = dateFormat.format(newDate);


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
                                    <h5><%= d%></h5>
                                    <h5><%= punchData.getWeek_day()%></h5>
                                    <h5 ><%= punchData.getDuration()%></h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <% }%>


            <!-- comment -->
        </section>

    </div><!-- comment -->
</div>
<% } else {%>


<div> <h2> Page "<%= isPunched %>" is Not Found </h2></div>

<% }%>

<!--    <div class="container">
        <h1>Weekly Attendance</h1>
        <table class="table">


            <thead>
                <tr>
                    <th>Date</th>
                    <th>Day</th>
                    <th>Duration(HH:MM:SS)</th>
                </tr>
            </thead>
            <tbody>

     

            </tbody>
        </table>

    </div>

-->

<script>
    var punchedIn = false;
    var punchInTime;
    var punchOutTime;


    // Function to get the current date
    function getCurrentDate() {
        var currentDate = new Date();
        var options = {day: '2-digit', month: '2-digit', year: 'numeric'};
        var formattedDate = currentDate.toLocaleDateString('en-GB', options);
        return formattedDate.replace(/\//g, '-');
    }

    document.getElementById('currentDateInput').value = getCurrentDate();
    function getCurrentDate1() {
        var currentDate = new Date();

        var options = {
            day: '2-digit',
            month: 'long',
            year: 'numeric',
            weekday: 'long'
        };

        var formattedDate = currentDate.toLocaleDateString('en-US', options);
        return formattedDate;
    }

    // Update the current date on the timesheet
    document.getElementById('currentDate').textContent = getCurrentDate1();



    var currentDate = new Date();
    var weekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    var weekDayName = weekDays[currentDate.getDay()];

    // Set the value of the hidden input field
    var selectedWeekDayInput = document.getElementById("selectedWeekDay");
    selectedWeekDayInput.value = weekDayName;

    function updatePunchInTime() {
        punchInTime = new Date();
        document.getElementById('punchInTime').textContent = 'Punch In Time: ' + getTime1();
    }

    function updatePunchOutTime() {
        punchOutTime = new Date();
        document.getElementById('punchOutTime').textContent = 'Punch Out Time: ' + getTime2();
    }

    function calculateDuration() {
        var duration = '';
        if (punchInTime && punchOutTime) {
            var diff = punchOutTime - punchInTime;
            var hours = Math.floor(diff / (1000 * 60 * 60)).toString().padStart(2, '0');
            var minutes = Math.floor((diff / (1000 * 60)) % 60).toString().padStart(2, '0');
            var seconds = Math.floor((diff / 1000) % 60).toString().padStart(2, '0');
            duration = 'Work Duration ' + hours + ' : ' + minutes + ' : ' + seconds + ' Hrs ';
            duration1 = hours + ' : ' + minutes + ' : ' + seconds + ' ';
        }
        document.getElementById('durationValue').textContent = duration;
        document.getElementById('durationInput').value = duration1;

    }



    function getTime1() {
        var now = new Date();
        var hours = now.getHours();
        var minutes = now.getMinutes().toString().padStart(2, '0');
        var seconds = now.getSeconds().toString().padStart(2, '0');
        var ampm = hours >= 12 ? 'PM' : 'AM';

        // Convert hours to 12-hour format
        hours = hours % 12;
        hours = hours ? hours : 12; // Set 0 to 12 for midnight

        return hours + ':' + minutes + ':' + seconds + ' ' + ampm;
    }
    function getTime2() {
        var now = new Date();
        var hours = now.getHours();
        var minutes = now.getMinutes().toString().padStart(2, '0');
        var seconds = now.getSeconds().toString().padStart(2, '0');
        var ampm = hours >= 12 ? 'PM' : 'AM';

        // Convert hours to 12-hour format
        hours = hours % 12;
        hours = hours ? hours : 12; // Set 0 to 12 for midnight

        return hours + ':' + minutes + ':' + seconds + ' ' + ampm;
    }

    function punchInOut() {
        var punchButton = document.getElementById('punchInOutBtn');
        var punchInTimeSpan = document.getElementById('punchInTime');
        var punchOutTimeSpan = document.getElementById('punchOutTime');
        //        var punchOut = true; // Set this variable to true/false based on your application logic
        var buttonContainer = document.querySelector('.button-container');
        var punchHoursDiv = document.querySelector('.punch-hours');

        if (punchedIn) {
            updatePunchOutTime();
            punchedIn = false;
            punchOutTimeSpan.textContent = 'Punch Out Time: ' + getTime2();
            punchButton.style.display = 'none';
            document.getElementById('punchOutTimeInput').value = getTime1();
            punchHoursDiv.style.display = 'flex';
            submitButton.style.display = 'block';
            calculateDuration();

        } else {
            updatePunchInTime();
            punchedIn = true;
            punchInTimeSpan.textContent = 'Punch In Time: ' + getTime1();
            punchButton.textContent = 'Punch Out';

            document.getElementById('punchInTimeInput').value = getTime2();
            //        punchButton.style.display = 'block';

        }
    }


    function updateTime() {
        var currentTimeElement = document.getElementById('currentTime');
        var currentTime = new Date();
        var hours = currentTime.getHours();
        var minutes = currentTime.getMinutes().toString().padStart(2, '0');
        var seconds = currentTime.getSeconds().toString().padStart(2, '0');
        var ampm = hours >= 12 ? 'PM' : 'AM';

        // Convert hours to 12-hour format
        hours = hours % 12;
        hours = hours ? hours : 12; // Set 0 to 12 for midnight

        var formattedTime = hours + ':' + minutes + ':' + seconds + ' ' + ampm;
        currentTimeElement.textContent = formattedTime;
    }

    // Call updateTime function initially to display current time
    updateTime();

    // Update the current time every second
    setInterval(updateTime, 1000);

</script>

<%@ include file="footer.jsp" %>





