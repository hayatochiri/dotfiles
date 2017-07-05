if [ (uname) = 'Darwin' ]

  set -g ICLOUD_PATH ~/Library/Mobile Documents/com~apple~CloudDocs
  set -g INOTE_PATH "$ICLOUD_PATH/iNote"
  mkdir -p $INOTE_PATH

  function inote
    set -u result
    find "$INOTE_PATH" -type f | string sub -s (string length "12$INOTE_PATH") | fzf --preview="cat '$INOTE_PATH/{}'" --query="$argv" --multi --print-query --expect=ctrl-r,ctrl-y,ctrl-x,ctrl-i,ctrl-s,enter --header='Ctrl + i:new / r:remove / x:move / y:copy / s:search' | while read -l r
      set result $result $r
    end

    set -u QUERY
    set -u EXPECT
    set -u SELECTED
    switch (count $result)
    case 0
      return
    case 1
      set QUERY $result[1]
    case 2
      set QUERY $result[1]
      set EXPECT $result[2]
    case '*'
      set QUERY $result[1]
      set EXPECT $result[2]
      set SELECTED $result[3..-1]
    end

    switch $EXPECT
    case 'ctrl-r' # Remove
      echo "Remove $SELECTED"
      read -p 'echo "OK?(y/N)"' -l ANSWER
      test "$ANSWER" = 'y'; and rm "$INOTE_PATH/$SELECTED"
      inote
    case 'ctrl-y' # Yank
      if [ (count $SELECTED) -ne 1 ]
        echo 'Copy file Multiple selections are not possible.'
        return
      end
      echo '================================================================'
      echo 'inote files'
      echo '================================================================'
      find "$INOTE_PATH" -type f | string sub -s (string length "12$INOTE_PATH")
      echo '================================================================'
      read -p 'echo "Copy to> "' -l COPY_TO
      test -z "$COPY_TO"; and return
      set CREATE_DIR (dirname $COPY_TO)
      mkdir -p "$INOTE_PATH/$CREATE_DIR"
      cp "$INOTE_PATH/$SELECTED" "$INOTE_PATH/$COPY_TO"
      inote
    case 'ctrl-x' # Move
      if [ (count $SELECTED) -ne 1 ]
        echo 'Move file Multiple selections are not possible.'
        return
      end
      echo '================================================================'
      echo 'inote files'
      echo '================================================================'
      find "$INOTE_PATH" -type f | string sub -s (string length "12$INOTE_PATH")
      echo '================================================================'
      read -p 'echo "Move to> "' -l MOVE_TO
      test -z "$MOVE_TO"; and return
      set CREATE_DIR (dirname $MOVE_TO)
      mkdir -p "$INOTE_PATH/$CREATE_DIR"
      mv "$INOTE_PATH/$SELECTED" "$INOTE_PATH/$MOVE_TO"
      inote
    case 'ctrl-i' # New
      set CREATE_DIR (dirname $QUERY)
      mkdir -p "$INOTE_PATH/$CREATE_DIR"
      touch "$INOTE_PATH/$QUERY"
      s "$INOTE_PATH/$QUERY"
    case 'ctrl-s' # Search
      for f in (find "$INOTE_PATH" -type f | string sub -s (string length "12$INOTE_PATH"))
        for l in (cat "$INOTE_PATH/$f")
          echo "$f: $l"
        end
      end | fzf --tac | sed -e 's/:.*$//' | read -l result
      inote "$result"
    case 'enter' # Open
      for f in $SELECTED
        s "$INOTE_PATH/$f"
      end
    end
  end

end
