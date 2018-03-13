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
		System.out.println("request.getParameter(usernameUserRecommendation): " + request.getParameter("usernameUserRecommendation"));
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
        
        int maxNumOfRecommendations = 0;
        Store[] resultStores = null;
        
        String username = request.getParameter("usernameUserRecommendation");
        double latitude = 0.0;
        double longitude = 0.0;
        
        if (request.getParameter("maxNumOfResultsUserRecommendation") != null)
          maxNumOfRecommendations = Integer.parseInt(request.getParameter("maxNumOfResultsUserRecommendation"));

        if (request.getParameter("latUserRecommendation") != null)
          latitude = Double.parseDouble(request.getParameter("latUserRecommendation"));
        if (request.getParameter("lngUserRecommendation") != null)
          longitude = Double.parseDouble(request.getParameter("lngUserRecommendation"));
        
        if (maxNumOfRecommendations == 0)
          resultStores = MongoDBSearch.getRecommendedStoresSorted(username, 
              latitude, longitude, 0);
        else
          resultStores = MongoDBSearch.getRecommendedStoresSorted(username, 
              latitude, longitude, maxNumOfRecommendations);

        double[] locations = new double[resultStores.length * 2];
        String[] names = new String[resultStores.length];
        String[] addresses = new String[resultStores.length];
        String[] categories = new String[resultStores.length];
        for (int index = 0; index < resultStores.length; index++)
        {
          locations[index * 2] = resultStores[index].getLatitude();
          locations[index * 2 + 1] = resultStores[index].getLongitude();
          names[index] = resultStores[index].getName();
          addresses[index] = resultStores[index].getAddress();
          categories[index] = resultStores[index].getCategory();
        } // for

        Long endTime = System.nanoTime();
        
        if (session != null) 
        {
          session.setAttribute("locationsUserRecommendation", locations);
          session.setAttribute("namesUserRecommendation", names);
          session.setAttribute("addressesUserRecommendation", addresses);
          session.setAttribute("categoriesUserRecommendation", categories);
          session.setAttribute("locationsNearby", null);
          session.setAttribute("namesNearby", null);
          session.setAttribute("addressesNearby", null);
          session.setAttribute("categoriesNearby", null);
          session.setAttribute("loading", false);
        } // if
        
        System.out.println("Username: " + username);
        System.out.println("locations: " + Arrays.toString(locations));
        System.out.println("names: " + Arrays.toString(names));
        System.out.println("addresses: " + Arrays.toString(addresses));
        System.out.println("categories: " + Arrays.toString(categories));
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
        
        String username = "";
        double latitude = 0.0;
        double longitude = 0.0;
        int maxNumOfResults = 0;
        Store[] resultStores = null;
        
        username = request.getParameter("usernameNearbySearch");
        
        if (request.getParameter("latNearbySearch") != null)
          latitude = Double.parseDouble(request.getParameter("latNearbySearch"));
        if (request.getParameter("lngNearbySearch") != null)
          longitude = Double.parseDouble(request.getParameter("lngNearbySearch"));
        
        if (request.getParameter("maxNumOfResultsNearbySearch") != null)
          maxNumOfResults = Integer.parseInt(request.getParameter("maxNumOfResultsNearbySearch"));
        System.out.println("maxNumOfResults: " + maxNumOfResults);
        
        resultStores = MongoDBSearch.nearbySearch(username, latitude, longitude, maxNumOfResults);
        
        double[] locations = new double[resultStores.length * 2];
        String[] names = new String[resultStores.length];
        String[] addresses = new String[resultStores.length];
        String[] categories = new String[resultStores.length];
        for (int index = 0; index < resultStores.length; index++)
        {
          locations[index * 2] = resultStores[index].getLatitude();
          locations[index * 2 + 1] = resultStores[index].getLongitude();
          names[index] = resultStores[index].getName();
          addresses[index] = resultStores[index].getAddress();
          categories[index] = resultStores[index].getCategory();
        } // for
        
        Long endTime = System.nanoTime();
        
        if (session != null) 
        {
          session.setAttribute("locationsUserRecommendation", null);
          session.setAttribute("namesUserRecommendation", null);
          session.setAttribute("addressesUserRecommendation", null);
          session.setAttribute("categoriesUserRecommendation", null);
          session.setAttribute("locationsNearby", locations);
          session.setAttribute("namesNearby", names);
          session.setAttribute("addressesNearby", addresses);
          session.setAttribute("categoriesNearby", categories);
          session.setAttribute("loading", false);
        } // if
        
        System.out.println("Username: " + username);
        System.out.println("locations: " + Arrays.toString(locations));
        System.out.println("names: " + Arrays.toString(names));
        System.out.println("addresses: " + Arrays.toString(addresses));
        System.out.println("categories: " + Arrays.toString(categories));
      } // try
      catch (Exception exception) {
        
      } // catch
    } // else if
		response.setHeader("Refresh", "0; URL=http://localhost:8080/DiscountDiscovery/index.jsp");
	} // doPost

} // class DiscountDiscovery
