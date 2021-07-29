<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PROFILE :: CREATE</title>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-4"></div>

        <div class="col-md-4" style="padding-top: 10%">
            <legend>Create New Profile</legend>

            <form:form method="POST" modelAttribute="profile" class="form-signin">

                <div class="mb-3">
                    <div>
                        <form:input type="text"
                                    path="name"
                                    class="form-control"
                                    placeholder="Profile name"
                                    autofocus="true"/>

                    </div>

                    <div style="margin-top: 5px">
                        <form:errors path="name" cssClass="alert alert-danger form-control"/>
                    </div>
                </div>

                <div class="mb-3">
                    <div>
                        <form:input type="password"
                                    path="password"
                                    class="form-control"
                                    placeholder="Password"/>
                    </div>

                    <div style="margin-top: 5px">
                        <form:errors path="password" cssClass="form-control alert alert-danger"/>
                    </div>
                </div>

                <div class="md-3">
                    <div>
                        <form:select path="role" cssClass="form-control">
                            <form:option value="">--Please Select Role--</form:option>
                            <form:options items="${roles}"/>
                        </form:select>
                    </div>

                    <div style="margin-top: 5px">
                        <form:errors path="role" cssClass="alert alert-danger"/>
                    </div>
                </div>

                <div class="mb-3">
                    <button class="btn btn-lg btn-primary btn-block" type="submit">Create</button>
                </div>
            </form:form>
        </div>
    </div>
</div>
</body>
</html>
