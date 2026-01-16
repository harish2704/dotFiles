#!/usr/bin/env python3

import subprocess
import datetime
import os
import gzip
import shutil
import argparse
import sys
import fnmatch
import logging

def get_args():
    parser = argparse.ArgumentParser(description="High-performance MySQL multi-database backup tool.")
    parser.add_argument("-H", "--host", default="localhost", help="MySQL Host")
    parser.add_argument("-P", "--port", default="3306", help="MySQL Port")
    parser.add_argument("-u", "--user", required=True, help="MySQL Username")
    parser.add_argument("-p", "--password", required=True, help="MySQL Password")
    parser.add_argument("-o", "--output", default="backups", help="Output directory")
    parser.add_argument("-x", "--exclude", action="append", default=[], 
                        help="Pattern to exclude (e.g., 'test_*'). Can be used multiple times.")
    # Added verbose flag
    parser.add_argument("-v", "--verbose", action="store_true", help="Print executed commands and detailed logs")
    return parser.parse_args()

def should_exclude(db_name, patterns):
    system_dbs = ('information_schema', 'performance_schema', 'sys', 'mysql', 'Database')
    if db_name in system_dbs:
        return True
    for pattern in patterns:
        if fnmatch.fnmatch(db_name, pattern):
            return True
    return False

def run_backup():
    args = get_args()
    
    # Configure logging based on verbose flag
    log_level = logging.DEBUG if args.verbose else logging.INFO
    logging.basicConfig(format='%(levelname)s: %(message)s', level=log_level)

    if not os.path.exists(args.output):
        logging.debug(f"Creating output directory: {args.output}")
        os.makedirs(args.output)

    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    
    # Hide password in logs for security, even in verbose mode
    safe_conn_flags = ['-h', args.host, '-P', args.port, '-u', args.user, '-p****']
    real_conn_flags = ['-h', args.host, '-P', args.port, '-u', args.user, f'-p{args.password}']

    try:
        # 1. Fetch Database List
        fetch_cmd = ['mysql'] + real_conn_flags + ['-e', 'SHOW DATABASES;', '-N', '-s']
        logging.debug(f"Executing: {' '.join(['mysql'] + safe_conn_flags + fetch_cmd[-3:])}")
        
        proc = subprocess.run(fetch_cmd, capture_output=True, text=True, check=True)
        raw_databases = proc.stdout.split()
        
        databases = [db for db in raw_databases if not should_exclude(db, args.exclude)]

        if not databases:
            logging.info("No databases found matching the criteria.")
            return

        logging.info(f"Starting backup for {len(databases)} databases...")

        for db in databases:
            filename = f"{db}_{timestamp}.sql.gz"
            filepath = os.path.join(args.output, filename)

            dump_cmd = [
                'mysqldump'
            ] + real_conn_flags + [
                '--single-transaction',
                '--extended-insert',
                '--quick',
                '--disable-keys',
                '--no-autocommit',
                db
            ]

            # Detailed log of the dump command
            safe_dump_cmd = ['mysqldump'] + safe_conn_flags + dump_cmd[7:]
            logging.debug(f"Executing: {' '.join(safe_dump_cmd)} | gzip > {filepath}")

            logging.info(f"  -> Backing up: {db}")
            
            with subprocess.Popen(dump_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE) as dump_proc:
                with gzip.open(filepath, 'wb', compresslevel=6) as f_out:
                    shutil.copyfileobj(dump_proc.stdout, f_out)
                
                dump_proc.wait()
                
                if dump_proc.returncode != 0:
                    error_msg = dump_proc.stderr.read().decode()
                    logging.error(f"Failed to backup {db}: {error_msg}")
                else:
                    logging.debug(f"Successfully completed {db}")

        logging.info("All tasks completed.")

    except subprocess.CalledProcessError as e:
        # Even errors should hide the password
        logging.error("Connection failed. Check your credentials and host settings.")
        sys.exit(1)
    except Exception as e:
        logging.error(f"Unexpected error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    run_backup()
