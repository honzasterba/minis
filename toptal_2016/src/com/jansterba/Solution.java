package com.jansterba;

class Solution {

    public static void main(String[] args) {
        Solution s = new Solution();
        int[] A = new int[] { 5, 5, 1, 7, 2, 3, 5 };
        System.out.println(s.solution(5, A));
        System.out.println(s.solution(1, new int[] { 1 }));
        System.out.println(s.solution(2, new int[] { 1 }));
        System.out.println(s.solution(10, new int[] { 1, 2, 3, 4 }));
        System.out.println(s.solution(10, new int[] { 11, 12, 13, 14, 15, 16 }));
        System.out.println(s.solution(10, new int[] { 10, 10, 13, 14, 15, 10 }));
    }

    public int solution(int X, int[] A) {
        int nonEqualCount = 0;
        for (int a : A) {
            if (a != X) {
                nonEqualCount++;
            }
        }
        int i = 0;
        int equalCount = 0;
        while (equalCount != nonEqualCount) {
            if (A[i] == X) {
                equalCount++;
            } else {
                nonEqualCount--;
            }
            i++;
        }
        return i;
    }

}