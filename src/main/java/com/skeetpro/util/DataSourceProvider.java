package com.skeetpro.util;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DataSourceProvider {
    
    private static DataSource dataSource;

    static {
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/skeetpro");
        } catch (NamingException e) {
            System.err.println("Errore: Impossibile trovare il DataSource JNDI 'jdbc/skeetpro'!");
            e.printStackTrace();
        }
    }

    private DataSourceProvider() {}

    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("Il DataSource non è stato inizializzato correttamente.");
        }
        return dataSource.getConnection();
    }
}
