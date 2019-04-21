#!/usr/bin/env fish
#
# To load in ~/.config/fish/fish.conf or a new file in
# ~/.config/fish/conf.d add:
# source /etc/grc.fish (path may depend on install method)
#
# See also the plugin at https://github.com/oh-my-fish/plugin-grc

set -U grc_plugin_execs df diff dig ifconfig ping traceroute make mount tail \
        du env last uptime w who tcpdump sysctl stat pstree
    #    docker docker-machine \

for executable in $grc_plugin_execs
    if type -q $executable
        alias $executable "grc $executable"
    end
end
