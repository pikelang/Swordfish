import .Swordfish.Connection;
import .Swordfish.Message;
import .Swordfish.Sender;
class Mybot {
	inherit Connection;
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
			array info = ({});
			if(Regexp.split2(":(.*?)!(.*?)@(.*?) PRIVMSG (.*?) :(.*?)", data) != 0) {
				Message message = Message(data);
				write(message->msg);
			
				if(array command = Regexp.split("^"+Comchar+"(.+)", message->msg)) {
					switch(command[0]-"\r"-"\n") {
						case "foo":
							send(message->sender->dest, "bar!");
							break;
						case "quit":
							quit("Quit!");
							break;
						case "action":
							action(message->sender->dest, "foo");
					}
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


