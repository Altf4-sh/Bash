#!/bin/bash

# Colours
RED="\e[0;31m\033[1m"
YELLOW="\e[0;33m\033[1m"
ORANGE="\033[0;33m"
BLUE="\e[0;34m\033[1m"
GREEN="\e[0;32m\033[1m"
PURPLE="\e[0;35m\033[1m"
TURQUOISE="\e[0;36m\033[1m"
GRAY="\e[0;37m\033[1m"
NC="\033[0m\e[0m"

# Banner
banner="
                        ${RED}+-------------------------------------+
                        |${NC}     ${YELLOW}Project Directory Structure${NC}     ${RED}|
                        |                                     |
                        |${NC} ${YELLOW}Author:${NC} Altf4-sh                    ${RED}|  
                        |${NC} ${YELLOW}GitHub:${NC} https://github.com/Altf4-sh ${RED}|
                        |${NC} ${YELLOW}Version:${NC} 2.0                        ${RED}|
                        +-------------------------------------+${NC}
"

menu(){

    while true; do

        echo -e "${YELLOW}[1]${NC} ${GREY}Custom${NC}"
        echo -e "${YELLOW}[2]${NC} ${GREY}Python${NC}"
        echo -e "${YELLOW}[3]${NC} ${GREY}JavaScript${NC}"
        echo -e "${YELLOW}[4]${NC} ${GREY}Java${NC}"
        echo -e "${YELLOW}[5]${NC} ${GREY}C++${NC}"
        echo -e "${YELLOW}[6]${NC} ${GREY}C#${NC}"
        echo -e "${YELLOW}[7]${NC} ${GREY}Ruby${NC}"
        echo -e "${YELLOW}[8]${NC} ${GREY}Swift${NC}"
        echo -e "${YELLOW}[9]${NC} ${GREY}Go${NC}"
        echo -e "${YELLOW}[10]${NC} ${GREY}Perl${NC}"
        echo -e "${YELLOW}[11]${NC} ${GREY}PHP${NC}\n"
        echo -e "${YELLOW}[exit]${NC} ${GREY}Exit${NC}"

        read -p "$(echo -e "\n${YELLOW}[+]${NC} ${GREY}>> ${NC} ")" opcion

        case $opcion in
            1) custom_directoryStructure $1 $2 ;;
            2) python_DirectoryStructure $1 $2;;
            3) javaScript_DirectoryStructure $1 $2 ;;
            4) java_DirectoryStructure $1 $2 ;;
            5) c++_DirectoryStructure $1 $2 ;;
            6) c#_DirectoryStructure $1 $2 ;;
            7) ruby_DirectoryStructure $1 $2 ;;
            8) swift_DirectoryStructure $1 $2 ;;
            9) go_DirectoryStructure $1 $2 ;;
            10) perl_DirectoryStructure $1 $2 ;;
            11) php_DirectoryStructure $1 $2 ;;
            exit) echo -e "\n${PURPLE}[+]${NC} ${GREEN}Bye${NC}"
                exit 0;;
        esac
    done
}

