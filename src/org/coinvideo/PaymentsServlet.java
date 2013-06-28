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

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class PaymentsServlet extends HttpServlet {
	private static final Logger _logger = Logger.getLogger(PaymentsServlet.class.getName());
	
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        if (user != null) {
        	double amount = 0.00000000;
        	double balance = 0.00000000;
      		String username = "N/A";
      		String email = "N/A";
      		String address = "N/A";
      		String pending = "0.00000000";
      		String total = "0.00000000";
        	String user_id = user.getUserId();
    		DatastoreService db = DatastoreServiceFactory.getDatastoreService();
            Key userKey = KeyFactory.createKey("Users", user_id);
            try {
    	        Entity e = db.get(userKey);
    	  		amount = Double.parseDouble(e.getProperty("delayed").toString());
    	  		balance = Double.parseDouble(e.getProperty("pending").toString());
    	  		username = e.getProperty("username").toString();
    	  		email = e.getProperty("email").toString();
    	  		address = e.getProperty("address").toString();
    	  		total = e.getProperty("total").toString();
            } catch (EntityNotFoundException e) {
           		System.out.println(e.toString());
            }
    	    Entity e = new Entity("Users", user_id);
    	    String delayed = "0.00000000";
    	    pending = String.format("%.8f", balance + amount);
    	    e.setProperty("delayed", delayed);
      		e.setProperty("username", username);
      		e.setProperty("email", email);
      		e.setProperty("address", address);
      		e.setProperty("pending", pending);
      		e.setProperty("total", total);
    		db.put(e);
    		_logger.info("[(USER) WITHDRAW] " + username + " => " + pending + " BTC");
    		resp.sendRedirect("/");
        } else { resp.sendRedirect("/?error=withdraw"); }
    }
    
}