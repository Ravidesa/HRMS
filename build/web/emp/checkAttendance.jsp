<%@ include file="header.jsp" %>
<%@ page import="java.sql.*, java.io.PrintWriter" %>

<div class="card" style="width:450px;">
    <div class="card-body timesheet-card"style="padding:1.4rem 0.7rem">
        <h5 class="card-title timesheet-title"> <small class="text-muted" id="currentDate"></small></h5>

        <%           
            String isPunchedStr = request.getParameter("isPunched");
            boolean isPunched = Boolean.parseBoolean(isPunchedStr);
            if (isPunched) {
                // User is already punched in, show the duration
        %>
        <h1>Duration: 8 hours</h1>
        <%
        } else {
            // User is not punched in, show the punch-in form
        %>
        <form action="punchIn" method="POST">
            <input type="hidden" name="userId" value="<%= request.getParameter("userId")%>">
            <input type="hidden" name="currentDate" value="<%= request.getParameter("currentDate")%>">
            <button type="submit">Punch In</button>
        </form>
        <%
            }
        %>
    </div>
</div>

<%@ include file="footer.jsp" %>





