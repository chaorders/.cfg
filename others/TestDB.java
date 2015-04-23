//import	org.postgresql.*;
import  java.sql.*;

public   class  TestDB  {
    public  TestDB()  {
    } 
    public   static   void  main(String args[])
    {
        try 
         {
           Class.forName("org.postgresql.Driver").newInstance();
           String url = "jdbc:postgresql://localhost:5432/thomas" ;
           Connection con = DriverManager.getConnection(url, "thomas", "1234" );
           Statement st = con.createStatement();
           String sql1 = "select * from testtable;" ;
           ResultSet rs = st.executeQuery(sql1);
            while (rs.next())
            {
               System.out.print(rs.getInt( 1 ) + " ");
               System.out.println(rs.getString( 2 ) + " ");
            } 
            String sql2 = "insert into testtable values(4, 'Bonny');" ;
            st.executeUpdate(sql2);
            
           rs.close();
           st.close();
           con.close();
           

        } 
        catch (Exception ee)
        {
           System.out.print(ee.getMessage());
        } 
   } 
}
