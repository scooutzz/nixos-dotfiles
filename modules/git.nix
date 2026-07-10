{pkgs, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "Fabio de Almeida";
      user.email = "fabioalmeida2004@gmail.com";
      init.defaultBranch = "main";
      core.editor = "nvim";

      url."git@github.com:".pushInsteadOf = "https://github.com/";

      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };
  };

  programs.ssh.matchBlocks = {
    "github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/id_ed25519";
      extraOptions = {
        StrictHostKeyChecking = "accept-new";
      };
    };
  };
}
