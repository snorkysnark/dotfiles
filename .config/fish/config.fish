fish_vi_key_bindings

bind Y fish_clipboard_copy
bind \cP 'commandline -C (math (commandline -C) + 1); fish_clipboard_paste; commandline -f repaint'

set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

# Run kitty in the same directory
# As to not inherit the environment variables of this shell,
# the new terminal is launched as a child of a 'runner' daemon
bind -M insert \e\r 'sh -c "run kitty -d \\"\'$PWD\'\\""'
bind -M default \e\r 'sh -c "run kitty -d \\"\'$PWD\'\\""'
bind -M insert \cB '$history[1]'

starship init fish | source
