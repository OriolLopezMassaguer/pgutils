if [ -n "$2" ]; then
    DB=$2
else
    DB="thebe"
fi

if [ -n "$3" ]; then
    HOST=$3
else
    HOST="localhost"
fi
psql -U postgres -d $DB -h $HOST < $1
