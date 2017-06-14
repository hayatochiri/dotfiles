function wb
  set WORD (string join '+' $argv)
  open "http://ejje.weblio.jp/content/$WORD"
end

function wp
  set WORD (string join '+' $argv)
  mkdir -p ~/.weblio

  if [ ! -e ~/.weblio/$WORD.mp3 ]
    set CURRENT (pwd)
    builtin cd ~/.weblio
    wget "http://ejje.westatic.com/audio/$WORD.mp3" -O "$WORD.mp3"
    builtin cd "$CURRENT"
  end
  afplay ~/.weblio/$WORD.mp3
end
