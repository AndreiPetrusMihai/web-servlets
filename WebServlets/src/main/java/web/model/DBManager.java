package web.model;

import web.domain.Url;
import web.domain.User;

import java.sql.*;
import java.util.ArrayList;

/**
 * Created by forest.
 */
public class DBManager {
    private Statement stmt;

    public DBManager() {
        connect();
    }

    public void connect() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/urlmanagement", "andrei","andrei");
            stmt = con.createStatement();
        } catch(Exception ex) {
            System.out.println("Error on connect:"+ex.getMessage());
            ex.printStackTrace();
        }
    }

    public User authenticate(String username, String password) {
        ResultSet rs;
        User u = null;
        System.out.println(username+" "+password);
        try {
            rs = stmt.executeQuery("select * from users where username='"+username+"' and password='"+password+"'");
            if (rs.next()) {
                u = new User(rs.getInt("uid"), rs.getString("username"), rs.getString("password"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }

    public ArrayList<Url> getUserUrls(int uid) {
        ArrayList<Url> urls = new ArrayList<Url>();
        ResultSet rs;
        try {
            rs = stmt.executeQuery("select * from urls where uid="+uid);
            while (rs.next()) {
                urls.add(new Url(
                        rs.getInt("urlid"),
                        rs.getInt("uid"),
                        rs.getString("url")
                ));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return urls;
    }

    public ArrayList<Url> getTopUrls(int numberOfUrls) {
        ArrayList<Url> urls = new ArrayList<Url>();
        ResultSet rs;
        try {
            //SELECT url, count(*) as 'Count' FROM urls group by url ORDER BY Count desc LIMIT 3;
            rs = stmt.executeQuery("SELECT url, count(*) as \'Count\' FROM urls group by url ORDER BY Count desc LIMIT " + numberOfUrls);
            while (rs.next()) {
                System.out.println();
                urls.add(new Url(
                        0,
                        0,
                        rs.getString("url")
                ));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return urls;
    }

    public int addUrl(Url url) {
        System.out.println("ADDING IN DB");
        int r = 0;
        int lastUid = -1;
        try {
            String statement = "INSERT INTO urls (url,uid) VALUES ('" + url.getUrl() + "'," +url.getUid() + ")";
            r = stmt.executeUpdate(statement);
            statement = "SELECT urlid FROM urls ORDER BY urlid DESC LIMIT 1";
            ResultSet rs = stmt.executeQuery(statement);
            while (rs.next()) {
                lastUid = rs.getInt("urlid");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lastUid;
    }

    public boolean updateUrl(Url url) {
        System.out.println("UPDATING IN DB");
        int r = 0;
        try {
            String statement = "update urls set url='" + url.getUrl() + "' where urlid="+url.getUrlid();
            r = stmt.executeUpdate(statement);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (r>0) return true;
        else return false;
    }

    public boolean deleteUrl(int urlid) {
        System.out.println("DELETING IN DB");
        int r = 0;
        try {
            String statement = "DELETE FROM urls where urlid=" + urlid;
            r = stmt.executeUpdate(statement);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (r>0) return true;
        else return false;
    }

}