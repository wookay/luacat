Date = {}

function Date.today()
  return os.date("*t", os.time())
end

function Date.new(year, month, day)
  return os.date("*t", os.time({year=year,month=month,day=day}))
end



INFINITY = 0

function milliseconds(n)
  return n
end
