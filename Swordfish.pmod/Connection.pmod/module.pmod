import  Stdio;

class  Connection {
	object Socket = File();
	string Server;
	string Nick;
	string Userln;
	string Data;
	int Port;
	array Channels;

	/**********Helper Functions*************/
	int raw(string msg) {
		write("<-- " + msg + "\n");
		Socket->write(msg + "\r\n");
		return 0;
	}

	int nick(string nickname) {
		if (raw("NICK " + nickname) != 0) {
			return 1; //Failed.
		}
		return 0;
	}

	int join(string dest) {
		if (raw("JOIN " + dest) != 0) {
			return 1; //Failed.
		}
		return 0;
	}


	void reconnect() {
		write("reconnecting \n");
	}
	/******* Socketection functions ************/
	int connect(){
		if (!Socket->connect(Server,Port)) {
			write("Meep.");
			return 1; //return failure
		} else { //Socketection successful
			write("Socketected!\n");
			Socket->set_nonblocking(0,0, reconnect);
			nick(Nick);
			raw("USER " + Userln);
			foreach(Channels, string dest) {
				join(dest);
			}
		}
		return 0;
	}

	/******* Functions that don't have a category at the moment ********/
	int read() {
		Data = Socket->read();
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
	
	int send(string dest, string message) {
		return raw("PRIVMSG " + dest + " :" + message);
	}

	int ctcp(string dest, string message) {
		return raw("PRIVMSG " + dest + " :\001" + message + "\001");
	}

	int action(string dest, string action) {
		return ctcp(dest, "ACTION " + action);
	}
	
	int quit(string message) {
		return raw("QUIT :" + message);
	}
}



//Miscellaneous classes

