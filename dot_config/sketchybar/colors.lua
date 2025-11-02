return {
  black = 0xff0f1117, -- matches your base background
  white = 0xffe6e6e6, -- soft white for contrast
  red = 0xffe06c75, -- muted crimson
  green = 0xff98c379, -- calm moss green
  blue = 0xff61afef, -- bright but balanced blue
  yellow = 0xffe5c07b, -- soft ochre
  orange = 0xffd19a66, -- warm copper
  magenta = 0xffc678dd, -- dusty lavender
  grey = 0xff5c6370, -- subtle neutral grey
  transparent = 0x00000000,

  bar = {
    bg = 0xff101219, -- slightly deeper than main bg for subtle depth
    border = 0xff1a1c22, -- faint edge line, almost invisible
  },
  popup = {
    bg = 0xf015171d, -- translucent version for floating panels
    border = 0xff3c4048,
  },
  bg1 = 0xff0f1117, -- main background
  bg2 = 0xff14161d, -- raised UI elements

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then
      return color
    end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
