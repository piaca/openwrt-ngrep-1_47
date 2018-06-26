#
# Copyright (C) 2007-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ngrep
PKG_VERSION:=V1_47
PKG_RELEASE:=3

PKG_SOURCE:=$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/jpr5/ngrep/archive/
PKG_HASH:=dc4dbe20991cc36bac5e97e99475e2a1522fd88c59ee2e08f813432c04c5fff3
PKG_BUILD_DIR:=$(BUILD_DIR)/ngrep-1_47

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ngrep
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libpcap +libpcre
  TITLE:=network grep
  URL:=http://ngrep.sourceforge.net
endef

define Package/ngrep/description
	ngrep a pcap-aware tool that will allow you to specify extended
	regular expressions to match against data payloads of packets. It
	currently recognizes TCP, UDP, and ICMP across Ethernet, PPP, SLIP,
	FDDI, Token Ring and null interfaces, and understands BPF filter
	logic in the same fashion as more common packet sniffing tools,
	like tcpdump and snoop.
endef

CONFIGURE_ARGS+= \
	--with-pcap-includes=$(STAGING_DIR)/usr/include \
	--enable-pcre \
	--with-pcre=$(STAGING_DIR)/usr \
	--disable-dropprivs \

CONFIGURE_VARS+= \
	LDFLAGS="$(TARGET_LDFLAGS) -lpcre" \

define Package/ngrep/install	
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/ngrep $(1)/usr/bin/
endef

$(eval $(call BuildPackage,ngrep))
