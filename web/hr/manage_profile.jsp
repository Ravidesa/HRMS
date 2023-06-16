<%@include file="header.jsp" %>
<div class="container">
    <div class="col-md-12">
        <div class="card md-12 ">
            <div class="row ">
                <div class="col-lg-2 col-md-2 ">
                    <img src="../images/default.png" class="img-fluid rounded m-2 " alt="... ">
                </div>
                <div class="col-lg-4 col-md-4 ">
                    <div class="card-body mt-3 ">
                        <div>
                            <strong class="large "><h4> Neel Ramani</h4></strong>
                        </div>
                        <div class="text-black-50 ">
                            <strong> Software Developer</strong>
                        </div>
                        <div class="text-black-50 mt-1 ">
                            Date of Joining: 12th October 2012
                        </div>
                        <button class="p-1 m-4 bg-white" id="add-details" data-bs-toggle="modal" data-bs-target="#editEmployee">
                            Add Details
                        </button>

                    </div>
                </div>


                <div class="col-md-5">
                    <ul class="personal-info m-2">
                        <li>
                            <div class="title m-2">Phone:
                                <span class="text"><a href="">9876543210</a></span>
                            </div>
                        </li>
                        <li>
                            <div class="title m-2">Email:
                                <span class="text"><a href="">Neel@gmail.com</a></span>
                            </div>
                        </li>
                        <li>
                            <div class="title m-2">Birthday:
                                <span class="text">24th July</span>
                            </div>
                        </li>
                        <li>
                            <div class="title m-2">Address:
                                <span class="text">12- Narayan park -2 , opp. india colony,Bopal </span></div>
                        </li>
                        <li>
                            <div class="title m-2">Gender:
                                <span class="text">Male</span></div>
                        </li>
                        <li>
                            <div class="title m-2">Skills:

                                <span class=" badge rounded-pill bg-primary ">Java</span>
                                <span class="badge rounded-pill bg-secondary ">Python</span>
                                <span class="badge rounded-pill bg-success ">Node.js</span>

                            </div>
                        </li>

                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="editEmployee" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary-background text-white">
                <h5 class="modal-title" id="exampleModalLabel"> HRMS </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">

                </button>
            </div>

            <div class="modal-body">
                <div class="container text-center">
                    <img src="../images/default.png" class="img-fluid" style="max-width: 150px;border-radius: 50%;">
                    <h5 class="modal-title mt-3" id="exampleModalLabel"> Ravi </h5>

                    <!--details-->
                    <div id="profile-details" class="mt-3">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <th scope="row">ID :</th>
                                    <td>{{userData.id}}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Email :</th>
                                    <td id="email"></td>
                                </tr>
                                <tr>
                                    <th scope="row">Gender :</th>
                                    <td>{{userData.gender}}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Status :</th>
                                    <td>Active</td>
                                </tr>
                                <tr>
                                    <th scope="row">Registered On :</th>
                                    <td>Created on</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!--end Detauils-->

                    <!--Profile Edit-->
                    <div id="profile-edit" style="display: none;">
                        <h3 class="mt3">Please Edit Carefully</h3>

                        <form  method="POST" enctype="multipart/form-data">
                            <table class="table" border="1">
                                <tr>
                                    <th scope="row">ID :</th>
                                    <td>1568</td>
                                </tr>
                                <tr>
                                    <th scope="row">Email :</th>
                                    <td><input type="email" class="form-control" name="user_email" value="ravi"></td>
                                </tr>
                                <tr>
                                    <th scope="row">Name :</th>
                                    <td><input type="text" class="form-control" name="user_name" value="jhj"></td>
                                </tr>
                                <tr>
                                    <th scope="row">Password :</th>
                                    <td><input type="password" class="form-control" name="user_password" value="llsa"></td>
                                </tr>
                                <tr>
                                    <th scope="row">Gender :</th>
                                    <td>male</td>
                                </tr>
                                <tr>
                                    <th scope="row">About :</th>
                                    <td>
                                        <textarea class="form-control" name="user_about" rows="3">
                                                    kalksjkajsk
                                        </textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">New Profile:</th>
                                    <td>
                                        <input type="file" name="image" class="form-control">
                                    </td>
                                </tr>
                            </table>
                            <div>
                                <button type="submit" class="btn btn-outline-primary">Save</button>
                            </div>
                        </form>
                    </div>
                    <!--End profile-->

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" id="edit-profile-button" class="btn btn-primary">Save</button>
            </div>
        </div>
    </div>
</div>

<!--end modal-->

<script>
//    $(document).ready(function () {
//    let editStatus = false;
//    $("#edit-profile-button").click(function () {
//    if (editStatus == false) {
//    $("button").attr("data-bs-dismiss", "modal");
//    }
//    })
//    })

    $(document).ready(function (){
        
    })
</script>

<%@include file="footer.jsp" %>

