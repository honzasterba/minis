#!/bin/ruby

def cnt(n, c, m)
  store = Array.new(n+1) do
    Array.new(m+1) do
      -1
    end
  end
  ways(store, n, c, m)
end

def ways(store, n, c, m)
  if n == 0
    return 1
  elsif n < 0
    return 0
  elsif m <= 0
    return 0
  elsif store[n][m] == -1
    store[n][m] = ways(store, n, c, m-1) + ways(store,n - c[m-1], c, m)
  end
  store[n][m]
end

def read_input(stream)
  n = stream.gets.strip.split(' ')[0].to_i
  c = stream.gets.strip.split(' ').map(&:to_i)
# Print the number of ways of making change for 'n' units
# using coins having the values given by 'c'
  return n, c
end

def main
  n, c = read_input(STDIN)
  puts cnt(n, c, c.size)
end
