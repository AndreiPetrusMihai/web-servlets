<%@ page import="web.domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Logged In</title>
    <style>
        .asset-name {
            background-color: cornflowerblue;
            border-right: solid 1px black;
        }
        .tableRow:hover{
            background-color: grey;
            cursor: pointer;
        }
        button:hover{
            cursor: pointer;
        }
        td{
            padding-right: 10px;
        }
        .extendedCell{
            min-width: 80px;
        }
        .subContainer{
            margin-top: 10vh;
        }
    </style>
    <script src="js/jquery-2.0.3.js"></script>
    <script src="js/ajax-utils.js"></script>
</head>
<body style="display: flex; justify-content: space-around">
<%! User user; %>
<%  user = (User) session.getAttribute("user");
    if (user != null) {
        System.out.println("Welcome " + user.getUsername());
    }
%>
<div class="subContainer">
    <section id="getall-section">
        <button id="getUrlsButton" type="button">Get Urls</button><br/>
        <table ><tbody id="urls-table"></tbody></table>
    </section>

    <p style="height: 50px;"></p>
</div>
<div class="subContainer">
    <section id="add-section">
        <span style="font-weight: bold; background-color: cornflowerblue">Add url</span><br/>
        <table>
            <tr><td>Url: </td><td><input type="text" id="addUrl"></td></tr>
            <tr><td><button type="button" id="add-url-btn">Add url</button></td><td></td></tr>
        </table>
        <p id="add-result-section"></p>
    </section>

    <p style="height: 50px;"></p>

    <section id="update-section">
        <span style="font-weight: bold; background-color: #cd5c5c">Update url</span><br/>
        <table>
            <tr><td>Urlid: </td><td><input readonly disabled type="number" id="updateUrlid"></td></tr>
            <tr><td>Url: </td><td><input type="text" id="updateUrl"></td></tr>
            <tr><td><button type="button" id="update-url-btn">Update url</button></td><td></td></tr>
        </table>
        <p id="update-result-section"></p>
    </section>

    <p style="height: 50px;"></p>
</div>
<div class="subContainer">
    <section id="top-section" style="display:flex">
        <div>
            <span style="font-weight: bold; background-color: yellow">Top urls</span><br/>
            <p>Number of urls to get:</p>
            <input type="number" id="numberOfUrls"><br/><br/>
            <button id="getTopUrlsButton" type="button">Get Top Urls</button>
        </div>
        <p style="width: 15px;"></p>
        <div>
            <table id="top-urls-table"></table>
        </div>
    </section>
</div>


<script>
    const deleteButtonClick = (urlid) => {
        const deleteCallback = (response) => {
            if (response)
                $(`#\${urlid}`).remove()
        }
        if(confirm("Are you sure that you want to delete the following url?\n" + urlid)){
            deleteUrl(urlid,
                deleteCallback)
        }
    }

    const getUrlsHandler = () => {
        getUserUrls(<%= user.getUid() %>, function(urls) {
            console.log(urls);
            $("#urls-table").html("");
            $("#urls-table").append("<tr style='background-color: mediumseagreen'><td class=\"extendedCell\">Urlid</td><td  class=\"extendedCell\">Url</td></tr> ");
            for(var name in urls) {
                //console.log(assets[name].description);
                $("#urls-table").append("<tr class=\"tableRow\" onclick='selectUrl(" + urls[name].urlid+",\""+ urls[name].url+ "\")' id="+ parseInt(urls[name].urlid) +">" +
                    "<td>"+urls[name].urlid+"</td>" +
                    "<td>"+urls[name].url+"</td>" +
                    "<td ><button style=\"cursor:pointer;\" onclick='deleteButtonClick(" + urls[name].urlid+  ")' >X</button></td>" +
                    "</tr>")
            }
        })
    }

    const getTopUrlsHandler = () => {
        const numberOfUrls = Number($("#numberOfUrls").val())
        if ( numberOfUrls && numberOfUrls>0){
            getTopUrls(numberOfUrls, function(urls) {
                $("#top-urls-table").html("");
                $("#top-urls-table").append("<tr style='background-color: yellow'><td>Url</td></tr> ");
                for(var name in urls) {
                    $("#top-urls-table").append("<tr>" +
                        "<td>"+urls[name].url+"</td>" +
                        "</tr>")
                }
            })
        }
    }

    const selectUrl = (urlid,url) => {
        console.log("Click")
        $("#updateUrlid").val(urlid)
        $("#updateUrl").val(url)
    }

    const addUrlHandler = () => {
        try{
            const url =  $("#addUrl").val()
            if(url)
                addUrl(
                    url,
                    function(response) {
                        if(response !== -1){
                            $("#add-result-section").html("Added url succesfully.");
                            $("<tr class=\"tableRow\" onclick='selectUrl(" + response+",\""+ url+ "\")' id="+ parseInt(response) +">" +
                                "<td>"+response+"</td>" +
                                "<td>"+url+"</td>" +
                                "<td ><button style=\"cursor:pointer;\" onclick='deleteButtonClick(" + response+  ")' >X</button></td>" +
                                "</tr>").insertAfter($("#urls-table tr").last())
                        } else {
                            $("#add-result-section").html("Error adding url!");
                        }
                    }
                )
            else
                $("#add-result-section").html("Invalid input");
        } catch (exception) {
            $("#add-result-section").html("Invalid input");
        }
    }

    const updateUrlHandler = () => {
        try{
            const urlid = Number(($("#updateUrlid").val()))
            const newUrl =  $("#updateUrl").val()
            if(urlid && newUrl)
                updateUrl(urlid,
                    newUrl,
                    function(response) {
                        if(response){
                            $("#update-result-section").html("Updated url succesfully.");
                            $("#"+urlid).replaceWith("<tr class=\"tableRow\" onclick='selectUrl(" + urlid+",\""+ newUrl+ "\")' id="+ parseInt(urlid) +">" +
                                "<td>"+urlid+"</td>" +
                                "<td>"+newUrl+"</td>" +
                                "<td ><button style=\"cursor:pointer;\" onclick='deleteButtonClick(" + urlid+  ")' >X</button></td>" +
                                "</tr>")
                        } else{
                            $("#update-result-section").html("Error updating url!");
                        }
                    }
                )
            else
                $("#update-result-section").html("Invalid input");
        } catch (exception) {
            $("#update-result-section").html("Invalid input");
        }
    }

    $(document).ready(function(){
        getUrlsHandler();
        $("#getUrlsButton").click(getUrlsHandler)
        $("#getTopUrlsButton").click(getTopUrlsHandler)
        $("#add-url-btn").click(addUrlHandler)
        $("#update-url-btn").click(updateUrlHandler)
    });
</script>
</body>
</html>