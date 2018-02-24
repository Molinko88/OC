
component = require 'component'
unicode = require 'unicode'

gpu = component.gpu


-- buffer = (width, height) ->
--   canvas = ("%X%X "\format 0x000000, 0x000000)\rep width * height
--   :width, :height, fBuffer: canvas, bBuffer: canvas
--
-- flush = (width, height, dx=0, dy=0) ->

byte_array = "FFFFFF000000 "\rep 160 * 50

getPixels = (byte_array, depth=24) ->
  pos = 1
  () ->
    chunk = unicode.sub byte_array, pos, pos + 12
    if chunk
      fg = unicode.sub chunk, 1, 6
      bg = unicode.sub chunk, 7, 12
      char = unicode.sub chunk, 12, 12
      pos += 13
      return tonumber(fg, 16), tonumber(bg, 16), char


x, y = 1, 1
for fg, bg, char in getPixels byte_array
  with gpu
    .setBackground bg
    .setForeground fg
    .set x, y, char
  if x == 160
    x = 1
    y += 1
  else
    x += 1
