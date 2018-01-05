require 'drawimage'

function weather(x,y)

  interval = 300
  timer = (updates % interval)
  area = "Tokyo" -- available currently: Tokyo

  if timer == 0 or conky_start == 1 then
    file = io.open(curdir .. "/.tmp/weather_" .. area)
    weather_t = {}
    for line in file:lines() do
      file_content = line
      table.insert(weather_t,file_content)
    end
    file:close()

  end

  if timer == 0 or conky_start == 1 then
    file = io.open(curdir .. "/.tmp/weather_forecasts_" .. area)
    forecast_t = {}
    for line in file:lines() do
      file_content = line
      table.insert(forecast_t,file_content)
    end
    file:close()
  end

  location_t = {
    ['Tokyo'] = "Tokyo, Japan",
    ['California'] = "California, United States"
  }

  weather_icon_t = {
    ['Fair']  = "day-sunny",
    ['Clear'] = "day-sunny",
    ['Sunny'] = "day-sunny",
    ['Mostly Sunny'] = "day-sunny-overcast",
    ['Mostly Cloudy'] = "cloudy",
    ['Partly Cloudy'] = "cloud",
    ['Rain'] = "rain",
    ['AM Rain'] = "rain",
    ['PM Rain'] = "rain",
    ['AM Showers'] = "showers",
    ['PM Showers'] = "showers"
  }
  weather_icon_day_t = {
    ['Fair'] = "day-sunny",
    ['Clear'] = "day-sunny",
    ['Fair / Windy'] = "day-windy",
    ['Mostly Sunny'] = "day-haze",
    ['Mostly Cloudy'] = "day-cloudy",
    ['Partly Cloudy'] = "day-cloudy",
    ['Rain'] = "day-rain",
    ['Showers'] = 'day-showers'
  }

  weather_icon_night_t = {
    ['Fair'] = "night-clear",
    ['Clear'] = "night-clear",
    ['Fair / Windy'] = "windy",
    ['Mostly Sunny'] = "night-clear",
    ['Mostly Cloudy'] = "cloudy",
    ['Partly Cloudy'] = "cloud",
    ['Rain'] = "night-rain",
    ['Showers'] = "night-showers"
  }

  location = location_t[area]

  temperature      = weather_t[1]
  temperature_high = weather_t[2]
  temperature_low  = weather_t[3]
  summary          = weather_t[4]
  wind_speed       = weather_t[5]
  wind_gust        = weather_t[6]
  wind_direction   = weather_t[7]
  visibility       = weather_t[8]
  precip_chance    = weather_t[9]
  dew_point        = weather_t[10]
  humidity         = weather_t[11]
  air_pressure     = weather_t[12]
  uv_index         = weather_t[13]
  uv_text          = weather_t[14]
  sunrise          = weather_t[15]
  sunset           = weather_t[16]
  moon_phase       = weather_t[17]
  last_update      = weather_t[18]
  observation      = weather_t[19]
  moon_phase_text  = weather_t[20]

  second_date          = forecast_t[1]
  second_day_of_week   = forecast_t[2]
  second_temp_high     = forecast_t[3]
  second_temp_low      = forecast_t[4]
  second_humidity      = forecast_t[5]
  second_precip_chance = forecast_t[6]
  second_summary       = forecast_t[7]
  third_date           = forecast_t[8]
  third_day_of_week    = forecast_t[9]
  third_temp_high      = forecast_t[10]
  third_temp_low       = forecast_t[11]
  third_humidity       = forecast_t[12]
  third_precip_chance  = forecast_t[13]
  third_summary        = forecast_t[14]
  fourth_date          = forecast_t[15]
  fourth_day_of_week   = forecast_t[16]
  fourth_temp_high     = forecast_t[17]
  fourth_temp_low      = forecast_t[18]
  fourth_humidity      = forecast_t[19]
  fourth_precip_chance = forecast_t[20]
  fourth_summary       = forecast_t[21]

  --images
  if conky_start == 1 then
    store_weather_icons() -- except for the condition icon
  end
  -- condition images
  if timer == 0 or conky_start == 1 then
    store_weather_condition_icons()
  end

  color = color6
  weather_icon_size = 50
  text_indent = iconsize + 15
  start1y = 35
  indent1 = 150
  spacing2 = 42
  start2x = x
  start2y = y + 82
  spacing3 = spacing2
  start3x = 150
  start3y = 82
  start4x = 260
  start4y = -30
  spacing4 = 25

  -- temperature
  font = "Roboto"
  font_size = 80
  text = temperature
  text_extents(text,font,font_size)
  x1 = x + 40 - (extents.width + extents.x_bearing)*1/2
  y1 = y
  displaytext(x1,y1,text,font,font_size,color)
  iconx = x + 45
  icony = y - 100
  iconname = "celsius"
  iconsize = 165
  iconorig = 30
  draw_image(iconx,icony,iconname,iconsize,iconorig,color6)

  -- element 1
  font_size = 17
  iconsize = 25
  iconorig = 30
  iconx = x + indent1
  icony = y + start1y - 18
  iconname = "thermometer"
  draw_image(iconx,icony,iconname,iconsize,iconorig,color6)
  text = temperature_high .. "/" .. temperature_low
  x2 = x + indent1 + text_indent - 15
  y2 = y + start1y
  displaytext(x2,y2,text,font,font_size,color)

  --font = "Inconsolata"
  font_size = 18
  text = summary
  x3 = x + 10
  y3 = y2
  displaytext(x3,y3,text,font,font_size,color)

  -- element 2
  font_size = 14

  iconx = start2x
  icony = start2y - 25
  iconname = "humidity"
  draw_image(iconx,icony,iconname,40,30,color6)
  text = humidity
  x4 = iconx + text_indent
  y4 = start2y
  displaytext(x4,y4,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconname = "umbrella"
  draw_image(iconx,icony,iconname,40,30,color6)
  text = precip_chance
  x5 = x4
  y5 = y4 + spacing2
  displaytext(x5,y5,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconname = "wind"
  draw_image(iconx,icony,iconname,40,30,color6)
  text = wind_speed
  x6 = x5
  y6 = y5 + spacing2
  displaytext(x6,y6,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconname = "barometer"
  draw_image(iconx,icony,iconname,40,30,color6)
  text = air_pressure
  x7 = x6
  y7 = y6 + spacing2
  displaytext(x7,y7,text,font,font_size,color)

  uv_icon_offset = -3
  iconx = iconx
  icony = icony + spacing2 + uv_icon_offset
  iconname = "uv"
  draw_image(iconx,icony,iconname,35,512,color6)
  text = uv_text
  x8 = x7
  y8 = y7 + spacing2
  displaytext(x8,y8,text,font,font_size,color)

  -- element 3
  iconx = iconx + start3x
  icony = start2y - 25
  iconname = "visibility"
  draw_image(iconx,icony,iconname,40,30,color6)
  text = visibility
  x9 = x + start3x + text_indent
  y9 = y + start3y
  displaytext(x9,y9,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconname = "dewpoint"
  draw_image(iconx,icony,iconname,40,30,color6)
  text = dew_point
  x10 = x9
  y10 = y9 + spacing3
  displaytext(x10,y10,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconname = "sunrise"
  draw_image(iconx,icony,iconname,40,30,color6)
  text = sunrise
  x11 = x10
  y11 = y10 + spacing3
  displaytext(x11,y11,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconname = "sunset"
  draw_image(iconx,icony,iconname,40,30,color6)
  text = sunset
  x12 = x11
  y12 = y11 + spacing3
  displaytext(x12,y12,text,font,font_size,color)

  moonx = iconx
  moony = icony + spacing3
  moonphase(moonx,moony)

  -- element4 (location,update)
  font_size = 18
  text = "Location: " .. location
  x14 = x + start4x
  y14 = y + start4y
  displaytext(x14,y14,text,font,font_size,color)

  font_size = 13.5
  text = "Last Update: " .. last_update
  x15 = x14
  y15 = y14 + spacing4
  displaytext(x15,y15,text,font,font_size,color)

  -- weather icon
  iconx = x + 160
  icony = y - 65
  iconname = "weather"
  iconsize = 81
  iconorig = 30
  draw_image(iconx,icony,iconname,iconsize,iconorig,color6)

  x = x15 + 15
  y = y15 + 50
  forecasts(x,y)

end
function moonphase(x,y)
  iconname = "moonphase"
  draw_image(x,y,iconname,40,30,color6)
  n = 0
  text = {}
  for i in string.gmatch(moon_phase_text,"%S+") do
    n = n + 1
    text[n] = i
  end

  if n == 1 then
    font_size = 15
    x13 = x12
    y13 = y12 + spacing3
    displaytext(x13,y13,text[1],font,font_size,color)
  end
  if n == 2 then
    font_size = 13
    x13 = x12
    y13 = y12 + spacing3 - 8
    displaytext(x13,y13,text[1],font,font_size,color)
    displaytext(x13,y13+font_size*1.1,text[2],font,font_size,color)
  end
end
function forecasts(x,y)
  text = "3 Day Forecasts"
  font = "Roboto"
  font_size = 16.5
  text_extents(text,font,font_size)
  color = color6

  top = 5
  left = 0
  spacing = 70
  spacing_text = 18
  weather_icon_size = 65
  weather_icon_offset = 8
  text_indent = 65  -- from left
  text_spacing = 25 -- from top
  icon_offset = -15
  icon_size = 20
  text_icon_indent  = 50
  text_icon_indent2 = 25
  text_text_indent  = 18
  text_text_indent2 = 20

  -- title
  sx1 = x
  sy1 = y + (extents.height/2 + extents.y_bearing)
  fx1 = sx1 + 40
  fy1 = sy1
  cairo_set_source_rgba(cr,rgba(color))
  cairo_set_line_width(cr,2)
  draw_line(sx1,sy1,fx1,fy1)
  cairo_stroke(cr)

  x1 = fx1 + 5
  y1 = y
  displaytext(x1,y,text,font,font_size,color)

  sx2 = x1 + (extents.width + extents.x_bearing) + 5
  sy2 = sy1
  fx2 = sx2 + 40
  fy2 = sy2
  cairo_set_source_rgba(cr,rgba(color))
  cairo_set_line_width(cr,2)
  draw_line(sx2,sy2,fx2,fy2)
  cairo_stroke(cr)

  -- tommorow
  font_size = 13
  secondx = x + left
  secondy = y + top
  iconx1 = secondx
  icony1 = secondy + weather_icon_offset
  draw_image(iconx1,icony1,"weather2",weather_icon_size,30,color)
  x2 = secondx + text_indent
  y2 = secondy + text_spacing
  text = "Tomorrow " .. second_date .. ":"
  displaytext(x2,y2,text,font,font_size,color)

  x3 = x2
  y3 = y2 + spacing_text
  text = second_summary
  displaytext(x3,y3,text,font,font_size,color)

  x4 = x3
  y4 = y3 + spacing_text
  text = second_temp_high .. "/" .. second_temp_low
  displaytext(x4,y4,text,font,font_size,color)

  iconx2 = x4 + text_icon_indent
  icony2 = y4 + icon_offset
  iconname = "humidity"
  draw_image(iconx2,icony2,iconname,icon_size,30,color)
  x5 = iconx2 + text_text_indent
  y5 = y4
  text = second_humidity
  displaytext(x5,y5,text,font,font_size,color)

  iconx3 = x5 + text_icon_indent2
  icony3 = y5 + icon_offset
  iconname = "umbrella"
  draw_image(iconx3,icony3,iconname,icon_size,30,color)
  x6 = iconx3 + text_text_indent2
  y6 = y5
  text = second_precip_chance
  displaytext(x6,y6,text,font,font_size,color)

  font_size = 13

  -- day after tomorrow
  thirdx = secondx
  thirdy = secondy + spacing
  iconx1 = thirdx
  icony1 = thirdy + weather_icon_offset
  draw_image(iconx1,icony1,"weather3",weather_icon_size,30,color)

  x2 = thirdx + text_indent
  y2 = thirdy + text_spacing
  text = third_day_of_week .. " " .. third_date .. ":"
  displaytext(x2,y2,text,font,font_size,color)

  x3 = x2
  y3 = y2 + spacing_text
  text = third_summary
  displaytext(x3,y3,text,font,font_size,color)

  x4 = x3
  y4 = y3 + spacing_text
  text = third_temp_high .. "/" .. third_temp_low
  displaytext(x4,y4,text,font,font_size,color)

  iconx2 = x4 + text_icon_indent
  icony2 = y4 + icon_offset
  iconname = "humidity"
  draw_image(iconx2,icony2,iconname,icon_size,30,color)
  x5 = iconx2 + text_text_indent2
  y5 = y4
  text = third_humidity
  displaytext(x5,y5,text,font,font_size,color)

  iconx3 = x5 + text_icon_indent2
  icony3 = y5 + icon_offset
  iconname = "umbrella"
  draw_image(iconx3,icony3,iconname,icon_size,30,color)
  x6 = iconx3 + text_text_indent2
  y6 = y5
  text = third_precip_chance
  displaytext(x6,y6,text,font,font_size,color)

  -- 2 days after tomorrow
  font_size = 13
  fourthx = thirdx
  fourthy = thirdy + spacing
  iconx1 = fourthx
  icony1 = fourthy + weather_icon_offset
  draw_image(iconx1,icony1,"weather4",weather_icon_size,30,color)
  x2 = fourthx + text_indent
  y2 = fourthy + text_spacing
  text = fourth_day_of_week .. " " .. fourth_date .. ":"
  displaytext(x2,y2,text,font,font_size,color)

  x3 = x2
  y3 = y2 + spacing_text
  text = fourth_summary
  displaytext(x3,y3,text,font,font_size,color)

  x4 = x3
  y4 = y3 + spacing_text
  text = fourth_temp_high .. "/" .. fourth_temp_low
  displaytext(x4,y4,text,font,font_size,color)

  iconx2 = x4 + text_icon_indent
  icony2 = y4 + icon_offset
  iconname = "humidity"
  draw_image(iconx2,icony2,iconname,icon_size,30,color)
  x5 = iconx2 + text_text_indent
  y5 = y4
  text = fourth_humidity
  displaytext(x5,y5,text,font,font_size,color)

  iconx3 = x5 + text_icon_indent2
  icony3 = y5 + icon_offset
  iconname = "umbrella"
  draw_image(iconx3,icony3,iconname,icon_size,30,color)
  x6 = iconx3 + text_text_indent2
  y6 = y5
  text = fourth_precip_chance
  displaytext(x6,y6,text,font,font_size,color)
end
function store_weather_icons()
  path = curdir .. "/image/weather_icons/celsius.svg"
  name = "celsius"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/thermometer.svg"
  name = "thermometer"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/humidity.svg"
  name = "humidity"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/umbrella.svg"
  name = "umbrella"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/windy.svg"
  name = "wind"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/barometer.svg"
  name = "barometer"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/uv.svg"
  name = "uv"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/smog.svg"
  name = "visibility"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/raindrops.svg"
  name = "dewpoint"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/sunrise.svg"
  name = "sunrise"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/sunset.svg"
  name = "sunset"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/moon-"..moon_phase..".svg"
  name = "moonphase"
  store_image(path,name)
end
function store_weather_condition_icons()
  path = curdir .. "/image/weather_icons/" .. weather_icon_name(summary) ..".svg"
  name = "weather"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/" .. forecast_icon_name(second_summary) .. ".svg"
  name = "weather2"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/" .. forecast_icon_name(third_summary) .. ".svg"
  name = "weather3"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/" .. forecast_icon_name(fourth_summary) .. ".svg"
  name = "weather4"
  store_image(path,name)
end
function forecast_icon_name(weather)
  return weather_icon_t[weather]
end
function weather_icon_name(weather)
  if 5 < tonumber(hours) and tonumber(hours) < 18  then
    return weather_icon_day_t[weather]
  else
    return weather_icon_night_t[weather]
  end
end
