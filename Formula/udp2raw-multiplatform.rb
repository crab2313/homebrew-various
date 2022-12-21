class Udp2rawMultiplatform < Formula
  desc "Multi-platform(cross-platform) version of udp2raw-tunnel. Client-Only."
  homepage "https://github.com/wangyu-/udp2raw-multiplatform"
  url "https://github.com/wangyu-/udp2raw-multiplatform/archive/refs/tags/20210111.0.tar.gz"
  sha256 "712ad3c79b6ef5bf106c615823d0b0b3865d1c957f9838cf05c23b7ac7024438"
  license "MIT"

  depends_on "make" => :build
  depends_on "libnet"

  patch :p1, :DATA

  def install
    system "make", "mac"
    bin.install "udp2raw_mp"
    etc.install "example.conf" => "udp2raw_client.conf"
  end

  service do
    run [bin/"udp2raw_mp", "--conf-file", etc/"udp2raw_client.conf"]
    # keep_alive true
    require_root true
  end
end

__END__
diff --git a/makefile b/makefile
index 9e54570..39d84f0 100755
--- a/makefile
+++ b/makefile
@@ -14,7 +14,7 @@ COMMON=main.cpp lib/md5.cpp encrypt.cpp log.cpp network.cpp common.cpp  connecti
 
 PCAP="-lpcap"
 
-LIBNET=-D_DEFAULT_SOURCE `libnet-config --defines` `libnet-config --libs`
+LIBNET=-D_DEFAULT_SOURCE `libnet-config --defines` `libnet-config --libs` `libnet-config --cflags`
 
 
 SOURCES= $(COMMON) lib/aes_faster_c/aes.cpp lib/aes_faster_c/wrapper.cpp lib/pbkdf2-sha1.cpp lib/pbkdf2-sha256.cpp
