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

def test_p2detect
  r = [1,2,3,4,5].p2detect{|e| e%2==0}
  h = {'a'=>1, 'b'=>2, 'c'=>2}.p2detect{|e| e[1]==2}
  raise "#{__method__} error" if (r!=2 || h!=['b', 2])
  p "#{__method__} passed"
end

def test_p2drop
  r = [1,2,3,4,5].p2drop(3)
  h = {'a'=>1, 'b'=>2, 'c'=>2}.p2drop(1)
  raise "#{__method__} error" if (r!=[4, 5] || h!=[['b', 2], ['c', 2]])
  p "#{__method__} passed"
end

def test_p2drop_while
  r = [1,2,3,4,5,0].p2drop_while{|e| e<3}
  h = {'a'=>1, 'b'=>2, 'c'=>1}.p2drop_while{|e| e[1]<2}
  raise "#{__method__} error" if (r!=[3, 4, 5, 0] || h!=[['b', 2], ['c', 1]])
  p "#{__method__} passed"
end

def test_p2each_cons
  r = [1,2,3,4,5]
  res = []
  r.p2each_cons(2){|e| res << e}
  raise "#{__method__} error" if (res!=[[1, 2], [2, 3], [3, 4], [4, 5]])
  p "#{__method__} passed"
end
def test_p2each_slice
  r = [1,2,3,4,5]
  res = []
  r.p2each_slice(2){|e| res << e}
  raise "#{__method__} error" if (res!=[[1, 2], [3, 4], [5]])
  p "#{__method__} passed"
end
def test_p2each_with_index
  hash = Hash.new
  hash_o = Hash.new
  %w(cat dog wombat).p2each_with_index { |item, index| hash[item] = index }
  %w(cat dog wombat).each_with_index { |item, index| hash_o[item] = index }
  raise "#{__method__} error" if hash!=hash_o
  p "#{__method__} passed"
end

def test_p2entries
  r = { 'a'=>1, 'b'=>2, 'c'=>3 }.p2entries
  r_o = { 'a'=>1, 'b'=>2, 'c'=>3 }.entries
  raise "#{__method__} error" if r!=r_o
  p "#{__method__} passed"
end

def test_p2find
  r = [1,2,3,4,5].p2find{|e| e%2==0}
  r_o = [1,2,3,4,5].find{|e| e%2==0}
  h = {'a'=>1, 'b'=>2, 'c'=>2}.p2find{|e| e[1]==2}
  h_o = {'a'=>1, 'b'=>2, 'c'=>2}.find{|e| e[1]==2}
  raise "#{__method__} error" if (r!=r_o || h!=h_o)
  p "#{__method__} passed"
end

def test_p2find_all
  r = [1,2,3,4,5,6,7,8,9,10].p2find_all{|e| e%2==0}
  r_o = [1,2,3,4,5,6,7,8,9,10].find_all{|e| e%2==0}
  raise "#{__method__} error" if r!=r_o
  p "#{__method__} passed"
end

def test_p2find_index
  i = [1,2,3,4,5,6,7,8,9,10].p2find_index{|e| e%2==0}
  i_o = [1,2,3,4,5,6,7,8,9,10].find_index{|e| e%2==0}
  raise "#{__method__} error" if i!=i_o
  p "#{__method__} passed"
end

def test_p2first
  r = [1,2,3,4,5,6,7,8,9,10].p2first(5)
  r_o = [1,2,3,4,5,6,7,8,9,10].first(5)
  raise "#{__method__} error" if r!=r_o
  p "#{__method__} passed"
end

def test_p2group_by
  hash = [1,2,3,4,5,6,7,8,9,10].p2group_by{|e| e%4}
  hash_o = [1,2,3,4,5,6,7,8,9,10].group_by{|e| e%4}
  raise "#{__method__} error" if hash!=hash_o
  p "#{__method__} passed"
end
def test_p2inject
  r = [1,2,3].p2inject{ |s, e| s + e }
  r_o = [1,2,3].inject{ |s, e| s + e }
  raise "#{__method__} error" if r != r_o
  p "#{__method__} passed"
end
def test_p2minmax
  w = %w(albatross dog horse)
  r = w.p2minmax { |a, b| a.length <=> b.length }
  r_o = w.minmax { |a, b| a.length <=> b.length }
  raise "#{__method__} error" if r != r_o
  p "#{__method__} passed"
end
def test_p2minmax_by
  a = %w(albatross dog horse)
  r = a.p2minmax_by { |x| x.length }
  r_o = a.minmax_by { |x| x.length }
  raise "#{__method__} error" if r != r_o
  p "#{__method__} passed"
end

def test_p2partition
  r = [1,2,3,4,5,6].p2partition { |v| v.even? }
  r_o = [1,2,3,4,5,6].partition { |v| v.even? }
  raise "#{__method__} error" if r != r_o
  p "#{__method__} passed"
end

def test_p2reject
  r = [1,2,3,4,5,6,7,8,9,10].p2reject { |i|  i % 3 == 0 }
  r_o = [1,2,3,4,5,6,7,8,9,10].reject { |i|  i % 3 == 0 }
  raise "#{__method__} error" if r != r_o
  p "#{__method__} passed"
end

def test_p2take
  r = [1, 2, 3, 4, 5, 0].p2take(3)
  r_o = [1, 2, 3, 4, 5, 0].take(3)
  raise "#{__method__} error" if r != r_o
  p "#{__method__} passed"
end

def test_p2take_while
  r = [1, 2, 3, 4, 5, 0].p2take_while { |i| i < 3 }
  r_o = [1, 2, 3, 4, 5, 0].take_while { |i| i < 3 }
  raise "#{__method__} error" if r != r_o
  p "#{__method__} passed"
end

def test_p2to_a
  r = {'1'=>1,'2'=>2,'3'=>3}.p2to_a
  raise "#{__method__} error" if r != [['1', 1], ['2', 2], ['3', 3]]
  p "#{__method__} passed"
end

def test_p2to_h
  r = [[1,2],[3,4]].p2to_h
  raise "#{__method__} error" if r != {1=>2, 3=>4}
  p "#{__method__} passed"
end



test_p2all
test_p2any
test_p2collect
test_p2collect_concat
test_p2count
test_p2cycle
test_p2detect
test_p2drop
test_p2drop_while
test_p2each_cons
test_p2each_slice
test_p2each_with_index
test_p2entries
test_p2find
test_p2find_all
test_p2find_index
test_p2first
test_p2group_by
test_p2inject
test_p2minmax
test_p2minmax_by
test_p2partition
test_p2reject
test_p2take
test_p2take_while
test_p2to_a
test_p2to_h
