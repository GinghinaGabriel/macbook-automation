#!/bin/bash

CURRENT_DIR=$(pwd)

FOLDER_NAME="Christmas"
INTEL_ENCRYPTION_FILE_NAME="ransomware-mimic-intel"
APPLE_ENCRYPTION_FILE_NAME="ransomware-mimic-apple"

FOLDER_PATH="$CURRENT_DIR/$FOLDER_NAME"
INTEL_ENCRYPTION_FILE_PATH="$CURRENT_DIR/$INTEL_ENCRYPTION_FILE_NAME"
APPLE_ENCRYPTION_FILE_PATH="$CURRENT_DIR/$APPLE_ENCRYPTION_FILE_NAME"

#NAME_LIST=("Joker" "HarleyQuinn" "Penguin" "Riddler" "Scarecrow")
NAME_LIST=("GrinchX6")

CPU_INFO=$(uname -m)

test_folder() {
    if [[ ! -d "$FOLDER_NAME" ]]; then
        echo "Create a new $FOLDER_NAME."
        
        mkdir -p "$FOLDER_NAME"

        for i in {1..10}; do
            touch "$FOLDER_NAME/file_$i.txt"
        done

    else
        rm -r "$FOLDER_NAME"
        echo "$FOLDER_NAME is corupted, destroy it!"
        test_folder
    fi
}

if [[ "$CPU_INFO" == "x86_64" ]]; then
    echo "Run the intel encryption file"

    for NAME in "${NAME_LIST[@]}"; do
        NEW_ENCRYPTION_FILE="$CURRENT_DIR/$NAME"
        
        cp -r "$INTEL_ENCRYPTION_FILE_PATH" "$NEW_ENCRYPTION_FILE"
        
        echo -e "\nVillan $NAME created."
        
        test_folder

        echo -e "\nStart the encryption."        

        "$NEW_ENCRYPTION_FILE" "$FOLDER_PATH"

        sleep 5

        rm "$NEW_ENCRYPTION_FILE"
    done

elif [[ "$CPU_INFO" == "arm64" ]]; then
    echo "Run the apple encryption file"

    for NAME in "${NAME_LIST[@]}"; do

        NEW_ENCRYPTION_FILE="$CURRENT_DIR/$NAME"

        cp -r "$INTEL_ENCRYPTION_FILE_PATH" "$NEW_ENCRYPTION_FILE"

        echo -e "\nVillan $NAME created."

        test_folder
        
        echo -e "\nStart the encryption." 

        "$NEW_ENCRYPTION_FILE" "$FOLDER_PATH"
        
        sleep 5

        rm "$NEW_ENCRYPTION_FILE"
    done

else
    echo "Unknown proccessor architecture"
fi

