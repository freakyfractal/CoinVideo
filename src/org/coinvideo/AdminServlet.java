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
public class AdminServlet extends HttpServlet {

	private static final Logger _logger = Logger.getLogger(AdminServlet.class.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		String user_id = req.getParameter("id");
		if (user_id == null || user_id == "null") user_id = "N/A";
		double r = 0.00000000;
		String username = "N/A";
		String email = "N/A";
		String address = "N/A";
		String delayed = "0.00000000";
		double total_tmp = 0.00000000;
		
		_logger.info("[ADMIN PAYMENT] " + req.toString());
		DatastoreService db = DatastoreServiceFactory.getDatastoreService();
		Key userKey = KeyFactory.createKey("Users", user_id);

		try {

			Entity e = db.get(userKey);
			username = e.getProperty("username").toString();
			email = e.getProperty("email").toString();
			address = e.getProperty("address").toString();
			delayed = e.getProperty("delayed").toString();
			r = Double.parseDouble(e.getProperty("pending").toString());
			total_tmp = Double.parseDouble(e.getProperty("total").toString()) + r;

		} catch (EntityNotFoundException e) {

			System.out.println(e.toString());

		}

		Entity e = new Entity("Users", user_id);
		String pending = "0.00000000";
		String total = String.format("%.8f", total_tmp);

		e.setProperty("delayed", delayed);
		e.setProperty("username", username);
		e.setProperty("email", email);
		e.setProperty("address", address);
		e.setProperty("pending", pending);
		e.setProperty("total", total);
		db.put(e);

		resp.sendRedirect("/admin/admin.jsp");
	}

}