require 'NumberExt'

local ONE_DAY_SECONDS    = 86400
local ONE_HOUR_SECONDS   = 3600
local ONE_MINUTE_SECONDS = 60
local ONE_DAY_HOURS      = 24

Date = extends(Object)

local function _new_date(time)
  local date = os.date("*t", time)
  date.time = time
  return new_object(date, Date.mt, 'date')
end

-- instance methods
function Date.getYesterday(self)
  return _new_date(self.time - ONE_DAY_SECONDS)
end

function Date.getTomorrow(self)
  return _new_date(self.time + ONE_DAY_SECONDS)
end

function Date.before(self, time_interval)
  return _new_date(self.time - time_interval)
end

function Date.after(self, time_interval)
  return _new_date(self.time + time_interval)
end

-- time interval
function time_interval_to_days(time_interval)
  local seconds = time_interval
  local days, hours, minutes = 0
  if seconds >= ONE_DAY_SECONDS then
    days = math.floor(seconds / ONE_DAY_SECONDS)
    seconds = seconds - days * ONE_DAY_SECONDS 
    if seconds >= ONE_HOUR_SECONDS then
      hours = math.floor(seconds / ONE_HOUR_SECONDS)
      seconds = seconds - hours * ONE_HOUR_SECONDS
      if seconds >= ONE_MINUTE_SECONDS then
        minutes = math.floor(seconds / ONE_MINUTE_SECONDS)
        seconds = seconds - minutes * ONE_MINUTE_SECONDS
      end
    end 
  end
  return { days = days, hours = hours, minutes = minutes, seconds = seconds }
end

function Number.getDays(self)
  return self * ONE_DAY_SECONDS
end

function Number.getHours(self)
  return self * ONE_HOUR_SECONDS
end

function Number.getMinutes(self)
  return self * ONE_MINUTE_SECONDS
end

function Number.getSeconds(self)
  return self
end




-- class methods
function Date.new(year, month, day)
  return _new_date(os.time({year=year,month=month,day=day,hour=0,min=0,sec=0}))
end

function Date.today()
  return _new_date(os.time())
end

Date.mt.__lt = function(a, b)
  return a.time < b.time
end

Date.mt.__sub = function(a, b)
  return a.time - b.time
end


INFINITY = 0

Time = extends(Object)
function Time.milliseconds(n)
  return n
end
function Time.seconds(n)
  return 1000 * n
end
