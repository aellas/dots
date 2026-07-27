{ pkgs, lib, ... }:

let
  st-custom = pkgs.stdenv.mkDerivation rec {
    pname = "st-custom";
    version = "0.9.3";

    src = pkgs.fetchFromGitHub {
      owner = "bakkeby";
      repo = "st-flexipatch";
      rev = "master";
      hash = "sha256-bYhitRKHlrHcWZ2qDIajH98QHGXbe5ti+fZf9D3AFxU=";
    };
    nativeBuildInputs = with pkgs; [
      pkg-config
      python3
    ];

    buildInputs = with pkgs; [
      fontconfig
      freetype
      harfbuzz
      libX11
      libXext
      libXft
      libXinerama
      libXrender
    ];

    postPatch = ''
      # ----------------------------------------------------------
      # Enable patches
      # ----------------------------------------------------------

      substituteInPlace patches.def.h \
        --replace-fail "#define ALPHA_PATCH 0" \
                       "#define ALPHA_PATCH 1" \
        --replace-fail "#define ANYSIZE_PATCH 0" \
                       "#define ANYSIZE_PATCH 1" \
        --replace-fail "#define BOXDRAW_PATCH 0" \
                       "#define BOXDRAW_PATCH 1" \
        --replace-fail "#define CLIPBOARD_PATCH 0" \
                       "#define CLIPBOARD_PATCH 1" \
        --replace-fail "#define LIGATURES_PATCH 0" \
                       "#define LIGATURES_PATCH 1" \
        --replace-fail "#define SCROLLBACK_PATCH 0" \
                       "#define SCROLLBACK_PATCH 1" \
        --replace-fail "#define SCROLLBACK_MOUSE_PATCH 0" \
                       "#define SCROLLBACK_MOUSE_PATCH 1" \
        --replace-fail "#define SCROLLBACK_MOUSE_ALTSCREEN_PATCH 0" \
                       "#define SCROLLBACK_MOUSE_ALTSCREEN_PATCH 1" \
        --replace-fail "#define XRESOURCES_PATCH 0" \
                       "#define XRESOURCES_PATCH 1"

      # Some revisions call the scrollback mouse options slightly
      # differently. Enable them when present.
      sed -i \
        -e 's/#define SCROLLBACK_MOUSE_PATCH 0/#define SCROLLBACK_MOUSE_PATCH 1/' \
        -e 's/#define SCROLLBACK_MOUSE_ALTSCREEN_PATCH 0/#define SCROLLBACK_MOUSE_ALTSCREEN_PATCH 1/' \
        -e 's/#define SCROLLBACK_MOUSE_INCREMENT_PATCH 0/#define SCROLLBACK_MOUSE_INCREMENT_PATCH 1/' \
        patches.def.h

      cp config.def.h config.h

      # ----------------------------------------------------------
      # Font and general appearance
      # ----------------------------------------------------------

      sed -i \
        -e 's|^static char \*font = .*|static char *font = "IosevkaTerm Nerd Font:pixelsize=18:antialias=true:autohint=true";|' \
        -e 's|^static int borderpx = .*|static int borderpx = 10;|' \
        -e 's|^static char \*termname = .*|static char *termname = "st-256color";|' \
        config.h

      # Set transparency when the alpha variable exists.
      sed -i \
        -E 's/^(static )?(const )?float alpha = [^;]+;/static float alpha = 0.95;/' \
        config.h

      # ----------------------------------------------------------
      # Tokyo Night
      # ----------------------------------------------------------

      python3 - <<'PY'
      from pathlib import Path
      import re

      path = Path("config.h")
      text = path.read_text()

      tokyo_night = r"""
      static const char *colorname[] = {
          /*  0: black   */ "#15161e",
          /*  1: red     */ "#f7768e",
          /*  2: green   */ "#9ece6a",
          /*  3: yellow  */ "#e0af68",
          /*  4: blue    */ "#7aa2f7",
          /*  5: magenta */ "#bb9af7",
          /*  6: cyan    */ "#7dcfff",
          /*  7: white   */ "#a9b1d6",

          /*  8: bright black   */ "#414868",
          /*  9: bright red     */ "#ff899d",
          /* 10: bright green   */ "#b9f27c",
          /* 11: bright yellow  */ "#ffcb6b",
          /* 12: bright blue    */ "#82aaff",
          /* 13: bright magenta */ "#c099ff",
          /* 14: bright cyan    */ "#86e1fc",
          /* 15: bright white   */ "#c0caf5",

          /* Extra colours */
          [255] = 0,
          "#c0caf5",
          "#1a1b26",
          "#7aa2f7",
      };
      """

      pattern = re.compile(
          r'static const char \*colorname\[\]\s*=\s*\{.*?\n\};',
          re.DOTALL,
      )

      text, replacements = pattern.subn(tokyo_night.strip(), text, count=1)

      if replacements == 0:
          raise RuntimeError("Could not find colorname[] in config.h")

      replacements = {
          r'static unsigned int defaultfg = \d+;':
              'static unsigned int defaultfg = 256;',
          r'static unsigned int defaultbg = \d+;':
              'static unsigned int defaultbg = 257;',
          r'static unsigned int defaultcs = \d+;':
              'static unsigned int defaultcs = 258;',
          r'static unsigned int defaultrcs = \d+;':
              'static unsigned int defaultrcs = 257;',
      }

      for pattern, replacement in replacements.items():
          text = re.sub(pattern, replacement, text)

      path.write_text(text)
      PY
    '';

    makeFlags = [
      "CC=${pkgs.stdenv.cc.targetPrefix}cc"
    ];

    installFlags = [
      "PREFIX=$(out)"
    ];

    preInstall = ''
      mkdir -p "$out/bin"
    '';

    meta = {
      description = "Custom patched build of the st terminal";
      homepage = "https://github.com/bakkeby/st-flexipatch";
      license = lib.licenses.mit;
      platforms = lib.platforms.linux;
      mainProgram = "st";
    };
  };
in
{
  home.packages = with pkgs; [
    st-custom
    nerd-fonts.iosevka-term
  ];
}
