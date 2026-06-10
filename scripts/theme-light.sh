#! /bin/sh
echo "Light Theme [Rose Pine Dawn]"
ln -sf ~/.dots/yazi/theme-light.toml ~/.dots/yazi/theme.toml
ln -sf ~/.dots/kitty/rose-pine-dawn.conf ~/.dots/kitty/theme.conf
ln -sf ~/.dots/nvim/lua/theme/theme-light.lua ~/.dots/nvim/lua/theme/init.lua
ln -sf ~/.dots/quickshell/ThemeLight.qml ~/.dots/quickshell/Theme.qml
ln -sf ~/.dots/hypr/wallpapers/light.jpg ~/.dots/hypr/wallpapers/wp

pkill quickshell && quickshell -d
hyprctl hyprpaper wallpaper ,"~/.config/hypr/wallpapers/wp"
