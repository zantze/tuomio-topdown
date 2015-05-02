mapper = {}

function split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={} ; i=1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

function mapper.load(path)
  map = {}
  lines = love.filesystem.read(path)
  lines = split(lines, '\r\n')
  conf = split(lines[1], ' ')
  map.width = tonumber(conf[1])
  map.height = tonumber(conf[2])
  map.tilemap = {}
  map.tilemap.texture = love.graphics.newImage(conf[3])
  map.tilemap.tile_width = tonumber(conf[4])
  map.tilemap.tile_height = tonumber(conf[5])
  map.data = {}
  for y = 1, map.height do
    row = split(lines[y + 1], ' ')
    for x = 1, map.width do
      if map.data[x] == nil then
        map.data[x] = {}
      end
      map.data[x][y] = row[x]
    end
  end

  function map:draw()
    s = 2
    w = map.tilemap.tile_width
    h = map.tilemap.tile_height
    t = map.tilemap.texture
    d = map.data
    for x = 1, map.width do
      for y = 1, map.height do
        love.graphics.draw(t, love.graphics.newQuad(d[x][y] * map.tilemap.tile_width, 0, w, h, t:getWidth(), t:getHeight()), (x - 1) * (w * s), (y - 1) * (h * s), 0, s, s)
      end
    end
  end

  return map
end
