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
        # import-citation-cff dependencies
        lt3luabridge \
        lua-tinyyaml

# Fonts
RUN tlmgr install \
        collection-fontsrecommended \
        newtx \
        sansmath \
        newtxsf

# import-citation-cff (formerly cfflatex) is on CTAN since 2026, so TeX Live
# 2026 and later install it with tlmgr. Older TeX Live releases build the
# pinned GitHub source release with l3build instead.
# IMPORT_CITATION_CFF_VERSION and IMPORT_CITATION_CFF_SHA256 apply only then.
ARG IMPORT_CITATION_CFF_VERSION=0.4.0
ARG IMPORT_CITATION_CFF_SHA256=73ad64950992f4a50502ddea4f557133ca1227a1bdef4d81a3b1ac429e5212fd
RUN if [ "$TEXLIVE_VERSION" -ge 2026 ]; then \
        tlmgr install import-citation-cff; \
    else \
        tlmgr install l3build \
        && work="$(mktemp -d)" \
        && curl --fail --silent --show-error --location --output "$work/source.tar.gz" \
            "https://github.com/JSS95/cfflatex/archive/refs/tags/v${IMPORT_CITATION_CFF_VERSION}.tar.gz" \
        && echo "${IMPORT_CITATION_CFF_SHA256}  ${work}/source.tar.gz" | sha256sum --check \
        && tar -xzf "$work/source.tar.gz" -C "$work" --strip-components=1 \
        && texmf="$(kpsewhich -var-value TEXMFLOCAL)" \
        # l3build links the cfflatexpand command into CFFLATEXPAND_BINDIR.
        # --full is not used, because it typesets the manual first.
        && (cd "$work" && CFFLATEXPAND_BINDIR=/usr/local/bin \
            l3build install --texmfhome "$texmf") \
        && mktexlsr "$texmf" \
        && rm -rf "$work"; \
    fi

LABEL repository="https://github.com/JSS95/docker-mcpl-paper" \
      maintainer="Jisoo Song <jeesoo9595@snu.ac.kr>"
