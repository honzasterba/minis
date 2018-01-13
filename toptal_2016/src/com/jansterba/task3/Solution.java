package com.jansterba.task3;

import java.util.Arrays;

class Solution {

    static Solution s = new Solution();

    public static void main(String [] a) {
        test(new int[] {1});
        test(new int[] {0});
        test(new int[] {1,1});
        test(new int[] {1,0,0,1,1});
        test(new int[] {1,0,0,1,1,1});
        test(new int[] {1,1,1,1,1,1,1,1,1,1,1});
        test(new int[] {0,1,0,1,0,1,0,1,0,1,0});
        test(new int[] {1,0,1,0,1,0,1,0,1,0,1});
    }

    public static void test(int[] a) {
        System.out.print(s.toDecimal(a) + " ");
        print(s.solution(a));
        System.out.println(" " + s.toDecimal(s.solution(a)));
    }

    public static void print(int[] a) {
        for (int x : a ) {
            System.out.print(x);
        }
    }

    public int[] solution(int[] A) {
        int M = toDecimal(A);
        M = -M;
        int[] result = new int[A.length];
        int i = 0;
        while (M != 0) {
            int mod = M % -2;
            if (mod < 0) {
                result[i] = 1;
                M -= 1;
            } else {
                result[i] = mod;
            }
            M /= -2;
            i++;
            if (i == result.length) {
                result = Arrays.copyOf(result, result.length*2);
            }
        }
        return result;
    }

    public int toDecimal(int[] A) {
        int M = 0;
        int base = 1;
        for (int bit : A) {
            M += bit * base;
            base *= -2;
        }
        return M;
    }

}