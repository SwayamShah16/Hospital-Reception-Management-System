package Service;

import java.util.*;
import DAO.ChatbotDAO;

public class ChatbotService {

    private ChatbotDAO dao = new ChatbotDAO();

    public String getResponse(String userMessage) {

        userMessage = userMessage.toLowerCase();

        Map<String, String> faq = dao.getAllFAQs();

        String bestMatch = null;
        int maxScore = 0;

        for (String question : faq.keySet()) {

            int score = calculateMatchScore(userMessage, question);

            if (score > maxScore) {
                maxScore = score;
                bestMatch = question;
            }
        }

        if (maxScore > 1) {
            return faq.get(bestMatch);
        }

        return "Sorry, I didn't understand. Try asking about appointments, doctors, or timing.";
    }

    // 🔥 Matching Logic
    private int calculateMatchScore(String input, String storedQuestion) {

        String[] inputWords = input.split(" ");
        String[] dbWords = storedQuestion.split(" ");

        int score = 0;

        for (String word1 : inputWords) {
            for (String word2 : dbWords) {
                if (word1.equals(word2)) {
                    score++;
                }
            }
        }

        return score;
    }
}