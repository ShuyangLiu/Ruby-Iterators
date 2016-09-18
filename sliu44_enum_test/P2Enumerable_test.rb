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
test_p2all
