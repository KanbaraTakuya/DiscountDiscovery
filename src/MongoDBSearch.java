import static com.mongodb.client.model.Filters.and;
import static com.mongodb.client.model.Filters.eq;

import java.util.Arrays;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

public class MongoDBSearch 
{
  public static double[] getAllSearchedStoresSorted(String username)
  {
    // Create an instance of MongoClient with the default credentials.
    MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
    
    // Get the database from the client.
    MongoDatabase db = mongoClient.getDatabase("testdb");
    
    // Get the collection instances.
    MongoCollection<Document> collectionUsers = db.getCollection("users");
    
    // Check if the username exists in the User collection.
    MongoCursor<Document> theUsers = 
        collectionUsers.find(eq("username", username)).iterator();
    
    // If the user already exists in the Users collection.
    if (theUsers.hasNext())
    {
      Document theUser = theUsers.next();
      String storesStr = theUser.getString("numOfSearchesStores");
      String[] storeInfoStrs = storesStr.split(" ");
      int numOfStores = storeInfoStrs.length / 2;
      
      double[] results = new double[numOfStores * 2];
      for (int counter = 0; counter < numOfStores; counter++)
      {
        results[counter * 2 + 0] = Double.parseDouble(storeInfoStrs[counter * 2 + 0]);
        results[counter * 2 + 1] = Double.parseDouble(storeInfoStrs[counter * 2 + 1]);
      } // for
      
      mongoClient.close();
      
      return results;
    } // if
    else
    {
      double[] allZeroes = new double[2];
      for (double number : allZeroes)
        number = 0.0;
      
      mongoClient.close();
      return allZeroes;
    } // else
  } // getAllSearchedStoresSorted
  
  public static double[] getRecommendedStoresSorted(String username, int numOfStores)
  {
    // Create an instance of MongoClient with the default credentials.
    MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
    
    // Get the database from the client.
    MongoDatabase db = mongoClient.getDatabase("testdb");
    
    // Get the collection instances.
    MongoCollection<Document> collectionUsers = db.getCollection("users");
    
    // Check if the username exists in the User collection.
    MongoCursor<Document> theUsers = 
        collectionUsers.find(eq("username", username)).iterator();
    
    // If the user already exists in the Users collection.
    if (theUsers.hasNext())
    {
      Document theUser = theUsers.next();
      String storesStr = theUser.getString("numOfSearchesStores");
      String[] storeInfoStrs = storesStr.split(" ");

      int numOfResultStores = numOfStores;
      int numOfavailableStores = storeInfoStrs.length / 2;
      if (numOfStores > numOfavailableStores)
        numOfResultStores = numOfavailableStores;
      
      double[] results = new double[numOfResultStores * 2];
      for (int counter = 0; counter < numOfResultStores; counter++)
      {
        results[counter * 2 + 0] = Double.parseDouble(storeInfoStrs[counter * 2 + 0]);
        results[counter * 2 + 1] = Double.parseDouble(storeInfoStrs[counter * 2 + 1]);
      } // for
      
      mongoClient.close();
      
      return results;
    } // if
    else
    {
      double[] allZeroes = new double[numOfStores * 2];
      for (double number : allZeroes)
        number = 0.0;
      
      mongoClient.close();
      return allZeroes;
    } // else
  } // getUserRecommendation
} // class MongoDBSearch