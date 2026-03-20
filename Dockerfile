ARG PYTHON_VERSION
ARG TEXLIVE_VERSION
FROM jeesoo9595/latex-matplotlib:${PYTHON_VERSION}_${TEXLIVE_VERSION}-inkscape

ARG TEXLIVE_VERSION

RUN tlmgr option repository "https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/${TEXLIVE_VERSION}/tlnet-final" && \
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
        # MCPL comment
        latexmk \
        kotex-utf \
        kotex-plain \
        nanumtype1 \
        todonotes \
        setspace

LABEL repository="https://github.com/JSS95/docker-mcpl-paper" \
      maintainer="Jisoo Song <jeesoo9595@snu.ac.kr>"
