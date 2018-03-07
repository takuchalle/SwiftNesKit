TOOL_NAME = nes-disasm
VERSION = 0.0.2

PREFIX?=/usr/local
INSTALL_PATH = $(PREFIX)/bin/$(TOOL_NAME)
BUILD_PATH = .build/release/$(TOOL_NAME)
REPO = https://github.com/takuyaohashi/SwiftNes
RELEASE_TAR = $(REPO)/archive/$(VERSION).tar.gz
SHA = $(shell curl -L -s $(RELEASE_TAR) | shasum -a 256 | sed 's/ .*//')

.PHONY: install build test lint clean xcode update_brew

build:
	swift build --disable-sandbox -c release -Xswiftc -static-stdlib

test:
	swift test

lint:
	swiftlint

clean:
	swift package clean

xcode:
	swift package generate-xcodeproj

update_brew:
	sed -i '' 's|\(url ".*/archive/\)\(.*\)\(.tar\)|\1$(VERSION)\3|' Formula/swiftnes.rb
	sed -i '' 's|\(sha256 "\)\(.*\)\("\)|\1$(SHA)\3|' Formula/swiftnes.rb

	git add .
	git commit -m "Update brew to $(VERSION)"

install: build
	mkdir -p "$(PREFIX)/bin"
	cp -f $(BUILD_PATH) $(INSTALL_PATH)
