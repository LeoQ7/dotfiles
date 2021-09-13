function proxyon
    set winip (ip route | grep default | awk '{print $3}')
    set addr $winip":7890"
    if count $argv > /dev/null
        set addr $argv[1]
    end
    export {http,https,ftp,telnet,all,HTTP,HTTPS,FTP,TELNET,ALL}_{proxy,PROXY}=$addr
end