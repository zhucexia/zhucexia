package com.keji50.zhucexia.dao.datasource;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;
 
public class CustomerRoutingDataSource extends AbstractRoutingDataSource {
 
   @Override
   protected Object determineCurrentLookupKey() {
      return CustomerContextHolder.getCustomerType();
   }
}