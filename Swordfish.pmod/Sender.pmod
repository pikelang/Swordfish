class Sender {

        string nick;
        string host;
        string name;
	void create(string senderinfo) {
		nick = (senderinfo/"!")[0];
		name = ((senderinfo/"!")[1]/"@")[0];
		host = ((senderinfo/"!")[1]/"@")[1];
		write(nick+"\n"+name+"\n"+host+"\n");

	}

}






