FROM debian:trixie

# Gestion de l'env
ENV QT_QPA_PLATFORM=offscreen
ENV XDG_RUNTIME_DIR=/tmp/runtime-TidalProducer
ENV JACK_NO_AUDIO_RESERVATION=1

# Gestion des packets systeme
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git jackd2 qjackctl zlib1g-dev gcc g++ ghc cabal-install curl ca-certificates \
    neovim tmux

RUN apt-get install -y --no-install-recommends \
    supercollider sc3-plugins sc3-plugins-language sc3-plugins-server \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# User + dossier runtime Qt
RUN useradd -m -G audio TidalProducer \
    && mkdir -p /tmp/runtime-TidalProducer \
    && chown TidalProducer:audio /tmp/runtime-TidalProducer \
    && chmod 700 /tmp/runtime-TidalProducer

USER TidalProducer
WORKDIR /home/TidalProducer

RUN export VERS=$(git ls-remote https://github.com/musikinformatik/SuperDirt.git | grep tags | tail -n1 | awk -F/ '{print $NF}'); \
    echo "Quarks.checkForUpdates({Quarks.install(\"SuperDirt\", \"$VERS\"); thisProcess.recompile(); 0.exit; });" > install_superdirt.scd \
    && sclang install_superdirt.scd \
    && rm install_superdirt.scd

RUN cabal update \
    && cabal install tidal --lib


CMD ["sleep", "5000"]


#   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#   $ nvim
#   :PlugInstall


#   ?? :UndotreeToggle ?? ( a utiliser dans un fichier apparement)

# “Hacky custom completion” tidal
# Idée : quand tu tapes billybd en insertion, Vim remplace automatiquement par un pattern complet.
# Dans ton init.vim ou ~/.vimrc, ajoute par exemple :
# ```
# autocmd FileType tidal call s:tidal_abbr()
# function! s:tidal_abbr()
#     inoreabbr billybd "[t ~ ~ ~] [~ ~ ~ ~] [t ~ ~ ~] [~ ~ ~ ~]"
#     inoreabbr billysn "[~ ~ ~ ~] [t ~ ~ ~] [~ ~ ~ ~] [t ~ ~ ~]"
#     " ... tes autres snippets perso ...
# endfunction
# ```

# Ensuite, dans un buffer .tidal avec vim-tidal actif :
# tu tapes billybd en mode insertion
# au moment où tu quittes le mot (espace, entrée…), il est remplacé par le pattern complet. 
# Tidal Cycles
# Tu peux te faire une petite bibliothèque de patterns “signatures” comme ça.


# $ mkdir -p ~/.config/nvim
# nvim ~/.config/nvim/init.vim
# $ $ cat ~/.config/nvim/init.vim
# " --- Plugins ---
# call plug#begin('~/.local/share/nvim/plugged')

# " Plugin Tidal
# Plug 'tidalcycles/vim-tidal'

# " (optionnel mais recommandé) Undotree pour suivre tes impros
# Plug 'mbbill/undotree'

# call plug#end()

# " Activer les plugins par type de fichier
# filetype plugin on

# " Local leader pour les raccourcis Tidal (par ex ,ss ,h etc.)
# let maplocalleader = ","

# " Forcer l’usage du terminal natif de (Neo)Vim pour Tidal
# let g:tidal_target = "terminal"

# " (optionnel) activer un terminal SuperCollider auto lancé
# let g:tidal_sc_enable = 1            " important : démarre sclang automatiquement

# " (optionnel) : boot perso si un jour tu en veux un
# " let g:tidal_sc_boot = "/home/TidalProducer/boot-superdirt.scd"