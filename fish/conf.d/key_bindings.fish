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

# enable keybindings
function fish_user_key_bindings
  bind ! bind_bang
  bind '$' bind_dollar
  bind "&&" 'commandline -i "; and"'
  bind "||" 'commandline -i "; or"'
end