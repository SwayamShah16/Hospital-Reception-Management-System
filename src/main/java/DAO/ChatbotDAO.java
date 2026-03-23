package DAO;

import java.sql.*;
import java.util.*;

import Connection.GetConnection;

public class ChatbotDAO {

    public Map<String, String> getAllFAQs() {

        Map<String, String> map = new HashMap<>();

        try {
            Connection con = GetConnection.getConnection();

            String sql = "SELECT question, answer FROM chatbot_faq";
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                map.put(rs.getString("question"), rs.getString("answer"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }
}