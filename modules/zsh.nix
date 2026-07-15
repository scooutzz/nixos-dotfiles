{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos";
      vim = "nvim";
      cd = "z";
      cat = "bat";
      ls = "eza -lh --group-directories-first --icons=auto";
      lsa = "ls -a";
      lt = "eza --tree --level=2 --long --icons --git";
      lta = "lt -a";
    };
    setOptions = [
      "PROMPT_SUBST"
      "HIST_IGNORE_DUPS"
      "HIST_IGNORE_SPACE"
      "SHARE_HISTORY"
    ];
    initContent = ''
      zstyle ':completion:*' list-suffixes true
      zstyle ':prompt:*:' truncate-to-parent true

      autoload -Uz vcs_info
      zstyle ':vcs_info:*' enable git svn
      zstyle ':vcs_info:git*' formats '%F{magenta}%b%f '
      precmd() { vcs_info; }

      prompt='%F{8}''${name:+[$name] }%f%F{green}%n%f %F{blue}%(3~|../%2~|%2~)%f ''${vcs_info_msg_0_}%F{white}$%f '

      bindkey -s ^f "tmux-sessionizer\n"

      nitch
    '';
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
  };
  programs.zoxide.enable = true;

  home.packages = with pkgs; [
    eza
    bat
    nitch
  ];
}
