# Sample .profile for SuSE Linux
# rewritten by Christian Steinruecken <cstein@suse.de>
#
# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

test -z "$PROFILEREAD" && . /etc/profile || true

# Most applications support several languages for their output.
# To make use of this feature, simply uncomment one of the lines below or
# add your own one (see /usr/share/locale/locale.alias for more codes)
# This overwrites the system default set in /etc/sysconfig/language
# in the variable RC_LANG.
#
#export LANG=de_DE.UTF-8	# uncomment this line for German output
#export LANG=fr_FR.UTF-8	# uncomment this line for French output
#export LANG=es_ES.UTF-8	# uncomment this line for Spanish output


# Some people don't like fortune. If you uncomment the following lines,
# you will have a fortune each time you log in ;-)

#if [ -x /usr/bin/fortune ] ; then
#    echo
#    /usr/bin/fortune
#    echo
#fi
if test -z "$USER_PROFILEREAD"; then

export PATH="$HOME/node_modules/.bin:$HOME/.local/bin:$PATH";
export PATH+=:"$HOME/go/bin";
export PATH="$HOME/.cargo/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export PATH=/opt/android-sdk/platform-tools:$PATH
export USER_PROFILEREAD=1


export INPUT_METHOD=ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

fi
