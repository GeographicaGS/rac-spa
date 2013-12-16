test -r ~/.alias && . ~/.alias
PS1='GRASS 6.4.2 (TroisFourches):\w > '
PROMPT_COMMAND="'/usr/local/gis/grass-6.4.2/grass-6.4.2/etc/prompt.sh'"
export PATH="/usr/local/gis/grass-6.4.2/grass-6.4.2/bin:/usr/local/gis/grass-6.4.2/grass-6.4.2/scripts:/home/malkab/.grass6/addons:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
export HOME="/home/malkab"
export GRASS_SHELL_PID=$$
trap "echo \"GUI issued an exit\"; exit" SIGQUIT
