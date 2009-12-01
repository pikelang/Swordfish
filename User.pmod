import  Stdio;
import .Misc;

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
	
	int send(string channel, string message) {
		return raw("PRIVMSG " + channel + " :" + message);
	}

	int action(string channel, string action) {
		return raw("PRIVMSG " + channel + " :\001ACTION " + action + "\001");
	}
	
	int quit(string message) {
		return raw("QUIT :" + message);
	}
}



