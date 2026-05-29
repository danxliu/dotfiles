{
  ...
}:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
      set -g fish_key_bindings fish_vi_key_bindings

      function fish_prompt
        set_color black -b blue
        echo -n " $hostname 󰘧 "
        set_color normal
        echo -n " "
        printf '%s' (prompt_pwd --full-length-dirs 2)
        echo -n " "
      end

      function fish_right_prompt
        set -l git_status (fish_git_prompt)
        set -l duration "$CMD_DURATION"

        if test -n "$git_status"
          echo -n "$git_status "
        end

        if test -n "$duration"
          set_color black -b blue
          echo -n " $duration"
          echo -n "ms "
        end
        set_color normal
      end

      function fish_mode_prompt
        commandline -f repaint
      end
    '';
  };
}
