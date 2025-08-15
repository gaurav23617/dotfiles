{ fetchurl, makeWrapper, appimageTools, lib, }:
appimageTools.wrapType2 rec {
  pname = "hayase";
  version = "6.4.11";

  src = fetchurl {
    url =
      "https://github.com/hayase-app/ui/releases/download/v${version}/linux-hayase-${version}-linux.AppImage";
    name = "${pname}-${version}.AppImage";
    sha256 = "c542ec4f8334df23e36e9a96087e01104a6320feb297c6f4e7872508269063ab";
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
