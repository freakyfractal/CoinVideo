<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.EntityNotFoundException" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery" %>

<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<link rel="shortcut icon" href="/img/favicon.png">
	<title>CoinVideo - Earn FREE Bitcoins Watch Viral Videos!</title>

	<!-- <link type="text/css" rel="stylesheet" href="/css/main.css" />
	<link type="text/css" rel="stylesheet" href="/css/default-jquery-ui.css" /> -->
	<!-- <link type="text/css" rel="stylesheet" href="/css/pepper-grinder/jquery-ui.css" /> -->

	<script src="http://code.jquery.com/jquery-2.0.2.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	
	<script type="text/javascript" src="/js/jquery.tablesorter.js"></script> 

	<script src="/js/admin.js"></script>
<style>
body{
	font:14px/20px 'Helvetica', Arial, sans-serif;
	padding:0;
	text-align: center;
}
a:link,a:active,a:visited,a{
	color:#336699;
}
table {width:100%;}
thead {cursor:pointer;}
</style>
</head>
<body>
<%
  DatastoreService db = DatastoreServiceFactory.getDatastoreService();
	Query q = new Query("Users");
  FetchOptions opts = FetchOptions.Builder.withDefaults();
  List<Entity> delayedList = new ArrayList<Entity>();
  List<Entity> pendingList = new ArrayList<Entity>();
  double delayedTotal = 0.00000000;
  double pendingTotal = 0.00000000;
  double sentTotal = 0.00000000;
  List<Entity> users = db.prepare(q).asList(opts);
	for (Entity result : users) {
		if (result.getProperty("username").toString().equals("N/A")) {/*delayedList.add(result);*/}
		else {
		  double delayedDouble = Double.parseDouble((String) result.getProperty("delayed"));
		  double pendingDouble = Double.parseDouble((String) result.getProperty("pending"));
		  double sentDouble = Double.parseDouble((String) result.getProperty("total"));
			if (pendingDouble > 0) {
				pendingTotal += pendingDouble;
				pendingList.add(result);
			} else {
				delayedTotal += delayedDouble;
				delayedList.add(result);
			}
			sentTotal += sentDouble;
		}
	}
	String str_sent = String.format("%.8f", sentTotal);
	String str_pending = String.format("%.8f", pendingTotal);
	String str_delayed = String.format("%.8f", delayedTotal);
	int num_pending = pendingList.size();
	int num_delayed = delayedList.size();
	%>
	<div style="margin: 0 0 20px 0;border:1px solid;border-top:none;padding:5px;"><strong>Pending</strong> (<%= num_pending %>): <span style="color:orange;"><%= str_pending %> BTC</span> | <strong>Delayed</strong> (<%= num_delayed %>): <%= str_delayed %> BTC</div>
	<div style="width:100%;margin:0 auto;">
		<table id="myTable" class="tablesorter">
		<thead>
		<tr>
			<th>Total</th>
			<th>Username</th>
			<th>Pending</th>
			<th>Delayed</th>
			<th>Address</th>
			<th>Actions</th>
		</tr>
		</thead>
		<tbody>
	<%
	for (Entity user : pendingList) {
			String user_id = user.getKey().getName();
		  String username = (String) user.getProperty("username");
		  String address = (String) user.getProperty("address");
			String delayed = (String) user.getProperty("delayed");
			String pending = (String) user.getProperty("pending");
			String total = (String) user.getProperty("total");
		  %>
		  <tr>
		  	<td><%= total %></div> 
		  	<td><a style="text-decoration:none;" href="-virool-id=user_id"><%= username %></a></td> 
			  <td><span style="color:orange;font-weight:bold;"><%= pending %></span></td>
			  <td><%= delayed %></td>
			  <td><strong><%= address %></strong></td>
			  <td><a href="pay?id=<%= user_id %>">confirm</a></td>
		  </tr>
		  <%
	}
	for (Entity user : delayedList) {
		  String username = (String) user.getProperty("username");
		  String address = (String) user.getProperty("address");
			String delayed = (String) user.getProperty("delayed");
			String pending = (String) user.getProperty("pending");
			String total = (String) user.getProperty("total");
		  %>
		  <tr>
		  	<td><%= total %></div> 
		  	<td><a style="text-decoration:none;" href="pay?id=NA"><%= username %></a></td> 
			  <td><%= pending %></td>
			  <td><%= delayed %></td>
			  <td><strong><%= address %></strong></td>
 			  <td>&nbsp;</td>
		  </tr>
		  <%
	}
	%>
		</tbody>
		</table>
		<div style="clear:both;"></div>
	</div>
	<div style="margin:20px 0;border:1px solid;border-bottom:none;padding:5px;">Total: (<%= num_pending + num_delayed %> Users) · Sent: <%= str_sent %> BTC</div>
</body>
</html>
