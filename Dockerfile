FROM mcr.microsoft.com/mssql/server:2017-latest

ENV DATABASE_NAME "hybris" 

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Bundle app source
COPY . /usr/src/app
# Grant permissions for the import-data script to be executable
RUN chmod +x /usr/src/app/import-data.sh && chmod +x entrypoint.sh 

ENTRYPOINT ["./entrypoint.sh"]

CMD ["tail -f /dev/null"]
