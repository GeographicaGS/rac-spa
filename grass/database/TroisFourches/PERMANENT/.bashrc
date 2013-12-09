test -r ~/.alias && . ~/.alias
PS1='GRASS 6.4.3 (TroisFourches):\w > '
PROMPT_COMMAND="'/usr/local/grass-6.4.3/etc/prompt.sh'"
export PATH="/usr/local/grass-6.4.3/bin:/usr/local/grass-6.4.3/scripts:/home/malkab/.grass6/addons:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
export HOME="/home/malkab"
export GRASS_SHELL_PID=$$
trap "echo \"GUI issued an exit\"; exit" SIGQUIT
