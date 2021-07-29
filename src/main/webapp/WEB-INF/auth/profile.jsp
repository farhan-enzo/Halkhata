<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PROFILE</title>

    <meta name="${_csrf.parameterName}" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>

<div class="container">
    <div class="row" style="padding-top: 10%">

        <div class="col-md-2"></div>

        <div class="col-md-8">
            <div class="row">
                <legend>Select your <strong>PROFILE</strong> first</legend>
            </div>

            <div class="container">
                <div class="row">

                    <c:forEach items="${user.profiles}" var="profile">
                        <button type="button"
                                class="btn btn-primary"
                                style="width: 15rem; margin-right: 10px"
                                data-bs-toggle="modal"
                                data-bs-target="#profile${profile.id}">
                            ${profile.name}
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="profile${profile.id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Password</h5>
                                    </div>

                                    <div class="modal-body">
                                        <input type="password"
                                               class="form-control"
                                               name="password"
                                               id="input${profile.id}"/>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary" onclick="verifyProfile(${profile.id}, 'input${profile.id}')">Submit</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function verifyProfile(id, password) {
        var profile = {
            id : id,
            password : $('#' + password).val()
        };

        console.log(JSON.stringify(profile));

        $.ajax({
            url: '/profile/verify',
            type: 'POST',
            cache: false,
            data: JSON.stringify(profile),
            contentType: 'application/json; charset=UTF-8',
            dataType: 'json',
            beforeSend: function(xhr) {
                var token = $("meta[name='_csrf']").attr("content");
                var header = $("meta[name='_csrf_header']").attr("content");

                xhr.setRequestHeader(header, token);
            },
            success: function(data) {
                window.location.href = 'dashboard';
            },
            error: function() {
                alert("Error occurred!");
            }
        });
    }
</script>
</body>
</html>
