{ fetchurl, makeWrapper, appimageTools, lib, }:
appimageTools.wrapType2 rec {
  pname = "hayase";
  version = "6.4.22";

  src = fetchurl {
    url =
      "https://github.com/hayase-app/ui/releases/download/v${version}/linux-hayase-${version}-linux.AppImage";
    name = "${pname}-${version}.AppImage";
    sha256 = "1av3j0k0h9c7wzscd5xjzqh66jhh05z0i5lsdvij7prlhd7yqhn5";
  };

  nativeBuildInputs = [ makeWrapper ];

  extraInstallCommands =
    let contents = appimageTools.extractType2 { inherit pname version src; };
    in ''
      # Create necessary directories
      mkdir -p "$out/share/applications"
      mkdir -p "$out/share/pixmaps"

      # Install desktop file if it exists
      if [ -f "${contents}/${pname}.desktop" ]; then
        cp "${contents}/${pname}.desktop" "$out/share/applications/"
        substituteInPlace "$out/share/applications/${pname}.desktop" \
          --replace 'Exec=AppRun' 'Exec=${pname}'
      fi

      # Install icon if it exists
      for icon in "${contents}"/*.png "${contents}"/*.svg; do
        if [ -f "$icon" ]; then
          cp "$icon" "$out/share/pixmaps/${pname}.png"
          break
        fi
      done
    '';

  meta = with lib; {
    description = "A modern anime streaming application";
    homepage = "https://github.com/hayase-app/ui";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = "hayase";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
}
