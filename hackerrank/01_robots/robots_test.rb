require 'test/unit'
require 'benchmark'

require './hackerrank/01_robots/robots_dp'

class TestThis < Test::Unit::TestCase

  def read_results(num, path)
    results = []
    File.open(path, 'r') do |f|
      num.times do
        results << f.gets.to_i
      end
    end
    results
  end

  def run_test_name(test_name)
    inputs = nil
    File.open("./hackerrank/01_robots/tests/input#{test_name}.txt", 'r') do |f|
      inputs = read_tests(f)
    end
    results = read_results inputs.length, "./hackerrank/01_robots/tests/output#{test_name}.txt"
    results.size.times do |i|
      actual = nil
      time = Benchmark.measure {
        actual = find_minimum_distance(inputs[i])
      }
      puts "test #{i}: #{time.real}"
      assert_equal results[i], actual
    end
  end

  def test_stuff
    run_test_name('01')
  end

end