# Creación custom de la estructura de un proyecto
custom_directoryStructure(){
    echo -e "           \n\n${YELLOW}[+]${NC} ${GREY}CUSTOM DIRECTORY STRUCTURE${NC}\n"
    sleep 0.5
    if [ $1 == "/" ]; then
        rute=$1$2
    else
        rute=$1/$2
    fi
    if mkdir $rute; then
        # Reglas regex para controlar el nombre de carpetas y archivos
        patronFolder="^([[:alnum:][:punct:]]+;)+[[:alnum:][:punct:]]+[^;]$"
        patronFile="^([[:alnum:][:punct:]]+\.[[:alnum:]]+;)+[[:alnum:][:punct:]]+\.[[:alnum:]]+$"
        patronFolder2="\b(\w+)\b.*\b\1\b"
        
        # Mediante un bucle while true, preguntamos el nombre de las carpetas que van en la raíz del proyecto y comprobamos que se introducen con el formato adecuado para su tratamiento
        while true; do
            echo -e "${YELLOW}[+]${NC} ${GREY}Nombre de las carpetas en al ${YELLOW}raíz${NC} de tu proyecto separadas por punto y coma. Mínimo 2 carpetas EJ: folder1;folder2;folder3;folder4;folder5 ${NC}\n"
            read -p "$(echo -e "\n${YELLOW}[+]${NC} ${GREY}Name of folders:  ${NC} ")" folders
            # Comprobamos con la regla REGEX que se hace con el formato correcto
            if [[ $folders =~ $patronFolder && ! $folders =~ $patronFolder2 ]]; then
                # Preguntamos si va haber archivos dentro de la raíz del proyecto y hacemos lo mismo que con las carpetas
                read -p "$(echo -e "\n${YELLOW}[+]${NC} ${GREY}¿Va haber archivos en la ${YELLOW}raíz${NC} del proyecto? [s/n]${NC} ")" yesORno
                if [ $yesORno == "s" ]; then
                    # Mediante un bucle while true, preguntamos el nombre de los archivos que van en la raíz del proyecto y comprobamos que se introducen con el formato adecuado para su tratamiento
                    while true; do
                        echo -e "${YELLOW}[+]${NC} ${GREY}Nombre de los archivos de la ${YELLOW}raíz${NC} del proyecto separados por punto y coma. Mínimo 2. EJ: file1;file2;file3 ${NC}\n"
                        read -p "$(echo -e "\n${YELLOW}[+]${NC} ${GREY}Name of files:  ${NC} ")" filesRoot
                        if [[ $filesRoot =~ $patronFile ]]; then
                            # Creamos los archivos que van en la raíz del proyecto
                            IFS=';' read -ra elementos <<< "$filesRoot"
                            for file in "${elementos[@]}"; do
                                touch $rute/$file
                            done
                            break
                        else
                            echo -e "\n${YELLOW}[+]${NC} ${RED}Formato incorrecto${NC}\n"
                        fi
                    done
                elif [ $yesORno == "n" ]; then
                    echo -e "\n${PURPLE}[+]${NC} ${GREEN}OK${NC}\n"
                fi

                structure $rute $patronFolder $patronFile $patronFolder2 $folders

                echo -e "\n${PURPLE}[+]${NC} ${GREEN}Proyecto creado correctamente${NC}\n"
                tree -a $rute
                break
            else
                echo -e "\n${YELLOW}[+]${NC} ${RED}Formato incorrecto${NC}\n"
            fi
        done
    else
        echo -e "\n${YELLOW}[+]${NC} ${RED}No tienes permiso para crear el proyecto en esta ruta:${NC} ${GRAY}$rute${NC}\n"
    fi
}


structure(){
    # Separamos las cadenas creadas para poder recorrer los elementos
    IFS=';' read -ra elementos <<< "$5"
    for folder in "${elementos[@]}"; do
        # Creamos las carpetas dadas por el usuario
        mkdir $1/$folder
        newRute=$1/$folder
        read -p "$(echo -e "\n${YELLOW}[+]${NC} ${GREY}¿Va haber archivos en ${YELLOW}$folder${NC}? [s/n]${NC} ")" yesORno
        if [ $yesORno == "s" ]; then
            while true; do
                echo -e "${YELLOW}[+]${NC} ${GREY}Nombre de los archivos de ${YELLOW}$folder${NC} separados por punto y coma. Mínimo 2. EJ: file1;file2;file3 ${NC}\n"
                read -p "$(echo -e "\n${YELLOW}[+]${NC} ${GREY}Name of files:  ${NC} ")" filesFolder
                if [[ $filesFolder =~ $3 ]]; then
                    # Creamos los archivos de cada carpeta
                    IFS=';' read -ra elementos <<< "$filesFolder"
                    for file in "${elementos[@]}"; do
                        touch $1/$folder/$file
                    done
                    break
                else
                    echo -e "\n${YELLOW}[+]${NC} ${RED}Formato incorrecto${NC}\n"
                fi
            done
        elif [ $yesORno == "n" ]; then
            echo -e "\n${PURPLE}[+]${NC} ${GREEN}OK${NC}\n"
        fi
        read -p "$(echo -e "\n${YELLOW}[+]${NC} ${GREY}¿Va haber carpetas en ${YELLOW}$folder${NC}? [s/n]${NC} ")" yesORno
        if [ $yesORno == "s" ]; then
            while true; do
                echo -e "${YELLOW}[+]${NC} ${GREY}Nombre de las carpetas de ${YELLOW}$folder${NC} separados por punto y coma. Mínimo 2. EJ: folder1;folder2;folder3 ${NC}\n"
                read -p "$(echo -e "\n${YELLOW}[+]${NC} ${GREY}Name of folders:  ${NC} ")" newFolder
                if [[ $folders =~ $2 && ! $folders =~ $4 ]]; then
                    # Llamamos a structure para que sea una fucion recursiva
                    structure "$newRute" "$2" "$3" "$4" "$newFolder"
                    break
                else
                    echo -e "\n${YELLOW}[+]${NC} ${RED}Formato incorrecto${NC}\n"
                fi
            done
        elif [ $yesORno == "n" ]; then
            echo -e "\n${PURPLE}[+]${NC} ${GREEN}OK${NC}\n"
        fi
    done
}

