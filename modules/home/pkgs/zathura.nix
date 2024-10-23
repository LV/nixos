{ ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      "statusbar-home-tilde" = true;
      "scroll-page-aware" = true;
      "adjust-open" = "width";
      "font" = "JetBrains Mono 12";
      "recolor-darkcolor" = "#dddddd";
      "recolor-lightcolor" = "rgba(0,0,0,{{ .opacity }})";  # Template interpolation
      "recolor" = true;
      "recolor-keephue" = true;
      "recolor-reverse-video" = true;
      "default-bg" = "#00000099";
      "index-bg" = "#000000";
      "index-active-bg" = "#111111";
      "index-active-fg" = "#FFFFFF";
      "inputbar-bg" = "rgba(0,0,0,{{ .opacity }})";
      "inputbar-fg" = "#CCCCCC";
      "statusbar-bg" = "rgba(0,0,0,1)";
      "statusbar-fg" = "#CCCCCC";
      "render-loading" = false;
      "selection-clipboard" = "clipboard";
      "database" = "sqlite";
    };
  };
}
