ARG PYTHON_VERSION=3.14
ARG TEXLIVE_VERSION=2025
FROM jeesoo9595/latex-matplotlib:${PYTHON_VERSION}_${TEXLIVE_VERSION}-inkscape

ARG TEXLIVE_VERSION=2025
ARG TEX_ARCHIVE="https://ftp.math.utah.edu/pub/tex/historic"

ENV LC_ALL=C
ENV TLREPO="${TEX_ARCHIVE}/systems/texlive/${TEXLIVE_VERSION}/tlnet-final"

RUN tlmgr option repository "$TLREPO" && \
    tlmgr update --self && \
    tlmgr install \
        # Default requirements; can be updated if needed.
        amsmath \
        amsfonts \
        graphics \
        caption \
        siunitx \
        threeparttable \
        booktabs \
        makecell \
        multirow \
        hyperref \
        cite \
        preprint \
        kastrup \
        standalone \
        microtype \
        # MCPL comment
        latexmk \
        kotex-utf \
        kotex-plain \
        nanumtype1 \
        todonotes \
        setspace \
        # Utilities
        texcount \
        lineno \
        # cfflatex dependencies
        lt3luabridge \
        lua-tinyyaml

# cfflatex is not in the TeX Live repository, so install its GitHub release.
ARG CFFLATEX_VERSION=0.2.0
ARG CFFLATEX_SHA256=d28ee4ae1aaa4a731d2f975f0ce5860f027083b01ca230da5c144fb06f83288f
RUN work="$(mktemp -d)" \
    && curl --fail --silent --show-error --location --output "$work/cfflatex.zip" \
        "https://github.com/JSS95/cfflatex/releases/download/v${CFFLATEX_VERSION}/cfflatex-${CFFLATEX_VERSION}.zip" \
    && echo "${CFFLATEX_SHA256}  ${work}/cfflatex.zip" | sha256sum --check \
    && texmf="$(kpsewhich -var-value TEXMFLOCAL)" \
    && unzip -j "$work/cfflatex.zip" cfflatex/cfflatex.sty cfflatex/cfflatex.lua \
        -d "$texmf/tex/latex/cfflatex" \
    && mktexlsr "$texmf" \
    && rm -rf "$work"

# Fonts
RUN tlmgr install \
        collection-fontsrecommended \
        newtx \
        sansmath \
        newtxsf

LABEL repository="https://github.com/JSS95/docker-mcpl-paper" \
      maintainer="Jisoo Song <jeesoo9595@snu.ac.kr>"
