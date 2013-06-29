<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>CoinVideo - Earn FREE Bitcoins Watch Viral Videos!</title>
	<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<%@ page import="com.google.appengine.api.users.User" %>
	<%@ page import="com.google.appengine.api.users.UserService" %>
	<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
	<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
	<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
	<%@ page import="com.google.appengine.api.datastore.Entity" %>
	<%@ page import="com.google.appengine.api.datastore.EntityNotFoundException" %>
	<%@ page import="com.google.appengine.api.datastore.Key" %>
	<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<link rel="shortcut icon" href="/img/favicon.png">
	<link rel="stylesheet" href="/css/south-street/jquery-ui.css" />
	<link rel="stylesheet" href="/css/ui-extras.css" />
	<link rel="stylesheet" href="/css/main.css" />
	
</head>
<body>
<div style="width:732px;margin:0 auto;">
	<%
  UserService userService = UserServiceFactory.getUserService();
  User user = userService.getCurrentUser();
  if (user != null) {
		String user_id = user.getUserId();
    DatastoreService db = DatastoreServiceFactory.getDatastoreService();
    Key userKey = KeyFactory.createKey("Users", user_id);
    boolean newUser = true;
    try {
   		Entity e = db.get(userKey);
   		newUser = false;
    } catch (EntityNotFoundException e) {
			//newUser().. newUser = true;
   		System.out.println(e.toString());
    }
    if (newUser == true) {
	    %>
			<div id="walletDialog">
			  <form action="/users" method="post" id="walletForm">
			  	<label>Send Bitcoins to ...</label><br>
			    <input type="text" name="address" size="34">
			    <input type="hidden" name="user_id" value="<%= user_id %>">
			  </form>
			</div>
	    <%
    } else {
      Entity e = db.get(userKey);
			String address = e.getProperty("address").toString();
			String delayed = e.getProperty("delayed").toString();
			String pending = e.getProperty("pending").toString();
			String total = e.getProperty("total").toString();
			%>
			<div id="changeWalletDialog" style="display: none;">
			  <form action="/wallet" method="post" id="changeWalletForm">
			  	<label>Send Bitcoins to ...</label><br>
			    <input type="text" name="address" size="34">
			    <input type="hidden" name="user_id" value="<%= user_id %>">
			  </form>
			</div>
			<div id="dialog" style="display: none;">
				<div style="text-align:left;font-size:12px;"><br><div style="float:left;"><strong><%= address %></strong>&nbsp;</div><div style="float:left;text-decoration:underline;cursor:pointer;" id="changeWalletLink">change</div></div>
				<div style="text-align:left;font-size:12px;"><br><br>Delayed: <em><%= delayed %> BTC</em></div>
				<div style="text-align:left;font-size:12px;">Pending: <em><%= pending %> BTC</em></div>
				<div style="text-align:left;font-size:12px;">Total Sent: <em><%= total %> BTC</em></div>
				<div style="text-align:left;font-size:12px;"><br><br><span style="color: red;">NOTE!</span> <em><strong>Please be patient</strong> as we are still in BETA testing.</em></div>
			  <form action="/withdraw" method="post" id="withdrawForm"></form>
			</div>
			
			<div id="displayBalance"></div>
			<div style="position:absolute;top:6px;right:10px;">
				<div><div id="mainBalance" style="float:left;margin-right:3px;"></div> BTC - <a style="text-decoration:none;" title="Logged in: <%= user %>" href="<%= userService.createLogoutURL(request.getRequestURI()) %>">logout</a>&nbsp;</div>
			</div>

	    <%
    }
	%>
	<!-- TODO: setAttribute("address") -->
	<div id="reloadFrame" style="position:absolute;top:5px;color:rgb(51, 102, 153);cursor:pointer;text-decoration:underline;text-align:right;width:689px;">reload videos</div>
	<div style="margin:20px 0 0 2px;height:590px;width:687px;">
		<iframe style="background: transparent" allowtransparency="true" id="myFrame"  width="687" height="590" 
		src="http://api.virool.com/offers/wall/2d384d3bc86bbccb854520986395c2d5?suid=<%= user_id %>" frameborder="0" marginwidth="0" marginheight="0" scrolling="yes"></iframe>
		<div style="clear: both;"></div>
	</div>
	
	<%

  } else {
	%>
	<p id="google_signin" style="color:#333;">
		<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
		with a Google account to earn bitcoins <em>watching videos!</em>
		<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">
			<img src="/images/google_signin.png" style="margin: 0 0 -5px 30px;">
		</a>
	</p>
	
	<div style="padding-top:40px;height:410px;width:728px;">
		<iframe style="background: transparent" allowtransparency="true" id="myFrame"  width="728" height="410" 
		src="http://api.virool.com/widgets/2d384d3bc86bbccb854520986395c2d5?suid=N%2FA&autoswitch=1" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
		<div style="clear: both;"></div>
	</div>

		<div id="dialogGettingStarted" style="text-align:justify;font-size:small;font-family: Helvetica;">
			<blockquote>
				<strong>Step 1. Get a Wallet.</strong> You can get a wallet many different ways, 
				we recommend you check out <a  target="_blank" href="https://blockchain.info/wallet/">BlockChain.info</a> 
				if you need a <strong><em>free</em></strong> wallet service. Once you have a 
				wallet you will have an address. Your address will be some long string, for example 
				<strong><code>1BKSD6BMtVPNrXtQcpoH6aA4GHjAcWeeYN</code></strong> …
			</blockquote>
			<blockquote>
				<strong>Step 2. Get Free Bitcoins.</strong> Just log in to start winning Bitcoins the 
				fun, easy way: <em>¡Watching <a target="_blank" href="https://www.virool.com/advertiser?rc=fd7b38f5"><strong>viral</strong> 
				videos</a>!</em> …
			</blockquote>
			<div style="text-align:right;"><br><div id="moreInfoLink" style="cursor:pointer;float:left;color:grey;"><br>... more</div>&nbsp;&nbsp;&nbsp;<a href="<%= userService.createLoginURL(request.getRequestURI()) %>"><button class="ui-dialog-buttonpane ui-state-focus ui-corner-all" style="width:50%;text-align:center;">Log In NOW!</button></a></div>
		</div>
		<div id="dialogMoreInfo" style="text-align:center;font-size:small;font-family: Helvetica;display:none;">
			<blockquote>
				<br><a href="http://www.bitvisitor.com/?ref=1BKSD6BMtVPNrXtQcpoH6aA4GHjAcWeeYN">BitVisitor</a> | <a href="http://coinofmidas.com/?r=bitcoingratis">Coin Of Midas</a><br>
				<br><a href="http://bitcoininformation.appspot.com/?ref=1BKSD6BMtVPNrXtQcpoH6aA4GHjAcWeeYN">Bitcoin Information</a> | <a href="http://www.coinvisitor.com">CV</a> +<a href="http://www.coinvisitor.com/chat">CHAT</a> | <a href="http://dailybitcoins.org/">Daily Bitcoin</a><br>
				<br><a href="https://bitcoinaddict.com">BitAddict</a> | <a href="http://sealswithclubs.eu">SealsWithClubs</a> | <a href="http://bitvegas.net">BitVegas</a><br> 
			</blockquote>
		</div>
	<%
  }
	%>
</div>


<div style="position:absolute;bottom:5px;right:10px;">
	<div><span style="color:red;font-weight:bold;font-style:italic;">NEW!</span> <em>Join our community CHAT on IRC!</em> <a target="_blank" href="chat.jsp">new tab</a></div>
</div>
<a target="_blank" href="https://github.com/coinpr0n/CoinVideo"><img style="position: absolute; top: 0; left: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_left_white_ffffff.png" alt="Fork me on GitHub"></a>


<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-40760257-1', 'coinvideo.appspot.com');
  ga('send', 'pageview');

</script>
<script src="http://code.jquery.com/jquery-2.0.2.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script src="/js/ui.js"></script>
<script src="/js/users.js"></script>
	
</body>
</html>
