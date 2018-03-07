import java.util.Objects;

public class Store implements Comparable<Store>
{
  private final double latitude;
  private final double longitude;
  private final String address;
  private final String category;
  private int numOfSearches;
  
  public Store(double latitude, double longitude, int numOfSearches, String address)
  {
    this.latitude = latitude;
    this.longitude = longitude;
    this.numOfSearches = numOfSearches;
    this.address = address;
    this.category = "";
  } // Store
  
  public Store(double latitude, double longitude, int numOfSearches, String address, String category)
  {
    this.latitude = latitude;
    this.longitude = longitude;
    this.numOfSearches = numOfSearches;
    this.address = address;
    this.category = category;
  } // Store
  
  public void incrementNumOfSearches()
  {
    numOfSearches++;
  } // incrementNumOfSearches
  
  public double getLatitude()
  {
    return latitude;
  }
  
  public double getLongitude()
  {
    return longitude;
  }
  
  public String getAddress()
  {
    return address;
  }
  
  public String getCategory()
  {
    return category;
  }
  
  public int getNumOfSearches()
  {
    return numOfSearches;
  }
  
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