{ ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      "statusbar-home-tilde" = true;
      "scroll-page-aware" = true;
      "adjust-open" = "width";
      "font" = "JetBrains Mono 12";
      "recolor-darkcolor" = "#dddddd"; # Light text color
      "recolor-lightcolor" = "rgba(0,0,0,0.5)";  # Transparent black background
      "recolor" = true;
      "recolor-keephue" = true;
      "recolor-reverse-video" = true;
      "default-bg" = "rgba(0,0,0,0.5)"; # Semi-transparent black background
      "index-bg" = "rgba(0,0,0,0.7)";
      "index-active-bg" = "#111111";
      "index-active-fg" = "#FFFFFF";
      "inputbar-bg" = "rgba(0,0,0,0.8)";
      "inputbar-fg" = "#CCCCCC";
      "statusbar-bg" = "rgba(0,0,0,0.7)";
      "statusbar-fg" = "#CCCCCC";
      "render-loading" = false;
      "selection-clipboard" = "clipboard";
      "database" = "sqlite";
    };
  };
}
