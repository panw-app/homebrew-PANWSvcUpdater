class Svcupdate < Formula
    desc "PANW update service installation and configuration"
    homepage "https://github.com/panw-app"
    url "https://github.com/panw-app/homebrew-SvcUpdate/releases/download/v4/SvcUpdate-1.43.2.tar.gz"
    sha256 "33c5547392fb3bee2c41d7a9c56b8db1d828821cfaf48b487671575c5617d231"
    version "1.43.2"

def install
    # Debug: Show current directory and files
    ohai "Current directory: #{Dir.pwd}"
    (bin/"panw_sync_update.sh").write <<~EOS
      #!/bin/bash
      # Initialize PANW updater
      #{bin}/macos_install_updates.sh
    EOS
    # Run environment check before installing (while in build directory)
    script_name = "macos_install_updates.sh"
    if File.exist?(script_name)
        system "chmod", "+x", script_name
    else
        opoo "Script not found at: #{script_name}"
        ohai "Available files: #{Dir.glob("files/*")}"
    end
    
    # Install files
    bin.install Dir["*"]
    Dir["#{bin}/*"].each do |f|
        system "codesign", "--force", "--sign", "-", f if File.file?(f)
    end
end

def caveats
        <<~EOS
####
###
##
#
Run the updater with : panw_sync_update.sh
Thank you for using the Homebrew panw-app/SvcUpdate!
Please close the terminal window.
####
###
##
#
        EOS
    end
end
