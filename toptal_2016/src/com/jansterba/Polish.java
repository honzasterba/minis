package com.jansterba;

public class Polish {

    /*
    2 1 + => 3
    5 5 + 3 * => 10 3 * => 30

    "5 2 + 3 *" => 21
    "5 2 * 2 * 4 +" => 24
    "5" => 5
    "0 1 *" => 0
     */

    public static void main(String[] args) {
        Polish p = new Polish();
        System.out.println(p.solve("2 1 +"));
        System.out.println(p.solve("5 5 + 3 *"));
        System.out.println(p.solve("5 2 + 3 *"));
        System.out.println(p.solve("5 2 * 2 * 4 +"));
        System.out.println(p.solve("5"));
        System.out.println(p.solve("0 1 *"));
    }

    public int solve(String expression) {
        String[] ops = expression.split(" ");
        int stack = Integer.parseInt(ops[0]);
        int i = 1;
        while (i < ops.length-1) {
            int number = Integer.parseInt(ops[i]);
            String operator = ops[i+1];
            if (operator.equals("+")) {
                stack += number;
            } else {
                stack *= number;
            }
            i += 2;
        }
        return stack;
    }

}
