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
import java.io.PrintWriter;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class UsersServlet extends HttpServlet {
	private static final Logger _logger = Logger.getLogger(UsersServlet.class.getName());
	
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        if (user != null) {
        	/* TRY: read from memcache first? */
	        String user_id = user.getUserId();
	        String delayed = "", pending = "", total = "";
	    	DatastoreService db = DatastoreServiceFactory.getDatastoreService();
	        Key userKey = KeyFactory.createKey("Users", user_id);
	        try {
		        Entity e = db.get(userKey);
		  		delayed = e.getProperty("delayed").toString();
		  		pending = e.getProperty("pending").toString();
		  		total = e.getProperty("total").toString();
	        } catch (EntityNotFoundException e) {
	       		//_logger.info(e.toString());
	       		resp.sendRedirect("/");
	        }
	    	resp.setContentType("application/json");
            PrintWriter writer = resp.getWriter();
            writer.write("{\"Delayed\":\""+delayed+"\",\"Pending\":\""+pending+"\",\"Total\":\""+total+"\"}");
            writer.close();	        
        } else/*logout. session expired.*/ resp.sendRedirect(userService.createLogoutURL("/"));
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
            if (validAddress(address)) {
	    		String user_id = user.getUserId();
	    		String username = user.getNickname();
	    		String email = user.getEmail();
	    		DatastoreService db = DatastoreServiceFactory.getDatastoreService();
	    	    Entity e = new Entity("Users", user_id);
	    	    e.setProperty("username", username);
	    	    e.setProperty("email", email);
	    	    e.setProperty("address", address);
	    	    e.setProperty("delayed", "0.00000000");
	    	    e.setProperty("pending", "0.00000000");
	    	    e.setProperty("total", "0.00000000");
	    		db.put(e);
	       		_logger.info("NEW User! " + username);
	        	resp.sendRedirect("/");
            } else resp.sendRedirect("/?error=invalidAddress");
        } else resp.sendRedirect("/?error=id");
	}
	
    private boolean validAddress(String s) {
	    if (s != null && (s.length() > 26 && s.length() < 35) && (s.startsWith("1") || s.startsWith("3")) && !s.contains("0") && !s.contains("O") && !s.contains("I") && !s.contains("l")) return true;
	    else return false;
    }
    
}