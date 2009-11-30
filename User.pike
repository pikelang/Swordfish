import  Stdio;

class User {
	object Conn = File();
	string Server;
	string Nick;
	string Userln;
	string Data;
	int Port;
	array Channels;

	/**********Helper Functions*************/
	int raw(string msg) {
		write("<-- " + msg + "\n");
		Conn->write(msg + "\r\n");
		return 0;
	}

	int nick(string nickname) {
		if (raw("NICK " + nickname) != 0) {
			return 1; //Failed.
		}
		return 0;
	}

	int join(string channel) {
		if (raw("JOIN " + channel) != 0) {
			return 1; //Failed.
		}
		return 0;
	}


	/******* Connection functions ************/
	int connect(){
		if (!Conn->connect(Server,Port)) {
			write("Meep.");
			return 1; //return failure
		} else { //Connection successful
			write("Connected!\n");
			Conn->set_nonblocking();
			nick(Nick);
			raw("USER " + Userln);
			foreach(Channels, string channel) {
				join(channel);
			}
		}
		return 0;
	}

	/******* Functions that don't have a category at the moment ********/
	int read() {
		Data = Conn->read();
		if(Data != "" && Data != 0) {
			//We have data
			handle(Data); //This is a function the bot is expected to write themselves
			return 0;
		}
		else {
			//No data.
			return 1;
		}
	}

	void handle(string data)
	{
		write("--> " + data + "\n");
	}
}

class Sender {
	string nick;
	string host;
	string dest;
	string name;
}

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


