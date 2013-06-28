package org.coinvideo;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class ViroolServlet extends HttpServlet {
	private static final Logger _logger = Logger.getLogger(ViroolServlet.class.getName());
	
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	String tx = req.getParameter("tx");
    	if (tx == null || tx == "null") tx = "0000-N/A-N/A";
    	String[] tx_array = tx.split("-");
    	double r_amount = Double.parseDouble(tx_array[0]) / 100000000;
    	String user_id = tx_array[1];
    	String tracking_id;
    	if (tx_array.length >= 7) {
    		tracking_id = tx_array[2]+"-"+tx_array[3]+"-"+tx_array[4]+"-"+tx_array[5]+"-"+tx_array[6];
    	} else {
    		tracking_id = tx_array[2];
    	}
    	
    	double balance = 0.00000000;
  		String username = "N/A";
  		String email = "N/A";
  		String address = "N/A";
  		String pending = "0.00000000";
  		String total = "0.00000000";
    	
		DatastoreService db = DatastoreServiceFactory.getDatastoreService();
        Key userKey = KeyFactory.createKey("Users", user_id);
        try {
	        Entity e = db.get(userKey);
	  		balance = Double.parseDouble(e.getProperty("delayed").toString());
	  		username = e.getProperty("username").toString();
	  		email = e.getProperty("email").toString();
	  		address = e.getProperty("address").toString();
	  		pending = e.getProperty("pending").toString();
	  		total = e.getProperty("total").toString();
        } catch (EntityNotFoundException e) {
        	_logger.info("Video watched! (Exception): " + e.toString());
        }
	    Entity e = new Entity("Users", user_id);
	    String delayed = String.format("%.8f", balance + r_amount);
	    e.setProperty("delayed", delayed);
  		e.setProperty("username", username);
  		e.setProperty("email", email);
  		e.setProperty("address", address);
  		e.setProperty("pending", pending);
  		e.setProperty("total", total);
		db.put(e);
		String r_string = String.format("%.8f", r_amount);
		_logger.info(username + " : Video watched!");
		_logger.info("Reward: " + r_string + " | User ID: " + user_id + " | Tracking ID: " + tracking_id);
    }
    
    /*private boolean validateTx(String signature) {
    	if (signature != null) return true;
    	else return false;
    }*/
    
}