<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8" />
    <title>Login</title>
    <style>
        .container {
            margin-left: auto;
            margin-right: auto;
            width: 400px;
            display: flex;
            justify-content: center;
        }
    </style>
    <script src="js/jquery-2.0.3.js"></script>
    <script src="js/ajax-utils.js"></script>
</head>
<body>
<form class="container" action="LoginController" method="post" style="margin-top: 20vh">
    <div>
        Enter username : <input type="text" name="username" /> <br />
        Enter password : <input type="password" name="password" /> <br />
        <input type="submit" value="Login" />
    </div>
</form>

<div style="margin-top: 5vh;" class="container">
    <section id="top-section">
        <span style="font-weight: bold; background-color: yellow">Top 10 urls:</span><br/>
        <table id="top-urls-table"></table>
    </section>
</div>
<script>
    $(document).ready(function() {
        getTopUrls(10, function (urls) {
            $("#top-urls-table").html("");
            for (var name in urls) {
                $("#top-urls-table").append("<tr>" +
                    "<td>" + urls[name].url + "</td>" +
                    "</tr>")
            }
            })
    })
</script>
</body>
</html>