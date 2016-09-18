module P2Enumerable
	def p2all?
    r = true
    p2each do |e|
      r = r && yield(e)
    end
    r
  end
  def p2any?
    r = false
    p2each do |e|
      r = r || yield(e)
    end
    r
  end
  def p2collect
    r = Array.new
    p2each do |e|
      res = yield(e)
      r << res
    end
    r
  end
  def p2collect_concat
    r = Array.new
    p2each do |e|
      res = yield(e)
      r += res
    end
    r
  end
  def p2count
    r = 0
    p2each do |e|
      if yield(e)
        r+=1
      end
    end
    r
  end
  def p2cycle(n=-1)
    c = 0
    until c==n do
      p2each do |e|
        yield(e)
      end
      c+=1
    end
  end
end

class Array
  include P2Enumerable
  def p2each
    self.size.times do |i|
      yield( self[i] )
    end
  end
end

class Hash
  include P2Enumerable
  def p2each
    self.keys.p2each do |k|
      yield([k,self[k]])
    end
  end
end
