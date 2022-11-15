grc_plugin_execs=(
  df diff dig ifconfig ping traceroute make mount tail du env last uptime w who tcpdump sysctl stat ps docker
)

for executable in $grc_plugin_execs; do
  alias $executable="grc $executable"
done
