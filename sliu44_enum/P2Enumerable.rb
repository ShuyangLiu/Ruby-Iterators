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
  def p2find_index
    i = 0
    p2each do |e|
      if yield(e)
        break
      end
      i+=1
    end
    i
  end
  def p2first(n=nil)
    if n==nil
      self.p2entries[0]
    else
      self.p2entries[0..n-1]
    end
  end
  def p2group_by
    hash = Hash.new
    p2each do |e|
      r = yield(e)
      ary = hash[r]
      if ary==nil
        ary = Array.new
      end
      ary << e
      hash[r] = ary
    end
    hash
  end
  def p2inject(initial = nil)
    ary = self
    if initial==nil
      initial = self.p2entries[0]
      ary = self.p2drop(1)
    end
    r = initial
    ary.p2each do | e |
      r = yield( r, e )
    end
    r
  end
  def p2minmax
    min = self.p2entries[0]
    max = self.p2entries[0]
    p2each do |e|
      if yield(e,min)<0
        min = e
      end
      if yield(e,max)>0
        max = e
      end
    end
    [min, max]
  end
  def p2minmax_by
    p2minmax{|a,b| yield(a) <=> yield(b)}
  end
  def p2partition
    true_ary = Array.new
    false_ary = Array.new
    p2each do |e|
      if yield(e)
        true_ary << e
       else
        false_ary << e
      end
    end
    [true_ary,false_ary]
  end
  def p2reject
    r = Array.new
    p2each do |e|
      unless yield(e)
        r << e
      end
    end
    r
  end
  def p2take(n)
    r = Array.new
    c = 0
    p2each do |e|
      if c>=n
        break
      end
      r << e
      c+=1
    end
    r
  end
  def p2take_while
    r = Array.new
    p2each do |e|
      if yield(e)
        r << e
      else
        break
      end
    end
    r
  end
  def p2to_a
    p2entries
  end
  def p2to_h
    ary = p2entries
    hash = Hash.new
    ary.p2each do |e|
      hash[e[0]] = e[1]
    end
    hash
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
