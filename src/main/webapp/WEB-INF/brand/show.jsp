<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Brand List</title>

    <meta name="${_csrf.parameterName}" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>

<div class="container">
    <div class="row content">

        <div class="col-md-4"></div>

        <div class="col-md-4">
            <div class="mb-3">
                <legend style="margin-bottom: 10%">
                        <a href="/auth/dashboard" class="link">
                            Halkhata <i class="fas fa-home"></i>
                        </a>
                </legend>

                <form:form method="POST" modelAttribute="brand" cssClass="row g-3">

                    <div class="col-auto">
                        <form:input type="text"
                                    path="name"
                                    cssClass="form-control"
                                    placeholder="Brand name"
                                    autofocus="true"/>

                    </div>

                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary mb-3">
                            <i class="fas fa-plus-circle"></i>
                        </button>
                    </div>

                    <div style="margin-top: 5px">
                        <form:errors path="name" cssClass="alert alert-danger form-control"/>
                    </div>
                </form:form>
            </div>

            <div class="mb-3">
                <legend>My brands</legend>

                <c:if test="${brandList.size() == 0}">
                    <div class="alert alert-info" role="alert">
                        You have no brand names!
                    </div>
                </c:if>

                <table class="table">
                    <thead>
                        <tr>
                            <th>Sl.</th>
                            <th>Brand name</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach items="${brandList}" var="t" varStatus="i">
                            <tr id="brand-${t.id}">
                                <td>${i.index + 1}</td>
                                <td>${t.name}</td>
                                <td>
                                    <a href="/brand/edit?id=${t.id}" class="link"><i class="fas fa-pen"></i></a>
                                </td>
                                <td>
                                    <a class="link" onclick="ajaxPostAction(${t.id})"><i class="fas fa-trash-alt"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    function ajaxPostAction(id) {
        if (confirm("Are you sure, you want to delete it?")) {
            $.ajax({
                url: '/brand/delete?id=' + id,
                type: 'DELETE',
                cache: false,
                contentType: 'application/json; charset=UTF-8',
                dataType: 'text',
                beforeSend: function(xhr) {
                    var token = $("meta[name='_csrf']").attr("content");
                    var header = $("meta[name='_csrf_header']").attr("content");

                    xhr.setRequestHeader(header, token);
                },
                success: function(data) {
                    location.reload();
                },
                error: function(e) {
                    alert("Error while deleting!");
                }
            });
        }
    }
</script>
</body>
</html>
