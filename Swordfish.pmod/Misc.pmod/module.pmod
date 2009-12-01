class Message {
	string msg;
	Sender sender;
	void create(string Data) {
		array info = Regexp.split(":(.*?)!(.*?)@(.*?) PRIVMSG (.*?) :(.*)", Data);
		sender = Sender(info);
		msg = info[4];
	}
}

class Sender {

        string nick;
        string host;
        string dest;
        string name;
	void create(array info) {
                nick = info[0];
                name = info[1];
                host = info[2];
                dest = info[3];
	}

}





