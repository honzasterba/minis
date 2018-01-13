def read_tests(input)
  num_tests = input.gets.to_i
  tests = []
  num_tests.times do
    tests << read_test(input)
  end
  tests
end

def read_test(input)
  num_containers, num_queries = read_two_ints(input)
  queries = []
  num_queries.times do
    queries << read_two_ints(input)
  end
  { containers: num_containers, queries: queries }
end

def read_two_ints(input)
  input.gets.split(" ").collect { |n| n.to_i }
end


def compute_distances(inputs)
  inputs.collect do |input|
    find_minimum_distance input
  end
end

def find_minimum_distance(input)
  queries = input[:queries]
  m = input[:containers]
  dp = Array.new(queries.length+1) do
    Array.new(m) do
      Array.new(m) do
        0
      end
    end
  end
  (1..queries.length).each do |i|
    options_a = []
    options_b = []
    query = queries[i-1]
    m.times do |j|
      m.times do |k|
        options_a << dp[i-1][j][k] + (j - query[0]-1).abs
        options_b << dp[i-1][j][k] + (k - query[0]-1).abs
      end
    end
    m.times do |jk|
      dp[i][query[1]-1][jk] = options_a.min + query_distance(query)
      dp[i][jk][query[1]-1] = options_b.min + query_distance(query)
    end
  end
  min = 10e10
  m.times do |j|
    min = [min, dp[queries.length][j].min].min
  end
  min
end

def query_distance(query)
  (query[0] - query[1]).abs
end

def main
  tests = read_tests(STDIN)
  distances = compute_distances(tests)
  distances.each do |distance|
    puts distance
  end
end