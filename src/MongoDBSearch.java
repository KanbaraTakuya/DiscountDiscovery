import static com.mongodb.client.model.Filters.and;
import static com.mongodb.client.model.Filters.eq;
import static com.mongodb.client.model.Filters.gt;
import static com.mongodb.client.model.Filters.lt;

import java.util.Arrays;
import java.util.ArrayList;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

public class MongoDBSearch 
{
  public static void updateOnSearch(String username, double latitude, double longitude,
      String address, String category)
  {
    // Create an instance of MongoClient with the default credentials.
    MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
    
    // Get the database from the client.
    MongoDatabase db = mongoClient.getDatabase("comp10120db");
    
    // Get the collection instances.
    MongoCollection<Document> collectionHistory = db.getCollection("history");
    MongoCollection<Document> collectionUsers = db.getCollection("users");
    MongoCollection<Document> collectionStores = db.getCollection("stores");
    
    // Check if the store associated with the search being made exists in the Stores collection.
    MongoCursor<Document> storesCursor = 
        collectionStores.find(and(eq("latitude", latitude), eq("longitude", longitude))).iterator();
    
    // The store id to be used for creating an entry in the History collection.
    // 0 by default and will be fetched from the database later.
    int storeID = 0;
    
    // If the store already exists, increment the numOfSearches by one.
    if (storesCursor.hasNext())
    {
      Document theStore = storesCursor.next();
      storeID = theStore.getInteger("id");
      int numOfSearches = theStore.getInteger("numOfSearches");
      numOfSearches++;
      collectionStores.updateOne(eq("id", storeID), 
          new Document("$set", new Document("numOfSearches", numOfSearches)));
    } // if
    // If the store does not exist, create it and put it in the collection.
    else
    {
      storeID = (int)collectionStores.count();
      Document store = new Document("id", storeID)
          .append("latitude", latitude)
          .append("longitude", longitude)
          .append("address", address)
          .append("category", category)
          .append("numOfSearches", 1);
      collectionStores.insertOne(store);
    } // else
    
    // Populate the History collection with a new search history.
    Document history = new Document("id", (int)collectionHistory.count())
        .append("username", username)
        .append("storeid", storeID);
    
    collectionHistory.insertOne(history);
    
    // Check if the username exists in the User collection.
    MongoCursor<Document> usersCursor = 
        collectionUsers.find(eq("username", username)).iterator();
    
    int userId = 0;
    
    // If the user already exists in the Users collection.
    if (usersCursor.hasNext())
    {
      Document theUser = usersCursor.next();
      userId = theUser.getInteger("id");
      String numOfSearchesLocationsStr = theUser.getString("numOfSearchesLocations");
      String numOfSearchesAddressesStr = theUser.getString("numOfSearchesAddresses");
      String numOfSearchesNumbersStr = theUser.getString("numOfSearchesNumbers");
      String[] locationsStrs = numOfSearchesLocationsStr.split(" ");
      String[] addressesStrs = numOfSearchesAddressesStr.split(";");
      String[] numbersStrs = numOfSearchesNumbersStr.split(" ");
      Store[] stores = new Store[numbersStrs.length];
      
      // Check if the store already exists in the string.
      // If it does, the numOfSearches of it is incremented by one.
      // Else, it is added to the end of the string.
      boolean storeInString = false;
      
      if (stores.length > 0)
      {
        // Turn the array of strings to an array of Store objects.
        for (int index2 = 0; index2 < stores.length; index2++)
        {
          double storeLatitude = Double.parseDouble(locationsStrs[index2 * 2 + 0]);
          double storeLongitude =  Double.parseDouble(locationsStrs[index2 * 2 + 1]);
          String storeAddress = addressesStrs[index2];
          int storeNumOfSearches = Integer.parseInt(numbersStrs[index2]);
          stores[index2] = new Store(storeLatitude, storeLongitude, storeNumOfSearches, storeAddress);
          
          // Increment the numOfSearches by one if the store is the same as the one associated with
          // the new search history.
          if (storeAddress.equals(address))
          {
            stores[index2].incrementNumOfSearches();
            storeInString = true;
          } // if
        } // for
        
        // If the store does not exist in the string of numOfSearches,
        // it is added to the end of the string with the numOfSearches being initialised to 1.
        if (!storeInString)
        {
          stores = Arrays.copyOf(stores, stores.length + 1);
          stores[stores.length - 1] = new Store(latitude, longitude, 1, address);
        } // if
        // Else, sort the array to descending order of numOfSearches.
        else
        {
          Arrays.sort(stores);
        }
        
        // Use a StringBuilder to build up the string to replace the original one.
        StringBuilder locationsBuilder = new StringBuilder();
        StringBuilder addressesBuilder = new StringBuilder();
        StringBuilder numbersBuilder = new StringBuilder();
        for (int index2 = 0; index2 < stores.length - 1; index2++)
        {
          locationsBuilder.append(stores[index2].getLatitude() + " ");
          locationsBuilder.append(stores[index2].getLongitude() + " ");
          addressesBuilder.append(stores[index2].getAddress() + ";");
          numbersBuilder.append(stores[index2].getNumOfSearches() + " ");
        }
        // Append the strings of the last Store object in the array.
        locationsBuilder.append(stores[stores.length - 1].getLatitude() + " ");
        locationsBuilder.append(stores[stores.length - 1].getLongitude());
        addressesBuilder.append(stores[stores.length - 1].getAddress());
        numbersBuilder.append(stores[stores.length - 1].getNumOfSearches());
        
        collectionUsers.updateOne(eq("username", username), 
            new Document("$set", new Document("numOfSearchesLocations", locationsBuilder.toString())));
        collectionUsers.updateOne(eq("username", username), 
            new Document("$set", new Document("numOfSearchesAddresses", addressesBuilder.toString())));
        collectionUsers.updateOne(eq("username", username), 
            new Document("$set", new Document("numOfSearchesNumbers", numbersBuilder.toString())));
      } // if
    } // if
    // If the user does not exist in the Users collection.
    else
    {
      userId = (int)collectionUsers.count();
      Document user = new Document("id", userId)
          .append("username", username)
          .append("numOfSearchesLocations", latitude + " " + longitude)
          .append("numOfSearchesAddresses", address)
          .append("numOfSearchesNumbers", "" + 1);
      collectionUsers.insertOne(user);
    } // else
    
    // Close the connection.
    mongoClient.close();
  } // updateOnSearch
  
