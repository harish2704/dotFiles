
addSsh(){
	mkdir -p ~/.ssh && read rsa && echo "$rsa" >> ~/.ssh/authorized_keys
}

