package com.honzasterba.dbfcoef;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;


public class DbCoef {
	
	static {
		try {
			Class.forName("com.hxtt.sql.dbf.DBFDriver");
		} catch (ClassNotFoundException e) {
			System.out.println("Cannot load driver.");
			e.printStackTrace();
		}
	}
	
	public static void run(String path, float coef) throws Exception {
		Connection c = DriverManager.getConnection("jdbc:dbf:///"+path);
		Statement s = c.createStatement();
		s.executeUpdate("UPDATE mp.dbf SET CENA_MONT = CENA_MONT  * " + coef + ", CENA_DEM = CENA_DEM * " + coef);
		s.close();
	}
}
