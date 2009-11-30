import .User;

class Mybot {
	inherit User;
	string Comchar;
	void handle(string data) {
		write ("--> " + data + "\n");
		//Check for PING
		if(Regexp.match("^PING", data)) {
			if(array ping = Regexp.split2("PING (.*)", data)) {
				raw("PONG " + ping[1]); //Send it straight back at 'em!
			}
		}
		else {
			Sender sender = Sender();
			array info = ({});
			string message;
			if(Regexp.split2(":(.*?)!(.*?)@(.*?) PRIVMSG (.*?) :(.*?)", data) != 0) {
				info = Regexp.split(":(.*?)!(.*?)@(.*?) PRIVMSG (.*?) :(.+)", data);
				
				//TODO: Investigate structs
				sender->nick = info[0];
				sender->name = info[1];
				sender->host = info[2];
				sender->dest = info[3];
				message = info[4];
			
				if(array command = Regexp.split("^"+Comchar+"(.+)", message)) {
						write(command[0]);
				}
			}
		}
	}
}

int main()
{
	Mybot bot = Mybot();
	bot->Server = "irc.eighthbit.net";
	bot->Nick = "Badbot";
	bot->Userln = "badbot badbot badbot badbot";
	bot->Port = 6667;
	bot->Channels = ({"#bots"});
	bot->Comchar = "%";
	bot->connect();
	bot->nick(bot->Nick);
	bot->raw("USER " + bot->Userln);
	while(1) {
		bot->read();
	}
}


