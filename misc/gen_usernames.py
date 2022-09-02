# Generates a username wordlist based on their full name
# Can also generate email addresses

import sys

def help():
	print("Usage :")
	print("python3 gen-usernames.py [user/mail] <fullnames.txt>")
	print("")
	print("Examples :")
	print("Basic : python3 gen-usernames.py -user fullnames.txt")
	print("Email : python3 gen-usernames.py -mail example.com fullnames.txt")
	print("")
	print("Formats :")
	print("fullnames.txt (case insensitive) : ")
	print("John Doe") # prénom - nom
	print("Sarah Croche") # prénom - nom

def readFile(filename):
	fullnames = open(filename, "r").read().split("\n")
	return fullnames

def show(values):
	for v in values:
		print(v)

def genUsernames(fullnames):
	output = []
	for fullname in fullnames:
		sp = fullname.split(" ")
		name = sp[0].lower() # prenom
		surname = sp[1].lower() # nom

		# john
		output.append(name)
		# j.doe
		output.append(name[0] + "." + surname)
		# jdoe
		output.append(name[0] + surname)
		# johndoe
		output.append(name + surname)
		# john.doe
		output.append(name + "." + surname)
	return output

def genEmails(users, domain):
	mail = []
	for username in users:
		mail.append(username + "@" + domain)
	return mail

if __name__ == "__main__":
	if len(sys.argv) < 3:
		help()
		exit(1)

	usernames = readFile(sys.argv[-1])
	users = genUsernames(usernames)
	if sys.argv[1] == "-mail":
		domain = sys.argv[2]
		mails = genEmails(users, domain)
		show(mails)
	elif sys.argv[1] == "-user":
		show(users)
	else:
		help()
		exit(1)
