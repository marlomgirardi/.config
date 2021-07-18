# enables !!
function bind_bang
  switch (commandline -t)
    case "!"
      commandline -t $history[1]; commandline -f repaint
    case "*"
      commandline -i !
  end
end

# enables !$
function bind_dollar
  switch (commandline -t)
    case "!"
      commandline -t ""
      commandline -f history-token-search-backward
    case "*"
      commandline -i '$'
  end
end

# Copy selected text
function copy_selected
  # iTerm is set to copy on select.
  set copied (pbpaste)
  open "https://www.google.com/search?q=$copied"
end

# enable keybindings
function fish_user_key_bindings
  bind ± copy_selected
  bind ! bind_bang
  bind '$' bind_dollar
  bind "&&" 'commandline -i "; and"'
  bind "||" 'commandline -i "; or"'
end