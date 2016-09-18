load '../sliu44_enum/P2Enumerable.rb'
def test_p2all
  ary = %w(one abc sss)
  hash = {'one'=>1, 'two'=>2, 'three'=>3}
  a = ary.p2all? {|e| e.length==3}
  b = hash.p2all? {|e| e.class==Array && e[0].class==String && e[1].class==Fixnum}
  r = a&&b
  raise "#{__method__} error" unless r
  p "#{__method__} passed"
end
def test_p2any
  ary = %w(one abc ssss)
  hash = {'one'=>1, 'two'=>2, 'three'=>3}
  a = ary.p2any? {|e| e.length==4}
  b = hash.p2any? {|e| e[0].length==5}
  a_o = ary.any?{|e| e.length==4}
  b_o = hash.any? {|e| e[0].length==5}
  raise "#{__method__} error" if a!=a_o || b!=b_o
  p "#{__method__} passed"
end
def test_p2collect
  r = [1,2,3].p2collect{ |e| e+1 }
  raise "#{__method__} error" if r != [2,3,4]
  p "#{__method__} passed"
end
def test_p2collect_concat
  r = [1,2,3].p2collect_concat{|e| [e,-e]}
  hash = {'a' => '1', 'b' => '2'}
  h = hash.p2collect_concat{|e| [e,e.class]}
  raise "#{__method__} error" if (r != [1,-1,2,-2,3,-3] || h != [%w(a 1), Array, %w(b 2), Array])
  p "#{__method__} passed"
end
def test_p2count
  r = [1,2,3,4,5,6].p2count{|e| e%2==0}
  h = {'a'=>1, 'b'=>2, 'c'=>3}.p2count{|e| e[1]%2==1}
  raise "#{__method__} error" if (r!=3 || h!=2)
  p "#{__method__} passed"
end
def test_p2cycle
  s = 0
  r = [1,2,3,4,5]
  r.p2cycle(2){|e| s+=e}
  h = 0
  hash = {'a'=>1, 'b'=>2, 'c'=>3}
  hash.p2cycle(3){|e| h+=e[1]}
  raise "#{__method__} error" if (s!=30 || h!=18)
  p "#{__method__} passed"
end

test_p2all
test_p2any
test_p2collect
test_p2collect_concat
test_p2count
test_p2cycle