  public static Store[] getRecommendedStoresSorted(String username, double latitude, double longitude,
      int searchRadius, int maxNumOfResults)
  {
    // Create an instance of MongoClient with the default credentials.
    MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
    
    // Get the database from the client.
    MongoDatabase db = mongoClient.getDatabase("comp10120db");
    
    // Get the collection instances.
    MongoCollection<Document> collectionUsers = db.getCollection("users");
    MongoCollection<Document> collectionStores = db.getCollection("stores");
    
    // Check if the username exists in the User collection.
    MongoCursor<Document> usersCursor = 
        collectionUsers.find(eq("username", username)).iterator();
    
    // If the user already exists in the Users collection.
    if (usersCursor.hasNext())
    {
      Document theUser = usersCursor.next();
      String locationsStr = theUser.getString("numOfSearchesLocations");
      String[] storeInfoStrs = locationsStr.split(" ");

      int resultCounter = 0;
      
      // Use arraylist for keeping all the nearby stores.
      ArrayList<Store> stores = new ArrayList<>();
      
      for (int counter = 0; counter < storeInfoStrs.length / 2; counter++)
      {
        double storeLat = Double.parseDouble(storeInfoStrs[counter * 2 + 0]);
        double storeLng = Double.parseDouble(storeInfoStrs[counter * 2 + 1]);
        
        MongoCursor<Document> storesCursor = 
            collectionStores.find(
                eq("latitude", storeLat)).iterator();
        
        if (storesCursor.hasNext())
        {
          Document theStore = storesCursor.next();

          // If the store is at most 1km away from the user.
          if (distance(latitude, longitude, storeLat, storeLng) < searchRadius)
          {
            stores.add(new Store(storeLat, storeLng, theStore.getString("name"), 
                theStore.getString("address"), theStore.getString("category"), theStore.getString("url")));
            
            resultCounter++;
          } // if
        } // if
        //results[counter * 2 + 0] = Double.parseDouble(storeInfoStrs[counter * 2 + 0]);
        //results[counter * 2 + 1] = Double.parseDouble(storeInfoStrs[counter * 2 + 1]);
      } // for
      
      if (resultCounter > maxNumOfResults)
        resultCounter = maxNumOfResults;
      Store[] results = new Store[resultCounter];
      
      for (int index = 0; index < resultCounter; index++)
        results[index] = stores.get(index);

      mongoClient.close();
      
      return results;
    } // if
    else
    {
      Store[] allZeroes = new Store[0];
      
      mongoClient.close();
      return allZeroes;
    } // else
  } // getRecommendedStoresSorted
  
