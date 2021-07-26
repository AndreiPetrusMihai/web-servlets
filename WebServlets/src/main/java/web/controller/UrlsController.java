package web.controller;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import web.domain.Url;
import web.domain.User;
import web.model.DBManager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "UrlsController", value = "/UrlsController")
public class UrlsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        DBManager dbmanager = new DBManager();
        int uid;
        try {
            uid = ((User) session.getAttribute("user")).getUid();
        } catch (NullPointerException ex){
            uid = -1;
        }

        if ((action != null) && action.equals("getAll")) {
            response.setContentType("application/json");
            ArrayList<Url> urls = dbmanager.getUserUrls(uid);
            JSONArray jsonUrls = new JSONArray();
            for (int i = 0; i < urls.size(); i++) {
                JSONObject jObj = new JSONObject();
                jObj.put("urlid", urls.get(i).getUrlid());
                jObj.put("url", urls.get(i).getUrl());
                jsonUrls.add(jObj);
            }
            PrintWriter out = new PrintWriter(response.getOutputStream());
            out.println(jsonUrls.toJSONString());
            out.flush();
        }  else if ((action != null) && action.equals("update")) {
            Integer urlid = Integer.parseInt(request.getParameter("urlid"));
            String newUrl = request.getParameter("newUrl");

            Boolean result = dbmanager.updateUrl(new Url(urlid,uid,newUrl));
            PrintWriter out = new PrintWriter(response.getOutputStream());
            out.println(true);
            out.flush();
        } else if ((action != null) && action.equals("add")) {
            String url = request.getParameter("url");
            int result = dbmanager.addUrl(new Url(-1,uid,url));
            PrintWriter out = new PrintWriter(response.getOutputStream());
            out.println(result);

            out.flush();
        } else if ((action != null) && action.equals("delete")) {
            Integer urlid = Integer.parseInt(request.getParameter("urlid"));
            Boolean result = dbmanager.deleteUrl(urlid);
            PrintWriter out = new PrintWriter(response.getOutputStream());
            out.println(result);
            out.flush();
        } else if ((action != null) && action.equals("getTopUrls")) {
            System.out.println("Here");
            Integer numberOfUrls = Integer.parseInt(request.getParameter("numberOfUrls"));
            ArrayList<Url> urls = dbmanager.getTopUrls(numberOfUrls);
            JSONArray jsonUrls = new JSONArray();
            for (int i = 0; i < urls.size(); i++) {
                JSONObject jObj = new JSONObject();
                jObj.put("url", urls.get(i).getUrl());
                jsonUrls.add(jObj);
            }
            PrintWriter out = new PrintWriter(response.getOutputStream());
            out.println(jsonUrls.toJSONString());
            out.flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