# Creación básica de la estructura de un proyecto para Python
python_DirectoryStructure(){
    echo -e "           \n\n${YELLOW}[+]${NC} ${GREY}BASIC PYTHON DIRECTORY${NC}"
    sleep 0.5
    if [ $1 == "/" ]; then
        rute=$1$2
    else
        rute=$1/$2
    fi
    if mkdir $rute; then
        mkdir -p $rute/data $rute/test $rute/src
        touch $rute/data/Documentation.txt $rute/main.py $rute/src/module1.py $rute/README.md
        sleep 0.5
        echo -e "\n${PURPLE}[+]${NC} ${GREEN}Proyecto creado correctamente${NC}\n"
        sleep 0.5
        tree -a $rute
        echo -e "\n"
        exit 0
    else
        echo -e "\n${YELLOW}[+]${NC} ${RED}No tienes permiso para crear el proyecto en esta ruta:${NC} ${GRAY}$rute${NC}\n"
    fi
}

# Creación básica de la estructura de un proyecto para JavaScript
javaScript_DirectoryStructure(){
    echo -e "           \n\n${YELLOW}[+]${NC} ${GREY}BASIC JAVASCRPT DIRECTORY${NC}"
    sleep 0.5
    if [ $1 == "/" ]; then
        rute=$1$2
    else
        rute=$1/$2
    fi
    if mkdir $rute; then
        mkdir -p $rute/test $rute/src
        touch $rute/src/index.js $rute/test/test_index.js $rute/README.md $rute/package.json
        sleep 0.5
        echo -e "\n${PURPLE}[+]${NC} ${GREEN}Proyecto creado correctamente${NC}\n"
        sleep 0.5
        tree -a $rute
        echo -e "\n"
        exit 0
    else
        echo -e "\n${YELLOW}[+]${NC} ${RED}No tienes permiso para crear el proyecto en esta ruta:${NC} ${GRAY}$rute${NC}\n"
    fi
}

# Creación básica de la estructura de un proyecto para Java
java_DirectoryStructure(){
    echo -e "           \n\n${YELLOW}[+]${NC} ${GREY}BASIC JAVA DIRECTORY${NC}"
    sleep 0.5
    if [ $1 == "/" ]; then
        rute=$1$2
    else
        rute=$1/$2
    fi
    if mkdir $rute; then
        mkdir -p $rute/src $rute/test $rute/lib
        touch $rute/src/main.java $rute/test/testMain.java $rute/README.md
        sleep 0.5
        echo -e "\n${PURPLE}[+]${NC} ${GREEN}Proyecto creado correctamente${NC}\n"
        sleep 0.5
        tree -a $rute
        echo -e "\n"
        exit 0
    else
        echo -e "\n${YELLOW}[+]${NC} ${RED}No tienes permiso para crear el proyecto en esta ruta:${NC} ${GRAY}$rute${NC}\n"
    fi
}