  public static Store[] getNearbyPopularStoresSorted(String username, double latitude, double longitude, 
      int searchRadius, int maxNumOfResults)
  {
    // Create an instance of MongoClient with the default credentials.
    MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
    
    // Get the database from the client.
    MongoDatabase db = mongoClient.getDatabase("comp10120db");
    
    // Get the collection instances.
    MongoCollection<Document> collectionUsers = db.getCollection("users");
    MongoCollection<Document> collectionStores = db.getCollection("stores");
    
    // Check if the username exists in the User collection.
    MongoCursor<Document> usersCursor = 
        collectionUsers.find(eq("username", username)).iterator();
    
    // If the user already exists in the Users collection.
    if (usersCursor.hasNext())
    {
      // Find the stores that are close enough to the user's currrent location.
      // In the radius of approximately 1km.
      /*
      MongoCursor<Document> theStores = 
          collectionStores.find(and(
              and(gt("latitude", latitude - 0.0064), 
              lt("latitude", latitude + 0.0064)), 
              and(gt("longitude", longitude - 0.0064), 
                  lt("longitude", longitude + 0.0064)))).iterator();
      */
      MongoCursor<Document> storesCursor = 
          collectionStores.find().iterator();
      
      // Use arraylist for keeping all the nearby stores.
      ArrayList<Store> stores = new ArrayList<>();
      
      while (storesCursor.hasNext())
      {
        Document theStore = storesCursor.next();
        double storeLat = theStore.getDouble("latitude");
        double storeLng = theStore.getDouble("longitude");

        // If the store is at most 500m away from the user.
        if (distance(latitude, longitude, storeLat, storeLng) < searchRadius)
        {
          stores.add(new Store(storeLat, storeLng, theStore.getString("name"), 
              theStore.getString("address"), theStore.getString("category"), theStore.getString("url")));
        } // if
      } // while

      // Sort the array of stores in descending order 
      Store[] storesSorted = null;

      if (stores != null && stores.size() > 0)
      {
        storesSorted = stores.toArray(new Store[0]);
        Arrays.sort(storesSorted);
      } // if
      
      // Return the top few stores as the result.
      int numOfResultStores = maxNumOfResults;
      if (storesSorted == null)
        numOfResultStores = 0;
      else if (storesSorted.length < maxNumOfResults)
        numOfResultStores = storesSorted.length;
      Store[] results = new Store[numOfResultStores];

      for (int index = 0; index < numOfResultStores; index++)
      {
        results[index] = storesSorted[index];
      }
      
      if (results.length == 0)
        results = new Store[0];

      return results;
    } // if
    else
    {
      Store[] allZeroes = new Store[0];
      
      mongoClient.close();
      return allZeroes;
    } // else
  } // getNearbyPopularStoresSorted
  
  public static Store[] getStoresByCategorySorted(String username, double latitude, double longitude, 
      String category, int searchRadius, int maxNumOfResults)
  {
    // Create an instance of MongoClient with the default credentials.
    MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
    
    // Get the database from the client.
    MongoDatabase db = mongoClient.getDatabase("comp10120db");
    
    // Get the collection instances.
    MongoCollection<Document> collectionUsers = db.getCollection("users");
    MongoCollection<Document> collectionStores = db.getCollection("stores");
    
    // Check if the username exists in the User collection.
    MongoCursor<Document> usersCursor = 
        collectionUsers.find(eq("username", username)).iterator();
    
    // If the user already exists in the Users collection.
    if (usersCursor.hasNext())
    {
      MongoCursor<Document> storesCursor = 
          collectionStores.find().iterator();
      
      // Use arraylist for keeping all the nearby stores.
      ArrayList<Store> stores = new ArrayList<>();
      
      while (storesCursor.hasNext())
      {
        Document theStore = storesCursor.next();
        double storeLat = theStore.getDouble("latitude");
        double storeLng = theStore.getDouble("longitude");
        String storeCategory = theStore.getString("category");

        // If the store is at most 2km away from the user.
        if (storeCategory.equals(category) && distance(latitude, longitude, storeLat, storeLng) < searchRadius)
        {
          stores.add(new Store(storeLat, storeLng, theStore.getString("name"), 
              theStore.getString("address"), storeCategory, theStore.getString("url")));
        } // if
      } // while
      
      // Sort the array of stores in descending order 
      Store[] storesSorted = null;

      if (stores != null && stores.size() > 0)
      {
        storesSorted = stores.toArray(new Store[0]);
        Arrays.sort(storesSorted);
      } // if
      
      // Return the top few stores as the result.
      int numOfResultStores = maxNumOfResults;
      if (storesSorted == null)
        numOfResultStores = 0;
      else if (storesSorted.length < maxNumOfResults)
        numOfResultStores = storesSorted.length;
      Store[] results = new Store[numOfResultStores];

      for (int index = 0; index < numOfResultStores; index++)
      {
        results[index] = storesSorted[index];
      }
      
      if (results.length == 0)
        results = new Store[0];

      return results;
    } // if
    else
    {
      Store[] allZeroes = new Store[0];
      
      mongoClient.close();
      return allZeroes;
    } // else
  } // getStoresByCategorySorted
  
  public static double distance(double lat1, double lng1, double lat2, double lng2) 
  {
    final double RADIUS  = 6371.01 * 1000; // Radius of the earth
    
    double lat1Rad = Math.toRadians(lat1);
    double lat2Rad = Math.toRadians(lat2);
    double latDistance = Math.toRadians(lat2 - lat1);
    double lonDistance = Math.toRadians(lng2 - lng1);
    
    double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
        + Math.cos(lat1Rad) * Math.cos(lat2Rad)
        * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    double distance = RADIUS * c; // convert to meters
    
    return distance;
  } // distance
} // class MongoDBSearch