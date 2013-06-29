package org.coinvideo;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class WalletServlet extends HttpServlet {
	private static final Logger _logger = Logger.getLogger(WalletServlet.class.getName());
	
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	resp.sendRedirect("/?warning=get_url");
    }
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processPost(req, resp);
	}
	
	private void processPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        if (user != null) {
        	String address = req.getParameter("address");
        	if (address == null || address == "null") address = "N/A";
            if (validAddress(address)) {
	    		String user_id = user.getUserId();
	      		String username = "N/A";
	      		String email = "N/A";
	      		String pending = "0.00000000";
	      		String delayed = "0.00000000";
	      		String total = "0.00000000";
		    	DatastoreService db = DatastoreServiceFactory.getDatastoreService();
		        Key userKey = KeyFactory.createKey("Users", user_id);
	            try {
	    	        Entity e = db.get(userKey);
	    	  		username = e.getProperty("username").toString();
	    	  		email = e.getProperty("email").toString();
	    	  		//address = e.getProperty("address").toString();
	    	  		delayed = e.getProperty("delayed").toString();
	    	  		pending = e.getProperty("pending").toString();
	    	  		total = e.getProperty("total").toString();
	            } catch (EntityNotFoundException e) {
	           		System.out.println(e.toString());
	            }
	    	    Entity e = new Entity("Users", user_id);
	      		e.setProperty("username", username);
	      		e.setProperty("email", email);
	      		e.setProperty("address", address);
	      		e.setProperty("pending", pending);
	    	    e.setProperty("delayed", delayed);
	      		e.setProperty("total", total);
	    		db.put(e);
	       		_logger.info("[INFO] " + username + " : 'Address' Updated.");
	        	resp.sendRedirect("/");
            } else resp.sendRedirect("/?error=invalidAddress");
        } else resp.sendRedirect("/?error=id");
	}
	
    private boolean validAddress(String s) {
	    if (s != null && (s.length() > 26 && s.length() < 35) && (s.startsWith("1") || s.startsWith("3")) && !s.contains("0") && !s.contains("O") && !s.contains("I") && !s.contains("l")) return true;
	    else return false;
    }
    
}