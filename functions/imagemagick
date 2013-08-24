function convert-to-alpha() {
  if [ $# -eq 0 ]; then
    echo "usage: $0 [source] [destination]"
  elif [ $# -eq 1 ]; then
    convert \( $1 -channel RGB -separate \) \( $1 -fx intensity -negate \) -channel RGBA -combine $1
  else
    convert \( $1 -channel RGB -separate \) \( $1 -fx intensity -negate \) -channel RGBA -combine $2
  fi
}

function fill-with-white() {
  if [ $# -eq 0 ]; then
    echo "usage: $0 [source] [destination]"
  elif [ $# -eq 1 ]; then
    convert $1 \( -clone 0 -fill white -draw "color 0,0 reset" \) -compose atop -composite $1
  else
    convert $1 \( -clone 0 -fill white -draw "color 0,0 reset" \) -compose atop -composite $2
  fi
}


