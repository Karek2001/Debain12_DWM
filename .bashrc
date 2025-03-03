alias i='sudo apt install'
alias u='sudo apt update && sudo apt upgrade'
alias q='apt list --installed'
alias r='sudo apt remove'
alias e='sudo nano'
alias vi='vim'
alias ll='ls -a -l'
alias windsurf='windsurf --no-sandbox --user-data-dir'
alias telegram='flatpak run org.telegram.desktop'
alias postman='~/Programs/Postman/Postman'
alias teamspeak='~/Program/TeamSpeak6/TeamSpeak'
alias remmina='flatpak run org.remmina.Remmina'
export XDG_CURRENT_DESKTOP=dwm
export XDG_SESSION_TYPE=x11

# Add this line at the end of the file
if [ "$TERM" = "st-256color" ]; then
fastfetch
