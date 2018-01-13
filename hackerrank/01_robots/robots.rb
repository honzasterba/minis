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
  max_distance = 2 * (1..input[:containers]).inject(0) { |sum,e| sum + e }
  minimum_distance(nil, nil, queries.dup, 0, 0, max_distance)
end

def minimum_distance(r1, r2, queries, i, total, max_distance)
  if i == queries.length || total > max_distance
    return total
  end

  query = queries[i]
  if r1.nil?
    dr1 = minimum_distance(query[1], r2, queries, i+1, total+travel(r1, query),
                            max_distance)
    dr2 = dr1
  elsif !r2.nil? && (r1 - query[0]).abs < (r2 - query[0]).abs
    dr1 = minimum_distance(query[1], r2, queries, i+1, total+travel(r1, query),
                           max_distance)
    dr2 = minimum_distance(r1, query[1], queries, i+1, total+travel(r2, query),
                           [max_distance, dr1].min)
  else
    dr2 = minimum_distance(r1, query[1], queries, i+1, total+travel(r2, query),
                           max_distance)
    dr1 = minimum_distance(query[1], r2, queries, i+1, total+travel(r1, query),
                           [max_distance, dr2].min)
  end
  [dr1, dr2].min
end

def travel(robot_pos, query)
  if robot_pos
    distance(robot_pos, query[0]) + distance(*query)
  else
    distance(*query)
  end
end

def distance(a, b)
  (a - b).abs
end

def main
  tests = read_tests(STDIN)
  distances = compute_distances(tests)
  distances.each do |distance|
    puts distance
  end
end