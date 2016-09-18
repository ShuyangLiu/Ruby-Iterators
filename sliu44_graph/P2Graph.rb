load '../sliu44_enum/P2Enumerable.rb'
class P2Graph
  include P2Enumerable
  # (P2Node => Array)
  attr_accessor :graph
  def initialize(h = nil)
    if h == nil
      @graph = Hash.new
    else
      @graph = h
    end
  end
  # Enumerates each node of the graph
  def p2each
    @graph.size.times do |i|
      yield(@graph.keys[i])
    end
  end
  # Enumerates each node of the graph with its number of neighbors
  def p2each_with_neighbor_count
    @graph.size.times do |i|
      yield(@graph.keys[i],@graph[@graph.keys[i]].size)
    end
  end
  # Insert new edge, connect two nodes
  def p2insert_edge(s,d)
    ary_s = @graph[s]
    ary_d = @graph[d]
    ary_s_new = Array.new
    ary_d_new = Array.new
    if ary_s!=nil
      ary_s_new +=ary_s
    end
    if ary_d!=nil
      ary_d_new += ary_d
    end
    ary_s_new << d
    ary_d_new << s
    @graph[s] = ary_s_new
    @graph[d] = ary_d_new
  end
  # Insert new node
  def p2insert_node(node)
    @graph[node] = []
  end
end

