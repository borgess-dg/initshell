#!/bin/bash

clear

function create_questions(){

    clear

    score=0

    lines_quantity=$(wc -l "./content/questions.txt" | awk '{print $1}')
    for ((i = 1; i <= lines_quantity; i++)) do

        clear

        random_line=$((RANDOM%lines_quantity+1))
        echo -e "PONTOS: $score"
        sed -n "$random_line"p "./content/questions.txt"

        response=$(sed -n "$random_line"p "./content/answers.txt")
        response_size=$(echo "$response" | awk '{print length}')
        read -r "-n$response_size" received_response

        if [[ "$received_response" == "$response" ]]; then
            score=$((score+1))
            if [[ $i == lines_quantity ]]; then
                echo "$score" >> "./content/history.txt"
            fi
        else
            echo -e "\nGAME OVER!"
            sleep 2
            echo "$score" >> "./content/history.txt"
            break
        fi
    done
}

function menu(){
    menu_items=("Novo Jogo" "Histórico" "Sair")
    action=""
    while [ -z "$action" ]; do
        for ((i = 1; i < 4; i++)) do
            echo "$i - ${menu_items[$i-1]}"
        done
        read -rsn1 action
        if [[ "$action" -eq 1 ]]; then
            create_questions
        fi
    done
}

function main(){
    menu
}

main