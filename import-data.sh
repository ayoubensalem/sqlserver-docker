#wait for the SQL Server to come up
echo "Wait until SQL Server comes up" 
export STATUS=1
i=0

while [[ $STATUS -ne 0 ]] && [[ $i -lt 30 ]]; do
	i=$i+1
	/opt/mssql-tools/bin/sqlcmd -t 1 -U sa -P $SA_PASSWORD -Q "select 1" >> /dev/null
	STATUS=$?
	echo "Retry $STATUS..."
done

if [ $STATUS -ne 0 ]; then 
	echo "Error: MSSQL SERVER took more than thirty seconds to start up."
	exit 1
fi

#run the setup script to create the DB and the schema in the DB

if [ ! -f "/usr/src/app/init" ]; then
	echo "DATABASE_NAME is ${DATABASE_NAME}"
	/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -d master -i setup.sql 
	echo "" > /usr/src/app/init
else  
 	echo "file init alrady exist" 
fi


