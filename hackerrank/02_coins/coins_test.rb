require 'test/unit'
require 'benchmark'

require './hackerrank/02_coins/main'

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
    File.open("./hackerrank/02_coins/tests/input#{test_name}.txt", 'r') do |f|
      n, c = read_input(f)
      puts cnt(n, c, c.size)
    end
  end

  def test_stuff
    run_test_name('01')
  end

end
