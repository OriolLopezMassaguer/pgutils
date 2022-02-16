 export LIQUIBASE_HOME=/home/oriol/soft/liquibase
 export CLASSPATH=/home/oriol/soft/liquibase/lib/

/home/oriol/soft/liquibase/liquibase --diffTypes data --driver=org.postgresql.Driver \
        --url=jdbc:postgresql://localhost:5432/thebe_dev_40_cosmetics \
        --username=postgres \
        --password=postgres \
    diff \
        --referenceUrl=jdbc:postgresql://localhost:5432/thebe_dev_30_rc6 \
        --referenceUsername=postgres \
        --referencePassword=postgres
    #--diffTypes=tables, views, columns, indexes, foreignkeys,  primarykeys, uniqueconstraints,data
    


