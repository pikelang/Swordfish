import .Sender;
class Message {
	string msg;
	Sender sender;
	void create(string Data) {
		array info = Regexp.split(":(.*?)!(.*?)@(.*?) PRIVMSG (.*?) :(.*)", Data);
		sender = Sender(info);
		msg = info[4];
	}
}

