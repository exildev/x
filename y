#!/usr/bin/env bash
mfile=manage.py
pro=~/Documentos/Poyectos
echo "Algo"
vrenv(){
    if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
        source /usr/local/bin/virtualenvwrapper.sh
    else
        source /etc/bash_completion.d/virtualenvwrapper
    fi
    workon piscis
}

m(){
    python manage.py migrate
}

k(){
    python manage.py makemigrations
}

u(){
    python manage.py createsuperuser
}

t(){
    python manage.py test
}

r(){
    python manage.py runserver 0.0.0.0:8000
}

a(){
    python manage.py startapp $1
}

s(){
    django-admin startproject $1
}

h(){
    cat <<- _EOF_
    Django command shortuts
        -s or --startproject    Create Django project
        -m or --migrate         Django migrate
        -k or --makemigrations  Django makemigrations
        -u or --createsuperuser Django createsuperuser
        -t or --test            Django test
        -r or --runserver       Django runserver
        -a or --startapp        Django startapp
_EOF_
}

retval=0

tput setaf 2;
echo "===========Exile============"
tput setaf 7;

control(){
    if [ ! -f manage.py ]; then
        if [ -d $pro/$1 ]; then
            cd $pro/$1;
            retval=1
        else
            if [ "$1" = "-s" ]; then
                vrenv
                cd $pro
                s $2
                cd $pro/$2;
                retval=2
            else
                tput setaf 1;
                echo "No se encontro el archivo manage.py"
                tput setaf 7;
            fi
        fi
    fi
}


control $1 $2
for (( i = 0; i < $retval; i++ )); do
    shift
done

if [ -f manage.py ]; then
    vrenv
    while [ "$1" != "" ]; do
        echo $1
        case  $1 in
            -m | --migrate)
                m
                ;;
            -k | --makemigrations)
                k
                ;;
            -u | --createsuperuser)
                u
                ;;
            -t | --test)
                t
                ;;
            -r | --runserver)
                r
                ;;
            -a | --startapp)
                a $2
                shift
                ;;
            -h | --help)
                h
                ;;
            *)
        esac
        shift
    done
fi
tput setaf 7;