# Creación básica de la estructura de un proyecto para C++
c++_DirectoryStructure(){
    echo -e "           \n\n${YELLOW}[+]${NC} ${GREY}BASIC C++ DIRECTORY${NC}"
    sleep 0.5
    if [ $1 == "/" ]; then
        rute=$1$2
    else
        rute=$1/$2
    fi
    if mkdir $rute; then
        mkdir -p $rute/src $rute/include $rute/test 
        touch $rute/src/main.cpp $rute/test/test_main.cpp $rute/README.md $rute/Makefile
        sleep 0.5
        echo -e "\n${PURPLE}[+]${NC} ${GREEN}Proyecto creado correctamente${NC}\n"
        sleep 0.5
        tree -a $rute
        echo -e "\n"
        exit 0
    else
        echo -e "\n${YELLOW}[+]${NC} ${RED}No tienes permiso para crear el proyecto en esta ruta:${NC} ${GRAY}$rute${NC}\n"
    fi
}

# Creación básica de la estructura de un proyecto para C#
c#_DirectoryStructure(){
    echo -e "           \n\n${YELLOW}[+]${NC} ${GREY}BASIC C# DIRECTORY${NC}"
    sleep 0.5
    if [ $1 == "/" ]; then
        rute=$1$2
    else
        rute=$1/$2
    fi
    if mkdir $rute; then
        mkdir -p $rute/src $rute/test 
        touch $rute/src/Program.cs $rute/test/TestProgram.cs $rute/README.md
        sleep 0.5
        echo -e "\n${PURPLE}[+]${NC} ${GREEN}Proyecto creado correctamente${NC}\n"
        sleep 0.5
        tree -a $rute
        echo -e "\n"
        exit 0
    else
        echo -e "\n${YELLOW}[+]${NC} ${RED}No tienes permiso para crear el proyecto en esta ruta:${NC} ${GRAY}$rute${NC}\n"
    fi
}

# Creación básica de la estructura de un proyecto para PHP
php_DirectoryStructure(){
    echo -e "           \n\n${YELLOW}[+]${NC} ${GREY}BASIC PHP DIRECTORY${NC}"
    sleep 0.5
    if [ $1 == "/" ]; then
        rute=$1$2
    else
        rute=$1/$2
    fi
    if mkdir $rute; then
        mkdir -p $rute/src $rute/test 
        touch $rute/src/idenx.php $rute/test/test_index.php $rute/README.md $rute/composer.json
        sleep 0.5
        echo -e "\n${PURPLE}[+]${NC} ${GREEN}Proyecto creado correctamente${NC}\n"
        sleep 0.5
        tree -a $rute
        echo -e "\n"
        exit 0
    else
        echo -e "\n${YELLOW}[+]${NC} ${RED}No tienes permiso para crear el proyecto en esta ruta:${NC} ${GRAY}$rute${NC}\n"
    fi
}

# Creación básica de la estructura de un proyecto para Ruby
ruby_DirectoryStructure(){
    echo -e "           \n\n${YELLOW}[+]${NC} ${GREY}BASIC RUBY DIRECTORY${NC}"
    sleep 0.5
    if [ $1 == "/" ]; then
        rute=$1$2
    else
        rute=$1/$2
    fi
    if mkdir $rute; then
        mkdir -p $rute/lib $rute/test 
        touch $rute/src/main.rb $rute/test/test_main.rb $rute/README.md
        sleep 0.5
        echo -e "\n${PURPLE}[+]${NC} ${GREEN}Proyecto creado correctamente${NC}\n"
        sleep 0.5
        tree -a $rute
        echo -e "\n"
        exit 0
    else
        echo -e "\n${YELLOW}[+]${NC} ${RED}No tienes permiso para crear el proyecto en esta ruta:${NC} ${GRAY}$rute${NC}\n"
    fi
}

