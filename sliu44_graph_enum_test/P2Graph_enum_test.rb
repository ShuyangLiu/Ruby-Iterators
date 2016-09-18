load '../sliu44_enum/P2Enumerable.rb'
load '../sliu44_graph/P2Graph.rb'
load '../sliu44_graph/P2Node.rb'

# a global graph for testing
$g = P2Graph.new
$node00 = P2Node.new('node00',1)
$g.p2insert_node($node00)
$node01 = P2Node.new('node01',2)
$g.p2insert_node($node01)
$node02 = P2Node.new('node02',2)
$g.p2insert_node($node02)
$g.p2insert_edge($node02,$node01)

def test_p2all_graph
  c = $g.p2all?{|e| e.value==1}
  raise "#{__method__} error" if c
  p "#{__method__} passed"
end
def test_p2any_graph
  c = $g.p2any?{|e| e.value==1}
  raise "#{__method__} error" unless c
  p "#{__method__} passed"
end
def test_p2collect_graph
  c = $g.p2collect{|e| e.value+1}
  raise "#{__method__} error" if c!=[2, 3, 3]
  p "#{__method__} passed"
end
def test_p2collect_concat_graph
  c = $g.p2collect_concat{|e| [e.name, e.value]}
  raise "#{__method__} error" if c!=['node00', 1, 'node01', 2, 'node02', 2]
  p "#{__method__} passed"
end
def test_p2count_graph
  c = $g.p2count{|e| e.value==2}
  raise "#{__method__} error" if c!=2
  p "#{__method__} passed"
end

def test_p2cycle_graph
  s = 0
  $g.p2cycle(3){|e| s+=e.value}
  raise "#{__method__} error" if s!=15
  p "#{__method__} passed"
end

def test_p2detect_graph
  c = $g.p2detect{|e| e.value==2}
  raise "#{__method__} error" if c.name!='node01'
  p "#{__method__} passed"
end

def test_p2drop_graph
  c = $g.p2drop(1)
  raise "#{__method__} error" if c.size!=2
  p "#{__method__} passed"
end

def test_p2drop_while_graph
  c = $g.p2drop_while{|e| e.name=='node00'||e.name=='node01'}
  raise "#{__method__} error" if c.size!=1
  p "#{__method__} passed"
end

def test_p2each_cons_graph
  c = []
  $g.p2each_cons(2){|e| c << e}
  raise "#{__method__} error" if c!=[[$node00,$node01],[$node01,$node02]]
  p "#{__method__} passed"
end

def test_p2each_slice_graph
  c = []
  $g.p2each_slice(2){|e| c << e}
  raise "#{__method__} error" if c!=[[$node00,$node01],[$node02]]
  p "#{__method__} passed"
end

def test_p2each_with_index_graph
  hash = Hash.new
  $g.p2each_with_index{|node, index| hash[node.name] = index}
  raise "#{__method__} error" if hash!={'node00'=>0, 'node01'=>1, 'node02'=>2}
  p "#{__method__} passed"
end

def test_p2entries_graph
  c = $g.p2entries
  raise "#{__method__} error" if c!=[$node00,$node01,$node02]
  p "#{__method__} passed"
end

def test_p2find_graph
  c = $g.p2find{|e| e.value==2}
  raise "#{__method__} error" if c.name!='node01'
  p "#{__method__} passed"
end

def test_p2find_all_graph
  c = $g.p2find_all{|e| e.value==2}
  raise "#{__method__} error" if c!=[$node01,$node02]
  p "#{__method__} passed"
end

def test_p2find_index_graph
  c = $g.p2find_index{|e| e.value==2}
  raise "#{__method__} error" if c!=1
  p "#{__method__} passed"
end

def test_p2first_graph
  c = $g.p2first(2)
  raise "#{__method__} error" if c!=[$node00,$node01]
  p "#{__method__} passed"
end

def test_p2group_by_graph
  c = $g.p2group_by{|e| e.value}
  raise "#{__method__} error" if c!={1=>[$node00],2=>[$node01,$node02]}
  p "#{__method__} passed"
end

def test_p2inject_graph
  c = $g.p2inject(0){|sum,e| sum + e.value}
  raise "#{__method__} error" if c!=5
  p "#{__method__} passed"
end

def test_p2minmax_graph
  c = $g.p2minmax{|a,b| a.value <=> b.value}
  raise "#{__method__} error" if c!=[$node00,$node01]
  p "#{__method__} passed"
end

def test_p2minmax_by_graph
  c = $g.p2minmax_by{|e| e.value}
  raise "#{__method__} error" if c!=[$node00,$node01]
  p "#{__method__} passed"
end

def test_p2partition_graph
  c = $g.p2partition{|e| e.value.even?}
  raise "#{__method__} error" if c!=[[$node01,$node02],[$node00]]
  p "#{__method__} passed"
end

def test_p2reject_graph
  c = $g.p2reject{|e| e.value%2==1}
  raise "#{__method__} error" if c!=[$node01,$node02]
  p "#{__method__} passed"
end

def test_p2take_graph
  c = $g.p2take(2)
  raise "#{__method__} error" if c!=[$node00,$node01]
  p "#{__method__} passed"
end

def test_p2take_while_graph
  c = $g.p2take_while{|e| e.value<2}
  raise "#{__method__} error" if c!=[$node00]
  p "#{__method__} passed"
end

def test_p2to_a_graph
  c = $g.p2to_a
  raise "#{__method__} error" if c!=[$node00,$node01,$node02]
  p "#{__method__} passed"
end


test_p2all_graph
test_p2any_graph
test_p2collect_graph
test_p2collect_concat_graph
test_p2count_graph
test_p2cycle_graph
test_p2detect_graph
test_p2drop_graph
test_p2drop_while_graph
test_p2each_cons_graph
test_p2each_slice_graph
test_p2each_with_index_graph
test_p2entries_graph
test_p2find_graph
test_p2find_all_graph
test_p2find_index_graph
test_p2first_graph
test_p2group_by_graph
test_p2inject_graph
test_p2minmax_graph
test_p2minmax_by_graph
test_p2partition_graph
test_p2reject_graph
test_p2take_graph
test_p2take_while_graph
test_p2to_a_graph
