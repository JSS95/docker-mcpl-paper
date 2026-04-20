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
        setspace

# Fonts
RUN tlmgr install \
        collection-fontsrecommended \
        newtx \
        sansmath \
        newtxsf

LABEL repository="https://github.com/JSS95/docker-mcpl-paper" \
      maintainer="Jisoo Song <jeesoo9595@snu.ac.kr>"
