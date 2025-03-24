{ config, pkgs, ... }:

{
  home.file = {
    "${config.xdg.configHome}/zsh-custom/themes/rankaviita.zsh-theme".source = ./rankaviita.zsh-theme;
  };

  programs = {
    alacritty = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./alacritty.toml);
    };
    zsh = {
      enable = true;
      enableCompletion = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "cabal" "colored-man-pages" "colorize" "command-not-found" "stack" "timer" ];
        theme = "rankaviita";
        custom = "$HOME/.config/zsh-custom";
      };

      initExtra = ''
        stty erase 
        
        bindkey -v
        bindkey '^?' backward-delete-char
        bindkey '^r' history-incremental-search-backward
        bindkey '^u' kill-whole-line
        bindkey '^e' end-of-line
        
        function zle-line-init zle-keymap-select {
          VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
          RPS1="''${''${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
          zle reset-prompt
        }
        zle -N zle-line-init
        zle -N zle-keymap-select
      '';
    };
  };
}
