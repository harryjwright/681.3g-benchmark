# Variables
LATEX = pdflatex
BIB   = biber
MAIN  = article_gemini

.PHONY: all
all:
	$(LATEX) $(MAIN)
	$(BIB) $(MAIN)
	$(LATEX) $(MAIN)
	$(LATEX) $(MAIN)

.PHONY: clean
clean:
	find . -mindepth 2 -type f \( \
		-name "*.aux" -o \
		-name "*.log" -o \
		-name "*.toc" -o \
		-name "*.bcf" -o \
		-name "*.bbl" -o \
		-name "*.blg" -o \
		-name "*.run.xml" -o \
		-name "*.fls" -o \
		-name "*.lof" -o \
		-name "*.lot" -o \
		-name "*.out" -o \
		-name "*.fdb_latexmk" -o \
		-name "*.synctex(busy)" -o \
		-name "*.synctex.gz" \
	\) -delete

.PHONY: strip
strip:
	@echo "Stripping metadata from all PDFs..."
	find . -name "*.pdf" -exec exiftool -all= -overwrite_original {} +
	@echo "Cleanup complete."
	#exiftool -all= -overwrite_original IMG_20260214_185953.jpg

.PHONY: biber
biber:
	find . -name "*.tex" -exec sh -c 'biber $${0%.tex}' {} \;

.PHONY: sha
sha:
	@echo "[!] INITIALISING FORENSIC SNAPSHOT..."
	@date +%F_%T > .last_audit
	@find . -type f ! -name "*.sha256" -exec sha256sum {} + > manifest_$$(date +%F_%H%M).sha256
	@echo "[+] HASH COMPLETE. MANIFEST GENERATED."
	@echo "[+] SIGNAL SECURED."

.PHONY: audit
audit:
	@echo "[?] VERIFYING INTEGRITY AGAINST LATEST MANIFEST..."
	@sha256sum -c $$(ls -t *.sha256 | head -n 1)

.PHONY: plex
plex:
	# 1. Create a working directory
	mkdir -p ~/ibm-plex-all && cd ~/ibm-plex-all

	# 2. Download all main IBM Plex font zip archives from GitHub
	wget https://github.com/IBM/plex/releases/download/@ibm/plex-math@1.1.0/ibm-plex-math.zip
	wget https://github.com/IBM/plex/releases/download/@ibm/plex-sans@1.1.0/ibm-plex-sans.zip
	wget https://github.com/IBM/plex/releases/download/@ibm/plex-serif@2.0.0/ibm-plex-serif.zip
	wget https://github.com/IBM/plex/releases/download/@ibm/plex-mono@2.5.0/ibm-plex-mono.zip
	wget https://github.com/IBM/plex/releases/download/@ibm/plex-sans-condensed@2.0.0/ibm-plex-sans-condensed.zip

	# 3. Create target system font folder
	mkdir -p ~/.local/share/fonts/ibm-plex

	# 4. Extract all OTF and TTF font files into the folder
	unzip -o "*.zip" "*.otf" "*.ttf" -d ~/.local/share/fonts/ibm-plex/

	# 5. Clean up temporary download files
	cd ~ && rm -rf ~/ibm-plex-all

	# 6. Rebuild System Fontconfig and LuaTeX font caches
	sudo fc-cache -f -v
	luaotfload-tool -f -u -p -v
