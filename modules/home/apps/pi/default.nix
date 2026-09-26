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
        "npm:@narumitw/pi-plan-mode"
        "npm:cc-safety-net"
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
    "${cfgDir}/skills/how/SKILL.md".source = ./how/SKILL.md;
    "${cfgDir}/skills/review/SKILL.md".source = ./review/SKILL.md;
    "${cfgDir}/skills/why/SKILL.md".source = ./why/SKILL.md;
  };
}
