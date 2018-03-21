import java.util.Objects;

public class Store implements Comparable<Store>
{
  private final double latitude;
  private final double longitude;
  private final String name;
  private final String address;
  private final String category;
  private final String url;
  private int numOfSearches;
  
  public Store(double latitude, double longitude, String address, String category)
  {
    this.latitude = latitude;
    this.longitude = longitude;
    this.numOfSearches = 1;
    this.name = "";
    this.address = address;  
    this.category = category;
    this.url = "";
  } // Store
  
  public Store(double latitude, double longitude, int numOfSearches, String address)
  {
    this.latitude = latitude;
    this.longitude = longitude;
    this.numOfSearches = numOfSearches;
    this.name = "";
    this.address = address;
    this.category = "";
    this.url = "";
  } // Store
  
  public Store(double latitude, double longitude, String name, String address, 
      String category, String url)
  {
    this.latitude = latitude;
    this.longitude = longitude;
    this.numOfSearches = 1;
    this.name = name;
    this.address = address;
    this.category = category;
    this.url = url;
  } // Store
  
  public Store(double latitude, double longitude, int numOfSearches, 
      String name, String address, String category, String url)
  {
    this.latitude = latitude;
    this.longitude = longitude;
    this.numOfSearches = numOfSearches;
    this.name = name;
    this.address = address;
    this.category = category;
    this.url = url;
  } // Store
  
  public void incrementNumOfSearches()
  {
    numOfSearches++;
  } // incrementNumOfSearches
  
  public double getLatitude()
  {
    return latitude;
  } // getLatitude
  
  public double getLongitude()
  {
    return longitude;
  } // getLongitude
  
  public String getName()
  {
    return name;
  } // getName
  
  public String getAddress()
  {
    return address;
  } // getAddress
  
  public String getCategory()
  {
    return category;
  } // getCategory
  
  public String getUrl()
  {
    return url;
  } // getUrl
  
  public int getNumOfSearches()
  {
    return numOfSearches;
  } // getNumOfSearches
  
  @Override
  public String toString()
  {
    return getClass().getName()
        + "[latitude=" + latitude
        + ",longitude=" + longitude
        + ",address=" + address
        + ",numOfSearches=" + numOfSearches
        + "]";
  } // toString
  
  // Compare two Store objects based on their numOfSearches.
  @Override
  public int compareTo(Store other)
  {
    return other.numOfSearches - numOfSearches;
  } // compareTo
  
  @Override
  public boolean equals(Object otherObject)
  {
    if (this == otherObject) return true;
    if (otherObject == null) return false;
    if (getClass() != otherObject.getClass()) return false;
    Store other = (Store)otherObject;
    return latitude == other.latitude
        && longitude == other.longitude
        && address == other.address
        && numOfSearches == other.numOfSearches;
  } // equals
  
  @Override
  public int hashCode()
  {
    return Objects.hash(latitude, longitude, numOfSearches);
  } // hashCode
} // class Store