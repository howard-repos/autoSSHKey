#!/usr/bin/env expect
proc copyKey {server password} {
	spawn ssh-copy-id $server
	expect {
		"password:" { send "$password\r";exp_continue }
		"to make sure we haven't added extra keys that you weren't expecting" {send_user "finished!\n";exit 0}
		default { myExit $server}
	}
}
proc myExit {host} {
	send_user "\nerror!please run ssh-copy-id $host yourself..\n";exit 1
}

set timeout 3
set server  [lindex $argv 0] 
set passwd [lindex $argv 1] 
set command {echo "NEU need $(sudo id -nu)"}
log_user 0
spawn ssh -t $server $command
expect {
	"NEU need root" { send_user "SSH already established, will do nothing\n";exit 0 }
	"(yes/no)?" { send "yes\r";exp_continue }
	"password:" {
		send "$passwd\r";
		expect {
			"NEU need root" { sleep 1;copyKey $server $passwd}
			default { myExit $server }
		} 
	}
	default { myExit $server }
}
