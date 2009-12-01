//Miscellaneous classes

class Sender {
        string nick;
        string host;
        string dest;
        string name;


}

class Misc { //We really need something better, but it'll have to do for now
	
	//Hopefully this can be made static eventually
	Sender fillsender(array info) {
		Sender sender = Sender();
		sender->nick = info[0];
		sender->name = info[1];
		sender->host = info[2];
		sender->dest = info[3];
		return sender;
	}
}




