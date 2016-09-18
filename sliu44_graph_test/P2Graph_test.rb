load '../sliu44_graph/P2Graph.rb'
load '../sliu44_graph/P2Node.rb'

# Test for graph class

def test_p2graph
  g = P2Graph.new
  node00 = P2Node.new('node00',0)
  g.p2insert_node(node00)
  node01 = P2Node.new('node01',1)
  g.p2insert_node(node01)
  node02 = P2Node.new('node02',2)
  g.p2insert_node(node02)
  g.p2insert_edge(node02,node01)
  g.p2each{|node| node.value = 100}
  r = Array.new
  g.p2each_with_neighbor_count do |node,count|
    r << [node.name,count]
  end
  raise "#{__method__} error" if g.graph!={node00=>[], node01=>[node02], node02=>[node01]} || node00.value!=100 || node01.value!=100 || node02.value!=100 || r!=[['node00', 0], ['node01', 1], ['node02', 1]]
  p "#{__method__} passed"
end

test_p2graph