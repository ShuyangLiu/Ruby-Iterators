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
  def p2detect
    r = nil
    p2each do |e|
      if yield(e)
        r = e
        break
      end
    end
    r
  end
  def p2drop(n)
    r = Array.new
    c = 0
    p2each do |e|
      if c>=n
        r << e
      end
      c+=1
    end
    r
  end
  def p2drop_while
    r = Array.new
    over = false
    p2each do |e|
      if !yield(e) || over==true
        over = true
        r << e
      end
    end
    r
  end
  def p2each_cons(n)
    i = 0
    size = 0
    p2each do |e|
      size+=1
    end
    (size - n + 1).times do |q|
      tmp = 0
      ary = []
      p2each do |e|
        if tmp>=i+q && tmp<=i+q+n-1
          ary << e
        end
        tmp+=1
      end
      yield(ary)
    end
  end
  def p2each_slice(n)
    i = n-1
    size = 0
    p2each do |e|
      size+=1
    end
    (size / n).times do |q|
      tmp = 0
      ary = []
      p2each do |e|
        if tmp>=i-n+1 && tmp<=i
          ary << e
        end
        tmp+=1
      end
      yield(ary)
      i+=n
    end
    i-=n
    if i<(size-1)
      tmp = 0
      a = []
      p2each do |e|
        if tmp>=i+1 && tmp<=size-1
          a << e
        end
        tmp+=1
      end
      yield(a)
    end
  end
  def p2each_with_index
    i = 0
    p2each do |e|
      yield(e,i)
      i+=1
    end
  end
  def p2entries
    r = Array.new
    p2each do |e|
      r << e
    end
    r
  end
  alias p2find p2detect
  def p2find_all
    r = Array.new
    p2each do |e|
      if yield(e)
        r << e
      end
    end
    r
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
