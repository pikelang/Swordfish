import .Sender;
class Message {
	string msg;
	string command;
	string dest;
	Sender sender;
	void create(string Data) {
		array info = Regexp.split(":(.*?) (.*)",  Data);
		sender = Sender(info[0]);
		array msginfo = Regexp.split("(.*?) (.*?) :(.*)", info[1]);
		command = msginfo[0];
		dest = msginfo[1];
		msg = msginfo[2];
	}
}