# Creación básica de la estructura de un proyecto para Swift
swift_DirectoryStructure(){
    echo -e "           \n\n${YELLOW}[+]${NC} ${GREY}BASIC SWIFT DIRECTORY${NC}"
    sleep 0.5
    if [ $1 == "/" ]; then
        rute=$1$2
    else
        rute=$1/$2
    fi
    if mkdir $rute; then
        mkdir -p $rute/Sources $rute/Tests
        touch $rute/Sources/main.swift $rute/Tests/TestsMain.swift $rute/README.md
        sleep 0.5
        echo -e "\n${PURPLE}[+]${NC} ${GREEN}Proyecto creado correctamente${NC}\n"
        sleep 0.5
        tree -a $rute
        echo -e "\n"
        exit 0
    else
        echo -e "\n${YELLOW}[+]${NC} ${RED}No tienes permiso para crear el proyecto en esta ruta:${NC} ${GRAY}$rute${NC}\n"
    fi
}

# Creación básica de la estructura de un proyecto para Go
go_DirectoryStructure(){
    echo -e "           \n\n${YELLOW}[+]${NC} ${GREY}BASIC GO DIRECTORY${NC}"
    sleep 0.5
    if [ $1 == "/" ]; then
        rute=$1$2
    else
        rute=$1/$2
    fi
    if mkdir $rute; then
        mkdir -p $rute/app $rute/app/handlers $rute/app/models $rute/app/utils $rute/pkg $rute/pkg/logger $rute/pkg/database $rute/pkg/database/migrations $rute/pkg/utils
        touch $rute/main.go $rute/app/handlers/home.go $rute/app/handlers/user.go $rute/app/models/user.go $rute/app/models/post.go $rute/app/utils/validation.go $rute/pkg/logger/logger.go $rute/pkg/database/database.go $rute/pkg/utils/file.go $rute/README.md
        sleep 0.5
        echo -e "\n${PURPLE}[+]${NC} ${GREEN}Proyecto creado correctamente${NC}\n"
        sleep 0.5
        tree -a $rute
        echo -e "\n"
        exit 0
    else
        echo -e "\n${YELLOW}[+]${NC} ${RED}No tienes permiso para crear el proyecto en esta ruta:${NC} ${GRAY}$rute${NC}\n"
    fi
}

# Creación básica de la estructura de un proyecto para Perl
perl_DirectoryStructure(){
    echo -e "           \n\n${YELLOW}[+]${NC} ${GREY}BASIC PERL DIRECTORY${NC}"
    sleep 0.5
    if [ $1 == "/" ]; then
        rute=$1$2
    else
        rute=$1/$2
    fi
    if mkdir $rute; then
        mkdir -p $rute/bin $rute/lib $rute/test
        touch $rute/bin/script.pl $rute/lib/MiModulo.pm $rute/test/test_script.t $rute/README.md
        sleep 0.5
        echo -e "\n${PURPLE}[+]${NC} ${GREEN}Proyecto creado correctamente${NC}\n"
        sleep 0.5
        tree -a $rute
        echo -e "\n"
        exit 0
    else
        echo -e "\n${YELLOW}[+]${NC} ${RED}No tienes permiso para crear el proyecto en esta ruta:${NC} ${GRAY}$rute${NC}\n"
    fi
}

echo -e "$banner"

# Comprobar que la ruta proporcionada es válida
while true; do
    read -p "$(echo -e "${YELLOW}[+]${NC} ${GREY}Ruta absoluta del nuevo proyecto:${NC} ")" projectDirectory
    if [ -d "$projectDirectory" ]; then
        echo -e "\n${PURPLE}[+]${NC} ${GREEN}Ruta válida${NC}\n"
        sleep 0.5
        # Comprobar que el nombre proporcionado es válido
        while true; do
            read -p "$(echo -e "${YELLOW}[+]${NC} ${GREY}Nombre del proyecto: ${NC} ")" projectName
            if [ -d "$projectDirectory/$projectName" ]; then
                echo -e "\n${YELLOW}[+]${NC} ${RED}Ya existe una carpeta con ese nombre${NC}\n"
                sleep 0.5
            else
                echo -e "\n${PURPLE}[+]${NC} ${GREEN}Nombre disponible${NC}\n"
                sleep 0.5
                break 2
            fi
        done
    else
        echo -e "\n${YELLOW}[+]${NC} ${RED}Ruta inválida${NC}\n"
        sleep 0.5
    fi
done

menu "$projectDirectory" "$projectName"
