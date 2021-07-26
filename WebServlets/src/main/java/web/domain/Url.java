package web.domain;

public class Url {
    private int urlid;
    private int uid;
    private String url;

    public Url(int urlid,int uid, String url) {
        this.urlid = urlid;
        this.uid = uid;
        this.url = url;
    }

    public int getUrlid() {
        return urlid;
    }

    public void setUrlid(int urlid) {
        this.urlid = urlid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

}
