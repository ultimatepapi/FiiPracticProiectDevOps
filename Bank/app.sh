#!/bin/bash

DB="bank.csv"

touch "$DB"
if [[ ! -s "$DB" ]]; then
	echo "Client,Sold curent" > "$DB"
fi

function menu() {
	echo -e "\nAplicatie bancara"
	echo "1) Creare client"
	echo "2) Modificare sold"
	echo "3) Stergere client"
	echo "4) Lista clienti"
	echo "Orice alta tasta: Iesire"
	echo -n "Alegeti o optiune: "
}

function add_client() {
	echo -n "Introduceti numele clientului: "
	read name
	if grep -q "^$name," "$DB"; then
		echo "Clientul cu numele $name exista deja."
	else
	       	echo "$name,0" >> "$DB"
		echo "Clientul cu numele $name a fost adaugat cu succes."
	fi		
}

function modify_sold() {
	echo -n "Introduceti numele clientului: "
	read name
	if grep -q "^$name," "$DB"; then
		echo -n "Introduceti noul sold: "
		read sold
		sed -i "/^$name,/c\\$name,$sold" "$DB"
		echo "Soldul clientului $name a fost actualizat la $sold"
	else
		echo "Clientul cu numele $name nu exista."
	fi
}

function delete_client() {
	echo -n "Introduceti numele clientului: "
	read name
	if grep -q "^$name," "$DB"; then
	       	sed -i "/^$name,/d" "$DB"
	       	echo "Clientul cu numele $name a fost sters."
       	else 
		echo "Clientul cu numele $name nu exista."
	fi
}

function list() {
	echo -e "\nLista clienti:\n"
	column -st "$DB"
}

while true; do
	menu
	read opt
	case $opt in
		1)
			add_client
			;;
		2)
			modify_sold
			;;
		3)
			delete_client
			;;
		4)
			list
			;;
		*)
			break
			;;
	esac
done
