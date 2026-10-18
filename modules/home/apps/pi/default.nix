{ config, pkgs, ... }:

{
  age.secrets."openrouter-key" = {
    file = ../../../../secrets/openrouter-key.age;
  };

  programs.pi-coding-agent = {
    enable = true;
    models = {
      providers = {
        openrouter = {
          apiKey = "!sh -c '. ${config.age.secrets."openrouter-key".path} && echo $OPENROUTER_API_KEY'";
        };
      };
    };
    settings = {
      defaultModel = "openai/gpt-6-luna";
      defaultProvider = "openrouter";
      packages = [
        "npm:@narumitw/pi-btw"
        "npm:pi-subagents"
        "npm:pi-web-access"
      ];
    };
    extraPackages = [ pkgs.nodejs pkgs.bun ];
  };

  home.file = let
    cfgDir = config.programs.pi-coding-agent.configDir;
  in {
    "${cfgDir}/APPEND_SYSTEM.md".source = ./APPEND_SYSTEM.md;
    "${cfgDir}/skills/grill/SKILL.md".source = ./grill/SKILL.md;
  };
}
