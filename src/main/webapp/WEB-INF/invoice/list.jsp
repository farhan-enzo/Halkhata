<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sale :: History</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-2"></div>

        <div class="col-md-8">
            <legend>Sale History</legend>

            <div class="input-group mb-3" style="margin-top: 10px">
                <input type="text"
                       id="invoiceSearch"
                       class="form-control"
                       placeholder="Invoice No.">
                <span class="input-group-text"><i class="fas fa-search"></i></span>
            </div>

            <c:if test="${invoices.size() == 0}">
                <div class="alert alert-info" role="alert">
                    You have no Sales yet!
                </div>
            </c:if>

            <table class="table" id="invoiceList">
                <thead>
                <tr>
                    <th>Sl.</th>
                    <th>Invoice No</th>
                    <th>Grand Total</th>
                    <th>Date</th>
                    <th>Profile</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${invoices}" var="invoice" varStatus="i">
                    <tr id="brand-${invioce.id}">
                        <td>${i.index + 1}.</td>
                        <td>${invoice.invoiceNo}</td>
                        <td>${invoice.grandTotal}</td>
                        <td>${invoice.date}</td>
                        <td>${invoice.profile.name}</td>
                        <td>
                            <a href="/invoice/show?id=${invoice.id}"
                               type="button" class="btn btn-sm btn-primary">
                                Show
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $("#invoiceSearch").on("keyup", function() {
            var value = $(this).val().toLowerCase();

            $("#invoiceList tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>
</body>
</html>
