# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)

# ------------------------------------------------------------------

# variáveis de configuração:

MAILTO="<email>" #separar por vírgula, sem espaços
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "É preciso ter instalado os pacotes postfix e mailutils para o envio de e-mails funcionar."
echo "Além disso o node precisa estar na PATH instalado para o root."
echo ""

echo "Os e-mails serão enviados para: $MAILTO"
echo "A pasta onde os jobs se encontram é: $DIR"
echo ""

command -v node >/dev/null 2>&1 || { echo >&2 "Node não está no PATH do root.  Aborting."; exit 1; }

# listar os jobs na lista abaixo
# rodam no horario da máquina, cuidado com UTC

cat <<EOF > crontab.conf
# arquivo gerado pelo arquivo: $0
MAILTO="$MAILTO"
# min hora dia mes diaDaSemana comando
# * * * * * $DIR/runNodeJob.sh <nodejobfile>
EOF

echo ""
echo "Arquivo de configuração gerado"

if crontab -u root crontab.conf; then
    echo "Rotinas agendadas"
    echo ""
    crontab -l
else
    echo "Erro a o configurar o crontab"
fi
