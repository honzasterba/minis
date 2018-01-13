package com.jansterba;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class Domino {

    public static void main(String[] args) throws IOException {
        List<Integer> result = new Domino().domino();
        for (Integer i : result) {
            System.out.println(i);
        }

    }

    public List<Integer> domino() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream("s.txt")));
        String line;
        List<Integer> results = new ArrayList<>();
        while ((line = reader.readLine()) != null) {
            int longestStreak = 1;
            int currentStreak = 1;
            String lastRight = line.substring(2, 3);
            for (int tileIndex = 1; tileIndex*4 < line.length(); tileIndex++) {
                int tileStart = tileIndex*4;
                String left = line.substring(tileStart, tileStart+1);
                String right = line.substring(tileStart+2, tileStart+3);
                if (left.equals(lastRight)) {
                    currentStreak++;
                } else if (currentStreak > longestStreak) {
                    longestStreak = currentStreak;
                    currentStreak = 1;
                }
                lastRight = right;
            }
            if (currentStreak > longestStreak) {
                longestStreak = currentStreak;
            }
            results.add(longestStreak);
        }
        return results;
    }
}
