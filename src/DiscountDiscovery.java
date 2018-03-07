import static com.mongodb.client.model.Filters.and;
import static com.mongodb.client.model.Filters.eq;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.Arrays;

import org.bson.Document;

/**
 * Servlet implementation class DiscountDiscovery
 */
@WebServlet(name ="DiscountDiscovery", urlPatterns ={"/DiscountDiscovery"})
public class DiscountDiscovery extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DiscountDiscovery() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		System.out.println("Request received");
		System.out.println("request.getParameter(usernameNearbySearch): " + request.getParameter("usernameNearbySearch"));
		System.out.println("request.getParameter(isUserRecommendation): " + request.getParameter("isUserRecommendation"));
		System.out.println("request.getParameter(isNearbySearch): " + request.getParameter("isNearbySearch"));
		
		if (request.getParameter("usernameUserRecommendation") != null
        && request.getParameter("usernameUserRecommendation") != ""
		    && request.getParameter("isUserRecommendation") != null
        && request.getParameter("isUserRecommendation").equals("true"))
    {
      try {
        Long startTime = System.nanoTime();
        
        HttpSession session = request.getSession(true);
        
        session.setAttribute("loading", true);
        
        int numOfRecommendations = 0;
        double[] results = null;
        
        String username = request.getParameter("usernameUserRecommendation");
        
        if (request.getParameter("numOfRecommendations") != null)
          numOfRecommendations = Integer.parseInt(request.getParameter("numOfRecommendations"));
        
        if (numOfRecommendations == 0)
          results = MongoDBSearch.getAllSearchedStoresSorted(username);
        else
          results = MongoDBSearch.getRecommendedStoresSorted(username, numOfRecommendations);
        
        Long endTime = System.nanoTime();
        
        System.out.println("Username: " + username);
        System.out.println(Arrays.toString(results));
        
        if (session != null) 
        {
          session.setAttribute("userRecommendations", results);
          session.setAttribute("nearbyStores", null);
        } // if
      } // try
      catch (Exception exception) {
        
      } // catch
    } // if
    else if (request.getParameter("usernameNearbySearch") != null
        && request.getParameter("usernameNearbySearch") != ""
        && request.getParameter("isNearbySearch") != null
        && request.getParameter("isNearbySearch").equals("true"))
    {
      try {
        Long startTime = System.nanoTime();
        
        HttpSession session = request.getSession(true);
        
        session.setAttribute("loading", true);
        
        double latitude = 0.0;
        double longitude = 0.0;
        double[] results = null;
        
        String username = request.getParameter("usernameNearbySearch");
        
        if (request.getParameter("latNearbySearch") != null)
          latitude = Double.parseDouble(request.getParameter("latNearbySearch"));
        if (request.getParameter("lngNearbySearch") != null)
          longitude = Double.parseDouble(request.getParameter("lngNearbySearch"));
        
        results = MongoDBSearch.nearbySearch(username, latitude, longitude);
        
        Long endTime = System.nanoTime();
        
        System.out.println("Username: " + username);
        System.out.println(Arrays.toString(results));
        
        if (session != null) 
        {
          session.setAttribute("userRecommendations", null);
          session.setAttribute("nearbyStores", results);
        } // if
      } // try
      catch (Exception exception) {
        
      } // catch
    } // else if
		response.setHeader("Refresh", "0; URL=http://localhost:8080/DiscountDiscovery/index.jsp");
	} // doPost

} // class DiscountDiscovery
