#!/bin/bash

# Requires DevOps Agent MSI identity, rover to run "az login --identity"

set -e
az login --identity
echo "[SQLSERVER]
Driver = ODBC Driver 17 for SQL Server
Server = tcp:${SQLCMDSERVER},1433
Authentication = ActiveDirectoryMsi" | sudo tee -a /etc/odbc.ini > /dev/null

sqlcmd -v DBUSERNAMES="${DBUSERNAMES}" DBROLES="${DBROLES}" -S SQLSERVER -d "${SQLCMDDBNAME}" -i "${SQLFILEPATH}" -D