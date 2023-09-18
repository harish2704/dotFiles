
mkdir -p ~/.local/share/tkthemes
cp -r /usr/share/PySolFC/themes/clearlooks/ ~/.local/share/tkthemes/
echo "export TCLLIBPATH=~/.local/share/tkthemes" >> ~/.bashrc
nv ~/.Xdefaults
